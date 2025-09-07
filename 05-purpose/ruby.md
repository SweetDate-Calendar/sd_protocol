---
title: Ruby 
nav_order: 6 
layout: home
parent: Purpose
---


### Ruby

```ruby
# Create a calendar and a user
calendar = SD_Calendar.new(name: "Booking", color_theme: "blue")
john_doe = SD_User.new(name: "John Doe", email: "jd@example.com")
calendar.add_user(user: john_doe, role: :owner)

# Create an event
event = calendar.create_event(
  name: "Planning Meeting",
  description: "Scrum Standup",
  status: "scheduled",
  visibility: "private",
  color_theme: "purple",
  location: "Copenhagen HQ",
  start_time: "2025-09-10T08:00:00Z",
  end_time: "2025-09-10T08:20:00Z",
  recurrence_rule: "FREQ=WEEKLY;INTERVAL=2", # bi-weekly
  all_day: false,
  send_invitations: true
)

# List events in a date range
calendar.events(
  from: "2025-09-01T00:00:00Z",
  to:   "2025-09-30T23:59:59Z"
)

# Invite users to the event
users = [
  {email: "alice@example.com", role: :guest}, 
  {email: "bob@example.com", role: :guest},
  {email: "jane@example.com", role: :guest}
  ]
event.invite_users(users)

# Handle responses
event.accept_invitation(["alice@example.com", "bob@example.com"])
event.decline_invitation(["jane@example.com"])

# Postpone and cancel
event.postpone(2.hours, notify: true)
event.cancel(notify: true)

# Multiple calendars for the same user
john_doe.add_calendar(name: "Work", status: :public)
john_doe.add_calendar(name: "Family", status: :private)

# Fetch calendars
work_calendars = john_doe.calendars(status: :private) => [{calendar: calendar, name: "Family"}]
calendar = john_doe.get_calendar(name: "Work", status: :public)


# Find free time slots
john_doe.time_slots(
  start: Time.now.utc,
  end:   1.week.from_now,
  calendars: ["Work", "Family"]
)
# => [{ start: "2025-09-12T13:00:00Z", end: "2025-09-12T14:00:00Z" }]

# Book a meeting directly
john_doe.book_meeting(
  start: "2025-09-15T10:00:00Z",
  end:   "2025-09-15T11:00:00Z"
)

# Add a reminder to an event
event.add_reminder(
  minutes_before: 30,
  method: :email
)

# Same features for Tenants
hotel_royal = Tenant.new(name: "Hotel Royal")
room_101 = hotel_royal.add_calendar(name: "room 101")
room_102 = hotel_royal.add_calendar(name: "room 102")
room_102 = hotel_royal.add_calendar(name: "room 103")

booking = room_101.create_event(
  name: "Planning Meeting",
  ... 
)

room_101.get_event(booking.id)

room_101.delete_event(booking.id)
...
```