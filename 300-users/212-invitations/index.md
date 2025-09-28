---
title: Invitations
nav_order: 212
layout: home
parent: Users 
type: protocol
---

# Invitations

This page documents the API endpoints for managing **invitations for a specific user** using nested REST routes.

> This endpoint is a proxy used to fetch invitations for a given user
  ```text
  /api/v1/events/:event_id/invitations
  ```
  **Create** and **Delete** invitation is called from **events/invitations**

| Field   | Allowed values                                      | Default  |
|---------|------------------------------------------------------|----------|
| status  | pending, accepted, declined, maybe, cancelled, expired | pending  |

**Scope** \
All routes are scoped under:

```text
/api/v1/users/:user_id/invitations
```

---

### LIST
Returns invitations associated with a user.

**DSL**

*Ruby*
```ruby
invitations = SD::Invitation.list("USER-ID", limit: 25, offset: 0, q: "alice")
```

*PHP*
```php
<?php
$invitations = \SweetDate\Invitation::list("USER-ID", 25, 0, "alice");
print_r($invitations);
```

*JavaScript*
```javascript
const invitations = await SD.Invitation.list("USER-ID", { limit: 25, offset: 0, q: "alice" });
console.log(invitations);
```

*Elixir*
```elixir
{:ok, invitations} = SD.Invitation.list("USER-ID", limit: 25, offset: 0, q: "alice")
IO.inspect(invitations)
```

**Request**
```
GET /api/v1/users/:user_id/invitations?limit=25&offset=0&q=alice
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

### GET

Fetch a specific invitation associated with a user.

**DSL**

*Ruby*
```ruby
invitation = SD::Invitation.get("USER-ID", "INVITATION-ID")
```

*PHP*
```php
<?php
$invitation = \SweetDate\Invitation::get("USER-ID", "INVITATION-ID");
print_r($invitation);
```

*JavaScript*
```javascript
const invitation = await SD.Invitation.get("USER-ID", "INVITATION-ID");
console.log(invitation);
```

*Elixir*
```elixir
{:ok, invitation} = SD.Invitation.get("USER-ID", "INVITATION-ID")
IO.inspect(invitation)
```

**Request**
```
GET /api/v1/users/:user_id/invitations/:id
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

### UPDATE
Update an invitation.

**Permitted Parameters**  
Only the following fields can be updated:

- **status** – `pending`, `accepted`, `declined`, `maybe`, `cancelled`, `expired`  

**DSL**

*Ruby*
```ruby
invitation = SD::Invitation.update("USER-ID", "INVITATION-ID", status: :accepted)
```

*PHP*
```php
<?php
$invitation = \SweetDate\Invitation::update("USER-ID", "INVITATION-ID", ["status" => "accepted"]);
print_r($invitation);
```

*JavaScript*
```javascript
const invitation = await SD.Invitation.update("USER-ID", "INVITATION-ID", { status: "accepted" });
console.log(invitation);
```

*Elixir*
```elixir
{:ok, invitation} = SD.Invitation.update("USER-ID", "INVITATION-ID", %{status: :accepted})
IO.inspect(invitation)
```

**Request**
```
PUT /api/v1/users/:user_id/invitations/:id
{
  "status": "accepted"
}
```

**Response**
```json
{
  "status": "ok",
  "invitation": {
    "id": "00000000-0000-0000-0000-000000000000",
    "status": "accepted",
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

**Error** 422 Unprocessable Entity
```json
{
  "status": "error",
  "message": "invalid input",
  "error_code": "VALIDATION_ERROR",
  "fields": {
    "status": ["is invalid"]
  }
}
```

**Error** 404 Not Found
```json
{
  "status": "error",
  "message": "not found",
  "error_code": "NOT_FOUND"
}
```
