---
name: product-routing
description: "Routing table for the Adobe readiness agents: which skill covers which product (Adobe Commerce ERP/WMS/retail, Edge Delivery Services, AEP/RTCDP/AJO/CJA) and which files each role (Trainer, Architect, Developer) loads. Use when: an orchestrator, trainer, architect or developer agent must pick the product skill and files for a request."
user-invocable: false
---

# Product routing

Pick the minimum set of rows the request touches, and load a role's files only when the question
needs them — never a whole row up front.

| Product | Trigger words | Skill | Trainer | Architect | Developer |
|---|---|---|---|---|---|
| Commerce ⇄ ERP/WMS/3PL | ERP, WMS, 3PL, inventory sync, MSI, Source Item, Salable Quantity, Reservation, GRN, ASN, BOM, cycle count, picking | `erp-wms-glossary` | the topic file holding the term | `commerce-architect-playbook` + `adobe-commerce-integration-points.md`, `wms-erp-systems-terms.md` | `commerce-developer-playbook` + `adobe-commerce-integration-points.md` |
| Retail commerce | POS, BOPIS, curbside, loyalty, promotion, checkout, cart/quote, order lifecycle, Pay@Pump, QSR, kiosk | `retail-glossary` | the topic file holding the term | `commerce-architect-playbook` | `commerce-developer-playbook` + `ecommerce-order-lifecycle.md` |
| Edge Delivery Services | EDS, AEM Franklin, Helix, DA.live, Sidekick, Code Sync, block, boilerplate, aem.page, aem.live, `aem up`, storefront on EDS | `eds-enablement-masterclass` | module per its `learning-path.md`; `glossary.md`; `simulator-walkthrough.md`; `program/` | `02-architecture-and-content-hub.md`, `03-why-eds-and-alternatives.md`, `06-real-world-commerce-storefront-build.md` | `04-hands-on-setup-and-code-sync.md`, `05-da-live-authoring-and-publishing.md`, `06-real-world-commerce-storefront-build.md` |
| AEP / RTCDP / AJO / CJA | AEP, XDM, schema, dataset, ingestion, identity, profile, merge policy, segment, audience, destination, journey, offer decisioning, CJA, attribution | `adobe-experience-masterclass` | module per its `learning-path.md`; `glossary.md`; `simulator-walkthrough.md`; `program/` | `03-xdm-schemas.md`, `05-identity-service.md`, `07-merge-policies.md`, `08-segmentation.md`, `09-destinations-activation.md`, `10-ajo-journeys.md` | `02-data-ingestion.md`, `03-xdm-schemas.md`, `04-schema-registry.md`, `08-segmentation.md` |

## Rules

- A request spanning products (e.g. an EDS storefront block calling a Commerce backend, AEP
  audiences built from Commerce orders) loads each matching row's skill.
- No row matches → say no skill is installed for that product. Don't improvise expertise.
- Adding a product = its skill folder under `.github/skills/` + one row here. No agent changes.
