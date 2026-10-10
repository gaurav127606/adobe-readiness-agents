# Scenario Walkthrough — The Kiosk-vs-Delivery Promo Code

This is this masterclass's running example — the equivalent of the AEP masterclass's Luma scenario.
**Source:** the author's App Builder article series, confirmed as the standing running example
2026-08-15.

## The scenario

> A retailer wants one small thing: *a promo code that only works on the in-store kiosk, not on the
> delivery app.*

Small, concrete, and deliberately mundane — the point isn't that this is a hard problem, it's that
the *way* you solve it reveals everything about why this whole stack is shaped the way it is.

## Old way — core customization

1. A developer edits Commerce core/module code to add the channel check.
2. The change ships bundled with the next full platform release.
3. Every channel — web, kiosk, delivery — gets redeployed, even though only kiosk needed to change.
4. Something breaks? You roll back the *entire* release to undo *one* rule.

## New way — App Builder (out-of-process extensibility)

1. A developer writes one small, independent action: *"if channel = kiosk and code = X, apply
   discount."*
2. They deploy just that action — hours, not a release cycle.
3. Web and delivery never even see a deployment; they're untouched.
4. Something breaks? Disable one action. Nothing else moves.

**Same business outcome. Completely different blast radius.**

## Why this is the right running example for this masterclass

It's a direct, concrete instance of the confirmed spine's central claim (Modules 1–2): the backend
stays untouched; a piece of out-of-process extensibility (here, App Builder) reacts to a condition
and adds behavior; nothing else in the stack needs to know it happened. The "old way" is exactly
what the layered/composable architecture in Module 1 was built to avoid, and the "new way" is what
"upgrade-safe extensibility" (Module 2) and "independent deployment model" look like *in practice*,
not just as bullet points.

## How to place this scenario on the spine, module by module

- **Module 1–2 (Backend + extensibility branch):** the Adobe Commerce Backend never changes; the
  App Builder action attaches to the extensibility branch, not to core.
- **Module 4 (decision framework):** this is a "need custom behavior" case (channel + code check is
  business logic, not content or existing commerce data) — but note it's *not* a Drop-in/Block
  concern at all; it's backend-side custom logic, which is why it routes to App Builder (Module 5)
  rather than to a storefront Extension Pattern (Slots/Containers/Hooks). Worth revisiting once
  Module 5 clarifies exactly where App Builder actions plug in versus storefront-side patterns.
- **Module 3 (EDS Storefront):** the storefront shows the discount once applied — it never needed a
  deployment, which is the "web and delivery never even see a deployment" line made concrete.
- **Module 5 (App Builder, written):** confirmed at the architecture level — the App Builder action
  sits downstream of both Commerce APIs (to read the channel/apply the discount) and Adobe Events
  (to react in real time), and it doesn't touch any of the external-system categories (ERP/CRM/PIM/
  payment/AI/3rd-party APIs) — this scenario only exercises the "custom business logic" arm of
  Module 5's decision framework, not the "integration" arm.
- **Module 6 (API Mesh, written):** not exercised by this scenario — see Module 6's own grounding
  note for why.
- **Module 7 (Events, written):** confirms the general pattern (Commerce publishes a business event,
  Adobe Events broker fans it out to independent consumers) but its worked example is "Order
  Created" for a *different* use case (order fulfillment fan-out to ERP/CRM/email/etc.) — not this
  scenario's trigger. The specific event this scenario would use (something closer to "coupon
  applied" or "cart updated") is still not named by any source material.
- **Module 8 (Admin UI SDK, written):** not exercised — no internal-admin tooling is part of the
  scenario as described.
- **Module 10 (capstone, written):** this scenario is used as the through-line across all five
  extensibility mechanisms — it's a strong, fully-confirmed example for exactly one of them (Module
  5/App Builder), and Module 10 states plainly that it doesn't demonstrate the other four rather than
  stretching it to fit.

## Check yourself

1. In the "old way," name every system that had to redeploy for a one-channel rule change, and why
   each one didn't actually need to.
2. In the "new way," what's the *only* thing that changes when the promo rule is disabled?
3. Why does this scenario belong to the extensibility branch (Module 2) rather than the Commerce
   APIs & Services layer?
4. Per Module 5's decision framework, which of the two questions ("custom business logic?" or
   "integration with ERP/CRM/AI/external APIs?") does this scenario answer YES to — and which does
   it answer NO to?

## Still open

The specific Adobe Event (if any) this action subscribes to isn't named by any source material so
far, including Module 7's own worked example ("Order Created," which is for a different use case).
Don't invent one; say it's unconfirmed.
