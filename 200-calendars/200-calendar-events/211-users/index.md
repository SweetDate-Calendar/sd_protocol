---
title: Users
nav_order: 211
layout: home
parent: Events
type: protocol
---

# Users

This page documents the API endpoints for managing **users within a specific event**.

**Enums** \
Some fields only allow selected values

| Field           | Allowed values                          | Default   |
|-----------------|-----------------------------------------|-----------|
| role          | organizer, attendee, guest | attendee |
| status      | invited, accepted, declined, maybe, cancelled | invited    |

**Scope** \
All routes are scoped under:

```text
/api/v1/join/events/:events_id/users
```

---

### LIST
Returns users associated with an event.

**DSL**

*Ruby*
```ruby
users = SD::EventUser.list("EVENT-ID", limit: 25, offset: 0, q: "alice")
```

*PHP*
```php
<?php
$users = \SweetDate\EventUser::list("EVENT-ID", 25, 0, "alice");
print_r($users);
```
*JavaScript*
```javascript
const users = await SD.EventUser.list("EVENT-ID", { limit: 25, offset: 0, q: "alice" });
console.log(users);
```
*Elixir*
```elixir
{:ok, users} = SD.EventUser.list("EVENT-ID", limit: 25, offset: 0, q: "alice")
IO.inspect(users)
```

**Request**
```
GET /api/v1/join/events/:events_id/users?limit=25&offset=0&q=alice
```

**Response**
```json
{
  "status": "ok",
  "users": [
    {
      "id": "00000000-0000-0000-0000-000000000000",
      "name": "Alice",
      "email": "alice@example.com",
      "role": "owner",
      "inserted_at": "2025-08-18T09:20:00Z",
      "updated_at": "2025-08-19T10:15:00Z"
    }
  ]
}
```

---

### CREATE

Associates a user with an event.

**DSL**

*Ruby*
```ruby
user = SD::EventUser.create("EVENT-ID", user_id: "USER-ID", role: :admin)
```
*PHP*
```php
<?php
$user = \SweetDate\EventUser::create("EVENT-ID", [
  "user_id" => "USER-ID",
  "role" => "admin"
]);
print_r($user);
```
*JavaScript*
```javascript
const user = await SD.EventUser.create("EVENT-ID", { user_id: "USER-ID", role: "admin" });
console.log(user);
```
*Elixir*
```elixir
{:ok, user} = SD.EventUser.create("EVENT-ID", %{user_id: "USER-ID", role: :admin})
IO.inspect(user)
```

**Request**
```
POST /api/v1/join/events/:events_id/users
```
**Payload**
```json
{
  "user_id": "00000000-0000-0000-000000000000",
  "role": "admin"
}
```

**Response**
```json
{
  "status": "ok",
  "user": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Alice",
    "email": "alice@example.com",
    "role": "admin",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

---

### GET

Fetch a specific user associated with an event.

**DSL**

*Ruby*
```ruby
user = SD::EventUser.get("EVENT-ID", "USER-ID")
```
*PHP*
```php
<?php
$user = \SweetDate\EventUser::get("EVENT-ID", "USER-ID");
print_r($user);
```
*JavaScript*
```javascript
const user = await SD.EventUser.get("EVENT-ID", "USER-ID");
console.log(user);
```
*Elixir*
```elixir
{:ok, user} = SD.EventUser.get("EVENT-ID", "USER-ID")
IO.inspect(user)
```

**Request**
```
GET /api/v1/join/events/:events_id/users/:id
```

**Response**
```json
{
  "status": "ok",
  "user": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Alice",
    "email": "alice@example.com",
    "role": "owner",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

---

### UPDATE

Updates the role of a user within the event.

**DSL**

*Ruby*
```ruby
user = SD::EventUser.update("EVENT-ID", "USER-ID", role: :guest)
```
*PHP*
```php
<?php
$user = \SweetDate\EventUser::update("EVENT-ID", "USER-ID", ["role" => "guest"]);
print_r($user);
```
*JavaScript*
```javascript
const user = await SD.EventUser.update("EVENT-ID", "USER-ID", { role: "guest" });
console.log(user);
```
*Elixir*
```elixir
{:ok, user} = SD.EventUser.update("EVENT-ID", "USER-ID", %{role: :guest})
IO.inspect(user)
```

**Request**
```
PUT /api/v1/join/events/:events_id/users/:id
```
**Payload**
```json
{
  "role": "guest"
}
```

**Response**
```json
{
  "status": "ok",
  "user": {
    "id": "00000000-0000-0000-0000-000000000000",
    "role": "guest",
    "name": "Alice",
    "email": "alice@example.com",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

---

### DELETE

Removes the association between the user and the event.

**DSL**

*Ruby*
```ruby
SD::EventUser.delete("EVENT-ID", "USER-ID")
```
*PHP*
```php
<?php
$resp = \SweetDate\EventUser::delete("EVENT-ID", "USER-ID");
print_r($resp);
```
*JavaScript*
```javascript
const resp = await SD.EventUser.delete("EVENT-ID", "USER-ID");
console.log(resp);
```
*Elixir*
```elixir
:ok = SD.EventUser.delete("EVENT-ID", "USER-ID")
```

**Request**
```
DELETE /api/v1/join/events/:events_id/users/:id
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
    "role": ["is invalid"]
  }
}
```
