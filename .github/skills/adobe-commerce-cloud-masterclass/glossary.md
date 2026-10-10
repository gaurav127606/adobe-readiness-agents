# Glossary

Plain-English definitions of every term across the full confirmed series (Modules 1–8 + the Module
10 capstone, from LinkedIn series Parts 1–6, 2026-08-15 — Part 6 was the final part). Module 9
(CI/CD) is confirmed **not** part of this source series — see SKILL.md "Still open."

**ACCS (Adobe Commerce as a Cloud Service)** — Adobe's SaaS commerce platform: Adobe-managed
backend + API layer + out-of-process extensibility. See Modules 1–2.

**Adobe Commerce Backend** — the system of record inside ACCS: catalog, cart, checkout, orders,
customers. Adobe-managed, automatically upgraded. See Module 2.

**Commerce APIs & Services** — the interface layer between the backend and everything else (GraphQL
+ SaaS services: catalog, search, recommendations, data connection). See Modules 2–3.

**Out-of-process extensibility** — the umbrella term for App Builder, API Mesh, Events, and Admin
UI SDK: all four extend ACCS from *outside* the backend process, which is what makes upgrades safe.
See Module 2. (Each tool itself is covered in its own module — 5, 6, 7, 8 respectively, not yet
written.)

**EDS (Edge Delivery Services)** — the edge-rendered storefront layer: renders and delivers pages
from the edge (close to the customer) for speed, SEO, and Core Web Vitals. See Module 3.

**Blocks** — reusable content and commerce building blocks used to compose EDS page layouts. Split
into Content Blocks and Commerce Blocks. See Module 4.

**Content Block** — a Block for content-driven experiences (marketing/informational content,
landing/campaign pages), authored in Adobe Experience Manager (DA.live); does not depend on commerce
APIs. See Module 4.

**Commerce Block** — a Block for data-driven experiences (product data, recommendations, search
results); consumes Commerce APIs & Services (GraphQL + SaaS) and updates based on data/user context.
See Module 4.

**Drop-in Components** — prebuilt, ready-to-use commerce UI for PDP, PLP, Cart, Checkout, and Auth
(Authentication & Account). Built by Adobe with proven patterns; upgrade-friendly. See Module 4.

**PDP / PLP** — Product Detail Page / Product Listing Page.

**Extension Patterns (Slots · Containers · Lifecycle Hooks)** — the three ways to customize a
Drop-in Component without modifying it: Slots inject UI/content at predefined locations, Containers
wrap a component to add logic/layout, Lifecycle Hooks react to component events to run custom logic.
"Extend, don't modify." See Module 4.

**Extensibility decision framework** — the ordered decision tree for choosing an extension
mechanism: Content Block → Commerce Block → Drop-in Component → Extend with Patterns (custom code),
always picking the highest-level abstraction that solves the problem first. See Module 4.

**Storefront Services** — the SaaS microservices behind the Commerce APIs & Services layer: Catalog
Service, Live Search, Product Recommendations, Data Connection. See Module 3.

**Core Web Vitals** — Google's real-world page-experience metrics (load speed, interactivity, visual
stability); cited in the source as a benefit of EDS's edge-rendering model. See Module 3.

**Loading Strategy (Eager / Lazy / Delayed)** — EDS's model for *when* different parts of a page
load: eager = critical content immediately, lazy = non-critical blocks/assets after initial render,
delayed = analytics/marketing/chat/third-party scripts, deferred furthest. See Module 3.

**App Builder (Adobe App Builder)** — Adobe's serverless out-of-process extensibility platform:
custom business logic and integrations, running as Adobe I/O Runtime Actions, downstream of both
Commerce APIs and Adobe Events, upstream of external systems (ERP, CRM, PIM, payment, AI, 3rd-party
APIs). See Module 5.

**Adobe I/O Runtime Action** — the actual unit of deployment in App Builder: a serverless,
scalable, secure, event-driven function. See Module 5.

**Adobe Events (Event Broker)** — the pub/sub layer Adobe Commerce publishes business events into
(e.g. "Order Created"); any interested consumer (ERP, CRM, email, analytics, AI services, fraud,
OMS/WMS, or an App Builder action) can react independently, without Commerce knowing they exist.
Named in the extensibility branch (Module 2); introduced as an App Builder input in Module 5;
detailed as event-driven architecture in Module 7.

**Business event** — a named occurrence Commerce publishes (e.g. "Order Created") that consumers
subscribe to, rather than being called directly. See Module 7.

**Event-driven architecture (vs. synchronous/request-response)** — communication model where
publishers and consumers only share an event contract, not direct calls; trades tight, sequential
coupling for loose, asynchronous, independently scalable consumers. See Module 7.

**API Mesh (Adobe API Mesh)** — a single, unified GraphQL endpoint that sits between the storefront
and every backend system (Commerce, ERP, CRM, Inventory, Pricing, Loyalty, AI Services, Reviews),
aggregating/filtering/transforming/securing responses so consumers make one call instead of many.
See Module 6.

**Federation** (API Mesh) — combining capabilities across distributed services into the mesh. See
Module 6.

**Aggregation** (API Mesh) — pulling data from multiple backend systems into one response. See
Module 6.

**Admin UI SDK** — the tool for extending the Commerce Admin experience for internal business users
(merchandisers, customer service, operations, administrators, finance) without core customization;
extensions appear as a natural part of the native Admin UI. See Module 8.

**Master extensibility decision framework** — the whole-stack decision tree (Module 5): storefront
experience → EDS/Drop-ins; commerce data → Commerce APIs & Services; custom business logic →
App Builder; external integration → App Builder; admin customization → Admin UI SDK. Module 4's
Content/Commerce Block → Drop-in → Extension Pattern tree is a zoom-in on this framework's first
branch.

**The ACCS Extensibility Journey** — the series' own closing summary (Module 10): Storefront
Extensibility (Modules 3–4) → Business Logic Extensibility (Module 5) → Integrations Extensibility
(Module 6) → Event-Driven Communication (Module 7) → Admin Experience Extensibility (Module 8) →
"build on the platform, not inside it."
