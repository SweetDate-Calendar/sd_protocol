---
title: User Events
nav_order: 121
layout: home
parent: User Events
type: protocol
---

# User Events

This page documents the API endpoints for managing **events attached to a specific user** using nested REST routes.




**Scope** \
All routes are scoped under:

```text
/api/v1/users/:user_id/events
```

---

## LIST EVENTS
Returns events associated with a user.

**Request**
```
GET /api/v1/users/:user_id/events?limit=25&offset=0
```

**Response**
```json
{
  "status": "ok",
  "events": [
    {
      "id": "00000000-0000-0000-0000-000000000000",
      "name": "Sprint Planning",
      "description": "Quarterly planning session",
      "location": "Room A",
      "status": "scheduled",
      "visibility": "public",
      "color_theme": "default",
      "start_time": "2025-08-21T09:00:00Z",
      "end_time": "2025-08-21T10:00:00Z",
      "recurrence_rule": "none",
      "all_day": false,
      "inserted_at": "2025-08-18T09:20:00Z",
      "updated_at": "2025-08-19T10:15:00Z"
    },
    {
      "id": "00000000-0000-0000-0000-000000000001",
      "name": "One-on-One",
      "description": "Monthly 1:1 with manager",
      "location": "Room B",
      "status": "scheduled",
      "visibility": "private",
      "color_theme": "blue",
      "start_time": "2025-08-22T13:30:00Z",
      "end_time": "2025-08-22T14:00:00Z",
      "recurrence_rule": "monthly",
      "all_day": false,
      "inserted_at": "2025-08-18T09:25:00Z",
      "updated_at": "2025-08-19T10:20:00Z"
    }
  ]
}
```

---

## GET EVENT

Get a user event association by event ID.

**Request**
```
GET /api/v1/users/:user_id/events/:id
```

**Response**
```json
{
  "status": "ok",
  "event": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Sprint Planning",
    "description": "Quarterly planning session",
    "location": "Room A",
    "status": "scheduled",
    "visibility": "public",
    "color_theme": "default",
    "start_time": "2025-08-21T09:00:00Z",
    "end_time": "2025-08-21T10:00:00Z",
    "recurrence_rule": "none",
    "all_day": false,
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

---

## DELETE EVENT

Delete a user event association.

**Request**
```
DELETE /api/v1/users/:user_id/events/:id
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
    "event_id": ["is invalid"]
  }
}
```
