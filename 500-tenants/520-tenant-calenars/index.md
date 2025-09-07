---
title: Tenant Calendars 
nav_order: 220
layout: home
parent: Tenant
---

# TENANT CALENDARS — Nested Resource

This page documents the API endpoints for managing **calendars within a specific tenant** using nested REST routes.

All routes are scoped under:

```
/api/v1/tenants/:tenant_id/calendars
```

---

### LIST
Returns calendars associated with a tenant.

**Request**
```
GET /api/v1/tenants/:tenant_id/calendars?limit=25&offset=0&q=marketing
```

**Response**
```json
{
  "status": "ok",
  "result": {
    "calendars": [
      {
        "id": "11111111-1111-1111-1111-111111111111",
        "name": "Marketing",
        "color_theme": "green",
        "visibility": "public",
        "timezone": "Europe/Copenhagen",
        "inserted_at": "2025-08-18T09:20:00Z",
        "updated_at": "2025-08-19T10:15:00Z"
      }
    ],
    "limit": 25,
    "offset": 0
  }
}
```

---

### CREATE
Create and associate a calendar with a tenant.

**Request**
```
POST /api/v1/tenants/:tenant_id/calendars
{
  "name": "Team A",
  "color_theme": "slate",
  "visibility": "private",
  "timezone": "Europe/Copenhagen"
}
```

**Response**
```json
{
  "status": "ok",
  "calendar": {
    "id": "22222222-2222-2222-2222-222222222222",
    "name": "Team A",
    "color_theme": "slate",
    "visibility": "private",
    "timezone": "Europe/Copenhagen",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-18T09:20:00Z"
  }
}
```

---

### GET
Get a single calendar by ID.

**Request**
```
GET /api/v1/tenants/:tenant_id/calendars/:id
```

**Response**
```json
{
  "status": "ok",
  "calendar": {
    "id": "22222222-2222-2222-2222-222222222222",
    "name": "Team A",
    "color_theme": "slate",
    "visibility": "private",
    "timezone": "Europe/Copenhagen",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

---

### UPDATE
Update an existing calendar.

**Request**
```
PUT /api/v1/tenants/:tenant_id/calendars/:id
{
  "name": "Team Alpha",
  "visibility": "shared",
  "timezone": "UTC"
}
```

**Response**
```json
{
  "status": "ok",
  "calendar": {
    "id": "22222222-2222-2222-2222-222222222222",
    "name": "Team Alpha",
    "color_theme": "slate",
    "visibility": "shared",
    "timezone": "UTC",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

---

### DELETE
Delete a calendar.

**Request**
```
DELETE /api/v1/tenants/:tenant_id/calendars/:id
```

**Response**
```json
{
  "status": "ok"
}
```


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
    "visibility": ["is invalid"]
  }
}
```
