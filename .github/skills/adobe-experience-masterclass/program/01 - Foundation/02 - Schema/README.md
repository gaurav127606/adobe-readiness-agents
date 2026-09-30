# Schema

**Track:** Foundation
**Goal:** Learn profile modelling
**Status:** Not started

## Link
https://experienceleague.adobe.com/en/docs/platform-learn/tutorials/schemas/create-schemas?lang=en

## Masterclass companion
Deeper explanation, Mermaid diagrams, and a quiz: **Module 03 — XDM & Schemas** in the AEP
masterclass skill. Run `/learn aep schemas` or `/define aep XDM`.
Local: [03-xdm-schemas.md](../../../03-xdm-schemas.md)

## Primer (read before you watch)

**What you'll learn:** how to model customer data in **XDM** (Experience Data Model) by creating a
schema from a class + field groups, and why that modelling decision shapes everything downstream.

**Key concepts:**
- **XDM** — Adobe's standard JSON schema language; everything in AEP speaks it.
- **Two classes:** **Individual Profile** = a person's current *state* (name, email, loyalty tier);
  **ExperienceEvent** = a single time-stamped *thing that happened* (a product view, a purchase).
  One-liner to remember: **Profile = state, ExperienceEvent = history.**
- **Field groups** (reusable field bundles) and **data types** compose a schema.
- **Identity fields** — the fields you flag as identities (email, CRM ID, ECID) wire the schema into
  Identity Service (next topic).

**Common mistakes to avoid:** cramming everything into "one giant schema"; modelling an event as a
profile attribute (or vice-versa); marking a non-unique field as an identity.

**Where it fits the spine:** Ingest → **Model** → Identity → Profile → Segment → Activate →
Orchestrate → Analyze. Schema design *is* the Model stage — get it wrong and every later stage
inherits the problem.

## Real-world example (optional)
A commerce-to-AEP integration project modeled both an "order placed" event and a "product price/stock
update" event as **ExperienceEvent** schemas (both are timestamped moments, not ongoing state).
Custom fields (e.g. a product image URL, a warehouse code, a special category) were added under a
company-specific **tenant namespace**, nested inside the standard product-line-items field group —
exactly the class → field group → custom field flow this topic teaches. One subtlety from that
project worth knowing: the product-update schema declared the **SKU** as its primary identity field.
That's fine — identities aren't only for people; a product-level schema can use a product-level key
so its events are joinable/lookup-able — but it only works because it's *not* a person-schema. Don't
carry that pattern into a Profile schema without checking [[Identity]] first.

## Your notes
_(fill in as you complete the tutorial — key takeaways, screenshots, questions)_

## Self-check
1. What's the difference between the Individual Profile class and the ExperienceEvent class?
2. Why does an ExperienceEvent schema require a timestamp but a Profile schema doesn't?
3. Why is marking `customerType = Gold` as an identity field dangerous?
