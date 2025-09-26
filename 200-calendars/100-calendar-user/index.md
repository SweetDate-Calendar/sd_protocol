---
title: Users
nav_order: 210
layout: home
parent: Calendars
type: protocol
---

# Users 

This page documents the API endpoints for managing **users within a specific calendar**.

All routes are scoped under:

```text
/api/v1/join/calendars/:calendar_id/users
```

> SDK Design
> 
> The SDK exposes a **Calendar object** that encapsulates user operations:
> - `calendar.users(limit:, offset:, q:)`
> - `calendar.add_user(user_id:, role:)`
> - `calendar.get_user(user_id)`
> - `calendar.update_user(user_id, role:)`
> - `calendar.remove_user(user_id)`
>
> Users can be created separately (e.g., `user = SD::User.create(name: "Bob")`) and then attached to a calendar.

---

## USERS
Returns users associated with a calendar.

*Ruby*
```ruby
calendar = SD::Calendar.get("CALENDAR-ID")
users = calendar.users(limit: 25, offset: 0, q: "alice")
```

*PHP*
```php
<?php
$calendar = \SweetDate\Calendar::get("CALENDAR-ID");
$users = $calendar->users(["limit" => 25, "offset" => 0, "q" => "alice"]);
print_r($users);
```

*JavaScript*
```javascript
const calendar = await SD.Calendar.get("CALENDAR-ID");
const users = await calendar.users({ limit: 25, offset: 0, q: "alice" });
console.log(users);
```

*Elixir*
```elixir
{:ok, calendar} = SD.Calendar.get("CALENDAR-ID")
{:ok, users} = SD.Calendar.users(calendar, limit: 25, offset: 0, q: "alice")
IO.inspect(users)
```

**Request**
```
GET /api/v1/calendars/:calendar_id/users?limit=25&offset=0&q=alice
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

## CREATE

Associates a user with a calendar.

*Ruby*
```ruby
calendar = SD::Calendar.get("CALENDAR-ID")
user = SD::User.create(name: "Bob", email: "bob@example.com")
added = calendar.add_user(user_id: user.id, role: :admin)
```

*PHP*
```php
<?php
$calendar = \SweetDate\Calendar::get("CALENDAR-ID");
$user = \SweetDate\User::create(["name" => "Bob", "email" => "bob@example.com"]);
$added = $calendar->addUser(["user_id" => $user->id, "role" => "admin"]);
print_r($added);
```

*JavaScript*
```javascript
const calendar = await SD.Calendar.get("CALENDAR-ID");
const user = await SD.User.create({ name: "Bob", email: "bob@example.com" });
const added = await calendar.addUser({ user_id: user.id, role: "admin" });
console.log(added);
```

*Elixir*
```elixir
{:ok, calendar} = SD.Calendar.get("CALENDAR-ID")
{:ok, user} = SD.User.create(%{name: "Bob", email: "bob@example.com"})
{:ok, added} = SD.Calendar.add_user(calendar, %{user_id: user.id, role: :admin})
IO.inspect(added)
```

**Request**
```
POST /api/v1/join/calendars/:calendar_id/users
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

## GET

Fetch a specific user associated with a calendar.

*Ruby*
```ruby
calendar = SD::Calendar.get("CALENDAR-ID")
user = calendar.get_user("USER-ID")
```

*PHP*
```php
<?php
$calendar = \SweetDate\Calendar::get("CALENDAR-ID");
$user = $calendar->getUser("USER-ID");
print_r($user);
```

*JavaScript*
```javascript
const calendar = await SD.Calendar.get("CALENDAR-ID");
const user = await calendar.getUser("USER-ID");
console.log(user);
```

*Elixir*
```elixir
{:ok, calendar} = SD.Calendar.get("CALENDAR-ID")
{:ok, user} = SD.Calendar.get_user(calendar, "USER-ID")
IO.inspect(user)
```

**Request**
```
GET /api/v1/calendars/:calendar_id/users/:id
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

## UPDATE

Updates the role of a user within the calendar.

*Ruby*
```ruby
calendar = SD::Calendar.get("CALENDAR-ID")
updated = calendar.update_user("USER-ID", role: :guest)
```

*PHP*
```php
<?php
$calendar = \SweetDate\Calendar::get("CALENDAR-ID");
$updated = $calendar->updateUser("USER-ID", ["role" => "guest"]);
print_r($updated);
```

*JavaScript*
```javascript
const calendar = await SD.Calendar.get("CALENDAR-ID");
const updated = await calendar.updateUser("USER-ID", { role: "guest" });
console.log(updated);
```

*Elixir*
```elixir
{:ok, calendar} = SD.Calendar.get("CALENDAR-ID")
{:ok, updated} = SD.Calendar.update_user(calendar, "USER-ID", %{role: :guest})
IO.inspect(updated)
```

**Request**
```
PUT /api/v1/calendars/:calendar_id/users/:id
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

## DELETE

Removes the association between the user and the calendar.

*Ruby*
```ruby
calendar = SD::Calendar.get("CALENDAR-ID")
calendar.remove_user("USER-ID")
# => { status: "ok" }
```

*PHP*
```php
<?php
$calendar = \SweetDate\Calendar::get("CALENDAR-ID");
$resp = $calendar->removeUser("USER-ID");
print_r($resp);
```

*JavaScript*
```javascript
const calendar = await SD.Calendar.get("CALENDAR-ID");
const resp = await calendar.removeUser("USER-ID");
console.log(resp);
```

*Elixir*
```elixir
{:ok, calendar} = SD.Calendar.get("CALENDAR-ID")
:ok = SD.Calendar.remove_user(calendar, "USER-ID")
```

**Request**
```
DELETE /api/v1/calendars/:calendar_id/users/:id
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
