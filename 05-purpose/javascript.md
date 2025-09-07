---
title: JavaScript
nav_order: 8
layout: home
parent: Purpose
---


### JavaScript 
```javascript
// Create a calendar and a user
const calendar = new SD_Calendar({ name: "Booking", color_theme: "blue" });
const johnDoe = new SD_User({ name: "John Doe", email: "jd@example.com" });
calendar.addUser({ user: johnDoe, role: "owner" });

// Create an event
const event = calendar.createEvent({
  name: "Planning Meeting",
  description: "Scrum Standup",
  status: "scheduled",
  visibility: "private",
  color_theme: "purple",
  location: "Copenhagen HQ",
  start_time: "2025-09-10T08:00:00Z",
  end_time: "2025-09-10T08:20:00Z",
  recurrence_rule: "FREQ=WEEKLY;INTERVAL=2", // bi-weekly
  all_day: false,
  send_invitations: true,
});

// List events in a date range
calendar.events({
  from: "2025-09-01T00:00:00Z",
  to: "2025-09-30T23:59:59Z",
});

// Invite users to the event
const users = [
  { email: "alice@example.com", role: "guest" },
  { email: "bob@example.com", role: "guest" },
  { email: "jane@example.com", role: "guest" },
];
event.inviteUsers(users);

// Handle responses
event.acceptInvitation(["alice@example.com", "bob@example.com"]);
event.declineInvitation(["jane@example.com"]);

// Postpone and cancel
event.postpone({ duration: "PT2H", notify: true }); // ISO8601 duration for 2 hours
event.cancel({ notify: true });

// Multiple calendars for the same user
johnDoe.addCalendar({ name: "Work", status: "public" });
johnDoe.addCalendar({ name: "Family", status: "private" });

// Fetch calendars
const workCalendars = johnDoe.calendars({ status: "private" });
// => [{ calendar: calendar, name: "Family" }]
const workCalendar = johnDoe.getCalendar({ name: "Work", status: "public" });

// Find free time slots
const timeSlots = johnDoe.timeSlots({
  start: new Date().toISOString(),
  end: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toISOString(), // 1 week from now
  calendars: ["Work", "Family"],
});
// => [{ start: "2025-09-12T13:00:00Z", end: "2025-09-12T14:00:00Z" }]

// Book a meeting directly
johnDoe.bookMeeting({
  start: "2025-09-15T10:00:00Z",
  end: "2025-09-15T11:00:00Z",
});

// Add a reminder to an event
event.addReminder({
  minutes_before: 30,
  method: "email",
});

// Same features for Tenants
const hotelRoyal = new Tenant({ name: "Hotel Royal" });
const room101 = hotelRoyal.addCalendar({ name: "Room 101" });
const room102 = hotelRoyal.addCalendar({ name: "Room 102" });
const room103 = hotelRoyal.addCalendar({ name: "Room 103" });

const booking = room101.createEvent({
  name: "Guest Reservation",
  status: "scheduled",
  start_time: "2025-10-05T14:00:00Z",
  end_time: "2025-10-07T10:00:00Z",
  send_invitations: true,
});

room101.getEvent(booking.id);
room101.deleteEvent(booking.id);

// Optional: guest invitations
booking.inviteUsers([{ email: "guest@example.com", role: "guest" }]);
booking.acceptInvitation(["guest@example.com"]);

// Reminders before check-in
booking.addReminder({ minutes_before: 1440, method: "email" }); // 24h before
booking.addReminder({ minutes_before: 60, method: "sms" });     // 1h before
```