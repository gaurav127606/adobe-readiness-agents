# Real-time customer insights & engagement

Interface walkthrough for the AJO **Profile Detail** screen (paired with [notes](README.md#notes) and the [layman example](Layman%20Example.md)).

## My takeaway

AJO operates on the Real-Time Customer Profile: it integrates all customer data — web, CRM, and offline — into one unified, 360-degree view.

## Left navigation

Grouped by function — maps to the Foundation/Profile/AJO Segmentation tracks:
- **Decision Management** (Offers, Components) — decisioning/personalization logic.
- **Content Management** (Assets, Content templates, Fragments) — reusable message building blocks.
- **Data Management** (**Schemas, Datasets**) — Foundation track: schemas define the *shape* of data, datasets store the actual records.
- **Connections** (Sources) — where raw data pipes in from (web, CRM, POS, etc.).
- **Customer** (Audiences, Subscription lists, **Profiles**) — Profile track; "Profiles" is selected here.
- **Privacy** (Requests) — GDPR/CCPA-style data subject requests.
- **Administration** (Configurations, Rules, Alerts, Channels, Tags) — admin persona's territory.

## Main panel — a single customer's unified profile

**Breadcrumb:** `Profiles > Profile BUF004WrrJmp5_1XXpqPoGnaG3vl3KJg` — the internal Profile ID AJO assigned this person.

**Tabs:** Detail (shown), Attributes, Events, Audience membership — Attributes shows every raw field, Events shows the timeline of what this customer did, Audience membership shows which segments they currently belong to.

**Merge policy:** "Profile using merge policy **Default Timebased**, Last modified time: 11/27/2023, 9:50 PM." When the same person shows up from multiple sources (e.g. an email from the website, a loyalty number from POS), AJO needs a rulebook for merging those into one profile — a **merge policy** (Timebased = newest data wins). This is the literal mechanism behind "integrate all your data into a unified profile."

**The four cards:**
1. **Customer profile** — human-readable summary: name ("Sandra Demo") + Profile ID.
2. **Basic attributes** — demographic/contact fields pulled together from whatever source(s) fed them in (address, gender, birthday, phone).
3. **Linked identities** — the **identity resolution** piece: AJO recognizes one physical person via more than one "key" (here, an email). "View identity graph" shows that web of connected identifiers visually.
4. **Channel preferences** — where/how this customer opted in to be reached (direct mail, phone, SMS, email, Facebook, Twitter) — feeds directly into omnichannel orchestration (e.g. don't SMS someone who only opted into email).

## Ties back to the pillar

"Real-time customer profile: Integrate all your data (web, CRM, offline) into a unified profile" = exactly this screen: one Profile ID, data stitched together from multiple sources, merged via a policy, with identity resolution linking the different "faces" of the same customer.
