# Convenience Store & QSR Vertical Terms

Vocabulary specific to convenience stores and quick-service restaurants (fast-food chains).
These verticals share a lot of overlap: high transaction volume, low average
basket, heavy reliance on speed, and (for c-stores) a fuel business layered on top of the
in-store business.

## Convenience store / fuel-specific

- **Forecourt** — the fuel-dispensing area of a c-store site (the pumps and canopy), as distinct
  from the "back office" (in-store retail). Forecourt systems (fuel dispensers, tank monitoring)
  are often a completely separate technology stack from the in-store POS, bridged by an
  integration layer.
- **Pay@Pump (P@P)** — paying for fuel directly at the dispenser (card reader at the pump) without
  entering the store, as opposed to prepaying inside or paying at the register after fueling.
- **Wetstock** — fuel inventory, measured by volume (gallons/liters) rather than unit count.
  "Wetstock reconciliation" compares what was sold (per the POS/dispenser) against what tank
  gauges say is physically left, to catch leaks, theft, or delivery discrepancies.
- **Fuel POS / dispenser controller** — the hardware/software that manages the pumps themselves
  (authorizing a pump to dispense, capping a $ amount, controlling the pump's display) — separate
  from the store's retail POS, though the two must talk to each other for a unified transaction.
- **Site controller** — the on-site system that mediates between the fuel dispensers, the in-store
  POS, and back-office/cloud systems — often the integration point a c-store's software has to
  reconcile with.
- **Drive-off** — a customer who dispenses fuel and leaves without paying, a shrink category
  specific to the fuel business.
- **Price sign / price board** — the roadside display showing current fuel prices, which must
  update in near-real-time when prices change (a common source of pricing-sync bugs).
- **C-store (convenience store)** — the general term for the retail format with a small
  footprint, high SKU turnover, extended/24-hour hours, often paired with fuel.

## QSR-specific

- **Drive-thru** — the ordering/pickup lane for customers who don't leave their car; usually has
  its own POS/kitchen-display flow optimized for speed, distinct from front-counter or kiosk
  ordering.
- **Kitchen Display System (KDS)** — the screen(s) in the kitchen showing incoming orders and
  their prep status, replacing paper tickets; order-taking systems (POS, kiosk, app, drive-thru)
  all feed into it.
- **Self-order kiosk** — an in-store touchscreen terminal where a customer builds and pays for
  their own order without a cashier.
- **Ghost kitchen / dark kitchen** — a food-prep location with no dine-in storefront, built solely
  to fulfill delivery/pickup orders — a fulfillment-channel concept, not a menu concept.
- **Mobile order-ahead** — ordering via app before arriving, with the order timed to be ready at
  (or shortly after) arrival — distinct from BOPIS in retail because timing/prep-start matters
  much more (food degrades; a shelf item doesn't).
- **Curbside pickup** — same concept as BOPAC in general retail, common in QSR for mobile
  order-ahead customers who don't want to enter the store.
- **86'd / 86 an item** — an item temporarily removed from availability (out of stock or can't be
  prepared), a term originating in restaurant kitchens that shows up in POS/menu-availability
  logic.
- **Combo / meal bundle** — a fixed bundle of items sold as one orderable unit at a set price,
  often with substitution rules (swap fries for a side salad) that ordering systems must model.

## Franchise & multi-format operations

- **Franchisee vs. franchisor** — the franchisee owns/operates an individual location under
  license; the franchisor (parent brand) sets standards, supplies branding, and often the core
  technology platform. Systems frequently need per-franchisee configuration or reporting
  boundaries.
- **Company-operated (corporate) store** — see [general-retail-terms.md](general-retail-terms.md)
  — relevant here because c-store and QSR brands typically run a mix of franchise and
  corporate-operated locations side by side, and back-office systems must account for both.
- **Multi-unit operator** — a franchisee who owns multiple locations, often needing aggregated
  reporting across their specific set of stores rather than the whole chain.

## Related files

- [general-retail-terms.md](general-retail-terms.md) — universal retail vocabulary
- [ecommerce-order-lifecycle.md](ecommerce-order-lifecycle.md) — cart/checkout/order/payment terms
- [acronyms.md](acronyms.md) — quick acronym lookup
