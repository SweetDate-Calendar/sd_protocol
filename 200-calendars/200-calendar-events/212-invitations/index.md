---
title: Event Inviations
nav_order: 212
layout: home
parent: Calendar Events
type: protocol
---

# Event Inviations

This page documents the API endpoints for managing **invitations within a specific event** using nested REST routes.

**Enums** \
Some fields only allow selected values

| Field   | Allowed values                                      | Default  |
|---------|------------------------------------------------------|----------|
| status  | pending, accepted, declined, maybe, cancelled, expired | pending  |
| role    | organizer, attendee, guest                           | attendee |

**Scope** \
All routes are scoped under:

```text
/api/v1/events/:event_id/invitations
```

---

## LIST INVITATIONS
Returns invitations associated with an event.

**Request**
```
GET /api/v1/events/:event_id/invitations?limit=25&offset=0&q=alice
```

**Response**
```json
{
  "status": "ok",
  "invitations": [
    {
      "id": "00000000-0000-0000-0000-000000000000",
      "status": "pending",
      "role": "attendee",
      "token": "XYZ123TOKEN",
      "expires_at": "2025-09-01T10:00:00Z",
      "email_display": "a***@example.com",
      "user": null,
      "inserted_at": "2025-08-18T09:20:00Z",
      "updated_at": "2025-08-19T10:15:00Z"
    },
    {
      "id": "00000000-0000-0000-0000-000000000001",
      "status": "accepted",
      "role": "attendee",
      "token": null,
      "expires_at": "2025-09-01T10:00:00Z",
      "email_display": null,
      "user": {
        "id": "00000000-0000-0000-0000-000000000999",
        "name": "Alice",
        "email": "alice@example.com"
      },
      "inserted_at": "2025-08-18T09:25:00Z",
      "updated_at": "2025-08-19T10:20:00Z"
    }
  ]
}
```

---

## CREATE INVITATION

Creates an invitation for an event. If `user_id` is provided, the invitation targets an existing user. Otherwise, a token-only invitation is created and the client application is expected to deliver the RSVP link externally.

**Request**
```
POST /api/v1/events/:event_id/invitations
```
**Payload**
```json
{
  "role": "attendee",
  "user_id": "00000000-0000-0000-0000-000000000999"
}
```
_or (token-only invitation)_
```json
{
  "role": "attendee"
}
```

**Response**
```json
{
  "status": "ok",
  "invitation": {
    "id": "00000000-0000-0000-0000-000000000000",
    "status": "pending",
    "role": "attendee",
    "token": "XYZ123TOKEN",
    "expires_at": "2025-09-01T10:00:00Z",
    "email_display": null,
    "user": {
      "id": "00000000-0000-0000-0000-000000000999",
      "name": "Alice",
      "email": "alice@example.com"
    },
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-18T09:20:00Z"
  }
}
```

---

## GET INVITATION

Fetch a specific invitation associated with an event.

**Request**
```
GET /api/v1/events/:event_id/invitations/:id
```

**Response**
```json
{
  "status": "ok",
  "invitation": {
    "id": "00000000-0000-0000-0000-000000000000",
    "status": "pending",
    "role": "attendee",
    "token": "XYZ123TOKEN",
    "expires_at": "2025-09-01T10:00:00Z",
    "email_display": "a***@example.com",
    "user": null,
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

---

## DELETE INVITATION

Deletes an invitation. (If the event is deleted, its invitations are deleted automatically.)

**Request**
```
DELETE /api/v1/events/:event_id/invitations/:id
```

**Response**
```json
{ "status": "ok" }
```

---

## Errors

### 404 Not Found
```json
{
  "status": "error",
  "message": "not found",
  "error_code": "NOT_FOUND"
}
```

### 422 Validation Error
```json
{
  "status": "error",
  "message": "invalid input",
  "error_code": "VALIDATION_ERROR",
  "fields": {
    "role": ["is invalid"],
    "user_id": ["is invalid"]
  }
}
```
