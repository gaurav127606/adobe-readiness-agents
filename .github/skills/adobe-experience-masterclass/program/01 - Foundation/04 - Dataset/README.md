# Dataset

**Track:** Foundation
**Goal:** Understand data → profile
**Status:** Not started

## Link
https://experienceleague.adobe.com/en/docs/platform-learn/tutorials/data-ingestion/create-datasets-and-ingest-data?lang=en

## Masterclass companion
Deeper explanation and Mermaid flow: **Module 02 — Data Ingestion** in the AEP masterclass skill.
Run `/learn aep ingestion`.
Local: [02-data-ingestion.md](../../../02-data-ingestion.md)

## Primer (read before you watch)

**What you'll learn:** how to create a **dataset** from a schema and ingest data into it, and the
one toggle that decides whether that data ever reaches a customer profile.

**Key concepts:**
- **Dataset** — a stored table of data that conforms to a schema. You ingest *into* a dataset.
- **Profile enablement** — the toggle that says "include this dataset in the Real-Time Customer
  Profile." **Off = the data exists but never appears in any profile.** This is the single biggest
  "why can't I see my data?" gotcha.
- Record data (state) lands in a **Profile-class** dataset; event data (history) lands in an
  **ExperienceEvent-class** dataset.

**Common mistakes to avoid:** ingesting data into a dataset but forgetting to profile-enable it, then
wondering why the profile is empty; skipping/mismapping the XDM field mapping on the way in.

**Where it fits the spine:** Ingest → **Model** → Identity → **Profile** … a dataset is where
ingested data lands and, if profile-enabled, becomes part of the unified profile.

## Your notes
_(fill in as you complete the tutorial — key takeaways, screenshots, questions)_

## Self-check
1. What is a dataset, and how does it relate to a schema?
2. Data was ingested but no profile shows it — what's the first thing to check?
3. Which class of dataset holds a customer's purchase events vs. their loyalty tier?
