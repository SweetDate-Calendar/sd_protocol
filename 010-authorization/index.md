---
title: Authorization (HTTP)
nav_order: 10
layout: home
has_children: true
---

# SweetDate Authorization (SignatureV1)

This document describes how to authenticate HTTP requests to the SweetDate REST API using **SignatureV1** (Ed25519 detached signatures).

> **TL;DR**: For every request (except `/health`), build a small canonical string, sign it with your **Ed25519 private key**, then send three headers: `sd-app-id`, `sd-timestamp`, and `sd-signature` (base64url, no padding).


## Base URL & Protected Routes

- **Base URL**: `https://sweetdate.io/api/v1/`
- **Dispatcher** (payload parity with TCP): `POST /api/v1/dispatch`
- **Health (no auth required)**: `GET /health`


## Required Headers

| Header          | Description                                                                 |
|-----------------|-----------------------------------------------------------------------------|
| `sd-app-id`     | Your application ID (e.g. `app_123…`).                                      |
| `sd-timestamp`  | Unix epoch seconds at the time of the request (server allows ±300s).   |
| `sd-signature`  | Base64url **(no padding)** Ed25519 signature of the canonical string.       |


## Canonical String (v1)

Construct the canonical string exactly as follows (5 lines, with `\n` newlines):

```
v1
<METHOD>
<PATH_AND_QUERY>
<TIMESTAMP>
-
```

**Rules**

- `METHOD` is uppercased, e.g., `GET`, `POST`.
- `PATH_AND_QUERY` must include the **leading slash** and **query string** if present (e.g., `/whoami?x=1&y=2`).
- `TIMESTAMP` is **seconds** since epoch (UTC), not milliseconds.
- The last line is a literal dash (`-`) for v1 (no body hash).

Example: `"v1\nGET\n/whoami?x=1&y=2\n1724071234\n-"`

## Signature

- Algorithm: **Ed25519**, detached signature over the canonical string **bytes**.
- Encodings:
  - Send `sd-signature` as **base64url** without padding (`-` and `_` alphabet, strip `=`).
  - `sd-app-id` is your app identifier issued by SweetDate.
- Server verification steps:
  1. Validate headers exist and timestamp is within skew (default ±300s).
  2. Resolve your public key by `sd-app-id`.
  3. Rebuild the canonical string and verify the Ed25519 signature.


## Example: `GET /whoami`

Canonical (example `ts=1724064000`):

```
v1
GET
/whoami
1724064000
-
```

Example request:

```
GET https://sweetdate.io/api/v1/whoami
sd-app-id: app_7dc655cb-30ee-422f-b13a-f0a796c53879
sd-timestamp: 1724064000
sd-signature: q8W…base64url…
```

Example response:

```json
{
  "status": "ok",
  "app_id": "app_7dc655cb-30ee-422f-b13a-f0a796c53879"
}
```


## Example: `POST /api/v1/dispatch`

Canonical (example `ts=1724064000`):

```
v1
POST
/api/v1/dispatch
1724064000
-
```

Request:

```
POST https://sweetdate.io/api/v1/dispatch
Content-Type: application/json
sd-app-id: app_7dc655cb-30ee-422f-b13a-f0a796c53879
sd-timestamp: 1724064000
sd-signature: q8W…base64url…

{
  "payload": {
    "cmd": "TENANTS.LIST",
    "limit": 25,
    "offset": 0
  }
}
```


## How to Sign (OpenSSL, pure shell)

> Works on macOS/Linux with OpenSSL 3+. If you already have an Ed25519 private key, skip to **Sign a request**.

### 1) Generate a keypair

```bash
# Private key (PEM)
openssl genpkey -algorithm ed25519 -out sk.pem

# Public key (PEM)
openssl pkey -in sk.pem -pubout -out pk.pem
```

> You will register the **public key** with SweetDate (the server stores 32‑byte Ed25519 public keys).

If you need the raw 32‑byte public key (for display or provisioning), you can extract it from the SPKI:
```bash
# Extract the last 32 bytes (raw ed25519 public key) and encode as base64url (no padding)
openssl pkey -in sk.pem -pubout -outform DER \
| tail -c 32 \
| base64 | tr '+/' '-_' | tr -d '='
```

### 2) Sign a request

```bash
BASE_URL="https://sweetdate.io"
METHOD="GET"
PATH="/api/v1/whoami"        # include query if present, e.g. /api/v1/whoami?x=1
TS=$(date +%s)               # seconds

CANONICAL=$(printf "v1\n%s\n%s\n%s\n-\n" "$METHOD" "$PATH" "$TS")

# Create Ed25519 detached signature (raw mode, no hash)
SIG_BIN=$(printf "%s" "$CANONICAL" | openssl pkeyutl -sign -inkey sk.pem -rawin)

# Base64url encode without padding
SIG_B64=$(printf "%s" "$SIG_BIN" | base64 | tr '+/' '-_' | tr -d '=')

# Call with curl
curl -i "$BASE_URL$PATH" \
  -H "sd-app-id: app_7dc655cb-30ee-422f-b13a-f0a796c53879" \
  -H "sd-timestamp: $TS" \
  -H "sd-signature: $SIG_B64"
```

### 3) Dispatch example (POST)

```bash
BASE_URL="https://sweetdate.io"
METHOD="POST"
PATH="/api/v1/dispatch"
TS=$(date +%s)

CANONICAL=$(printf "v1\n%s\n%s\n%s\n-\n" "$METHOD" "$PATH" "$TS")
SIG_BIN=$(printf "%s" "$CANONICAL" | openssl pkeyutl -sign -inkey sk.pem -rawin)
SIG_B64=$(printf "%s" "$SIG_BIN" | base64 | tr '+/' '-_' | tr -d '=')

curl -i "$BASE_URL$PATH" \
  -H "Content-Type: application/json" \
  -H "sd-app-id: app_7dc655cb-30ee-422f-b13a-f0a796c53879" \
  -H "sd-timestamp: $TS" \
  -H "sd-signature: $SIG_B64" \
  --data @- <<'JSON'
{
  "payload": {
    "cmd": "TENANTS.LIST",
    "limit": 25,
    "offset": 0
  }
}
JSON
```


## Clock Skew

- Default allowed skew is **±300 seconds**.
- If your system clock is off, signatures will be rejected with `401 unauthorized`.


## Error Responses

- `401 unauthorized` — missing headers, bad/expired timestamp, key not found, or signature verify failed.
- `404 not_found` — unknown route.
- Body is JSON; `{"error":"unauthorized"}` in the 401 case.


## Security Notes

- **Never** share your private key. Store it securely (file permissions, secrets manager).
- Rotate credentials regularly.
- Prefer short‑lived tokens or key rotation for automation.
- Log `sd-app-id`, not signature values.


## Troubleshooting

- **401 with correct headers** — check:
  - `sd-timestamp` is seconds (not ms) and within ±300s.
  - Canonical string uses the exact **path + query** your request sends.
  - `METHOD` uppercased.
  - `sd-signature` is base64url **without padding** (`=` removed).
  - Your public key registered for the given `sd-app-id` matches the private key used.
- **Query parameters** — must be present in the canonical path (e.g. `/whoami?x=1&y=2`).

---

**Appendix: Example Canonical Strings**

```
# GET /api/v1/whoami at 1724064000
v1
GET
/api/v1/whoami
1724064000
-

# POST /api/v1/dispatch at 1724064001
v1
POST
/api/v1/dispatch
1724064001
-
```
