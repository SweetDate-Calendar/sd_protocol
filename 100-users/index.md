---
has_children: true
layout: home
nav_order: 100 
title: Users
---

# USERS --- Command Reference

This page specifies commands for working with users and their associated
calendars.\
Each section documents parameters, response types, and examples.

---

### LIST_USERS

Returns users ordered by name ascending.

**Request**

    GET /api/v1/users?limit=25&offset=0&q=Alice

**Response**
```json
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

---

### CREATE

Create a new user.

**Request**
```
  POST /api/v1/users
```
**Payload**
```json
    {
      "name": "Charlie Example",
      "email": "charlie@example.com"
    }
```
**Response**
```json
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

---

### GET

Get a single user by ID.

**Request**
```
  GET /api/v1/users/:id
```

**Response**
```json

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

---

### UPDATE

Update an existing user.

**Request**
```
  PUT /api/v1/users/:id
```
**Payload**
```json
{
  "name": "Bobby Example"
}
```

**Response**
```json
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

---

### DELETE

Delete a user.

**Request**

    DELETE /api/v1/users/:id

**Response**

```json
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
    "name": ["can't be blank"],
    "email": ["can't be blank"]
  }
}
```