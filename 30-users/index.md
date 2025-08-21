---
title: Users 
nav_order: 30
layout: home
has_children: true
---

# USERS — Command Reference

This page specifies commands for working with users and their associated calendars.  
Each section documents parameters, response types, and examples.

---

### LIST_USERS
Returns users ordered by name ascending.

**Request**
```
GET /api/v1/users?limit=25&offset=0
```

**Response**
```
{
  "status": "ok",
  "result": {
    "users": [
      {
        "id": "00000000-0000-0000-0000-000000000000",
        "name": "Alice Example",
        "email": "alice@example.com",
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
Create a new user.

**Request**
```
POST /api/v1/users
{
  "name": "Charlie Example",
  "email": "charlie@example.com"
}
```

**Response**
```
{
  "status": "ok",
  "user": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Charlie Example",
    "email": "charlie@example.com",
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
Get a single user by ID.

**Request**
```
GET /api/v1/users/:id
```

**Response**
```
{
  "status": "ok",
  "user": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Bob Example",
    "email": "bob@example.com",
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
Update an existing user.

**Request**
```
PUT /api/v1/users/:id
{
  "name": "Bobby Example"
}
```

**Response**
```
{
  "status": "ok",
  "user": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Bobby Example",
    "email": "bob@example.com",
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
Delete a user.

**Request**
```
DELETE /api/v1/users/:id
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
List all calendars attached to a user.

**Request**
```
GET /api/v1/users/:user_id/calendars
```

**Response**
```
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
    },
    { 
      "id": "00000000-0000-0000-0000-000000000000", 
      "name": "Personal",
      "color_theme": "blue",
      "visibility": "private",
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
Attach a calendar to a user.  

> Permitted values for `visibility`:  
> - **private** – Only the owner has access  
> - **shared** – Shared with selected users  
> - **public** – Discoverable within the tenant  
> - **unlisted** – Hidden from discovery, link/ID required  

**Request**
```
POST /api/v1/users/:user_id/calendars
{
  "calendar_id": "00000000-0000-0000-0000-000000000000"
}
```

**Response**
```
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
```
{ "status": "error", "message": "..." }
```

---

### GET_CALENDAR
Get a user calendar by ID, including its associated users.

**Request**
```
GET /api/v1/users/:user_id/calendars/:id
```

**Response**
```
{
  "status": "ok",
  "calendar": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Work",
    "color_theme": "white",
    "visibility": "private",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z",
    "users": [
      {
        "id": "00000000-0000-0000-0000-000000000000",
        "name": "Alice Example",
        "email": "alice@example.com",
        "role": "owner",
        "inserted_at": "2025-08-18T09:20:00Z",
        "updated_at": "2025-08-19T10:15:00Z"
      },
      {
        "id": "00000000-0000-0000-0000-000000000000",
        "name": "Bob Example",
        "email": "bob@example.com",
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
Delete a user calendar association.

**Request**
```
DELETE /api/v1/users/:user_id/calendars/:id
```

**Response**
```
{ "status": "ok" }
```

**Error**
```
 { "status": "error", "message": "..." }
```
