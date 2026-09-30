-- YUVRYX signup/profile alignment and verified-email trial activation.
-- Applied to the YUVRYX Supabase production project on 2026-09-30.
-- Idempotent so it is safe to replay during environment bootstrap.

alter table public.profiles
  add column if not exists gender text;

alter table public.profiles
  drop constraint if exists profiles_gender_check;

alter table public.profiles
  add constraint profiles_gender_check
  check (gender is null or gender in ('male','female','non_binary','prefer_not_to_say'));

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $function$
begin
  insert into public.profiles
    (id, full_name, email, phone, gender, course, stream, current_semester, email_verified)
  values
    (
      new.id,
      coalesce(new.raw_user_meta_data->>'full_name', split_part(coalesce(new.email,''),'@',1), 'Student'),
      new.email,
      coalesce(new.raw_user_meta_data->>'phone',''),
      nullif(new.raw_user_meta_data->>'gender',''),
      new.raw_user_meta_data->>'course',
      new.raw_user_meta_data->>'stream',
      new.raw_user_meta_data->>'current_semester',
      new.email_confirmed_at is not null
    )
  on conflict (id) do nothing;
  return new;
end;
$function$;

create or replace function public.handle_user_email_verification()
returns trigger
language plpgsql
security definer
set search_path = public
as $function$
begin
  if new.email_confirmed_at is not null and old.email_confirmed_at is null then
    update public.profiles
       set email_verified = true,
           trial_claimed = case when trial_claimed then trial_claimed else true end,
           trial_started_at = case when trial_started_at is null then now() else trial_started_at end,
           trial_ends_at = case when trial_ends_at is null then now() + interval '7 days' else trial_ends_at end,
           updated_at = now()
     where id = new.id;
  end if;
  return new;
end;
$function$;

drop trigger if exists on_auth_user_email_verified on auth.users;
create trigger on_auth_user_email_verified
after update of email_confirmed_at on auth.users
for each row
execute function public.handle_user_email_verification();

revoke execute on function public.handle_new_user() from public, anon, authenticated;
revoke execute on function public.handle_user_email_verification() from public, anon, authenticated;
