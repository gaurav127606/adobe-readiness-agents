# Glossary — Adobe Experience Cloud Ecosystem

Plain-English definitions. Each entry says **what it is**, and where useful, **where it sits on the
spine** (Ingest → Model → Identity → Profile → Segment → Activate → Orchestrate → Analyze). Use this
to back `/define aep`.

## The core products

- **Adobe Experience Cloud** — the umbrella brand for all of Adobe's enterprise customer-experience
  products (AEP, RTCDP, AJO, CJA, Analytics, Target, Commerce, Campaign, etc.). Not a single product.
- **AEP — Adobe Experience Platform** — the *foundation layer*. It ingests data, models it (XDM),
  resolves identity, assembles the Real-Time Customer Profile, and builds audiences. Most other
  Adobe apps are *powered by* AEP rather than being separate silos. **Mental model: AEP is the
  engine; the other apps are powered by it.**
- **RTCDP — Real-Time Customer Data Platform** — an *application built on AEP* focused on collecting
  profiles, building audiences, and activating them to external destinations (ads, email, etc.). If
  AEP is the engine, RTCDP is the "audiences & activation" product packaged on top of it.
- **AJO — Adobe Journey Optimizer** — orchestration. Reads the unified profile, evaluates people
  against segment rules, and triggers **journeys** (multi-step flows) and **offers** (personalized
  decisions) across channels in real time. Spine: *Orchestrate*.
- **CJA — Customer Journey Analytics** — analysis. Connects AEP datasets to produce unified reports:
  funnels, revenue attribution, journey performance. Spine: *Analyze*.
- **Adobe Analytics** — Adobe's long-standing web/behavioral analytics product. CJA is the newer,
  AEP-native evolution that can blend online + offline + cross-channel data on the shared identity.
- **Adobe Target** — on-site / in-app personalization and A/B testing. Consumes profiles/audiences
  to decide what a given visitor sees. Spine: *Activate* (on your own properties).
- **Adobe Campaign** — Adobe's earlier cross-channel campaign/messaging product (email, SMS,
  direct). AJO is the newer AEP-native successor for journey-based messaging.
- **Adobe Commerce (Magento)** — the commerce/storefront platform. A *source* of events (product
  views, add-to-cart, orders) that flow into AEP. Not part of AEP itself.

## Data modeling

- **XDM — Experience Data Model** — Adobe's standardized, open schema language for describing
  customer data as structured JSON. Everything in AEP speaks XDM. Spine: *Model*.
- **Schema** — a definition of the shape of data: which fields exist, their types, and which class
  it belongs to. Two classes matter most below.
- **Class** — the top-level "type" of a schema. The two you must know:
  - **Individual Profile (Profile) class** — describes a person's current **state** (name, email,
    loyalty tier, engagement score). "Who they are right now."
  - **ExperienceEvent class** — describes a single **time-stamped thing that happened** (a
    productView, a ctaClick, a conversion). "What they did, and when." History, not state.
- **Field group** (formerly "mixin") — a reusable bundle of fields you attach to a schema (e.g. a
  "loyalty" field group, a "commerce" field group).
- **Data type** — a reusable multi-field structure (e.g. an "address" with street/city/zip).
- **Schema Registry** — the system (with a UI *and* an API) where all schemas, field groups, classes,
  and identity descriptors live and are enforced. The UI is the surface; the Registry is the truth.
- **Dataset** — a stored table of data that conforms to a schema. You ingest *into* a dataset. A
  dataset can be **Profile-enabled** so its data contributes to the Real-Time Customer Profile.
- **Union schema** — the automatically-combined view of all Profile-enabled schemas of the same
  class. It's how RTCP sees "all the fields that could describe a person."

## Identity

- **Identity** — a value that identifies a customer, always paired with a **namespace** for context.
- **Identity namespace** — the *type* of an identifier, giving a raw value meaning. `12345` is
  ambiguous; `CRMID:12345` is not. Examples: **ECID**, **Email**, **CRMID**, **Phone**, **LoyaltyID**.
- **ECID — Experience Cloud ID** — the anonymous cookie/device identifier Adobe assigns to a visitor
  before they log in. Usually the *first* identity a customer has. (Older name: MCID.)
- **Primary identity** — the identity marked as the main key for a record (e.g. `customerid` /
  `CRMID`). **Secondary identities** (email, ECID) link to it.
- **Identity Service** — the AEP service that connects identifiers to each other. **It does not
  identify people; it connects identifiers.** Spine: *Identity*.
- **Identity Graph** — the network of connected identifiers Adobe builds per person. As new data
  arrives with overlapping IDs, the graph grows and stitches fragments together.
