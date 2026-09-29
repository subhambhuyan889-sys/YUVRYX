# YUVRYX Architecture

## Current state

The repository currently contains a validated single-file experience in `index.html`. It is the visual/interaction baseline, not the final production architecture.

## Production target

```
apps/
  web/                 # student-facing Next.js application
  admin/               # owner/admin console

packages/
  ui/                  # shared design system
  ai/                  # model routing + AI contracts
  matching-engine/     # opportunity/eligibility logic
  shared/              # types, validation, utilities
  config/              # safe public configuration

supabase/
  migrations/          # PostgreSQL schema + RLS
  functions/           # privileged server-side logic
  seed/                # controlled seed data

docs/
  product/
  architecture/
  security/
  api/

tests/
```

## Rules

1. Browser code never contains service-role keys, payment secrets, owner credentials, or privileged decisions.
2. Paid-plan access is enforced server-side; UI locks are only the presentation layer.
3. Opportunity data is verified and source-linked.
4. Student Passport data is private by default.
5. AI recommendations remain explainable and do not make high-impact personal decisions for the user.
6. Every major feature should have a clear loading, empty, error, success, and locked state.
7. New changes should preserve keyboard navigation, responsive layouts, and reduced-motion support.

## AI direction

YUVRYX V1 will use a model-routing layer rather than hard-coding one model into every feature. The router can select capabilities for reasoning, coding, vision, document analysis, speech, and research while preserving one student context layer.

## Release discipline

Every feature change should be:
- implemented
- statically validated
- smoke-tested
- reviewed for security
- committed with a focused message
