---
title: Calendars 
nav_order: 200 
layout: home
has_children: true
type: protocol
---

# Calendars 

This page specifies commands for working with calendars.  
Each section shows **language-specific SDK calls first** (Ruby, PHP, JavaScript, Elixir), followed by the **raw REST request/response**.

> Conventions used below:
> - All SDKs expose a `Calendars` namespace/module/class.
> - Pagination uses `limit` and `offset` (defaults: `limit=25`, `offset=0`).
> - Timestamps are ISO 8601 (UTC).
> 
---

### LIST 
Returns calendars ordered by name ascending.

*Ruby*
```ruby
SD::Calendars.list(limit: 25, offset: 0)
```

*PHP*
```php
<?php
$calendars = \SweetDate\Calendars::list(25, 0);
print_r($calendars);
```

*JavaScript*
```javascript
const calendars = await SD.Calendars.list({ limit: 25, offset: 0 });
console.log(calendars);
```

*Elixir*
```elixir
{:ok, calendars} = SD.Calendars.list(limit: 25, offset: 0)
IO.inspect(calendars)
```

**Request**
```
GET /api/v1/calendars?limit=25&offset=0
```

**Response**
```json
{
  "status": "ok",
  "calendars": [
    {
      "id": "00000000-0000-0000-0000-000000000000",
      "name": "Work",
      "color_theme": "red",
      "visibility": "shared",
      "inserted_at": "2025-08-18T09:20:00Z",
      "updated_at": "2025-08-19T10:15:00Z"
    }
  ],
  "limit": 25,
  "offset": 0
}
```

**Error**
```json
{ "status": "error", "message": "..." }
```

---

### CREATE
Create a new calendar.

> Permitted values for `visibility`:  
> - **private** – Only the owner has access  
> - **shared** – Shared with selected users  
> - **public** – Discoverable within the tenant  
> - **unlisted** – Hidden from discovery, link/ID required  

*Ruby*
```ruby
SD::Calendars.create(name: "Work", color_theme: "red", visibility: :shared)
```

*PHP*
```php
<?php
$calendar = \SweetDate\Calendars::create([
  "name" => "Work",
  "color_theme" => "red",
  "visibility" => "shared"
]);
print_r($calendar);
```

*JavaScript*
```javascript
const calendar = await SD.Calendars.create({
  name: "Work",
  color_theme: "red",
  visibility: "shared"
});
console.log(calendar);
```

*Elixir*
```elixir
{:ok, calendar} = SD.Calendars.create(%{name: "Work", color_theme: "red", visibility: :shared})
IO.inspect(calendar)
```

**Request**
```
POST /api/v1/calendars
{
  "name": "Work",
  "color_theme": "red",
  "visibility": "shared"
}
```

