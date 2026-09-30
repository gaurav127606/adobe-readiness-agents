# Batch Audience

**Track:** AJO Segmentation
**Goal:** Batch use cases
**Status:** Not started

## Link
https://experienceleague.adobe.com/en/docs/experience-platform/segmentation/methods/batch-segmentation

## Masterclass companion
Deeper explanation (batch vs. streaming vs. edge): **Module 08 — Segmentation** in the AEP
masterclass skill. Run `/define aep batch segmentation`.
Local: [08-segmentation.md](../../../08-segmentation.md)

## Primer (read before you watch)

**What you'll learn:** how **batch segmentation** evaluates the full profile store on a schedule, and
when batch is the right choice over streaming.

**Key concepts:**
- **Batch segmentation** runs on a schedule (typically daily), evaluating profiles in bulk — latency
  is hours, not seconds.
- It's the right tool for **large audiences** and **complex historical logic** (e.g. "purchased 3+
  times in the last 90 days", "lifetime value > X") that don't need instant reaction.
- Batch and streaming are complementary — many implementations use both: streaming for
  time-sensitive triggers, batch for big analytical audiences.

**Common mistakes to avoid:** using batch for a use case that needs same-session reaction (abandoned
cart); expecting a batch audience to update the instant a customer's data changes.

**Where it fits the spine:** … → Profile → **Segment (batch)** → Activate … the scheduled lane for
large or historically-complex audiences.

## Your notes
_(fill in as you complete the tutorial — key takeaways, screenshots, questions)_

## Self-check
1. What latency does batch segmentation have, and what kind of audiences suit it?
2. Give an example of segment logic that's better suited to batch than streaming.
3. Why do many real implementations use both batch and streaming segmentation?