- **Identity stitching** — the act of linking a previously-anonymous identity (ECID) to a known one
  (email/CRMID) when a login/purchase/form-submit provides the "bridge" event.
- **Identity Graph Collapse** — the nightmare failure: marking a non-unique field (e.g.
  `country = India`, `tier = Gold`) as an identity causes thousands of unrelated people to be linked
  into one giant graph. Everything downstream (profiles, audiences, reports) becomes unreliable.

## Profile & assembly

- **RTCP — Real-Time Customer Profile** — the continuously-assembled, up-to-date view of a customer,
  built by merging all Profile-enabled fragments (attributes + events) resolved to the same identity
  graph. **Not a table — an assembly engine.** Spine: *Profile*.
- **Profile fragment** — one partial contribution to a profile from one dataset/source (CRM says one
  thing, web says another). RTCP merges fragments into one view.
- **Merge policy** — the *rules* that decide which data wins when fragments conflict: which datasets
  take precedence, and whether newest-timestamp or dataset-priority order applies. **A profile is
  constructed truth, and the merge policy is the construction rule.** Spine: *Profile*.
  - **Timestamp Ordered** — most recent value wins.
  - **Dataset Precedence** — a ranked list of datasets decides the winner regardless of recency.
- **Profile enablement** — a toggle on a dataset/schema that says "include this in RTCP." Off = the
  data exists but never reaches the profile.

## Audiences & activation

- **Segment / Audience** — a group of profiles that match a condition. **Not a static list — a
  continuously evaluated condition** that profiles flow in and out of as their data changes.
  ("Audience" is the current umbrella term; "segment definition" is the rule behind it.) Spine:
  *Segment*.
- **Segmentation Service** — the engine that continuously evaluates profiles against segment
  definitions.
- **Batch segmentation** — evaluated on a schedule (e.g. daily). Good for large, non-urgent audiences.
- **Streaming segmentation** — evaluated continuously as data streams in (seconds/minutes).
- **Edge segmentation** — evaluated at the edge for the fastest same-page/same-session use cases.
- **Destination** — a pre-built connector that sends audiences/profiles *out* of AEP to an external
  platform (Meta, Google Ads, email ESPs) or an Adobe app (AJO, Target). Spine: *Activate*.
- **Activation** — the act of sending an audience to a destination so it can drive experiences.
  - **Audience (segment) activation** — send a whole audience.
  - **Profile activation** — send individual profile attributes for personalization.
  - **Streaming vs. batch activation** — how fast the audience reaches the destination.
- **Audience count mismatch** — audience sizes rarely match exactly across platforms (identity
  match rates, hashing, consent, timing differ). Expected, not necessarily a bug.

## Orchestration (AJO) & analytics (CJA)

- **Journey** — an AJO multi-step flow: an **entry** condition, **decision** splits, **action** nodes
  (send email/push/offer), and **wait** steps. Example from the simulator: *Cross-Sell Journey* —
  enter on `ActiveCoffeeBuyers` → decision "bought accessories?" → send "20% off" → wait 2 days →
  thank-you email → exit.
- **Offer / Offer Decisioning** — AJO's engine that evaluates all eligible offers against a profile
  and picks the single highest-priority one to serve (e.g. `OFF-001 Lavazza Pro Upgrade`,
  priority High, rule `machinetype = Lavazza`).
- **Decisioning rule** — the eligibility condition on an offer (e.g. `engagementScore < 50`).
- **Conversion funnel** — the staged drop-off report: Product Views → CTA Clicks → Conversions.
- **Attribution** — assigning credit for revenue to the offers/journeys/touchpoints that drove it.
- **dataLayer** — the client-side object where web events are collected before being sent as XDM
  ExperienceEvents into AEP. In the simulator, "Fire ProductView/CTA/Conversion" writes here.

## Common event types (in the Luma example)

- **productView** — customer looked at a product (e.g. "Lavazza Pro").
- **ctaClick** — customer clicked a call-to-action ("Add to Cart", "Learn More").
- **conversion** — customer completed a purchase.

## Acronyms quick-reference

| Acronym | Expansion |
|---------|-----------|
| AEP | Adobe Experience Platform |
| RTCDP / CDP | (Real-Time) Customer Data Platform |
| AJO | Adobe Journey Optimizer |
| CJA | Customer Journey Analytics |
| AA | Adobe Analytics |
| XDM | Experience Data Model |
| RTCP | Real-Time Customer Profile |
| ECID / MCID | Experience Cloud ID (Marketing Cloud ID) |
| ESP | Email Service Provider |
| SDK | Software Development Kit (Web SDK / Mobile SDK) |
| CRM | Customer Relationship Management (system) |
| POS | Point of Sale |
| ROI | Return on Investment |
