# Headless Calendar Protocol

This document defines the core protocol for interacting with the Chronopipe headless calendar engine over TCP. It is designed to serve as the canonical reference for building and maintaining language-specific client libraries (e.g. Ruby, JavaScript, Elixir), which communicate with the `cp_tcp` module in the `sd_engine` umbrella app.

## Goals

- Define a consistent, extensible command set for calendar and event operations
- Enable simple integration with any programming language
- Support code generation from the protocol definition
- Cleanly separate domain responsibilities (calendars, events, users)
- Future-proof the protocol for new use cases

## Command Format

All commands follow a namespaced format:

```
<DOMAIN>.<ACTION>
```

Example:

```
CALENDARS.CREATE
EVENTS.ADD_USER
```

Each command is invoked with a set of arguments (JSON or line-encoded) and receives a structured response (typically a JSON payload or status result). Communication is handled via TCP with a thin line-oriented or JSON protocol over sockets.

## Protocol Commands

### CALENDARS

| Command                 | Description                                   |
| ----------------------- | --------------------------------------------- |
| `CALENDARS.CREATE`      | Create a new calendar                         |
| `CALENDARS.GET`         | Retrieve a calendar by ID                     |
| `CALENDARS.UPDATE`      | Update calendar metadata                      |
| `CALENDARS.DELETE`      | Delete a calendar                             |
| `CALENDARS.LIST`        | List calendars owned by or shared with a user |
| `CALENDARS.ADD_USER`    | Grant a user access to a calendar             |
| `CALENDARS.REMOVE_USER` | Revoke a user's access to a calendar          |
| `CALENDARS.USERS`       | List users who have access to a calendar      |

#### Example Usage

```elixir
calendar_id = Calendar.create(name: "Team", owner_id: "u123")
calendar = Calendar.get(calendar_id)
Calendar.add_user(calendar, user_id: "u456", role: :viewer)
```

### EVENTS

| Command              | Description                            |
| -------------------- | -------------------------------------- |
| `EVENTS.CREATE`      | Create a new event                     |
| `EVENTS.GET`         | Get event details                      |
| `EVENTS.UPDATE`      | Modify event data                      |
| `EVENTS.DELETE`      | Remove an event                        |
| `EVENTS.LIST`        | List events on a calendar              |
| `EVENTS.ADD_USER`    | Add a user to an event (invite/assign) |
| `EVENTS.REMOVE_USER` | Remove a user from an event            |

#### Typical Event Fields

- `calendar_id`
- `name`
- `description`
- `location`
- `start_time`
- `end_time`
- `all_day`
- `recurrence_rule`
- `visibility` (`:public`, `:private`, `:busy`)
- `color_theme`

#### Example Usage

```elixir
event = Event.create(calendar_id, name: "Sprint Planning", start_time: ...)
Event.add_user(event, user_id: "u456", role: :attendee)
```

### USERS (optional)

| Command        | Description                                |
| -------------- | ------------------------------------------ |
| `USERS.GET`    | Get a user's profile or metadata           |
| `USERS.LIST`   | List all users (admin only or scoped)      |
| `USERS.EVENTS` | List all events a user is participating in |

## Client Protocol Integration

Client libraries will expose this protocol as high-level methods, for example:

```ruby
calendar = Calendar.create(name: "Dev Team")
Calendar.add_user(calendar.id, user_id: "123")
events = Event.list(calendar_id: calendar.id)
```

These commands are translated to TCP messages and sent to the `cp_tcp` engine, which routes them to the appropriate context (`CP.Calendars`, `CP.Events`, etc.).

## Future Considerations

- Support for reminders and notification scheduling
- Recurrence parsing and generation (RFC 5545 compatible)
- Access control levels (owner, editor, viewer)
- Soft deletion and audit trails
- JSON Schema or Protobuf for strict client codegen
- Command versioning (e.g., `CALENDARS.CREATE@v2`)

## Next Steps

1. Finalize a canonical wire format (e.g. line-delimited JSON or JSON-RPC)
2. Implement dispatcher and handlers in `cp_tcp`
3. Build auto-generated clients from the protocol in:
   - Ruby (`cp_client`)
   - JavaScript
   - Elixir
4. Create integration test suites for client conformance

---

**© Chronopipe Headless Calendar Protocol — v1.0**