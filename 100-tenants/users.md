---
title: Users 
nav_order: 100 
layout: home
parent: Tenants
type: protocol
---

# Users 

This page specifies commands for working with users for a given tenant.  
Each section shows **language-specific SDK calls first** (Ruby, PHP, JavaScript, Elixir), followed by the **raw REST request/response**.

---

### USERS
List all tenant users.

> Optional query params:  
> - **limit** – Maximum number of users to return (default: 25)  
> - **offset** – Number of users to skip before starting to return results (default: 0)  
> - **q** – Search term (matches against user name or email)  

*Ruby*
```ruby
SD::TenantUsers.list("TENANT-ID", limit: 10, offset: 20, q: "alice")
```

*PHP*
```php
<?php
$users = \SweetDate\TenantUsers::list("TENANT-ID", 10, 20, "alice");
print_r($users);
```

*JavaScript*
```javascript
const users = await SD.TenantUsers.list("TENANT-ID", { limit: 10, offset: 20, q: "alice" });
console.log(users);
```

*Elixir*
```elixir
{:ok, users} = SD.TenantUsers.list("TENANT-ID", limit: 10, offset: 20, q: "alice")
IO.inspect(users)
```

**Request**
```
GET /api/v1/tenants/:tenant_id/users?limit=10&offset=20&q=alice
```

**Response**
```json
{
  "status": "ok",
  "users": [
    {
      "id": "00000000-0000-0000-0000-000000000000", 
      "name": "some name",
      "email": "some-email@example.com",
      "role": "owner", 
      "inserted_at": "2025-08-18T09:20:00Z",
      "updated_at": "2025-08-19T10:15:00Z"
    },
    {
      "id": "00000000-0000-0000-0000-000000000000", 
      "name": "Some other name",
      "email": "some-other-email@example.com",
      "role": "admin",
      "inserted_at": "2025-08-18T09:20:00Z",
      "updated_at": "2025-08-19T10:15:00Z"
    }
  ]
}
```

**Error**
```json
{
  "status": "error",
  "message": "not found",
  "error_code": "NOT_FOUND"
}
```

---

### CREATE
Create a tenant–user association.

> Permitted values for `role`:  
> - **owner** – Create, Show, Update, Delete **tenant** and **calendar**
> - **admin** – Create, Show, Update, Delete **calendar**  
> - **guest** – Show  **calendar**

*Ruby*
```ruby
SD::TenantUsers.create("TENANT-ID", user_id: "USER-ID", role: :admin)
```

*PHP*
```php
<?php
$user = \SweetDate\TenantUsers::create("TENANT-ID", [
  "user_id" => "USER-ID",
  "role" => "admin"
]);
print_r($user);
```

*JavaScript*
```javascript
const user = await SD.TenantUsers.create("TENANT-ID", {
  user_id: "USER-ID",
  role: "admin"
});
console.log(user);
```

*Elixir*
```elixir
{:ok, user} = SD.TenantUsers.create("TENANT-ID", %{user_id: "USER-ID", role: :admin})
IO.inspect(user)
```

**Request**
```
POST /api/v1/tenants/:tenant_id/users
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
    "email": "some-name@example.com",
    "name": "some name",
    "role": "admin",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
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

**Error** 422 Unprocessable Entity
```json
{
  "status": "error",
  "message": "invalid input",
  "error_code": "VALIDATION_ERROR",
  "fields": {
    "user_id": ["is not a valid UUID"],
    "role": ["is invalid"]
  }
}
```

---

### GET
Get a tenant user by ID.

*Ruby*
```ruby
SD::TenantUsers.get("TENANT-ID", "USER-ID")
```

*PHP*
```php
<?php
$user = \SweetDate\TenantUsers::get("TENANT-ID", "USER-ID");
print_r($user);
```

*JavaScript*
```javascript
const user = await SD.TenantUsers.get("TENANT-ID", "USER-ID");
console.log(user);
```

*Elixir*
```elixir
{:ok, user} = SD.TenantUsers.get("TENANT-ID", "USER-ID")
IO.inspect(user)
```

**Request**
```
GET /api/v1/tenants/:tenant_id/users/:id
```

**Response**
```json
{
  "status": "ok",
  "user": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Some name",
    "email": "some-name@example.com",
    "role": "owner",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

**Error**
```json
{
  "status": "error",
  "error_code": "VALIDATION_ERROR",
  "fields": { "role": ["is invalid"] },
  "message": "invalid input"
}
```

---

### UPDATE
Update a tenant user.

*Ruby*
```ruby
SD::TenantUsers.update("TENANT-ID", "USER-ID", role: :admin)
```

*PHP*
```php
<?php
$user = \SweetDate\TenantUsers::update("TENANT-ID", "USER-ID", ["role" => "admin"]);
print_r($user);
```

*JavaScript*
```javascript
const user = await SD.TenantUsers.update("TENANT-ID", "USER-ID", { role: "admin" });
console.log(user);
```

*Elixir*
```elixir
{:ok, user} = SD.TenantUsers.update("TENANT-ID", "USER-ID", %{role: :admin})
IO.inspect(user)
```

**Request**
```
PUT /api/v1/tenants/:tenant_id/users/:id
{
  "role": "admin"
}
```

**Response**
```json
{
  "status": "ok",
  "user": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Some name",
    "email": "some-name@example.com",
    "role": "admin",
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
    "role": ["is invalid"]
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

---

### USER
Delete a tenant user.

*Ruby*
```ruby
SD::TenantUsers.delete("TENANT-ID", "USER-ID")
# => { status: "ok" }
```

*PHP*
```php
<?php
$resp = \SweetDate\TenantUsers::delete("TENANT-ID", "USER-ID");
print_r($resp);
```

*JavaScript*
```javascript
const resp = await SD.TenantUsers.delete("TENANT-ID", "USER-ID");
console.log(resp);
```

*Elixir*
```elixir
:ok = SD.TenantUsers.delete("TENANT-ID", "USER-ID")
```

**Request**
```
DELETE /api/v1/tenants/:tenant_id/users/:id
```

**Response**
```json
{ "status": "ok" }
```

**Error** 404 Not Found
```json
{
  "status": "error",
  "message": "not found",
  "error_code": "NOT_FOUND"
}
```
