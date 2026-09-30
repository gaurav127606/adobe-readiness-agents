# Supply Chain Visibility & Resilience Terms

Vocabulary for tracking and reasoning about a supply chain as a whole, across multiple parties and
locations — not just what happens inside one warehouse.

## Visibility concepts

- **Supply chain visibility** — the ability to see, in real time, where goods and orders actually
  are and what state they're in across the whole chain (supplier → warehouse → carrier →
  customer), rather than only having accurate data at one link and blind spots elsewhere.
  Fragmented, siloed systems are the default failure mode this term is defined against.
- **Control tower** — a centralized monitoring capability (dashboard/platform) that aggregates
  data across suppliers, warehouses, and carriers to give a single end-to-end view, so disruptions
  are visible immediately rather than being discovered only when a shipment fails to arrive.
- **Real-time information / real-time data** — data reflecting current state (stock level, order
  status, shipment location) with minimal lag, as opposed to batch/periodic updates. The
  practical value: disruptions can be caught and acted on while still in progress, instead of
  being discovered after the fact.
- **OEM (Original Equipment Manufacturer)** — in a supply-chain-visibility context, the party that
  needs real-time signal on component/part demand and supplier performance to adjust production
  schedules before a shortfall actually hits the line — a common use case cited for why real-time
  visibility matters, not just "faster reporting."
- **Perfect order rate** — the percentage of orders delivered complete, on time, undamaged, and
  with accurate documentation — a commonly cited composite KPI for supply-chain execution quality;
  improved visibility is frequently linked to raising this metric (cited industry figures put the
  improvement in the 20-40% range when moving from low to high visibility).

## Resilience & disruption response

- **Supply chain resilience** — the capacity of a supply chain to prepare for, respond to, and
  recover from unexpected disruptions (natural disasters, geopolitical events, pandemics, demand
  shocks) while maintaining continuity of operations and service levels — treated as a necessity
  rather than a nice-to-have given how often global disruptions actually occur.
- **Lack of visibility / rigid structures / manual processes** — the three traditional
  supply-chain weaknesses most commonly cited as blocking resilience: without real-time data,
  fragmented across disconnected systems, and reliant on manual steps, a supply chain can't
  respond swiftly when something goes wrong — it discovers the problem too late to act on it
  cheaply.
- **Demand forecasting** — predicting future demand from historical sales, seasonality, and market
  signals; explicitly called out as complex because of external shocks (economic shifts, sudden
  behavior changes) that historical data alone can't anticipate — a forecast is a starting
  assumption to be corrected by real-time signal, not a fixed plan.

## Customer-facing impact

- **Order tracking / shipment tracking** — customer-visible status updates on where their order
  is in the fulfillment/delivery process; increasingly expected by default (an "omnichannel"
  baseline) rather than treated as a premium feature.
- **Customer satisfaction impact** — the throughline argument connecting internal visibility
  improvements to external outcomes: better visibility → faster detection of problems → fewer
  missed/delayed deliveries → higher trust and repeat business. When evaluating a
  visibility/tracking feature request, this is the causal chain a customer stakeholder is
  usually reasoning from, even if they only state the end goal ("customers keep asking where
  their order is").

## Related files

- [inventory-management-terms.md](inventory-management-terms.md) — the underlying data visibility
  depends on being accurate
- [warehouse-operations-terms.md](warehouse-operations-terms.md) — where much of this data
  originates
- [wms-erp-systems-terms.md](wms-erp-systems-terms.md) — the systems (WMS/TMS/control tower
  platforms) that provide this visibility
- [adobe-commerce-integration-points.md](adobe-commerce-integration-points.md) — how order-status
  visibility surfaces to the Adobe Commerce storefront/customer
- [acronyms.md](acronyms.md) — quick acronym lookup
