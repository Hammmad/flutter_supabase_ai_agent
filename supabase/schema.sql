-- Run this in the Supabase SQL editor to create the example table.
create table if not exists public.todos (
  id bigint generated always as identity primary key,
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  title text not null,
  is_done boolean not null default false,
  created_at timestamptz not null default now()
);

alter table public.todos enable row level security;

create policy "Users can read their own todos"
  on public.todos for select using (auth.uid() = user_id);
create policy "Users can insert their own todos"
  on public.todos for insert with check (auth.uid() = user_id);
create policy "Users can update their own todos"
  on public.todos for update using (auth.uid() = user_id);
create policy "Users can delete their own todos"
  on public.todos for delete using (auth.uid() = user_id);

-- Enable realtime updates for the stream() used in the app.
alter publication supabase_realtime add table public.todos;
