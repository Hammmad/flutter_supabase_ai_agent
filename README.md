# AI Workspace (Flutter + Supabase)

A learning and portfolio project: a private AI assistant that answers
questions from your own notes and turns what you discuss into tasks.

Built with Flutter (web and Android) and Supabase (Postgres, Auth, Storage,
Edge Functions).

## Status

Work in progress, built in milestones:

1. Database schema, signup trigger and row-level security
2. Flutter auth and workspace connection
3. Private storage and an AI agent Edge Function with tool calling
4. Chat UI with streaming, CI and an architecture diagram

## Running locally

1. Copy `env.example.json` to `env.json` and fill in your Supabase project
   URL and publishable key (Project Settings → API).
2. Run:

   ```bash
   flutter run --dart-define-from-file=env.json
   ```

The Flutter version is pinned in `.fvmrc`.

## Project layout

- `lib/custom_views/`: design system components
- `lib/theme/`: colors, typography and spacing tokens
- `supabase/sql/`: database scripts, run in order in the Supabase SQL Editor
