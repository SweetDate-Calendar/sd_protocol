---
title: Calendars 
nav_order: 40
layout: home
has_children: true
---

# CALENDARS — Command Reference

This page specifies commands for working with calendars, their events, and calendar–user associations.  
Each section documents parameters, response types, and examples.

---

### LIST_CALENDARS
Returns calendars ordered by name ascending.

**Request**
```
GET /api/v1/calendars?limit=25&offset=0
```

**Response**
```
{
  "status": "ok",
  "result": {
    "calendars": [
      {
        "id": "00000000-0000-0000-0000-000000000000",
        "name": "Work",
        "color_theme": "red",
        "visibility": "shared",
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
Create a new calendar.

> Permitted values for `visibility`:  
> - **private** – Only the owner has access  
> - **shared** – Shared with selected users  
> - **public** – Discoverable within the tenant  
> - **unlisted** – Hidden from discovery, link/ID required  

**Request**
```
POST /api/v1/calendars
{
  "name": "Work",
  "color_theme": "red",
  "visibility": "shared"
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

### GET
Get a single calendar by ID.

**Request**
```
GET /api/v1/calendars/:id
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

### UPDATE
Update an existing calendar.

> Permitted values for `visibility`:  
> - **private** – Only the owner has access  
> - **shared** – Shared with selected users  
> - **public** – Discoverable within the tenant  
> - **unlisted** – Hidden from discovery, link/ID required  

**Request**
```
PUT /api/v1/calendars/:id
{
  "name": "Work (Team)",
  "visibility": "public"
}
```

**Response**
```
{
  "status": "ok",
  "calendar": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Work (Team)",
    "color_theme": "red",
    "visibility": "public",
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
Delete a calendar.

**Request**
```
DELETE /api/v1/calendars/:id
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

### LIST_EVENTS
List all events on a calendar.

**Request**
```
GET /api/v1/calendars/:calendar_id/events?limit=25&offset=0
```

**Response**
```
{
  "status": "ok",
  "events": [
    {
      "id": "00000000-0000-0000-0000-000000000000",
      "name": "Weekly Sync",
      "description": "Team status meeting",
      "status": "scheduled",
      "visibility": "public",
      "color_theme": "default",
      "location": "Room 3A",
      "start_time": "2025-08-20T09:00:00Z",
      "end_time": "2025-08-20T09:30:00Z",
      "recurrence_rule": "weekly",
      "all_day": false,
      "inserted_at": "2025-08-18T09:20:00Z",
      "updated_at": "2025-08-19T10:15:00Z"
    }
  ],
  "limit": 25,
  "offset": 0
}
```

**Error**
```
{ "status": "error", "message": "..." }
```

---

### CREATE_EVENT
Create an event on a calendar.

> Permitted values for `status`:  
> - **scheduled** · **cancelled** · **postponed** · **completed**  
>
> Permitted values for `visibility`:  
> - **private** · **public** · **busy**  
>
> Permitted values for `recurrence_rule`:  
> - **none** · **daily** · **weekly** · **monthly** · **yearly**  

**Request**
```
POST /api/v1/calendars/:calendar_id/events
{
  "name": "Planning",
  "description": "Q3 planning session",
  "status": "scheduled",
  "visibility": "busy",
  "color_theme": "default",
  "location": "Zoom",
  "start_time": "2025-08-22T13:00:00Z",
  "end_time": "2025-08-22T14:00:00Z",
  "recurrence_rule": "none",
  "all_day": false
}
```

**Response**
```
{
  "status": "ok",
  "event": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Planning",
    "description": "Q3 planning session",
    "status": "scheduled",
    "visibility": "busy",
    "color_theme": "default",
    "location": "Zoom",
    "start_time": "2025-08-22T13:00:00Z",
    "end_time": "2025-08-22T14:00:00Z",
    "recurrence_rule": "none",
    "all_day": false,
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

### GET_EVENT
Get a calendar event by ID.

**Request**
```
GET /api/v1/calendars/:calendar_id/events/:id
```

**Response**
```
{
  "status": "ok",
  "event": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Planning",
    "description": "Q3 planning session",
    "status": "scheduled",
    "visibility": "busy",
    "color_theme": "default",
    "location": "Zoom",
    "start_time": "2025-08-22T13:00:00Z",
    "end_time": "2025-08-22T14:00:00Z",
    "recurrence_rule": "none",
    "all_day": false,
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

### UPDATE_EVENT
Update a calendar event.

> Permitted values for `status`: scheduled · cancelled · postponed · completed  
> Permitted values for `visibility`: private · public · busy  
> Permitted values for `recurrence_rule`: none · daily · weekly · monthly · yearly

**Request**
```
PUT /api/v1/calendars/:calendar_id/events/:id
{
  "status": "cancelled",
  "visibility": "public",
  "name": "Planning (Cancelled)"
}
```

**Response**
```
{
  "status": "ok",
  "event": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Planning (Cancelled)",
    "description": "Q3 planning session",
    "status": "cancelled",
    "visibility": "public",
    "color_theme": "default",
    "location": "Zoom",
    "start_time": "2025-08-22T13:00:00Z",
    "end_time": "2025-08-22T14:00:00Z",
    "recurrence_rule": "none",
    "all_day": false,
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

### DELETE_EVENT
Delete a calendar event.

**Request**
```
DELETE /api/v1/calendars/:calendar_id/events/:id
```

**Response**
```
{ "status": "ok" }
```

**Error**
```
{ "status": "error", "message": "..." }
```

---

### LIST_USERS
List all users attached to a calendar.

**Request**
```
GET /api/v1/calendars/:calendar_id/users
```

**Response**
```
{
  "status": "ok",
  "calendar_id": "00000000-0000-0000-0000-000000000000",
  "users": [
    {
      "id": "00000000-0000-0000-0000-000000000000",
      "name": "Alice Example",
      "email": "alice@example.com",
      "role": "owner",
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
Attach a user to a calendar.

> Permitted values for `role`:  
> - **owner** – Owns the calendar and can delete it  
> - **admin** – Edit  
> - **guest** – Show  

**Request**
```
POST /api/v1/calendars/:calendar_id/users
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
    "name": "Alice Example",
    "email": "alice@example.com",
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
Get a calendar user by ID.

**Request**
```
GET /api/v1/calendars/:calendar_id/users/:id
```

**Response**
```
{
  "status": "ok",
  "user": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Alice Example",
    "email": "alice@example.com",
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

### UPDATE_USER
Update a calendar user.

**Request**
```
PUT /api/v1/calendars/:calendar_id/users/:id
{
  "role": "owner"
}
```

**Response**
```
{
  "status": "ok",
  "user": {
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "Alice Example",
    "email": "alice@example.com",
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

### DELETE_USER
Delete a calendar user association.

**Request**
```
DELETE /api/v1/calendars/:calendar_id/users/:id
```

**Response**
```
{ "status": "ok" }
```

**Error**
```
{ "status": "error", "message": "..." }
```
