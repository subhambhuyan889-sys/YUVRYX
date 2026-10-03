-- YUVRYX: real surprise-test question storage
alter table public.surprise_tests
  add column if not exists questions jsonb not null default '[]'::jsonb;
