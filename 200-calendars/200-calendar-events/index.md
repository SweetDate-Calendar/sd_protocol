---
title: Events 
nav_order: 210 
layout: home
parent: Calendars
has_children: true
type: protocol
---

# Events 

This page documents the API endpoints for managing **events within a specific calendar**.

All routes are scoped under:

```text
/api/v1/calendars/:calendar_id/events
```

> SDK Design
>
> The SDK exposes a **Calendar object** that encapsulates event operations:
> - `calendar.events(limit:, offset:, q:)`
> - `calendar.create_event(attrs)`
> - `calendar.get_event(event_id)`
> - `calendar.update_event(event_id, attrs)`
> - `calendar.delete_event(event_id)`
>
> You can also create events/users separately and attach them if your SDK supports it.


**Enums** \
Some fields only allow selected values

| Field           | Allowed values                              | Default   |
|-----------------|---------------------------------------------|-----------|
| status          | scheduled, cancelled, postponed, completed  | scheduled |
| visibility      | private, public, busy                       | public    |
| recurrence_rule | none, daily, weekly, monthly, yearly        | none      |


---

### LIST EVENTS

Returns events associated with a calendar.

*Ruby*
```ruby
calendar = SD::Calendar.get("CALENDAR-ID")
events = calendar.events(limit: 25, offset: 0, q: "meeting")
```

*PHP*
```php
<?php
$calendar = \SweetDate\Calendar::get("CALENDAR-ID");
$events = $calendar->events(["limit" => 25, "offset" => 0, "q" => "meeting"]);
print_r($events);
```

*JavaScript*
```javascript
const calendar = await SD.Calendar.get("CALENDAR-ID");
const events = await calendar.events({ limit: 25, offset: 0, q: "meeting" });
console.log(events);
```

*Elixir*
```elixir
{:ok, calendar} = SD.Calendar.get("CALENDAR-ID")
{:ok, events} = SD.Calendar.events(calendar, limit: 25, offset: 0, q: "meeting")
IO.inspect(events)
```

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

### CREATE EVENT

Associates an event with a calendar.

*Ruby*
```ruby
calendar = SD::Calendar.get("CALENDAR-ID")
event = calendar.create_event(
  title: "Sprint Planning",
  starts_at: "2025-08-21T09:00:00Z",
  ends_at: "2025-08-21T10:00:00Z",
  location: "Room A",
  description: "Quarterly planning session",
  status: :tentative
)
```

*PHP*
```php
<?php
$calendar = \SweetDate\Calendar::get("CALENDAR-ID");
$event = $calendar->createEvent([
  "title" => "Sprint Planning",
  "starts_at" => "2025-08-21T09:00:00Z",
  "ends_at" => "2025-08-21T10:00:00Z",
  "location" => "Room A",
  "description" => "Quarterly planning session",
  "status" => "tentative"
]);
print_r($event);
```

*JavaScript*
```javascript
const calendar = await SD.Calendar.get("CALENDAR-ID");
const event = await calendar.createEvent({
  title: "Sprint Planning",
  starts_at: "2025-08-21T09:00:00Z",
  ends_at: "2025-08-21T10:00:00Z",
  location: "Room A",
  description: "Quarterly planning session",
  status: "tentative"
});
console.log(event);
```

*Elixir*
```elixir
{:ok, calendar} = SD.Calendar.get("CALENDAR-ID")
{:ok, event} =
  SD.Calendar.create_event(calendar, %{
    title: "Sprint Planning",
    starts_at: "2025-08-21T09:00:00Z",
    ends_at: "2025-08-21T10:00:00Z",
    location: "Room A",
    description: "Quarterly planning session",
    status: :tentative
  })
IO.inspect(event)
```

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

### GET EVENT

Fetch a specific event associated with a calendar.

*Ruby*
```ruby
calendar = SD::Calendar.get("CALENDAR-ID")
event = calendar.get_event("EVENT-ID")
```

*PHP*
```php
<?php
$calendar = \SweetDate\Calendar::get("CALENDAR-ID");
$event = $calendar->getEvent("EVENT-ID");
print_r($event);
```

*JavaScript*
```javascript
const calendar = await SD.Calendar.get("CALENDAR-ID");
const event = await calendar.getEvent("EVENT-ID");
console.log(event);
```

*Elixir*
```elixir
{:ok, calendar} = SD.Calendar.get("CALENDAR-ID")
{:ok, event} = SD.Calendar.get_event(calendar, "EVENT-ID")
IO.inspect(event)
```

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

### UPDATE EVENT

Updates an event within the calendar.

*Ruby*
```ruby
calendar = SD::Calendar.get("CALENDAR-ID")
updated = calendar.update_event("EVENT-ID", title: "Sprint Planning (Updated)", status: :confirmed, location: "Room B")
```

*PHP*
```php
<?php
$calendar = \SweetDate\Calendar::get("CALENDAR-ID");
$updated = $calendar->updateEvent("EVENT-ID", [
  "title" => "Sprint Planning (Updated)",
  "status" => "confirmed",
  "location" => "Room B"
]);
print_r($updated);
```

*JavaScript*
```javascript
const calendar = await SD.Calendar.get("CALENDAR-ID");
const updated = await calendar.updateEvent("EVENT-ID", {
  title: "Sprint Planning (Updated)",
  status: "confirmed",
  location: "Room B"
});
console.log(updated);
```

*Elixir*
```elixir
{:ok, calendar} = SD.Calendar.get("CALENDAR-ID")
{:ok, updated} =
  SD.Calendar.update_event(calendar, "EVENT-ID", %{
    title: "Sprint Planning (Updated)",
    status: :confirmed,
    location: "Room B"
  })
IO.inspect(updated)
```

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

### DELETE EVENT

Delete the event.

*Ruby*
```ruby
calendar = SD::Calendar.get("CALENDAR-ID")
calendar.delete_event("EVENT-ID")
# => { status: "ok" }
```

*PHP*
```php
<?php
$calendar = \SweetDate\Calendar::get("CALENDAR-ID");
$resp = $calendar->deleteEvent("EVENT-ID");
print_r($resp);
```

*JavaScript*
```javascript
const calendar = await SD.Calendar.get("CALENDAR-ID");
const resp = await calendar.deleteEvent("EVENT-ID");
console.log(resp);
```

*Elixir*
```elixir
{:ok, calendar} = SD.Calendar.get("CALENDAR-ID")
:ok = SD.Calendar.delete_event(calendar, "EVENT-ID")
```

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
