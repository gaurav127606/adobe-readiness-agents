# Profiles

**Track:** Foundation
**Goal:** Understand unified profile
**Status:** Not started

## Link
https://experienceleague.adobe.com/en/docs/platform-learn/tutorials/profiles/understanding-the-real-time-customer-profile?lang=en

## Masterclass companion
Deeper explanation and Mermaid assembly diagram: **Module 06 — Real-Time Customer Profile** in the
AEP masterclass skill. Run `/learn aep profile` or `/define aep RTCP`.
Local: [06-rtcp-profile.md](../../../06-rtcp-profile.md)

## Primer (read before you watch)

**What you'll learn:** what the **Real-Time Customer Profile (RTCP)** is, and how AEP assembles one
unified view of a customer from many scattered fragments.

**Key concepts:**
- **RTCP is not a customer table — it's a real-time *assembly engine*.** The profile you see is
  computed on the fly, not stored as a single row.
- **Profile fragment** — one partial contribution from one source (CRM tier, web product views, POS
  purchases). No single system has the whole customer.
- RTCP resolves every fragment to the **identity graph** (Identity topic) and **merges** them into
  one view — attributes *and* the event time-series together.
- **Union schema** — the combined view of all profile-enabled schemas of a class, so RTCP knows the
  full set of fields that can describe a person.

**Common mistakes to avoid:** thinking it's a static database; forgetting profile enablement (then
the field is missing); expecting real-time updates from a field that only arrives via daily batch.

**Where it fits the spine:** Ingest → Model → Identity → **Profile** → Segment → … the profile is
what every segment, journey, and report reads from.

## Your notes
_(fill in as you complete the tutorial — key takeaways, screenshots, questions)_

## Self-check
1. Why is "assembly engine" more accurate than "customer table"?
2. What two AEP capabilities does RTCP rely on to merge fragments correctly?
3. Can a profile be truly real-time if its loyalty tier comes from a nightly batch file? Why?
