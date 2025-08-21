---
title: SweetDate CLI
nav_order: 100 
layout: home
has_children: true
---

# SweetDate CLI

The **SweetDate CLI** is a developer tool for working with the **SweetDate Implementation Protocol (SDIP)**.  
It takes the protocol definition (provided as JSON) and generates starter templates for implementing client libraries in different programming languages.

## Purpose

The SweetDate CLI ensures **secure and consistent implementations** of client libraries by scaffolding a complete set of methods exposed by the **SweetDate Engine**.  

For each supported language, the CLI generates a template with all protocol commands (as defined in the SDIP), so developers can focus on implementing the details in their language ecosystem rather than re-designing the interface from scratch.  

This guarantees that client libraries across Ruby, Elixir, PHP, and future languages stay aligned with the SweetDate protocol and behave consistently.

---

## Flow

![Development diagram]({{ site.baseurl }}/assets/images/CLI-Flow.svg)

- **Input:** A JSON specification of the SDIP (SweetDate Implementation Protocol).  
- **Output:** Language-specific scaffolding code (Ruby, Elixir, PHP, …).  


---

## Configuration

The CLI reads a configuration file (`sd.config.json`) in the project root.  
This file defines the protocol location and the output folders for generated code.

**Example:**

```
{
  "protocol": "protocol-version-01/protocol.json",
  "targets": {
    "ruby": {
      "output": "out/ruby"
    },
    "elixir": {
      "output": "out/elixir"
    }
  }
}
```

---

## Protocol Definition Files

The SweetDate CLI generates code based on the **SweetDate Implementation Protocol (SDIP)**.  
These definitions are stored as JSON files in the project root, organized by protocol version.
```
protocol-version-01/
  ├─ calendars.json
  ├─ tenants.json
  ├─ users.json
  └─ events.json
```
**Example structure:**
```
{
  "TENANTS": {
    "commands": [
      {
        "name": "GET_LIST",
        "description": "Returns tenants ordered by name ascending.",
        "params": {
          "limit": {
            "type": "integer",
            "required": false,
            "default": 25,
            "min": 1,
            "max": 100,
            "description": "Maximum number of items to return."
          },
          "offset": {
            "type": "integer",
            "required": false,
            "default": 0,
            "min": 0,
            "description": "Number of items to skip."
          }
        },
        "response": {
          "type": "tenant_list",
          "description": "Paginated list of tenants (ordered by name asc).",
          "example": {
            "status": "ok",
            "result": {
              "tenants": [
                {
                  "id": "t1",
                  "name": "Alpha",
                  "account_id": "acc-123",
                  "inserted_at": "2025-08-18T09:20:00Z",
                  "updated_at": "2025-08-19T10:15:00Z"
                },
                {
                  "id": "t2",
                  "name": "Beta",
                  "account_id": "acc-456",
                  "inserted_at": "2025-08-18T11:00:00Z",
                  "updated_at": "2025-08-18T11:00:00Z"
                }
              ],
              "limit": 25,
              "offset": 0
            }
          },
          "error_example": {
            "error": "invalid",
            "details": {
              "limit": ["must be between 1 and 100"],
              "offset": ["must be >= 0"]
            }
          }
        }
      }
      ...
```