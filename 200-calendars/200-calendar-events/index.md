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

### LIST

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
      "event": {
        "id": "00000000-0000-0000-0000-000000000000",
        "status": "scheduled",
        "name": "Planning",
        "description": "Q3 planning session",
        "color_theme": "default",
        "visibility": "busy",
        "location": "Zoom",
        "start_time": "2025-08-22T13:00:00Z",
        "end_time": "2025-08-22T14:00:00Z",
        "recurrence_rule": "none",
        "all_day": false,
        "inserted_at": "2025-08-18T09:20:00Z",
        "updated_at": "2025-08-19T10:15:00Z"
      }
    }
  ]
}
```

---

### CREATE
Create an event on a calendar.

> Permitted values for `status`:  
> - **scheduled** · **cancelled** · **postponed** · **completed**  
>
> Permitted values for `visibility`:  
> - **private** · **public** · **busy**  
>
> Permitted values for `recurrence_rule`:  
> - **none** · **daily** · **weekly** · **monthly** · **yearly**  

*Ruby*
```ruby
SD::Calendars.create_event("CALENDAR-ID", name: "Planning", description: "Q3 planning session", status: :scheduled, visibility: :busy, location: "Zoom", start_time: "2025-08-22T13:00:00Z", end_time: "2025-08-22T14:00:00Z")
```

*PHP*
```php
<?php
$event = \SweetDate\Calendars::createEvent("CALENDAR-ID", [
  "name" => "Planning",
  "description" => "Q3 planning session",
  "status" => "scheduled",
  "visibility" => "busy",
  "location" => "Zoom",
  "start_time" => "2025-08-22T13:00:00Z",
  "end_time" => "2025-08-22T14:00:00Z"
]);
print_r($event);
```

*JavaScript*
```javascript
const event = await SD.Calendars.createEvent("CALENDAR-ID", {
  name: "Planning",
  description: "Q3 planning session",
  status: "scheduled",
  visibility: "busy",
  location: "Zoom",
  start_time: "2025-08-22T13:00:00Z",
  end_time: "2025-08-22T14:00:00Z"
});
console.log(event);
```

*Elixir*
```elixir
{:ok, event} =
  SD.Calendars.create_event("CALENDAR-ID", %{
    name: "Planning",
    description: "Q3 planning session",
    status: :scheduled,
    visibility: :busy,
    location: "Zoom",
    start_time: "2025-08-22T13:00:00Z",
    end_time: "2025-08-22T14:00:00Z"
  })
IO.inspect(event)
```

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
```json
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
```json
{ "status": "error", "message": "..." }
```

---

### GET_EVENT
Get a calendar event by ID.

*Ruby*
```ruby
SD::Calendars.get_event("CALENDAR-ID", "EVENT-ID")
```

*PHP*
```php
<?php
$event = \SweetDate\Calendars::getEvent("CALENDAR-ID", "EVENT-ID");
print_r($event);
```

*JavaScript*
```javascript
const event = await SD.Calendars.getEvent("CALENDAR-ID", "EVENT-ID");
console.log(event);
```

*Elixir*
```elixir
{:ok, event} = SD.Calendars.get_event("CALENDAR-ID", "EVENT-ID")
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
```json
{ "status": "error", "message": "..." }
```

---

### UPDATE
Update a calendar event.

*Ruby*
```ruby
SD::Calendars.update_event("CALENDAR-ID", "EVENT-ID", status: :cancelled, visibility: :public, name: "Planning (Cancelled)")
```

*PHP*
```php
<?php
$event = \SweetDate\Calendars::updateEvent("CALENDAR-ID", "EVENT-ID", [
  "status" => "cancelled",
  "visibility" => "public",
  "name" => "Planning (Cancelled)"
]);
print_r($event);
```

*JavaScript*
```javascript
const event = await SD.Calendars.updateEvent("CALENDAR-ID", "EVENT-ID", {
  status: "cancelled",
  visibility: "public",
  name: "Planning (Cancelled)"
});
console.log(event);
```

*Elixir*
```elixir
{:ok, event} = SD.Calendars.update_event("CALENDAR-ID", "EVENT-ID", %{status: :cancelled, visibility: :public, name: "Planning (Cancelled)"})
IO.inspect(event)
```

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
```json
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
```json
{ "status": "error", "message": "..." }
```

---

### DELETE
Delete a calendar event.

*Ruby*
```ruby
SD::Calendars.delete_event("CALENDAR-ID", "EVENT-ID")
# => { status: "ok" }
```

*PHP*
```php
<?php
$resp = \SweetDate\Calendars::deleteEvent("CALENDAR-ID", "EVENT-ID");
print_r($resp);
```

*JavaScript*
```javascript
const resp = await SD.Calendars.deleteEvent("CALENDAR-ID", "EVENT-ID");
console.log(resp);
```

*Elixir*
```elixir
:ok = SD.Calendars.delete_event("CALENDAR-ID", "EVENT-ID")
```

**Request**
```
DELETE /api/v1/calendars/:calendar_id/events/:id
```

**Response**
```json
{ "status": "ok" }
```

**Error**
```json
{ "status": "error", "message": "..." }
```
