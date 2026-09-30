# Architect Mode — Decision Framework

How to go from "a few plausible integration approaches" to "a specific, justified recommendation."
This is the mechanism behind Integration Options → Recommended Approach → Trade-offs in the output
format — it stops a recommendation from being "use an API, because APIs are modern."

## Step 1 — Fix the constraints before comparing anything

You cannot rank integration approaches without something to rank them against. Before comparing
alternatives, pin down (from the conversation, or as explicit assumptions):

- **Freshness requirement** — a number or tolerance ("inventory must reflect within 5 minutes" vs.
  "nightly sync is fine"), not "as real-time as possible." This alone usually decides EDI/batch vs.
  API/webhook.
- **Source of truth** — which system (ERP or WMS) owns the authoritative on-hand quantity; Adobe
  Commerce's Source Items must be fed from that one system, not reconciled from two.
- **Volume shape** — order/SKU/location count and whether it spikes (e.g. flash sale, seasonal
  peak) — a design that's fine at 500 orders/day can fall over at 50,000/day if it relies on
  synchronous per-order API calls with no queue.
- **Failure tolerance** — is a stale-but-available state acceptable during an outage, or must the
  storefront reflect "unavailable" immediately? This decides how aggressively to invalidate cached
  Salable Quantity on a sync failure.
- **Team/vendor technical maturity** — a customer's ERP team fluent in EDI but with no engineering
  team to build/maintain webhook consumers rules out an approach requiring the latter, regardless
  of which is "better" in the abstract.

If one of these is missing and materially changes the ranking, ask for it (or flag the assumption
explicitly) before presenting options — don't present options against an unstated bar.

## Step 2 — Present 2–3 real alternatives, not a strawman

Example set for "sync inventory from an on-prem ERP into Adobe Commerce":

1. **Scheduled batch import via EDI/flat file** (e.g. nightly ASN + inventory feed processed by a
   scheduled job)
2. **Near-real-time sync via message queue** (ERP publishes inventory-change events to a queue;
   a consumer updates Source Items on receipt)
3. **Direct synchronous API integration** (Adobe Commerce calls the ERP's API on-demand, or the
   ERP calls Adobe Commerce's REST/GraphQL API on every change)

Each must be a genuinely viable choice given the constraints pinned in Step 1 — not one real option
and two options invented to lose.

## Step 3 — Score each option against the pinned constraints

| Constraint | Batch/EDI | Queue-based near-real-time | Direct synchronous API |
|---|---|---|---|
| Freshness (5-min target) | Fails — hours of staleness | Meets — seconds to low minutes | Meets, but only while both systems are up |
| Volume spike resilience | High — batch absorbs any burst | High — queue buffers bursts | Low — synchronous calls can cascade-fail under load |
| ERP team's technical fit | High — EDI is standard for legacy ERPs | Medium — needs event-publishing capability | Medium — needs reliable API availability |
| Failure behavior | Simple — last successful batch holds | Needs dead-letter/retry handling | Needs explicit timeout/fallback per call |
| Build/ops complexity | Low | Medium (needs queue infra) | Low to build, high risk in production |

## Step 4 — State the deciding factor explicitly, in the language of the constraint

- Bad: "We recommend a queue-based integration because it's more modern than batch/EDI."
- Good: "We recommend a queue-based near-real-time sync over nightly EDI because the customer
  stated inventory must reflect within minutes to avoid overselling fast-moving SKUs during flash
  sales — nightly batch fails that requirement outright. We recommend the queue over a direct
  synchronous API because the customer's peak order volume (50,000/day, 10x spikes during
  promotions) would risk cascading failures with synchronous per-order calls; a queue absorbs the
  burst and lets the consumer apply backpressure instead."

Always name the specific number or constraint that ruled out each rejected option.

## Step 5 — Record what would change the recommendation

- "If the ERP team can't support event publishing within the project timeline, fall back to
  batch/EDI with a shorter interval (e.g. hourly) as an interim step, and revisit queue-based sync
  later."
- "If order volume drops well below the spike threshold that ruled out direct API calls, a
  simpler synchronous integration becomes viable and may be preferred for its lower build cost."

## Anti-patterns to avoid

- **Requirements-after-the-fact** — picking the integration approach first (because it's what was
  used on the last project), then finding requirements that justify it.
- **False consensus** — presenting only the option already favored, with token one-line dismissals
  of the alternatives.
- **Analysis paralysis** — this framework must land on one recommended approach, not an
  open-ended list of pros and cons.
