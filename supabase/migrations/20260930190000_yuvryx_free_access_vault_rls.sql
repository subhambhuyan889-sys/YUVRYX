-- YUVRYX: free-access mode, private vault storage, and corrected study-group RLS
insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
values ('yuvryx-vault','yuvryx-vault',false,10485760,array['application/pdf','image/png','image/jpeg','image/webp','text/plain','application/msword','application/vnd.openxmlformats-officedocument.wordprocessingml.document'])
on conflict (id) do nothing;

drop policy if exists "yuvryx_vault_select_own" on storage.objects;
drop policy if exists "yuvryx_vault_insert_own" on storage.objects;
drop policy if exists "yuvryx_vault_update_own" on storage.objects;
drop policy if exists "yuvryx_vault_delete_own" on storage.objects;

create policy "yuvryx_vault_select_own" on storage.objects for select to authenticated
using (bucket_id='yuvryx-vault' and (storage.foldername(name))[1]=auth.uid()::text);
create policy "yuvryx_vault_insert_own" on storage.objects for insert to authenticated
with check (bucket_id='yuvryx-vault' and (storage.foldername(name))[1]=auth.uid()::text);
create policy "yuvryx_vault_update_own" on storage.objects for update to authenticated
using (bucket_id='yuvryx-vault' and (storage.foldername(name))[1]=auth.uid()::text)
with check (bucket_id='yuvryx-vault' and (storage.foldername(name))[1]=auth.uid()::text);
create policy "yuvryx_vault_delete_own" on storage.objects for delete to authenticated
using (bucket_id='yuvryx-vault' and (storage.foldername(name))[1]=auth.uid()::text);

drop policy if exists "study_group_members_member_access" on public.study_group_members;
create policy "study_group_members_member_access" on public.study_group_members
for select to public
using (
  user_id = auth.uid()
  or exists (
    select 1 from public.study_group_members m
    where m.group_id = study_group_members.group_id
      and m.user_id = auth.uid()
  )
);

drop policy if exists "study_messages_group_members" on public.study_messages;
create policy "study_messages_group_members" on public.study_messages
for all to public
using (
  user_id = auth.uid()
  or exists (
    select 1 from public.study_group_members m
    where m.group_id = study_messages.group_id
      and m.user_id = auth.uid()
  )
)
with check (
  user_id = auth.uid()
  and exists (
    select 1 from public.study_group_members m
    where m.group_id = study_messages.group_id
      and m.user_id = auth.uid()
  )
);
