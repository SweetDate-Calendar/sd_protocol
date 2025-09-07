---
has_children: true
layout: home
nav_order: 200 
title: Calendars
---

# CALENDARS --- Command Reference

This page specifies commands for working with calendars and their associated
users.\
Each section documents parameters, response types, and examples.

---

### LIST_CALENDARS

Returns calendars ordered by name ascending.

**Request**
```
GET /api/v1/calendars?limit=25&offset=0
```

**Response**

    {
      "status": "ok",
      "result": {
        "calendars": [
          {
            "id": "00000000-0000-0000-0000-000000000000",
            "name": "Work",
            "color_theme": "red",
            "visibility": "shared",
            "timezone": "Europe/Copenhagen",
            "inserted_at": "2025-08-18T09:20:00Z",
            "updated_at": "2025-08-19T10:15:00Z"
          }
        ],
        "limit": 25,
        "offset": 0
      }
    }


---

### CREATE

Create a new calendar.

**Request**
```
POST /api/v1/calendars
```

**Payload**
```json
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
    "id": "11111111-1111-1111-1111-111111111111",
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
GET /api/v1/calendars/:id
```

**Response**
```json
{
  "status": "ok",
  "calendar": {
    "id": "11111111-1111-1111-1111-111111111111",
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
PUT /api/v1/calendars/:id
```
**Payload**
```json
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
    "id": "11111111-1111-1111-1111-111111111111",
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
DELETE /api/v1/calendars/:id
```

**Response**
```json
{
  "status": "ok",
  "calendar": {
    "id": "11111111-1111-1111-1111-111111111111",
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
