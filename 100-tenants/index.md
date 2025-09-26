---
title: Tenants 
nav_order: 100 
layout: home
has_children: true
type: protocol
---

# Tenants

Tenants are a way to group calendars together. Each **tenant** can have many **calendars**.

This page specifies commands for working with tenants.
Each section shows language-specific SDK calls first (Ruby, PHP, JavaScript, Elixir), followed by the raw REST request/response.

> Conventions used below:
> - All SDKs expose a `Tenants` namespace/module/class.
> - Pagination uses `limit` and `offset` (defaults: `limit=25`, `offset=0`).
> - Timestamps are ISO 8601 (UTC).

---

## LIST_TENANTS
Returns tenants ordered by name ascending.

*Ruby*
```ruby
# Optional pagination
SD::Tenants.list(limit: 25, offset: 0)
# => [{ id: "00000000-0000-0000-0000-000000000000", name: "Hotel Royal" }]
```

*PHP*
```php
<?php
$tenants = \SweetDate\Tenant::list(25, 0);
print_r($tenants);
// => [ ["id" => "00000000-0000-0000-0000-000000000000", "name" => "Hotel Royal"] ]
```
 
*JavaScript*
```javascript
const tenants = await SD.Tenants.list({ limit: 25, offset: 0 });
console.log(tenants);
// => [{ id: "00000000-0000-0000-0000-000000000000", name: "Hotel Royal" }]
```

*Elixir*
```elixir
{:ok, tenants} = SD.Tenants.list(limit: 25, offset: 0)
IO.inspect(tenants)
# => [%{id: "00000000-0000-0000-0000-000000000000", name: "Hotel Royal"}]
```

**Request**
```
GET /api/v1/tenants?limit=25&offset=0
```

**Response**
```json
{
  "status": "ok",
  "tenants": [
    {
      "id": "00000000-0000-0000-0000-000000000000",
      "name": "Alpha",
      "account_id": "acc-123",
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

## CREATE
Create a new tenant.

*Ruby*
```ruby
SD::Tenants.create(name: "Building 4")
# => { id: "00000000-0000-0000-0000-000000000000", name: "Building 4" }
```

*PHP*
```php
<?php
$tenant = \SweetDate\Tenants::create(["name" => "Building 4"]);
print_r($tenant);
```

*JavaScript*
```javascript
const tenant = await SD.Tenants.create({ name: "Building 4" });
console.log(tenant);
```

*Elixir*
```elixir
{:ok, tenant} = SD.Tenants.create(%{name: "Building 4"})
IO.inspect(tenant)
```

**Request**
```
POST /api/v1/tenants
{
  "name": "Building 4"
}
```

**Response**
```json
{
  "status": "ok",
  "tenant": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Building 4",
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

## GET
Get a single tenant by ID.

*Ruby*
```ruby
SD::Tenants.get("00000000-0000-0000-0000-000000000000")
# => { id: "...", name: "Terminal 23" }
```

*PHP*
```php
<?php
$tenant = \SweetDate\Tenant::get("00000000-0000-0000-0000-000000000000");
print_r($tenant);
```

*JavaScript*
```javascript
const tenant = await SD.Tenants.get("00000000-0000-0000-0000-000000000000");
console.log(tenant);
```

*Elixir*
```elixir
{:ok, tenant} = SD.Tenants.get("00000000-0000-0000-0000-000000000000")
IO.inspect(tenant)
```

**Request**
```
GET /api/v1/tenants/:id
```

**Response**
```json
{
  "status": "ok",
  "tenant": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Terminal 23",
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

## UPDATE
Update an existing tenant.

*Ruby*
```ruby
SD::Tenants.update("00000000-0000-0000-0000-000000000000", name: "Terminal 3 3/4")
# => { id: "...", name: "Terminal 3 3/4" }
```

*PHP*
```php
<?php
$tenant = \SweetDate\Tenant::update("00000000-0000-0000-0000-000000000000", ["name" => "Terminal 3 3/4"]);
print_r($tenant);
```

*JavaScript*
```javascript
const tenant = await SD.Tenants.update("00000000-0000-0000-0000-000000000000", {
  name: "Terminal 3 3/4"
});
console.log(tenant);
```

*Elixir*
```elixir
{:ok, tenant} =
  SD.Tenants.update("00000000-0000-0000-0000-000000000000", %{name: "Terminal 3 3/4"})
IO.inspect(tenant)
```

**Request**
```
PUT /api/v1/tenants/:id
{
  "name": "Terminal 3 3/4"
}
```

**Response**
```json
{
  "status": "ok",
  "tenant": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Terminal 3 3/4",
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

## DELETE
Delete a tenant.

*Ruby*
```ruby
SD::Tenants.delete("00000000-0000-0000-0000-000000000000")
# => { status: "ok" }
```

*PHP*
```php
<?php
$resp = \SweetDate\Tenant::delete("00000000-0000-0000-0000-000000000000");
print_r($resp);
// => ["status" => "ok"]
```

*JavaScript*
```javascript
const resp = await SD.Tenants.delete("00000000-0000-0000-0000-000000000000");
console.log(resp);
// => { status: "ok" }
```

*Elixir*
```elixir
:ok = SD.Tenants.delete("00000000-0000-0000-0000-000000000000")
# => :ok
```

**Request**
```
DELETE /api/v1/tenants/:id
```

**Response**
```json
{ "status": "ok" }
```

**Error**
```json
{ "status": "error", "message": "..." }
```