**Response**
```json
{
  "status": "ok",
  "calendar": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Work",
    "color_theme": "red",
    "visibility": "shared",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

**Error**
```json
{ "status": "error", "message": "..." }
```

---

### GET
Get a single calendar by ID.

*Ruby*
```ruby
SD::Calendars.get("CALENDAR-ID")
```

*PHP*
```php
<?php
$calendar = \SweetDate\Calendars::get("CALENDAR-ID");
print_r($calendar);
```

*JavaScript*
```javascript
const calendar = await SD.Calendars.get("CALENDAR-ID");
console.log(calendar);
```

*Elixir*
```elixir
{:ok, calendar} = SD.Calendars.get("CALENDAR-ID")
IO.inspect(calendar)
```

**Request**
```
GET /api/v1/calendars/:id
```

**Response**
```json
{
  "status": "ok",
  "calendar": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Work",
    "color_theme": "red",
    "visibility": "shared",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

**Error**
```json
{ "status": "error", "message": "..." }
```

---

### UPDATE
Update an existing calendar.

> Permitted values for `visibility`:  
> - **private** – Only the owner has access  
> - **shared** – Shared with selected users  
> - **public** – Discoverable within the tenant  
> - **unlisted** – Hidden from discovery, link/ID required  

*Ruby*
```ruby
SD::Calendars.update("CALENDAR-ID", name: "Work (Team)", visibility: :public)
```

*PHP*
```php
<?php
$calendar = \SweetDate\Calendars::update("CALENDAR-ID", [
  "name" => "Work (Team)",
  "visibility" => "public"
]);
print_r($calendar);
```

*JavaScript*
```javascript
const calendar = await SD.Calendars.update("CALENDAR-ID", {
  name: "Work (Team)",
  visibility: "public"
});
console.log(calendar);
```

*Elixir*
```elixir
{:ok, calendar} = SD.Calendars.update("CALENDAR-ID", %{name: "Work (Team)", visibility: :public})
IO.inspect(calendar)
```

**Request**
```
PUT /api/v1/calendars/:id
{
  "name": "Work (Team)",
  "visibility": "public"
}
```

**Response**
```json
{
  "status": "ok",
  "calendar": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Work (Team)",
    "color_theme": "red",
    "visibility": "public",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

**Error**
```json
{ "status": "error", "message": "..." }
```

---

### DELETE
Delete a calendar.

*Ruby*
```ruby
SD::Calendars.delete("CALENDAR-ID")
# => { status: "ok" }
```

*PHP*
```php
<?php
$resp = \SweetDate\Calendars::delete("CALENDAR-ID");
print_r($resp);
```

*JavaScript*
```javascript
const resp = await SD.Calendars.delete("CALENDAR-ID");
console.log(resp);
```

*Elixir*
```elixir
:ok = SD.Calendars.delete("CALENDAR-ID")
```

**Request**
```
DELETE /api/v1/calendars/:id
```

**Response**
```json
{"status": "ok"}
```

**Error**
```json
{ "status": "error", "message": "..." }
```

---

### LIST_EVENTS
List all events on a calendar.

*Ruby*
```ruby
SD::Calendars.list_events("CALENDAR-ID", limit: 25, offset: 0)
```

*PHP*
```php
<?php
$events = \SweetDate\Calendars::listEvents("CALENDAR-ID", 25, 0);
print_r($events);
```

*JavaScript*
```javascript
const events = await SD.Calendars.listEvents("CALENDAR-ID", { limit: 25, offset: 0 });
console.log(events);
```

*Elixir*
```elixir
{:ok, events} = SD.Calendars.list_events("CALENDAR-ID", limit: 25, offset: 0)
IO.inspect(events)
```

**Request**
```
GET /api/v1/calendars/:calendar_id/events?limit=25&offset=0
```

**Response**
```json
{
  "status": "ok",
  "events": [
    {
      "id": "00000000-0000-0000-0000-000000000000",
      "name": "Weekly Sync",
      "description": "Team status meeting",
      "status": "scheduled",
      "visibility": "public",
      "color_theme": "default",
      "location": "Room 3A",
      "start_time": "2025-08-20T09:00:00Z",
      "end_time": "2025-08-20T09:30:00Z",
      "recurrence_rule": "weekly",
      "all_day": false,
      "inserted_at": "2025-08-18T09:20:00Z",
      "updated_at": "2025-08-19T10:15:00Z"
    }
  ],
  "limit": 25,
  "offset": 0
}
```

**Error**
```json
{ "status": "error", "message": "..." }
```

---

### CREATE_EVENT
Create an event on a calendar.

> Permitted values for `status`:  
> - **scheduled** · **cancelled** · **postponed** · **completed**  
>
> Permitted values for `visibility`:  
> - **private** · **public** · **busy**  
>
> Permitted values for `recurrence_rule`:  
> - **none** · **daily** · **weekly** · **monthly** · **yearly**  

*Ruby*
```ruby
SD::Calendars.create_event("CALENDAR-ID", name: "Planning", description: "Q3 planning session", status: :scheduled, visibility: :busy, location: "Zoom", start_time: "2025-08-22T13:00:00Z", end_time: "2025-08-22T14:00:00Z")
```

*PHP*
```php
<?php
$event = \SweetDate\Calendars::createEvent("CALENDAR-ID", [
  "name" => "Planning",
  "description" => "Q3 planning session",
  "status" => "scheduled",
  "visibility" => "busy",
  "location" => "Zoom",
  "start_time" => "2025-08-22T13:00:00Z",
  "end_time" => "2025-08-22T14:00:00Z"
]);
print_r($event);
```

*JavaScript*
```javascript
const event = await SD.Calendars.createEvent("CALENDAR-ID", {
  name: "Planning",
  description: "Q3 planning session",
  status: "scheduled",
  visibility: "busy",
  location: "Zoom",
  start_time: "2025-08-22T13:00:00Z",
  end_time: "2025-08-22T14:00:00Z"
});
console.log(event);
```

*Elixir*
```elixir
{:ok, event} =
  SD.Calendars.create_event("CALENDAR-ID", %{
    name: "Planning",
    description: "Q3 planning session",
    status: :scheduled,
    visibility: :busy,
    location: "Zoom",
    start_time: "2025-08-22T13:00:00Z",
    end_time: "2025-08-22T14:00:00Z"
  })
IO.inspect(event)
```

**Request**
```
POST /api/v1/calendars/:calendar_id/events
{
  "name": "Planning",
  "description": "Q3 planning session",
  "status": "scheduled",
  "visibility": "busy",
  "color_theme": "default",
  "location": "Zoom",
  "start_time": "2025-08-22T13:00:00Z",
  "end_time": "2025-08-22T14:00:00Z",
  "recurrence_rule": "none",
  "all_day": false
}
```

**Response**
```json
{
  "status": "ok",
  "event": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Planning",
    "description": "Q3 planning session",
    "status": "scheduled",
    "visibility": "busy",
    "color_theme": "default",
    "location": "Zoom",
    "start_time": "2025-08-22T13:00:00Z",
    "end_time": "2025-08-22T14:00:00Z",
    "recurrence_rule": "none",
    "all_day": false,
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

**Error**
```json
{ "status": "error", "message": "..." }
```

---

### GET_EVENT
Get a calendar event by ID.

*Ruby*
```ruby
SD::Calendars.get_event("CALENDAR-ID", "EVENT-ID")
```

*PHP*
```php
<?php
$event = \SweetDate\Calendars::getEvent("CALENDAR-ID", "EVENT-ID");
print_r($event);
```

*JavaScript*
```javascript
const event = await SD.Calendars.getEvent("CALENDAR-ID", "EVENT-ID");
console.log(event);
```

*Elixir*
```elixir
{:ok, event} = SD.Calendars.get_event("CALENDAR-ID", "EVENT-ID")
IO.inspect(event)
```

**Request**
```
GET /api/v1/calendars/:calendar_id/events/:id
```

**Response**
```json
{
  "status": "ok",
  "event": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Planning",
    "description": "Q3 planning session",
    "status": "scheduled",
    "visibility": "busy",
    "color_theme": "default",
    "location": "Zoom",
    "start_time": "2025-08-22T13:00:00Z",
    "end_time": "2025-08-22T14:00:00Z",
    "recurrence_rule": "none",
    "all_day": false,
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

**Error**
```json
{ "status": "error", "message": "..." }
```

---

### UPDATE_EVENT
Update a calendar event.

*Ruby*
```ruby
SD::Calendars.update_event("CALENDAR-ID", "EVENT-ID", status: :cancelled, visibility: :public, name: "Planning (Cancelled)")
```

*PHP*
```php
<?php
$event = \SweetDate\Calendars::updateEvent("CALENDAR-ID", "EVENT-ID", [
  "status" => "cancelled",
  "visibility" => "public",
  "name" => "Planning (Cancelled)"
]);
print_r($event);
```

*JavaScript*
```javascript
const event = await SD.Calendars.updateEvent("CALENDAR-ID", "EVENT-ID", {
  status: "cancelled",
  visibility: "public",
  name: "Planning (Cancelled)"
});
console.log(event);
```

*Elixir*
```elixir
{:ok, event} = SD.Calendars.update_event("CALENDAR-ID", "EVENT-ID", %{status: :cancelled, visibility: :public, name: "Planning (Cancelled)"})
IO.inspect(event)
```

**Request**
```
PUT /api/v1/calendars/:calendar_id/events/:id
{
  "status": "cancelled",
  "visibility": "public",
  "name": "Planning (Cancelled)"
}
```

**Response**
```json
{
  "status": "ok",
  "event": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Planning (Cancelled)",
    "description": "Q3 planning session",
    "status": "cancelled",
    "visibility": "public",
    "color_theme": "default",
    "location": "Zoom",
    "start_time": "2025-08-22T13:00:00Z",
    "end_time": "2025-08-22T14:00:00Z",
    "recurrence_rule": "none",
    "all_day": false,
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

**Error**
```json
{ "status": "error", "message": "..." }
```

---

### DELETE_EVENT
Delete a calendar event.

*Ruby*
```ruby
SD::Calendars.delete_event("CALENDAR-ID", "EVENT-ID")
# => { status: "ok" }
```

*PHP*
```php
<?php
$resp = \SweetDate\Calendars::deleteEvent("CALENDAR-ID", "EVENT-ID");
print_r($resp);
```

*JavaScript*
```javascript
const resp = await SD.Calendars.deleteEvent("CALENDAR-ID", "EVENT-ID");
console.log(resp);
```

*Elixir*
```elixir
:ok = SD.Calendars.delete_event("CALENDAR-ID", "EVENT-ID")
```

**Request**
```
DELETE /api/v1/calendars/:calendar_id/events/:id
```

**Response**
```json
{ "status": "ok" }
```

**Error**
```json
{ "status": "error", "message": "..." }
```

---

### LIST_USERS
List all users attached to a calendar.

*Ruby*
```ruby
SD::Calendars.list_users("CALENDAR-ID")
```

*PHP*
```php
<?php
$users = \SweetDate\Calendars::listUsers("CALENDAR-ID");
print_r($users);
```

*JavaScript*
```javascript
const users = await SD.Calendars.listUsers("CALENDAR-ID");
console.log(users);
```

*Elixir*
```elixir
{:ok, users} = SD.Calendars.list_users("CALENDAR-ID")
IO.inspect(users)
```

**Request**
```
GET /api/v1/calendars/:calendar_id/users
```

**Response**
```json
{
  "status": "ok",
  "calendar_id": "00000000-0000-0000-0000-000000000000",
  "users": [
    {
      "id": "00000000-0000-0000-0000-000000000000",
      "name": "Alice Example",
      "email": "alice@example.com",
      "role": "owner",
      "inserted_at": "2025-08-18T09:20:00Z",
      "updated_at": "2025-08-19T10:15:00Z"
    }
  ]
}
```

**Error**
```json
{ "status": "error", "message": "..." }
```

---

### CREATE_USER
Attach a user to a calendar.

> Permitted values for `role`:  
> - **owner** – Owns the calendar and can delete it  
> - **admin** – Edit  
> - **guest** – Show  

*Ruby*
```ruby
SD::Calendars.create_user("CALENDAR-ID", user_id: "USER-ID", role: :admin)
```

*PHP*
```php
<?php
$user = \SweetDate\Calendars::createUser("CALENDAR-ID", [
  "user_id" => "USER-ID",
  "role" => "admin"
]);
print_r($user);
```

*JavaScript*
```javascript
const user = await SD.Calendars.createUser("CALENDAR-ID", { user_id: "USER-ID", role: "admin" });
console.log(user);
```

*Elixir*
```elixir
{:ok, user} = SD.Calendars.create_user("CALENDAR-ID", %{user_id: "USER-ID", role: :admin})
IO.inspect(user)
```

**Request**
```
POST /api/v1/calendars/:calendar_id/users
{
  "user_id": "00000000-0000-0000-0000-000000000000",
  "role": "admin"
}
```

**Response**
```json
{
  "status": "ok",
  "user": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Alice Example",
    "email": "alice@example.com",
    "role": "admin",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

**Error**
```json
{ "status": "error", "message": "..." }
```

---

### GET_USER
Get a calendar user by ID.

*Ruby*
```ruby
SD::Calendars.get_user("CALENDAR-ID", "USER-ID")
```

*PHP*
```php
<?php
$user = \SweetDate\Calendars::getUser("CALENDAR-ID", "USER-ID");
print_r($user);
```

*JavaScript*
```javascript
const user = await SD.Calendars.getUser("CALENDAR-ID", "USER-ID");
console.log(user);
```

*Elixir*
```elixir
{:ok, user} = SD.Calendars.get_user("CALENDAR-ID", "USER-ID")
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
    "name": "Alice Example",
    "email": "alice@example.com",
    "role": "admin",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

**Error**
```json
{ "status": "error", "message": "..." }
```

---

### UPDATE_USER
Update a calendar user.

*Ruby*
```ruby
SD::Calendars.update_user("CALENDAR-ID", "USER-ID", role: :owner)
```

*PHP*
```php
<?php
$user = \SweetDate\Calendars::updateUser("CALENDAR-ID", "USER-ID", ["role" => "owner"]);
print_r($user);
```

*JavaScript*
```javascript
const user = await SD.Calendars.updateUser("CALENDAR-ID", "USER-ID", { role: "owner" });
console.log(user);
```

*Elixir*
```elixir
{:ok, user} = SD.Calendars.update_user("CALENDAR-ID", "USER-ID", %{role: :owner})
IO.inspect(user)
```

**Request**
```
PUT /api/v1/calendars/:calendar_id/users/:id
{
  "role": "owner"
}
```

**Response**
```json
{
  "status": "ok",
  "user": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Alice Example",
    "email": "alice@example.com",
    "role": "owner",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

**Error**
```json
{ "status": "error", "message": "..." }
```

---

### DELETE_USER
Delete a calendar user association.

*Ruby*
```ruby
SD::Calendars.delete_user("CALENDAR-ID", "USER-ID")
# => { status: "ok" }
```

*PHP*
```php
<?php
$resp = \SweetDate\Calendars::deleteUser("CALENDAR-ID", "USER-ID");
print_r($resp);
```

*JavaScript*
```javascript
const resp = await SD.Calendars.deleteUser("CALENDAR-ID", "USER-ID");
console.log(resp);
```

*Elixir*
```elixir
:ok = SD.Calendars.delete_user("CALENDAR-ID", "USER-ID")
```

**Request**
```
DELETE /api/v1/calendars/:calendar_id/users/:id
```

**Response**
```json
{ "status": "ok" }
```

**Error**
```json
{ "status": "error", "message": "..." }
```
