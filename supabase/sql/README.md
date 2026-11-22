# Database scripts

Every change to the Supabase database lives here as a numbered SQL file.

## Workflow

1. Write the script here first, for example `01_profiles.sql`.
2. Run it in the Supabase dashboard: **SQL Editor → New query → paste → Run**.
3. Commit the file in the same commit as any app code that depends on it.

## Rules

- **Never edit a script that has already been run.** Fix mistakes with a new,
  higher-numbered script, so this folder always replays to the live schema.
- Run scripts in number order on a fresh project to rebuild the database.
- No secrets in these files. API keys belong in the dashboard
  (Edge Functions → Secrets), never in git.
