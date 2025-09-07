---
title: Elixir 
nav_order: 9 
layout: home
parent: Purpose
---


### Elixir

```elixir
# Create a calendar and a user
calendar = SD.Calendar.new(name: "Booking", color_theme: "blue")
john_doe = SD.User.new(name: "John Doe", email: "jd@example.com")
{:ok, user} = SD.Calendar.add_user(calendar, user: john_doe, role: :owner)

# Create an event
{:ok, event} =
  SD.Calendar.create_event(calendar, %{
    name: "Planning Meeting",
    description: "Scrum Standup",
    status: :scheduled,
    visibility: :private,
    color_theme: "purple",
    location: "Copenhagen HQ",
    start_time: "2025-09-10T08:00:00Z",
    end_time: "2025-09-10T08:20:00Z",
    # Bi-weekly recurrence using RFC 5545 RRULE
    recurrence_rule: "FREQ=WEEKLY;INTERVAL=2",
    all_day: false,
    send_invitations: true
  })

# List events in a date range
events =
  SD.Calendar.events(calendar,
    from: "2025-09-01T00:00:00Z",
    to: "2025-09-30T23:59:59Z"
  )

# Invite users to the event
:ok =
  SD.Event.invite_users(event, [
    %{email: "alice@example.com", role: :guest},
    %{email: "bob@example.com", role: :guest},
    %{email: "jane@example.com", role: :guest}
  ])

# Handle responses
:ok = SD.Event.accept_invitation(event, ["alice@example.com", "bob@example.com"])
:ok = SD.Event.decline_invitation(event, ["jane@example.com"])

# Postpone and cancel
# Postpone by 2 hours using ISO-8601 duration; notify participants
:ok = SD.Event.postpone(event, duration: "PT2H", notify: true)
:ok = SD.Event.cancel(event, notify: true)

# Multiple calendars for the same user
{:ok, _work}   = SD.User.add_calendar(john_doe, name: "Work",   status: :public)
{:ok, _family} = SD.User.add_calendar(john_doe, name: "Family", status: :private)

# Fetch calendars
work_calendars = SD.User.calendars(john_doe, status: :private)
work_calendar  = SD.User.get_calendar(john_doe, name: "Work", status: :public)

# Find free time slots (now -> one week from now)
now_iso =
  DateTime.utc_now()
  |> DateTime.truncate(:second)
  |> DateTime.to_iso8601()

one_week_iso =
  DateTime.utc_now()
  |> DateTime.add(7 * 24 * 60 * 60, :second)
  |> DateTime.truncate(:second)
  |> DateTime.to_iso8601()

time_slots =
  SD.User.time_slots(john_doe,
    start: now_iso,
    end: one_week_iso,
    calendars: ["Work", "Family"]
  )
# Example response:
# [%{start: "2025-09-12T13:00:00Z", end: "2025-09-12T14:00:00Z"}]

# Book a meeting directly
{:ok, meeting} =
  SD.User.book_meeting(john_doe,
    start: "2025-09-15T10:00:00Z",
    end: "2025-09-15T11:00:00Z"
  )

# Add a reminder to an event
:ok = SD.Event.add_reminder(event, minutes_before: 30, method: :email)

# -------------------------------------------------------------------
# Same features for Tenants (e.g., a hotel chain)
# -------------------------------------------------------------------

hotel_royal = SD.Tenant.new(name: "Hotel Royal")

{:ok, room_101} = SD.Tenant.add_calendar(hotel_royal, name: "Room 101")
{:ok, room_102} = SD.Tenant.add_calendar(hotel_royal, name: "Room 102")
{:ok, room_103} = SD.Tenant.add_calendar(hotel_royal, name: "Room 103")

{:ok, booking} =
  SD.Calendar.create_event(room_101, %{
    name: "Guest Reservation",
    status: :scheduled,
    visibility: :private,
    start_time: "2025-10-05T14:00:00Z",
    end_time: "2025-10-07T10:00:00Z",
    send_invitations: true
  })

{:ok, found} = SD.Calendar.get_event(room_101, booking.id)
:ok = SD.Calendar.delete_event(room_101, booking.id)

# Optional: guest invitations on room calendars
:ok = SD.Event.invite_users(booking, [%{email: "guest@example.com", role: :guest}])
:ok = SD.Event.accept_invitation(booking, ["guest@example.com"])

# Reminders before check-in/checkout
:ok = SD.Event.add_reminder(booking, minutes_before: 60 * 24, method: :email) # 24h before
:ok = SD.Event.add_reminder(booking, minutes_before: 60,       method: :sms)   # 1h before
```