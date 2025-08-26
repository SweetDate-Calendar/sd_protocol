---
title: Universal Conformance Driver
nav_order: 110
layout: home
parent: SweetDate CLI
---

# Universal Conformance Driver

The **Universal Conformance Driver** is a module in the SweetDate CLI that verifies protocol compliance of language-specific implementations. It runs test manifests that describe expected behavior, and delegates test execution to each implementation under test.

## Purpose

The conformance driver ensures that all language-specific client libraries behave **correctly and consistently** according to the SweetDate Implementation Protocol (SDIP).

It does not test the server itself. Instead, it tests that a client implementation of the protocol can send the correct requests, interpret responses, and handle edge cases as described in the protocol definition.

---

## How It Works

```ascii
                ┌────────────────────────────┐
                │   SweetDate CLI Driver     │
                │     (Conformance Layer)    │
                └────────────────────────────┘
                           │
             Reads test manifest JSON
                           ▼
                ┌───────────────────────┐
                │  Language Test Runner │───────┐
                │  (Ruby, Elixir, PHP)  │       │
                └───────────────────────┘       ▼
                     Executes test cases   Validates results
                                               │
                                     Reports Pass/Fail
```

---

## Structure

Each test is defined in a **manifest JSON file**, specifying:

- The command to be tested (e.g. `CALENDARS.CREATE`)
- The parameters to send
- The expected request/response behavior
- Optional edge case checks (e.g. missing params, rate limits)

---

## Configuration

The `sd.config.json` file can include a section for conformance testing:

```json
{
  "protocol": "protocol-version-01/protocol.json",
  "conformance": {
    "runner": "ruby",
    "runner_path": "out/ruby/test_runner.rb",
    "manifest": "tests/protocol_manifest.json"
  }
}
```

---

## Execution

To run the conformance tests from the CLI:

```sh
sd_cli test conformance
```

This will:
- Load the selected protocol version and manifest
- Delegate test execution to the test runner in the selected language
- Capture and summarize the results in a final test report

---

## Language-Specific Runners

Each supported language must expose a `test_runner` CLI interface that accepts a command name and test parameters, then returns a structured JSON result.

**Example Invocation:**

```sh
ruby test_runner.rb --command CALENDARS.CREATE --params '{}'
```

**Expected Output (JSON):**

```json
{
  "status": "ok",
  "result": "passed"
}
```

---

## Benefits

- Detect missing or invalid protocol commands in clients
- Ensure future versions of the protocol don’t break existing clients
- Provide confidence to integrators and end users