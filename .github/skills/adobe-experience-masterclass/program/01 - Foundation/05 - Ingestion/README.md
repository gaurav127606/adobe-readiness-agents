# Ingestion

**Track:** Foundation
**Goal:** See data live
**Status:** Not started

## Link
https://experienceleague.adobe.com/en/docs/journey-optimizer-learn/tutorials/data-management/create-datasets-and-ingest-data

## Masterclass companion
Deeper explanation and Mermaid flow: **Module 02 — Data Ingestion** in the AEP masterclass skill.
Run `/learn aep ingestion` or `/define aep Web SDK`.
Local: [02-data-ingestion.md](../../../02-data-ingestion.md)

## Primer (read before you watch)

**What you'll learn:** the ways data actually enters AEP, and — crucially — why the ingestion method
you choose decides whether real-time reactions are even possible later.

**Key concepts:**
- **Streaming (seconds):** Web SDK, Mobile SDK, streaming/HTTP APIs — for live behavior.
- **Batch (minutes–hours, scheduled):** file upload (CSV/Parquet), source connectors (CRM, cloud
  storage, databases).
- **Batch vs. streaming is not a preference — it's a real-time question.** If a triggering event
  arrives by daily batch, no journey can react to it in seconds, no matter how good AJO is.
- Every path must **map to XDM** on the way in, and land in a **dataset**.

**Common mistakes to avoid:** choosing batch for data that needs a same-session reaction (e.g.
abandoned-cart); ingesting events with no identity field (they become orphans that can't be stitched
to a person).

**Where it fits the spine:** **Ingest** → Model → Identity → … this is the front door; latency you
accept here is latency you're stuck with everywhere after.

## Real-world example (optional)
A commerce-to-AEP integration project deliberately used a different ingestion method per data type,
which is a good illustration of "batch vs. streaming is a real-time question, not a preference":
**order events** were streamed in near-real-time (via a streaming/HTTP-style API) since journeys
needed to react within seconds of a purchase; the **full product catalog** was sent as a nightly
**batch file upload** (SFTP/CSV) since it's just lookup/reference data with no urgency; and **price
and stock changes** were streamed as they happened, because a same-day price-drop or restock alert
is only useful if it arrives before the customer loses interest. Same platform, three ingestion
methods, chosen per how time-sensitive each data type actually is — not by default habit.

## Your notes
_(fill in as you complete the tutorial — key takeaways, screenshots, questions)_

## Self-check
1. Name a streaming and a batch ingestion method, and a good use for each.
2. Why is "batch vs. streaming" a real-time question, not just a performance detail?
3. What must every ingestion path do to the incoming data before it's usable?
