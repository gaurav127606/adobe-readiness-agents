# General Retail Terms

Universal retail-industry vocabulary, organized by category. Each entry is a plain-English
definition first, with retail-specific nuance second.

## Store operations

- **SKU (Stock Keeping Unit)** — a unique identifier for one specific sellable variant of a
  product (e.g., a 20oz bottle of a drink is a different SKU from the 12oz bottle of the same
  drink). Not the same as a product — one product can have many SKUs.
- **PLU (Price Look-Up code)** — a short numeric code (commonly seen on produce stickers) used to
  ring up items at POS without scanning a barcode.
- **Planogram** — a diagram specifying exactly where each product sits on a shelf/shelf-set, used
  to standardize merchandising across stores.
- **Shrinkage / shrink** — inventory loss from theft, damage, spoilage, or administrative error —
  the gap between what the system says should be on hand and what's physically there.
- **Cycle count** — a partial, rolling physical inventory count (as opposed to a full annual
  count) used to catch shrink and correct system quantities continuously.
- **Voids / voided transaction** — a transaction cancelled at the POS after it started but before
  (or immediately after) it completed, usually requiring manager override.
- **Till / drawer** — the cash drawer assigned to a cashier or register for a shift; "till count"
  is reconciling expected vs. actual cash at shift close.
- **Franchise vs. corporate (company-operated) store** — a franchise store is independently owned
  and licenses the brand; a corporate store is owned and operated directly by the parent company.
  Systems often need to behave differently for each (e.g., different reporting, different payment
  processors).

## Merchandising & pricing

- **MSRP** — Manufacturer's Suggested Retail Price; the "sticker price" a manufacturer recommends,
  which the retailer may or may not honor.
- **Markdown** — a permanent or semi-permanent price reduction (as opposed to a temporary
  promotion), usually to clear slow-moving stock.
- **Private label** — a product manufactured for and branded by the retailer itself (not a
  national brand) — usually higher margin.
- **Category management** — organizing and merchandising products by logical grouping (e.g.,
  "snacks," "beverages") rather than by supplier, to optimize shelf space and sales.
- **Basket / basket size** — the set of items in one customer's purchase; "basket size" or
  "average basket" is a common KPI (average $ or item count per transaction).
- **Attach rate** — the rate at which a secondary item is purchased alongside a primary one (e.g.,
  % of fuel purchases that also buy something in-store).

## Promotions & pricing rules

- **Promotion / promo** — a temporary price change or offer, usually rule-driven (buy-one-get-one,
  % off, threshold discount) as opposed to a permanent markdown.
- **Rule-based promotion** — a promotion defined by conditions (e.g., "customer qualifies if cart
  contains category X and subtotal > $10") rather than a flat item-level price change.
- **Funding / promo funding** — who "pays" for a discount — the retailer, the manufacturer/vendor,
  or shared — tracked separately from the discount itself for accounting and vendor billback
  purposes.
- **Coupon** — a promo redeemed via a code or physical/digital voucher, as opposed to an
  automatically-applied discount.
- **Loyalty offer** — a promo only available to logged-in / enrolled loyalty members, often
  personalized.

## Supply chain

- **EDI (Electronic Data Interchange)** — a standardized format for exchanging business documents
  (POs, invoices, ASNs) between trading partners' systems, still very common between retailers and
  suppliers.
- **ASN (Advance Ship Notice)** — a supplier's electronic notice that a shipment is on its way,
  with contents and expected arrival, sent before the goods arrive.
- **DC (Distribution Center)** — a warehouse that receives goods from suppliers and redistributes
  them to stores, as opposed to a store receiving directly from the manufacturer.
- **Replenishment** — the (often automated) process of reordering stock based on sales velocity
  and target inventory levels.
- **Backhaul** — using a delivery truck's return trip to pick up goods, instead of running it
  empty — a supply-chain cost optimization.
- **Wetstock** — inventory that is a liquid, measured/reconciled by volume rather than unit count
  (fuel is the classic c-store example — see [qsr-cstore-terms.md](qsr-cstore-terms.md)).

## Payments

- **Authorization (auth) vs. capture** — authorization reserves funds on a card without moving
  money; capture is the actual charge. Retail commonly authorizes at order time and captures at
  fulfillment/pickup, especially for fuel and delivery.
- **Settlement** — the batch process where authorized/captured payments actually move between
  banks — usually happens on a delay (often overnight), separate from the customer-facing
  transaction.
- **Chargeback** — a forced reversal of a card payment initiated by the customer's bank, disputing
  the charge — distinct from a refund the merchant issues voluntarily.
- **Tender type** — the payment method used (cash, credit, debit, EBT, gift card, loyalty points).
- **EBT (Electronic Benefits Transfer)** — a government-benefits payment card (e.g., SNAP) with
  its own rules about what items qualify — relevant to POS and cart logic that must
  split/restrict eligible items.

## Loyalty & CRM

- **Loyalty program / rewards program** — a system that tracks customer identity across visits to
  award points, tiers, or personalized offers.
- **Enrollment** — the act of a customer signing up for the loyalty program, often gating which
  promotions apply.
- **Tiering** — segmenting loyalty members into levels (e.g., silver/gold) with different
  benefits, usually based on spend or visit frequency.
- **CDP (Customer Data Platform)** — a system that unifies customer data across channels
  (in-store, app, web) into one profile, typically feeding personalization and marketing
  campaigns.

## Digital & omnichannel

- **Omnichannel** — a retail strategy where channels (in-store, app, web, kiosk) share the same
  inventory, pricing, and customer data, so the customer experience is consistent regardless of
  channel.
- **BOPIS (Buy Online, Pickup In Store)** — order and pay online, then physically collect the
  item in-store.
- **BOPAC / Curbside** — Buy Online, Pickup At Curb — store associate brings the order out to the
  customer's car instead of the customer entering the store.
- **Ship-from-store** — fulfilling an online order by shipping it from a nearby retail store's
  inventory rather than a distribution center.
- **Endless aisle** — using in-store digital kiosks/tablets to let customers order items not
  physically stocked in that store (usually shipped or picked up elsewhere).
- **Click-to-brick** — a customer researching/ordering online and completing the transaction (or
  pickup) in a physical store.

## Related files

- [qsr-cstore-terms.md](qsr-cstore-terms.md) — convenience-store and QSR-specific vocabulary
- [ecommerce-order-lifecycle.md](ecommerce-order-lifecycle.md) — cart/checkout/order/payment terms
- [acronyms.md](acronyms.md) — quick acronym lookup
