# Module 4 — Building Actions & Using State

> The one question: **How do you write an action, and how does it read/write data?**
> Spine position: **Action** internals + **Data** (State).

## The mental model

> **An action is one `main(params)` function that returns `{ statusCode, headers, body }`. Inputs
> come in via `params`; data persistence comes from Adobe I/O State. Keep each action small and
> single-purpose.**

## Anatomy of a real action — `map-geocode`

```js
const { Core } = require('@adobe/aio-sdk');
const { ok, errorResponse } = require('../../utils/response-web');

exports.main = async function main(params) {
  const logger = Core.Logger('map-geocode', { level: params.LOG_LEVEL || 'info' });
  try {
    const address = params.address;                       // ← input from the caller
    if (!address) return errorResponse(400, 'Missing required parameter: address', logger);

    const provider = params.MAP_PROVIDER || 'osm';        // ← input from .env via app.config.yaml
    // ...call OpenStreetMap (or Google) ...
    const res = await fetch(`https://nominatim.openstreetmap.org/search?format=json&limit=1&q=${encodeURIComponent(address)}`, {
      headers: { 'User-Agent': 'retail-compass-poc/1.0 (contact: you@example.com)' },
    });
    const results = await res.json();
    if (!results.length) return errorResponse(404, `No match for "${address}"`, logger);

    const { lat, lon, display_name } = results[0];
    return ok({ lat: Number(lat), lng: Number(lon), formattedAddress: display_name, provider: 'osm' });
  } catch (e) {
    return errorResponse(500, e.message, logger);
  }
};
```

Notice:
- **`params`** carries everything: query-string values (`params.address`), JSON body fields, and
  `inputs:` from `app.config.yaml` (`params.MAP_PROVIDER`, `params.LOG_LEVEL`).
- **Return shape** is always `{ statusCode, headers, body }`. Helpers (`ok`, `errorResponse`) just
  build that consistently.
- **`node-fetch` isn't needed on `nodejs:20`** — Node 20 has a global `fetch`. (The reference code
  imported `node-fetch`; we dropped it since the runtime was Node 20.)
- **Real HTTP semantics:** missing input → `400`, no match → `404` (not a crash), error → `500`.

## Reading & writing data — Adobe I/O State

State is the key-value store from Module 2. A small data-access module keeps action code clean:

```js
const stateLib = require('@adobe/aio-lib-state');

async function listRetailers(state) {
  const idx = await state.get('retailers_index');
  const ids = idx && idx.value ? JSON.parse(idx.value) : [];
  const all = await Promise.all(ids.map((id) => state.get(`retailer_${id}`)));
  return all.filter(Boolean).map((r) => JSON.parse(r.value));
}
```

`store-locator-search` uses it like this:

```js
const state = await stateLib.init();
const retailers = (await listRetailers(state)).filter((r) => r.enabled);   // enabled only
const results = retailers
  .map((r) => ({ ...r, distanceKm: haversineKm(lat, lng, r.lat, r.lng) })) // distance
  .filter((r) => r.distanceKm <= radiusKm)                                 // within radius
  .sort((a, b) => a.distanceKm - b.distanceKm)                            // nearest first
  .slice(0, maxResults);                                                   // cap
return ok({ retailers: results, count: results.length });
```

Key-value has no query language, so **filtering, distance math, and sorting happen in your action**.
That's fine at POC scale (hundreds of records); revisit with a real DB if you reach thousands.

## Web actions & auth

In `app.config.yaml`, each action declares:
- `web: 'yes'` → reachable over HTTPS (a web action).
- `annotations: { require-adobe-auth: false }` → **public**, no Adobe login required to call it.
  Set it to `true` for actions that **change** data (create/update/delete), so only authenticated
  callers can write. Read/search staying public is normal and expected.

## The response helper & a real CORS lesson (preview of Module 5)

Our shared `response.js` set `Access-Control-Allow-Origin: *` itself. But **Adobe I/O Runtime already
adds that header for web actions** — so the browser saw it *twice* (`*,*`) and rejected the call. The
fix: **don't set CORS headers in your action**; let the runtime provide them. We put the CORS-safe
helper (`response-web.js`, Content-Type only) on just the new actions to avoid touching shared code.
Full story in Module 5.

## Testing an action

```bash
# Direct HTTPS call (curl ignores CORS, so great for backend testing):
curl "https://123456-myproject-integration.adobeioruntime.net/api/v1/web/retailer-storelocator/map-geocode?address=Austin,TX"

# Seed data into this workspace's State, then search:
BASE='https://123456-myproject-integration.adobeioruntime.net/api/v1/web/retailer-storelocator' node test-payloads/seed.js
```

## Check yourself

1. What object shape must every action return?
2. Where do the values in `params` come from (name three sources)?
3. Why must filtering/sorting happen in the action rather than the datastore?
4. Which actions should have `require-adobe-auth: true`, and why?

Next: **Module 5 — Connecting Actions to a Storefront** (calling from an EDS block + the CORS fix).
