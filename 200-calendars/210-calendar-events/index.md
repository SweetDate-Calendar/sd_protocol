---
title: Calendar Events 
nav_order: 210 
layout: home
parent: Calendars
---

# CALENDAR EVENTS — Nested Resource

This page documents the API endpoints for managing **events within a specific calendar** using nested REST routes.

  
**Enums** \
Some fields only allow selected values


| Field           | Allowed values                          | Default   |
|-----------------|-----------------------------------------|-----------|
| status          | scheduled, cancelled, postponed, completed | scheduled |
| visibility      | private, public, busy                   | public    |
| recurrence_rule | none, daily, weekly, monthly, yearly    | none      |


**Scope** \
All routes are scoped under:

```
/api/v1/calendars/:calendar_id/events
```

---

## LIST EVENTS

Returns events associated with a calendar.

**Request**
```
GET /api/v1/calendars/:calendar_id/events?limit=25&offset=0&q=meeting
```

**Response**
```json
{
  "status": "ok",
  "events": [
    {
      "id": "00000000-0000-0000-0000-000000000000",
      "title": "Sprint Planning",
      "starts_at": "2025-08-21T09:00:00Z",
      "ends_at": "2025-08-21T10:00:00Z",
      "location": "Room A",
      "status": "confirmed",
      "inserted_at": "2025-08-18T09:20:00Z",
      "updated_at": "2025-08-19T10:15:00Z"
    }
  ]
}
```

---

## CREATE EVENT

Associates an event with a calendar.

**Request**
```
POST /api/v1/calendars/:calendar_id/events
```
**Payload**
```json
{
  "title": "Sprint Planning",
  "starts_at": "2025-08-21T09:00:00Z",
  "ends_at": "2025-08-21T10:00:00Z",
  "location": "Room A",
  "description": "Quarterly planning session",
  "status": "tentative"
}
```

**Response**
```json
{
  "status": "ok",
  "event": {
    "id": "00000000-0000-0000-0000-000000000000",
    "title": "Sprint Planning",
    "starts_at": "2025-08-21T09:00:00Z",
    "ends_at": "2025-08-21T10:00:00Z",
    "location": "Room A",
    "description": "Quarterly planning session",
    "status": "tentative",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

---

## GET EVENT

Fetch a specific event associated with a calendar.

**Request**
```
GET /api/v1/calendars/:calendar_id/events/:id
```

**Response**
```json
{
  "status": "ok",
  "event": {
    "id": "00000000-0000-0000-0000-000000000000",
    "title": "Sprint Planning",
    "starts_at": "2025-08-21T09:00:00Z",
    "ends_at": "2025-08-21T10:00:00Z",
    "location": "Room A",
    "status": "confirmed",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

---

## UPDATE EVENT

Updates an event within the calendar.

**Request**
```
PUT /api/v1/calendars/:calendar_id/events/:id
```
**Payload**
```json
{
  "title": "Sprint Planning (Updated)",
  "status": "confirmed",
  "location": "Room B"
}
```

**Response**
```json
{
  "status": "ok",
  "event": {
    "id": "00000000-0000-0000-0000-000000000000",
    "title": "Sprint Planning (Updated)",
    "starts_at": "2025-08-21T09:00:00Z",
    "ends_at": "2025-08-21T10:00:00Z",
    "location": "Room B",
    "status": "confirmed",
    "inserted_at": "2025-08-18T09:20:00Z",
    "updated_at": "2025-08-19T10:15:00Z"
  }
}
```

---

## DELETE EVENT

Delete the event.

**Request**
```
DELETE /api/v1/calendars/:calendar_id/events/:id
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
    "starts_at": ["can't be blank"],
    "ends_at": ["must be after starts_at"]
  }
}
```
