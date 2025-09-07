---
title: PHP 
nav_order: 7
layout: home
parent: Purpose
---


### PHP

```PHP
<?php

// use SweetDate\Calendar as SD_Calendar;
// use SweetDate\User as SD_User;
// use SweetDate\Tenant as Tenant;

/**
 * Helper timestamps (examples)
 */
$nowUtc = '2025-09-07T11:00:00Z';
$oneWeekFromNowUtc = '2025-09-14T11:00:00Z';

// -----------------------------------------------------------------------------
// Create a calendar and a user
// -----------------------------------------------------------------------------

$calendar = new SD_Calendar([
    'name' => 'Booking',
    'color_theme' => 'blue',
]);

$johnDoe = new SD_User([
    'name'  => 'John Doe',
    'email' => 'jd@example.com',
]);

$calendar->addUser([
    'user' => $johnDoe,
    'role' => 'owner',
]);

// -----------------------------------------------------------------------------
// Create an event
// -----------------------------------------------------------------------------

$event = $calendar->createEvent([
    'name'            => 'Planning Meeting',
    'description'     => 'Scrum Standup',
    'status'          => 'scheduled',
    'visibility'      => 'private',
    'color_theme'     => 'purple',
    'location'        => 'Copenhagen HQ',
    'start_time'      => '2025-09-10T08:00:00Z',
    'end_time'        => '2025-09-10T08:20:00Z',
    // Bi-weekly recurrence using RFC 5545 RRULE
    'recurrence_rule' => 'FREQ=WEEKLY;INTERVAL=2',
    'all_day'         => false,
    'send_invitations'=> true,
]);

// -----------------------------------------------------------------------------
// List events in a date range
// -----------------------------------------------------------------------------

$events = $calendar->events([
    'from' => '2025-09-01T00:00:00Z',
    'to'   => '2025-09-30T23:59:59Z',
]);

// -----------------------------------------------------------------------------
// Invite users to the event
// -----------------------------------------------------------------------------

$users = ['alice@example.com', 'bob@example.com', 'jane@example.com'];
$event->inviteUsers($users);

// -----------------------------------------------------------------------------
// Handle responses
// -----------------------------------------------------------------------------

$event->acceptInvitation(['alice@example.com', 'bob@example.com']);
$event->declineInvitation(['jane@example.com']);

// -----------------------------------------------------------------------------
// Postpone and cancel
// -----------------------------------------------------------------------------

/**
 * Postpone by 2 hours (ISO8601 duration "PT2H"); notify participants.
 */
$event->postpone('PT2H', true);

$event->cancel(true); // notify participants

// -----------------------------------------------------------------------------
// Multiple calendars for the same user
// -----------------------------------------------------------------------------

$johnDoe->addCalendar(['name' => 'Work',   'status' => 'public']);
$johnDoe->addCalendar(['name' => 'Family', 'status' => 'private']);

// Fetch calendars
$privateCalendars = $johnDoe->calendars(['status' => 'private']); 
$workCalendar     = $johnDoe->getCalendar(['name' => 'Work', 'status' => 'public']);

// -----------------------------------------------------------------------------
// Find free time slots
// -----------------------------------------------------------------------------

$timeSlots = $johnDoe->timeSlots([
    'start'     => $nowUtc,
    'end'       => $oneWeekFromNowUtc,
    'calendars' => ['Work', 'Family'],
]);
// Example response:
// [ ['start' => '2025-09-12T13:00:00Z', 'end' => '2025-09-12T14:00:00Z'] ]

// Book a meeting directly
$meeting = $johnDoe->bookMeeting([
    'start' => '2025-09-15T10:00:00Z',
    'end'   => '2025-09-15T11:00:00Z',
]);

// Add a reminder to an event
$event->addReminder([
    'minutes_before' => 30,
    'method'         => 'email',
]);

// -----------------------------------------------------------------------------
// Same features for Tenants (e.g., a hotel chain)
// -----------------------------------------------------------------------------

$hotelRoyal = new Tenant(['name' => 'Hotel Royal']);

$room101 = $hotelRoyal->addCalendar(['name' => 'Room 101']);
$room102 = $hotelRoyal->addCalendar(['name' => 'Room 102']);
$room103 = $hotelRoyal->addCalendar(['name' => 'Room 103']);

$booking = $room101->createEvent([
    'name'        => 'Guest Reservation',
    'status'      => 'scheduled',
    'visibility'  => 'private',
    'start_time'  => '2025-10-05T14:00:00Z',
    'end_time'    => '2025-10-07T10:00:00Z',
    'send_invitations' => true,
]);

$found = $room101->getEvent($booking->id);
$room101->deleteEvent($booking->id);

// Optional: invitations for room calendars (guest confirmations)
$booking->inviteUsers(['guest@example.com']);
$booking->acceptInvitation(['guest@example.com']);

// Reminders before check-in/checkout
$booking->addReminder(['minutes_before' => 60 * 24, 'method' => 'email']); // 24h before
$booking->addReminder(['minutes_before' => 60,       'method' => 'sms']);   // 1h before
```