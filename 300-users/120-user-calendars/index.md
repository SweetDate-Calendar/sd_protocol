---
title: User Calendars
nav_order: 120 
layout: home
parent: Users
type: protocol
---

# User Calendars

This page documents the API endpoints for managing **calendars attached to a specific user** using nested REST routes.

All routes are scoped under:

```text
/api/v1/users/:user_id/calendars
```

---

### LIST CALENDARS
Returns calendars associated with a user.

**Request**
```
GET /api/v1/users/:user_id/calendars?limit=25&offset=0
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

---

### CREATE CALENDAR

Attach a calendar to a user.

**Request**
```
POST /api/v1/users/:user_id/calendars
```
**Payload**
```json
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
    "name": "Work",
    "color_theme": "red",
    "visibility": "shared",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

---

### GET CALENDAR

Get a user calendar association by calendar ID.

**Request**
```
GET /api/v1/users/:user_id/calendars/:id
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

---

### DELETE CALENDAR

Delete a user calendar association.

**Request**
```
DELETE /api/v1/users/:user_id/calendars/:id
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
    "calendar_id": ["is invalid"]
  }
}
```
