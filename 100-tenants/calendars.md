---
title: Calendars 
nav_order: 22
layout: home
parent: Tenants
type: protocol
---

# Calendars 

This page specifies commands for working with calendars for a given tenant.  
Each section shows **language-specific SDK calls first** (Ruby, PHP, JavaScript, Elixir), followed by the **raw REST request/response**.

---

### CALENDARS
List all calendars attached to a tenant.

> Optional query params:
> - **limit** – Maximum number of calendars to return (default: 25)  
> - **offset** – Number of calendars to skip before starting to return results (default: 0)  
> - **q** – Search term (matches against calendar name)  

*Ruby*
```ruby
SD::TenantCalendars.list(tenant_id: "00000000-0000-0000-0000-000000000000", limit: 25, offset: 0)
# => [%{id: "...", name: "Some calendar"}]
```

*PHP*
```php
<?php
$calendars = \SweetDate\TenantCalendars::list("00000000-0000-0000-0000-000000000000", 25, 0);
print_r($calendars);
```

*JavaScript*
```javascript
const calendars = await SD.TenantCalendars.list("00000000-0000-0000-0000-000000000000", { limit: 25, offset: 0 });
console.log(calendars);
```

*Elixir*
```elixir
{:ok, calendars} = SD.TenantCalendars.list("00000000-0000-0000-0000-000000000000", limit: 25, offset: 0)
IO.inspect(calendars)
```

**Request**
```
GET /api/v1/tenants/:tenant_id/calendars
```

**Response**
```json
{
  "status": "ok",
  "calendars": [
    { 
      "id": "00000000-0000-0000-0000-000000000000", 
      "name": "Some name",
      "color_theme": "red",
      "visibility": "shared",
      "inserted_at": "2025-08-18T09:20:00Z",
      "updated_at": "2025-08-19T10:15:00Z"
    },
    { 
      "id": "00000000-0000-0000-0000-000000000000", 
      "name": "Some other name",
      "color_theme": "blue",
      "visibility": "shared",
      "inserted_at": "2025-08-18T09:20:00Z",
      "updated_at": "2025-08-19T10:15:00Z"
    }
  ]
}
```

**Errors** 404 Not Found
```json
{
  "status": "error",
  "message": "not found"
}
```

---

### CREATE
Attach a calendar to a tenant.

> Permitted values for `visibility`:  
> - **private** – Only the owner has access  
> - **shared** – Shared with selected users  
> - **public** – Discoverable within the tenant  
> - **unlisted** – Hidden from discovery, link/ID required  

*Ruby*
```ruby
SD::TenantCalendars.create("00000000-0000-0000-0000-000000000000", calendar_id: "CAL-123")
```

*PHP*
```php
<?php
$calendar = \SweetDate\TenantCalendars::create("00000000-0000-0000-0000-000000000000", [
  "calendar_id" => "CAL-123"
]);
print_r($calendar);
```

*JavaScript*
```javascript
const calendar = await SD.TenantCalendars.create("00000000-0000-0000-0000-000000000000", {
  calendar_id: "CAL-123"
});
console.log(calendar);
```

*Elixir*
```elixir
{:ok, calendar} = SD.TenantCalendars.create("00000000-0000-0000-0000-000000000000", %{calendar_id: "CAL-123"})
IO.inspect(calendar)
```

**Request**
```
POST /api/v1/tenants/:tenant_id/calendars
{
  "calendar_id": "00000000-0000-0000-0000-000000000000"
}
```

**Response**
```json
{
  "status": "ok",
  "calendar": { 
    "id": "00000000-0000-0000-0000-000000000000", 
    "name": "Some name",
    "visibility": "shared",
    "color_theme": "red",
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
Get a tenant calendar by ID, including its associated users.

*Ruby*
```ruby
SD::TenantCalendars.get("TENANT-ID", "CALENDAR-ID")
```

*PHP*
```php
<?php
$calendar = \SweetDate\TenantCalendars::get("TENANT-ID", "CALENDAR-ID");
print_r($calendar);
```

*JavaScript*
```javascript
const calendar = await SD.TenantCalendars.get("TENANT-ID", "CALENDAR-ID");
console.log(calendar);
```

*Elixir*
```elixir
{:ok, calendar} = SD.TenantCalendars.get("TENANT-ID", "CALENDAR-ID")
IO.inspect(calendar)
```

**Request**
```
GET /api/v1/tenants/:tenant_id/calendars/:id
```

**Response**
```json
{
  "status": "ok",
  "calendar": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Some calendar",
    "color_theme": "white",
    "visibility": "private",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z",
    "users": [
      {
        "id": "00000000-0000-0000-0000-000000000000",
        "name": "Some name",
        "email": "some-name@example.com",
        "role": "owner",
        "inserted_at": "2025-08-18T09:20:00Z",
        "updated_at": "2025-08-19T10:15:00Z"
      },
      {
        "id": "00000000-0000-0000-0000-000000000000",
        "name": "Some other name",
        "email": "some-other-name@example.com",
        "role": "admin",
        "inserted_at": "2025-08-18T09:20:00Z",
        "updated_at": "2025-08-19T10:15:00Z"
      }
    ]
  }
}
```

**Error**
```json
{ "status": "error", "message": "..." }
```

---

### DELETE
Delete a tenant calendar association.

*Ruby*
```ruby
SD::TenantCalendars.delete("TENANT-ID", "CALENDAR-ID")
# => { status: "ok" }
```

*PHP*
```php
<?php
$resp = \SweetDate\TenantCalendars::delete("TENANT-ID", "CALENDAR-ID");
print_r($resp);
```

*JavaScript*
```javascript
const resp = await SD.TenantCalendars.delete("TENANT-ID", "CALENDAR-ID");
console.log(resp);
```

*Elixir*
```elixir
:ok = SD.TenantCalendars.delete("TENANT-ID", "CALENDAR-ID")
```

**Request**
```
DELETE /api/v1/tenants/:tenant_id/calendars/:id
```

**Response**
```json
{ "status": "ok" }
```

**Error**
```json
{ "status": "error", "message": "..." }
```
