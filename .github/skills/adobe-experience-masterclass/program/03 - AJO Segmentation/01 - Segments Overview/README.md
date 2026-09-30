# Segments Overview

**Track:** AJO Segmentation
**Goal:** Learn segmentation strategy
**Status:** Not started

## Link
https://experienceleague.adobe.com/en/docs/experience-platform/segmentation/methods/overview

## Masterclass companion
Deeper explanation and Mermaid flow: **Module 08 — Segmentation** in the AEP masterclass skill.
Run `/learn aep segmentation` or `/define aep segment`.
Local: [08-segmentation.md](../../../08-segmentation.md)

## Primer (read before you watch)

**What you'll learn:** the segmentation strategy behind AEP — what a segment really is, and the
different evaluation methods available.

**Key concepts:**
- **Segments are not lists — they are continuously evaluated conditions.** The **Segmentation
  Service** evaluates profiles against rules every second.
- Three evaluation methods (next two topics go deeper on two of them):
  - **Batch** — evaluated on a schedule (hours); large, non-urgent audiences.
  - **Streaming** — evaluated continuously as data arrives (seconds–minutes); react-quickly cases.
  - **Edge** — evaluated at the edge, same session; fastest personalization.
- Segmentation sits on the resolved, merged profile, so it inherits every upstream decision
  (identity stitching, profile assembly, merge policy).

**Common mistakes to avoid:** treating audiences as static exports; blaming the segment rule when
the real cause is upstream (wrong identity graph or merge policy qualifies the wrong people).

**Where it fits the spine:** … → Profile → **Segment** → Activate → … this is where profiles become
targetable audiences.

## Your notes
_(fill in as you complete the tutorial — key takeaways, screenshots, questions)_

## Self-check
1. Why is "continuously evaluated condition" more accurate than "list"?
2. Name the three segmentation methods and one use for each.
3. An audience contains the wrong people — name two upstream causes before blaming the rule.
