# Segment Builder

**Track:** AJO Segmentation
**Goal:** Confidently build non-trivial segments
**Status:** Not started

## Link
https://experienceleague.adobe.com/en/docs/journey-optimizer-learn/tutorials/profiles-audiences-subscriptions/create-audiences-using-the-rule-builder

## Masterclass companion
Deeper explanation with worked Luma segment rules: **Module 08 — Segmentation** in the AEP
masterclass skill. Run `/learn aep segmentation`.
Local: [08-segmentation.md](../../../08-segmentation.md)

## Primer (read before you watch)

**What you'll learn:** how to use the **rule builder** to create real, non-trivial audiences by
combining profile attributes and event conditions.

**Key concepts:**
- Segment rules combine two kinds of conditions:
  - **Attribute (profile) conditions** — e.g. `loyaltyPoints >= 1000 AND membershipStatus = active`.
  - **Event (behavioral) conditions** — e.g. `viewed a product AND NOT converted within 24h`.
- Non-trivial segments layer AND/OR logic, time windows ("within 24h", "in last 90 days"), and
  event sequences.
- Worked examples (from the masterclass Luma scenario):
  - `ActiveCoffeeBuyers` = `eventType = conversion AND productCategory = "Coffee Machine" AND status = active`
  - `AbandonedBrowsers` = `eventType = productView AND NOT conversion within 24h`

**Common mistakes to avoid:** over-broad rules that qualify far more (or fewer) profiles than
intended — always check the estimated audience size; confusing attribute vs. event conditions.

**Where it fits the spine:** … → Profile → **Segment** → … the hands-on core of building audiences.

## Your notes
_(fill in as you complete the tutorial — key takeaways, screenshots, questions)_

## Self-check
1. What's the difference between an attribute condition and an event condition? Give one of each.
2. How would you build "viewed a product but didn't buy within 24 hours"?
3. Why check the estimated audience size after building a rule?
