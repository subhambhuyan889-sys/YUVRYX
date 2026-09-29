# YUVRYX

**The Limitless Power of Youth**

YUVRYX is a student-first platform designed to help people **learn, build, discover opportunities, take action, and grow** from one ecosystem.

## Product promise
- Every Student. Every Dream. Every Step.
- One account · One Student Passport · One ecosystem.
- Free-first, affordable-first.
- AI empowers users; it does not make personal decisions for them.
- Verified opportunities, transparent eligibility, and explainable recommendations.
- Privacy, security, accessibility, and reliability are product requirements.

## Core ecosystem
AI, Study & Education, Student Life, Skills, Projects, Career, Opportunities, Applications, Career Documents, Backlog Support, Student Passport, Progress & Readiness, Scholarships, Money Saver, Community, Group Study, Surprise Test, YUVRYX Champions, Student Store, Hackathon Kit Builder, College Companion, Global Opportunities, Team Finder, Digital Vault, Student Services, Tools & Resources, Plans & Benefits, and Owner/Admin.

## Production direction
The repository is being organized for a maintainable production application rather than a single-page demo.

### Planned stack
- Web: Next.js + React + TypeScript
- Backend: Supabase PostgreSQL + Auth + Storage + Realtime + Edge Functions
- Payments: Razorpay with server-side verification and idempotent webhooks
- Deployment: Vercel/Cloudflare + GitHub
- AI: multimodal model router, research/web layer, student-context layer, evaluation and safety controls

## Security rules
Never expose service-role keys, payment secrets, owner credentials, or privileged business logic in browser code. Paid access must be enforced server-side.

## Repository status
Initial repository setup. Features will be implemented incrementally with testable commits.