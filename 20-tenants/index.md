---
title: Tenants 
nav_order: 20
layout: home
has_children: true
---

# TENANTS — Command Reference

This page specifies commands for working with tenants, tenant–user associations, and tenant–calendar associations.  
Each section documents parameters, response types, and examples.

---

### LIST_TENANTS
Returns tenants ordered by name ascending.

**Request**
```
GET /api/v1/tenants?limit=25&offset=0
```

**Response**
```
{
  "status": "ok",
  "result": {
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
}
```

**Error**
```
{ "status": "error", "message": "..." }
```

---

### CREATE
Create a new tenant.

**Request**
```
POST /api/v1/tenants
{
  "name": "Building 4"
}
```

**Response**
```
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
```
 { "status": "error", "message": "..." }
```

---

### GET
Get a single tenant by ID.

**Request**
```
GET /api/v1/tenants/:id
```

**Response**
```
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
```
 { "status": "error", "message": "..." }
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
```
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
```
 { "status": "error", "message": "..." }
```

---

### DELETE
Delete a tenant.

**Request**
```
DELETE /api/v1/tenants/:id
```

**Response**
```
{"status": "ok"}
```

**Error**
```
 { "status": "error", "message": "..." }
```

---

### LIST_USERS
List all tenant users.

**Request**
```
GET /api/v1/tenants/:tenant_id/users
```

**Response**
```
{
  "status": "ok",
  "tenant_id": "00000000-0000-0000-0000-000000000000",
  "users": [
    {
      "id": "00000000-0000-0000-0000-000000000000", 
      "name": "some name",
      "email": "some-email@example.com"
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
```
 { "status": "error", "message": "..." }
```

---

### CREATE_USER
Create a tenant–user association.

> Permitted values for `role`:  
> - **owner** – Owns the calendar and can delete it  
> - **admin** – Edit  
> - **guest** – Show  
 

**Request**
```
POST /api/v1/tenants/:tenant_id/users
{
  "user_id": "00000000-0000-0000-0000-000000000000",
  "role": "admin"
}
```

**Response**
```
{
  "status": "ok",
  "user": {
    "id": "00000000-0000-0000-0000-000000000000",
    "email": "some-name@example.com,
    "name": "some name",
    "role": "admin",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

**Error**
```
 { "status": "error", "message": "..." }
```

---

### GET_USER
Get a tenant user by ID.

**Request**
```
GET /api/v1/tenants/:tenant_id/users/:id
```

**Response**
```
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
```
 { "status": "error", "message": "..." }
```

---

### UPDATE_USER
Update a tenant user.

**Request**
```
PUT /api/v1/tenants/:tenant_id/users/:id
{
  "role": "admin"
}
```

**Response**
```
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

**Error**
```
 { "status": "error", "message": "..." }
```

---

### DELETE_USER
Delete a tenant user.

**Request**
```
DELETE /api/v1/tenants/:tenant_id/users/:id
```

**Response**
```
{"status": "ok"}
```

**Error**
```
{ "status": "error", "message": "..." }
```

---


### LIST_CALENDARS
List all calendars attached to a tenant.

**Request**
```
GET /api/v1/tenants/:tenant_id/calendars
```

**Response**
```
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
      "color_theme": "blue"
      "visibility": "shared",
      "inserted_at": "2025-08-18T09:20:00Z",
      "updated_at": "2025-08-19T10:15:00Z"
    }
  ]
}
```

**Error**
```
{ "status": "error", "message": "..." }
```

---

### CREATE_CALENDAR
Attach a calendar to a tenant.
> Permitted values for `visibility`:
- **private** – Only the owner has access  
- **shared** – Shared with selected users  
- **public** – Discoverable within the tenant  
- **unlisted** – Hidden from discovery, link/ID required  

**Request**
```
POST /api/v1/tenants/:tenant_id/calendars
{
  "calendar_id": "00000000-0000-0000-0000-000000000000",
}
```

**Response**
```
{
  "status": "ok",
  "calendar": { 
    "id": "00000000-0000-0000-0000-000000000000", 
    "name": "Some name",
    "color_theme": "red",
    "visibility": "shared",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

**Error**
```
{ "status": "error", "message": "..." }
```

---

### GET_CALENDAR
Get a tenant calendar by ID, including its associated users

**Request**
```
GET /api/v1/tenants/:tenant_id/calendars/:id
```

**Response**
```
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
```
 { "status": "error", "message": "..." }
```

---

### DELETE_CALENDAR
Delete a tenant calendar association.

**Request**
```
DELETE /api/v1/tenants/:tenant_id/calendars/:id
```

**Response**
```
{ "status": "ok" }
```

**Error**
```
 { "status": "error", "message": "..." }
```
