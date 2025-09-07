---
title: Tenant Users 
nav_order: 510
layout: home
parent: Tenant
---

# TENANT USERS — Nested Resource

This page documents the API endpoints for managing **users within a specific tenant** using nested REST routes.

All routes are scoped under:

```
/api/v1/tenants/:tenant_id/users
```

---

## LIST USERS

Returns users associated with a tenant.

**Request**
```
GET /api/v1/tenants/:tenant_id/users?limit=25&offset=0&q=alice
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

## CREATE USER

Associates a user with a tenant.

**Request**
```
POST /api/v1/tenants/:tenant_id/users
```
**Payload**
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
    "name": "Alice",
    "email": "alice@example.com",
    "role": "admin",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

---

## GET USER

Fetch a specific user associated with a tenant.

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
    "name": "Alice",
    "email": "alice@example.com",
    "role": "owner",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

---

## UPDATE USER

Updates the role of a user within the tenant.

**Request**
```
PUT /api/v1/tenants/:tenant_id/users/:id
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

## DELETE USER

Removes the association between the user and the tenant.

**Request**
```
DELETE /api/v1/tenants/:tenant_id/users/:id
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
