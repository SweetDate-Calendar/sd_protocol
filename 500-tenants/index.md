---
title: Tenant 
nav_order: 500 
layout: home
has_children: true
---

# TENANTS — Command Reference

This page specifies commands for working with tenants, tenant–user associations, and tenant–calendar associations.  

---

### LIST_TENANTS
Returns tenants ordered by name ascending.

**Request**
```
GET /api/v1/tenants?limit=25&offset=0
```

**Response**
```json
{
  "status": "ok",
  "result": {
    "tenants": [{}, {}],
    "limit": 25,
    "offset": 0
  }
}
```

---

### CREATE
Create a new tenant.

**Request**
```
POST /api/v1/tenants
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

---

### GET
Get a single tenant by ID.

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
    "name": "Building 4",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

---

### UPDATE
Update an existing tenant.

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

---

### DELETE
Delete a tenant.

**Request**
```
DELETE /api/v1/tenants/:id
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

---

## Errors

### 404 Not Found
```json
{
  "status": "error",
  "message": "not found"
}
```

### 422 Validation Error
```json
{
  "status": "error",
  "message": "validation failed",
  "details": {
    "name": ["can't be blank"]
  }
}
```