# Create a Test Profile

**Track:** Profile
**Goal:** Learn how to create a test profile
**Status:** Not started

## Link
https://experienceleague.adobe.com/en/docs/journey-optimizer-learn/tutorials/journeys/test-a-journey

> Note: the official link is the **"Test a journey"** tutorial — creating a test profile is the
> first step of testing a journey, which is why this item points there.

## Masterclass companion
Profiles: **Module 06 — RTCP**; journeys you'll test them against: **Module 10 — AJO Journeys &
Offers**. Run `/learn ajo` or `/learn aep profile`.
Local: [10-ajo-journeys.md](../../../10-ajo-journeys.md)

## Primer (read before you watch)

**What you'll learn:** how to create a **test profile** and use it to validate a journey before it
goes live — the safe way to confirm entry conditions, decisions, and messages behave as intended.

**Key concepts:**
- A **test profile** is a controllable, known profile you can push through a journey to see exactly
  what happens at each node.
- Testing lets you verify **entry qualification** (does this profile enter the journey?), branch
  **decisions**, and **message/offer** rendering without waiting for a real customer.
- Do this in a **development sandbox** (see Foundation → Sandboxes and Access) so you never test
  against live customer data.

**Common mistakes to avoid:** testing in production; using a profile that doesn't actually match the
journey's entry condition (then wondering why it never enters).

**Where it fits the spine:** a validation loop over **Profile → Segment → Orchestrate** — you're
confirming the profile qualifies for the segment and flows correctly through the AJO journey.

## Your notes
_(fill in as you complete the tutorial — key takeaways, screenshots, questions)_

## Self-check
1. Why create a test profile instead of waiting for a real customer to enter a journey?
2. Which sandbox should you run journey tests in, and why?
3. If a test profile never enters your journey, what's the most likely cause?
