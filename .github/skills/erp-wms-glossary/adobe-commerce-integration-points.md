# Adobe Commerce Integration Points

Where the general ERP/WMS/supply-chain vocabulary in this skill maps to Adobe Commerce's (Magento's)
own concepts. This is what turns "I know what a GRN is" into "I know what happens in Adobe Commerce
when a GRN-driven inventory update needs to land here."

## Inventory model (MSI)

Adobe Commerce's Multi-Source Inventory (MSI) is the platform's own answer to "which warehouse
does this stock live in and how much is sellable" — the same problem a WMS/ERP integration is
usually trying to solve from the outside.

- **Source** — a physical or logical inventory location in Adobe Commerce (a warehouse, a store,
  a 3PL location) — this is the direct analog of a "warehouse" or "DC" in general supply-chain
  vocabulary. A customer's WMS-per-warehouse setup usually maps close to 1:1 with Sources.
- **Source Item** — the quantity of a specific SKU at a specific Source — this is where an
  inventory-sync integration from an external WMS/ERP actually writes data: "SKU X has quantity Y
  at Source Z."
- **Stock** — a named group of Sources exposed to a specific sales channel (a website/storefront),
  with a defined priority order for sourcing. This is Adobe Commerce's mechanism for "which
  Sources can fulfill orders from this website, and in what order do we try them" — relevant when
  a customer describes a fulfillment-priority rule (e.g., "always try the local store before the
  DC") that needs to be modeled as Stock source priority.
- **Salable Quantity** — the actual quantity available to sell, which is on-hand quantity minus
  reservations (see below) — not the same number as raw Source Item quantity. Confusing these two
  is a common source of "why does the site show different stock than the WMS" questions from
  customers.
- **Reservations** — a ledger of quantity decrements (order placed, quantity manually adjusted)
  applied against Source Item quantity to compute Salable Quantity, without immediately rewriting
  the physical quantity record. This exists specifically to handle concurrency (many simultaneous
  orders) without needing to lock/recompute the full inventory table on every sale — worth
  explaining to a customer's technical stakeholder when they ask "why not just decrement inventory
  directly."

## Order lifecycle → fulfillment mapping

- **Sales order → invoice → shipment → credit memo** — Adobe Commerce's own order-lifecycle
  records (see the retail-glossary skill's
  [ecommerce-order-lifecycle.md](../retail-glossary/ecommerce-order-lifecycle.md) for the
  cart/quote-stage vocabulary that precedes this). The **shipment** record is specifically where a
  WMS integration usually needs to write back: when a warehouse's WMS marks an order as picked/
  packed/shipped, that status needs to create or update a shipment record in Adobe Commerce so the
  storefront and customer see accurate fulfillment status.
- **Order status / order state** — as in general order-lifecycle vocabulary, but note Adobe
  Commerce distinguishes the customer-facing **status** (customizable label) from the underlying
  **state** (fixed set: new, processing, complete, canceled, etc.) — a common point of confusion
  when a customer asks for a "new status" that actually needs a new state-to-status mapping.

## Where ERP/WMS integrations typically plug in

- **Inbound (ERP/WMS → Adobe Commerce)**: product/inventory sync (Source Items), price sync,
  order-status/shipment updates, GRN-driven quantity corrections. Typically implemented via the
  REST/GraphQL APIs, bulk/async APIs for high-volume sync, or a message-queue-based integration
  (RabbitMQ) for near-real-time updates without blocking the request.
- **Outbound (Adobe Commerce → ERP/WMS)**: new order created, order canceled, return/RMA
  initiated — typically implemented via webhooks (Adobe Commerce Webhooks / Adobe I/O Events) or
  by the external system polling the API, depending on how real-time the customer's WMS/ERP needs
  the signal to be.
- **Indexers** — Adobe Commerce's mechanism for keeping computed data (including inventory/stock
  status shown on the storefront) in sync with underlying source data without recomputing it on
  every page load. Relevant to integration timing conversations: a Source Item quantity update
  from an external WMS doesn't reflect on the storefront until the relevant indexer runs (or runs
  "on save," depending on indexer mode) — a frequent source of "we updated the WMS but the site
  still shows the old quantity" tickets.

## Conversation-ready framing for customer discovery

When a customer describes their ERP/WMS setup, these are the discovery questions this vocabulary
should prompt:

- Is their WMS the source of truth for on-hand quantity, or is it the ERP? (Determines which
  system's updates should drive Adobe Commerce Source Item quantity.)
- Do they need real-time inventory sync, or is a scheduled batch sync (hourly/nightly) acceptable?
  (Determines API/webhook vs. scheduled-import integration design.)
- How many physical Sources (warehouses/stores) do they have, and do they need
  fulfillment-priority logic across them? (Determines Stock/Source configuration complexity.)
- Do they need shipment-status write-back to the storefront (customer-visible tracking), or is
  WMS-side tracking sufficient? (Determines whether the integration needs to touch the Shipment
  entity at all.)

## Related files

- [inventory-management-terms.md](inventory-management-terms.md)
- [warehouse-operations-terms.md](warehouse-operations-terms.md)
- [supply-chain-visibility-terms.md](supply-chain-visibility-terms.md)
- [wms-erp-systems-terms.md](wms-erp-systems-terms.md)
- [acronyms.md](acronyms.md)
