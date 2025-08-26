---
title: Conformance Testing
nav_order: 120
layout: home
has_children: true
---

# Conformance Testing

The **SweetDate Conformance Testing** suite is a set of tools and protocols that verify whether a client implementation of the **SweetDate Protocol** behaves as expected.

This mechanism is designed to ensure **trust**, **interoperability**, and **predictability** across implementations in different programming languages.

## Purpose

While the **SweetDate CLI** scaffolds starter templates from the official protocol definition, the **Conformance Testing Suite** ensures that the resulting implementation **correctly and fully implements the protocol**.

It does so by coordinating an automated interaction between:
- a **Language-specific Test Runner** (maintained by the implementor), and
- a **Universal Conformance Driver** (provided by the SweetDate project).

Together, these components validate whether the commands, error handling, and edge case behavior conform to the expectations defined in the protocol specification.

---

## Why It Matters

Client implementations are developed independently across ecosystems.  
Conformance testing gives implementors and integrators **confidence** that:

- The library behaves exactly like others (regardless of language)
- Protocol-breaking bugs are caught early
- New protocol versions can be tested before releasing

It also enables **third-party distribution**: packages can be labeled as _SweetDate Certified_ once they pass the conformance suite.

---

## Testing Strategy

The Conformance Suite uses an **active test pattern** inspired by contract-based testing:

1. The **Conformance Driver** sends a command to the client implementation asking it to run a specific scenario (e.g., `EVENTS.CREATE with missing start_time`).
2. The client runs that test internally and returns a **success/failure signal**.
3. The driver verifies the result and logs/report outcomes in a common format.

This avoids the risk of **false compliance** caused by incomplete test coverage inside language-specific test suites.

---

## Components

| Component | Description |
|----------|-------------|
| **Conformance Driver** | A generic orchestrator that issues standardized test commands and receives test results from the client. |
| **Language-specific Test Runner** | A program or script (written in Ruby, PHP, Elixir, etc.) that accepts test requests and executes matching scenarios using the actual client implementation. |
| **Protocol Spec** | The source of truth. All test cases are derived from the SDIP JSON files, ensuring alignment across all tooling. |
| **Result Format** | JSON and writes to the console |

---

## Example Flow

```mermaid
sequenceDiagram
  participant Driver as Conformance Driver
  participant Impl as Ruby Client (Test Runner)

  Driver->>Impl: { "command": "EVENTS.CREATE", "scenario": "missing start_time" }
  Impl-->>Driver: { "status": "fail", "error_code": "MISSING_FIELD" }
  Driver->>Impl: { "command": "EVENTS.DELETE", "scenario": "valid event" }
  Impl-->>Driver: { "status": "pass" }