---
title: Dev doc
nav_order: 214 
layout: home
parent: Calendar Events
---

# User Invitations

This page documents the **token‑only** invitation flow for calendar events, with a detailed **sequence diagram** and an **ERD** developers can rely on.

> Philosophy: the engine stays **headless**. The client app owns identity, delivery, and UX. The engine exposes minimal APIs, webhooks, and a predictable state machine.

---

## Flow

![Development diagram]({{ site.baseurl }}/assets/images/invitation.svg)


---

## Status machine (engine-enforced)
`pending → accepted | declined | maybe | cancelled | expired`

- `accepted` creates/ensures the `event_users` row.
- `expired` at `expires_at` (background job or DB constraint logic).
- All transitions emit hooks; payloads exclude PII.

---

## Configuration knobs (for implementers)

```yaml
hooks:
  url: https://app.example.com/sd_hooks
  secret: ${SD_HOOKS_SECRET}
invitations:
  token_ttl: 7d
  single_use: true
  auto_add_on_accept: true
  tombstone_ttl: 30d   # keep minimal invite rows for audit, then purge
```

**ENV alternative**
```
SD_HOOKS_URL=https://app.example.com/sd_hooks
SD_HOOKS_SECRET=supersecret
SD_INVITE_TOKEN_TTL=7d
SD_INVITE_TOKEN_SINGLE_USE=true
SD_INVITE_AUTO_ADD_ON_ACCEPT=true
SD_INVITE_TOMBSTONE_TTL=30d
```

---

## Developer checkpoints

- ✅ Engine never stores contact PII for delivery (token‑only).
- ✅ RSVP requires authenticated `user_id`.
- ✅ Hooks are signed (HMAC) and idempotent.
- ✅ Cascades keep the graph clean (event/calendar/user deletes).
- ✅ Clear indexes & uniqueness for performance and integrity.
