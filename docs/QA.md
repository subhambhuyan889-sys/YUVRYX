# YUVRYX QA Checklist

## Navigation
- Every `data-v` navigation target maps to exactly one `.view`.
- Only one view is active at a time.
- Hash navigation opens the correct section.
- Invalid hashes fall back safely.

## Paid access
- Free features remain available.
- Paid-only surfaces show a lock state.
- UI clicks never grant a paid entitlement.
- Production entitlement checks must be server-side.

## Responsive
- Desktop sidebar works.
- Mobile drawer opens/closes.
- No horizontal page overflow.
- Cards and pricing grids collapse cleanly.

## Accessibility
- Keyboard focus remains visible.
- Reduced-motion preference is respected.
- Buttons have meaningful labels.
- Content remains readable without animation.

## Regression
Run:

```bash
node tests/yuvryx-smoke.mjs
```

Then manually verify the high-value flows: Home → AI → Study → Career → Benefits → Plans → Group Study → Surprise Test → Profile.
