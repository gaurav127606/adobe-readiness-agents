# E-commerce Order Lifecycle Terms

Retail-speak for the cart → checkout → order → fulfillment → payment pipeline, as it's actually
used in digital commerce platforms (Magento/Adobe Commerce included). Useful because these are
the exact terms that show up in tickets and code on Adobe Commerce projects, even though they sound
like generic software terms — retail gives them specific meaning.

## Cart / basket stage

- **Cart / basket** — the working set of items a customer is considering buying, before checkout.
  Used interchangeably in most contexts, though "basket" is more common in physical-retail-derived
  vocabulary and "cart" in web/digital.
- **Quote** — in Magento/Adobe Commerce specifically, "quote" is the technical/data-model name for
  a cart before it becomes an order. Business people say "cart"; the codebase (and DB tables) say
  "quote." Knowing this mapping matters when reading code — a `quote_payment` table, for instance,
  is cart-stage payment data, not a completed order's payment record.
- **Abandoned cart** — a cart that was created/modified but never converted to an order, tracked
  because it's a common re-marketing target ("you left something behind").
- **Guest cart vs. customer cart** — a cart tied to a logged-in customer account vs. one created
  without login; merge/reconciliation logic (what happens if a guest logs in mid-checkout) is a
  common source of retail-commerce bugs.

## Checkout stage

- **Checkout** — the flow where a cart is finalized into a purchase: shipping/fulfillment method
  selection, payment method, and order review.
- **Fulfillment method** — how the customer will receive the order (ship to address, BOPIS,
  curbside, delivery) — selected during checkout and driving very different backend logic per
  method.
- **Order review / order summary** — the final checkout step showing totals, taxes, and applied
  promotions before the customer confirms.
- **Tax calculation / tax jurisdiction** — checkout must calculate tax based on the applicable
  jurisdiction (often the fulfillment address, not the billing address), and rules vary
  significantly by product category (e.g., prepared food vs. packaged goods can be taxed
  differently) — a frequent source of retail-specific checkout complexity.

## Order stage

- **Order** — the record created once checkout completes — a cart "converts" to an order. From
  this point, most systems treat the order as immutable except through defined
  amendment/cancellation flows.
- **Order status / order state** — the lifecycle stage of an order (e.g., pending, processing,
  complete, canceled, closed) — business rules for what actions are allowed usually key off this.
- **Invoice** — in commerce-platform terms, the record of the payment actually being captured
  against an order (see auth vs. capture in
  [general-retail-terms.md](general-retail-terms.md)) — not the customer-facing paper/PDF receipt,
  though it can generate one.
- **Shipment** — the record of goods physically leaving for the customer (or being handed over at
  pickup) — a single order can have multiple partial shipments.
- **Credit memo / refund** — the record of money returned to a customer against a completed order,
  distinct from a chargeback (see general-retail-terms.md) which the customer's bank initiates
  rather than the merchant.
- **RMA (Return Merchandise Authorization)** — the approval/tracking record for a physical return,
  which may or may not result in a credit memo.

## Payment stage

- **Payment method / tender** — see "tender type" in
  [general-retail-terms.md](general-retail-terms.md) — the specific instrument used.
- **Authorization hold** — funds reserved on checkout but not yet captured; common for fuel
  (authorize a high ceiling like $100, capture only the actual pumped amount) and for delivery
  orders (authorize, then capture once the final basket/tip is known).
- **Payment gateway** — the third-party service that actually talks to card networks/banks to
  authorize and capture payments (the commerce platform itself rarely touches raw card data
  directly).
- **Idempotency** — in payment/order contexts, ensuring a retried request (e.g., a flaky network
  causing a checkout submit to double-fire) doesn't create a duplicate charge or duplicate order —
  a recurring theme in checkout reliability work.

## Concurrency & consistency concepts that show up in retail checkout code

- **Race condition at checkout** — two near-simultaneous actions on the same cart/order (e.g., a
  customer double-clicking "place order," or a background job and a user request touching the
  same quote) that can corrupt state if not serialized. The usual fix is a mutex/lock around
  checkout for a given cart.
- **Stuck order / orphaned cart** — an order or cart left in an inconsistent intermediate state
  because a process (payment capture, inventory reservation, etc.) didn't complete and nothing
  cleaned it up — a common retail-platform failure mode under load.

## Related files

- [general-retail-terms.md](general-retail-terms.md) — universal retail vocabulary
- [qsr-cstore-terms.md](qsr-cstore-terms.md) — c-store and QSR vertical vocabulary
- [acronyms.md](acronyms.md) — quick acronym lookup
