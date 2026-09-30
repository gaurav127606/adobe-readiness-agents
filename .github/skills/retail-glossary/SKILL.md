---
name: retail-glossary
description: "Retail industry vocabulary in plain English, mapped to Adobe Commerce. Use when: a ticket, PR or customer conversation uses retail terms such as POS, SKU, BOPIS, curbside, loyalty, promotions, promo funding, tender, EBT, planogram, c-store, QSR, forecourt, Pay@Pump, wetstock, drive-thru, kiosk, KDS, franchise, or cart/quote/checkout/order/invoice/shipment/credit-memo lifecycle terms, checkout race conditions and stuck orders."
---

# Retail Glossary — Domain Knowledge Skill

## Purpose

A developer who joins a retail project from a non-retail background (fintech, SaaS, internal
tools) can read the code and still have no idea what a "planogram," a "wetstock reconciliation,"
or a "quote" in the retail sense actually refers to. This skill translates retail-industry
vocabulary — the kind used by product owners, store ops, and business stakeholders at
convenience-store, fuel, and quick-service restaurant chains — into plain language a general
software engineer can use immediately.

It covers terms used across retail broadly, specifically in the convenience-store / QSR vertical,
and in digital-commerce order lifecycles — including what Adobe Commerce calls the same thing (a
cart is a "quote").

## When to use

- You're new to a retail codebase and hit a term in a ticket, PR, Slack thread, or variable name
  you don't recognize (e.g. "P@P," "forecourt," "SKU," "BOPIS," "wetstock," "planogram").
- You need to explain a technical change to a retail stakeholder (or explain a business requirement
  to an engineer) and want the right vocabulary on both sides.
- You're reading a ticket about carts/checkout/orders and need to know how retail-speak
  ("basket," "quote," "wetstock," "voided transaction") maps to what the code calls the same thing.

## When NOT to use

- Magento/Adobe Commerce framework internals (DI, plugins, service contracts, indexers, cron) —
  that's platform knowledge, not retail-industry knowledge. See the
  `Adobe-Commerce-Solution-Architect-Knowledge-Library` reference material for that instead.
- ERP/WMS/supply-chain vocabulary and the MSI inventory mapping — see the sibling
  [erp-wms-glossary](../erp-wms-glossary/SKILL.md) skill.
- Deep system-design/architecture decisions (caching topology, load balancing, DB sharding) —
  out of scope for a vocabulary skill.

## Capabilities

- Plain-language definitions for retail terms, organized by category (store ops, merchandising,
  supply chain, payments, loyalty, digital/omnichannel).
- Convenience-store and QSR-specific vocabulary (forecourt, fuel/wetstock, drive-thru, franchise
  model, kiosk ordering).
- Digital order-lifecycle vocabulary (cart, checkout, order, fulfillment, payment
  authorization/capture) as it's actually used in retail commerce platforms.
- A quick-lookup acronym table (POS, SKU, BOPIS, OMS, WMS, PIM, EDI, PLU, SSTK, COGS, etc.).

## Outputs

When asked to explain a retail term or onboard someone, this skill should provide:

- A one-line plain-English definition.
- Which category it belongs to (store ops / merchandising / supply chain / payments / loyalty /
  digital).
- Where relevant, how the concept typically shows up in an Adobe Commerce codebase (entity, table,
  or API).
- Related terms worth knowing alongside it.

## Additional resources

- [general-retail-terms.md](general-retail-terms.md) — universal retail vocabulary: store ops,
  merchandising, supply chain, payments, loyalty/CRM, digital & omnichannel
- [qsr-cstore-terms.md](qsr-cstore-terms.md) — convenience-store and QSR vertical vocabulary:
  forecourt, fuel/wetstock, drive-thru, franchise model, kiosk ordering, curbside
- [ecommerce-order-lifecycle.md](ecommerce-order-lifecycle.md) — cart → checkout → order →
  fulfillment → payment vocabulary as used in digital commerce platforms
- [acronyms.md](acronyms.md) — A-Z quick-reference acronym table
