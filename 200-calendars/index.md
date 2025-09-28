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


