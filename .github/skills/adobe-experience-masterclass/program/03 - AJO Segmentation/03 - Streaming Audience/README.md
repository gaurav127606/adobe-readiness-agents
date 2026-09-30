# Streaming Audience

**Track:** AJO Segmentation
**Goal:** Real-time use cases
**Status:** Not started

## Link
https://experienceleague.adobe.com/en/docs/experience-platform/segmentation/methods/streaming-segmentation

## Masterclass companion
Deeper explanation (batch vs. streaming vs. edge): **Module 08 — Segmentation** in the AEP
masterclass skill. Run `/define aep streaming segmentation`.
Local: [08-segmentation.md](../../../08-segmentation.md)

## Primer (read before you watch)

**What you'll learn:** how **streaming segmentation** evaluates profiles continuously as data
arrives, enabling near-real-time audience qualification.

**Key concepts:**
- **Streaming segmentation** re-evaluates a profile the moment qualifying data streams in — latency
  is seconds to minutes, not hours.
- It powers time-sensitive use cases: cart abandonment, churn-signal reactions, welcome flows,
  same-visit follow-ups.
- A segment can only behave in real time if its **triggering data also streams in** (Web/Mobile SDK,
  streaming API) — batch-ingested data can't drive a streaming audience instantly.
- Not every rule is eligible for streaming evaluation; complex historical logic often falls back to
  batch.

**Common mistakes to avoid:** expecting instant qualification from batch-ingested data; assuming
*every* segment can be streaming.

**Where it fits the spine:** … → Profile → **Segment (streaming)** → Activate/Orchestrate … the
fast lane that lets journeys react within a session.

## Your notes
_(fill in as you complete the tutorial — key takeaways, screenshots, questions)_

## Self-check
1. What latency does streaming segmentation offer, and name two use cases it enables.
2. Why can't a streaming segment react instantly if its data arrives via daily batch?
3. Is every segment eligible for streaming evaluation? What might force batch instead?
