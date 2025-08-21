---
title: Command Format Reference
nav_order: 15
layout: home
---

# Command Definition Format

This document describes how the JSON specification for commands maps to generated documentation and client libraries.  
It serves as a guide for developers who want to add or extend commands in the protocol.

---

## Structure

Each context (e.g. `TENANTS`, `CALENDARS`) contains a `commands` array.  
Each command is defined as an object with the following fields:

```
{ MODEL_NAMES: 
  {
    "name": "SOME_COMAND",
    "url: "api/v1/SOME_ENDPOINT"
    "description": "Some description",
    "params": {
      "SOME_PARAM": {
        "type": "integer",
        "required": false,
        "default": 25,
        "min": 1,
        "max": 100,
        "description": "Some description."
      },
      "SOME_OTHER_PARAM": {
        "type": "integer",
        "required": false,
        "default": 0,
        "min": 0,
        "description": "Some description."
      }
    },
    "response": {
      "type": "SOME_COMAND",
      "description": "Some description).",
      "example": { "...": "..." },
      "error_example": { "...": "..." }
    }
  },
  {
    "name": "SOME_OTHER_COMAND",
    ...
  }
}
```

---

## Field Mapping
### `MODEL_NAMES`
- **Purpose:** Unique identifier of context the commands is working on (e.g. `TENANTS`, `USERS`).
- **Documentation:** Becomes the section title in the reference.
- **Client Libraries:** Used as the function/method name.

### `name`
- **Purpose:** Unique identifier of the command (e.g. `GET_LIST`, `CREATE`).
- **Documentation:** Becomes the section title in the reference.
- **Client Libraries:** Used as the function/method name.

### `description`
- **Purpose:** Explains what the command does in one sentence.
- **Documentation:** Appears below the command title.
- **Client Libraries:** Added as a docstring/comment.

### `params`
- **Purpose:** Defines input fields for the command.
- **Attributes:**
  - `type`: data type (`string`, `integer`, `boolean`, etc.)
  - `required`: whether the field is mandatory
  - `default`: default value if omitted
  - `min`/`max`: numeric constraints
  - `description`: human-readable explanation
- **Documentation:** Rendered as part of the request example or parameter list.
- **Client Libraries:** Used for validation and function signatures.

### `response`
- **Purpose:** Defines the structure of the command’s response.
- **Attributes:**
  - `type`: symbolic type (e.g. `tenant`, `tenant_list`)
  - `description`: what the response represents
  - `example`: JSON payload of a successful result
  - `error_example`: JSON payload of an error case
- **Documentation:** Rendered under **Response** and **Error** examples.
- **Client Libraries:** Defines the expected return structure and error handling.

---

## Example Mapping

### JSON Definition
```
{ TENANTS:
  {
    "name": "GET_LIST",
    "description": "Returns tenants ordered by name ascending.",
    "params": {
      "limit": { "type": "integer", "required": false, "default": 25 },
      "offset": { "type": "integer", "required": false, "default": 0 }
    },
    "response": {
      "type": "tenant_list",
      "description": "Paginated list of tenants (ordered by name asc).",
      "example": { "status": "ok", "result": { "items": [] } },
      "error_example": { "error": "invalid", "details": {} }
    }
  }
}
```

### Generated Documentation
```
### GET_LIST
Returns tenants ordered by name ascending.

**Request**
GET /api/v1/tenants?limit=25&offset=0

**Response**
{ "status": "ok", "result": { "items": [] } }

**Error**
{ "error": "invalid", "details": {} }
```

### Client Library (Pseudo-code)
```elixir
def list_tenants(limit \ 25, offset \ 0) do
  "REST endpoing" "api/v1/tennants/{params}"
  "REST endpoint: TENANTS.GET_LIST" 
  # lets rethink send_command, i beleive api interface should be read from an environment variable in the client
  #send_command("TENANTS.GET_LIST", %{limit: limit, offset: offset})
end
```

---

## Extending the Protocol

1. Add a new command block under the appropriate context (e.g. `TENANTS`).
2. Define `name`, `description`, `params`, and `response`.
3. Regenerate documentation and client libraries from the JSON file.

This ensures consistent behavior across all supported languages.
