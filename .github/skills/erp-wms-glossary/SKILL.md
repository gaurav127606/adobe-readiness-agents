---
name: erp-wms-glossary
description: "ERP, WMS and supply-chain vocabulary in plain English, mapped to Adobe Commerce inventory/order concepts (MSI, Sources, Source Items, Stocks, Salable Quantity, Reservations, Shipments). Use when: an ERP/WMS/3PL/TMS/OMS integration, inventory sync, GRN, ASN, BOM, cycle count, ABC analysis, safety stock, wave/zone/batch picking, cross-docking, AGV, control tower, EDI vs API integration, or 'how does this map to MSI' comes up."
---

# ERP & Warehouse Management Glossary — Domain Knowledge Skill

## Purpose

Adobe Commerce/Magento developers regularly sit in customer conversations about integrating with
an ERP, a WMS, or a 3PL, and those conversations are conducted in supply-chain vocabulary
(cycle counts, ABC analysis, wave picking, GRNs, control towers) that has nothing to do with
Magento internals. Not knowing this vocabulary makes a technically capable developer sound
unprepared in front of a customer's ops/supply-chain stakeholders.

This skill translates ERP, warehouse-management-system (WMS), and supply-chain vocabulary into
plain language, and — critically — maps it to the actual integration points Adobe Commerce
developers touch (MSI, source items, inventory reservations, order management APIs) so the
knowledge is immediately usable in a scoping or design conversation, not just trivia.

## When to use

- A customer or PM mentions ERP/WMS/3PL/TMS integration and you need to understand what system
  is doing what before proposing an Adobe Commerce integration approach.
- You're scoping an inventory-sync, order-sync, or fulfillment-status integration and need to know
  what terms like "ASN," "GRN," "cycle count," or "cross-docking" actually mean to the customer's
  ops team.
- You're in a discovery call and the customer describes their warehouse process (picking waves,
  pallet racks, drive-in storage, AGVs) and you need enough context to ask informed follow-up
  questions.
- You need to explain how Adobe Commerce's own inventory model (MSI, sources, stocks) maps to
  general WMS/ERP concepts a customer already knows.

## When NOT to use

- Magento/Adobe Commerce framework internals unrelated to inventory/order domain (DI, plugins,
  service contracts, indexers, cron) — see the `Adobe-Commerce-Solution-Architect-Knowledge-Library`
  reference material for that instead.
- Retail-industry vocabulary that isn't specifically ERP/WMS/supply-chain (POS, loyalty,
  merchandising, checkout) — see the sibling [retail-glossary](../retail-glossary/SKILL.md) skill
  for that.
- Deep technical WMS/ERP product evaluation (choosing a specific vendor) — this skill provides
  vocabulary and concepts, not a buying guide.

## Capabilities

- Plain-language definitions for inventory management terms (SKU-level control, ABC analysis,
  JIT, safety stock, cycle counting, GRN, BOM).
- Warehouse operations vocabulary (picking strategies, storage/racking types, labor automation).
- Supply-chain visibility and resilience concepts (control towers, real-time tracking, perfect
  order rate, disruption response).
- WMS/ERP/TMS/OMS system-level vocabulary, including cloud WMS features and how these systems
  typically integrate with each other.
- A direct mapping from this vocabulary to Adobe Commerce's own inventory/order concepts (MSI,
  source items, reservations, order management), so the knowledge connects to actual project work.
- A quick-lookup acronym table (BOM, GRN, WMS, ERP, TMS, OMS, AGV, ABC, JIT, RFID, SSTK, etc.).

## Outputs

When asked to explain a term or prepare for a customer conversation, this skill should provide:

- A one-line plain-English definition.
- Which category it belongs to (inventory / warehouse ops / visibility & resilience / systems).
- Where relevant, how it maps to an Adobe Commerce concept or integration point.
- Related terms worth knowing alongside it.

## Additional resources

- [inventory-management-terms.md](inventory-management-terms.md) — SKU-level control, ABC
  analysis, JIT, safety stock, cycle counting, GRN, BOM, perishable inventory, barcode/RFID
- [warehouse-operations-terms.md](warehouse-operations-terms.md) — picking strategies (batch/
  zone/wave), storage/racking types, cross-docking, labor automation (AGVs, robotic arms,
  conveyors), labor KPIs
- [supply-chain-visibility-terms.md](supply-chain-visibility-terms.md) — control towers,
  real-time visibility, perfect order rate, demand forecasting, disruption/resilience vocabulary
- [wms-erp-systems-terms.md](wms-erp-systems-terms.md) — WMS/ERP/TMS/OMS definitions, cloud WMS
  features, system-to-system integration patterns (EDI, API), security/compliance basics
- [adobe-commerce-integration-points.md](adobe-commerce-integration-points.md) — how this
  vocabulary maps to Adobe Commerce's own inventory/order model (MSI, sources, stocks,
  reservations) and where ERP/WMS integrations typically plug in
- [acronyms.md](acronyms.md) — A-Z quick-reference acronym table
