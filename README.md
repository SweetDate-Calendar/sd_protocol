# SweetDate Implementation Protocol (SDIP)

The **SweetDate Implementation Protocol** defines how clients and servers communicate in the SweetDate ecosystem.  
It is designed to be **open, versioned, and language-agnostic**, making it easy for developers to integrate calendar functionality across multiple platforms.

This repository is the **authoritative source** for the SDIP specification, proposals, and version history.

---

## 📜 Purpose

- Provide a **clear and consistent specification** for SweetDate implementations.
- Encourage **community-driven development** of the protocol.
- Maintain a **transparent history** of changes and decisions.
- Ensure **backward compatibility** and smooth upgrades.

---

## 🛠 How to Contribute

We welcome contributions from **developers, integrators, and stakeholders**.

### 1. Join the Discussion
- Use the [GitHub Discussions](https://github.com/SweetDate-Calendar/sd_protocol/discussions) to share ideas, report pain points, or ask questions.

### 2. Propose a Change
We use **SIP (SDIP Improvement Proposal)** documents to propose changes or additions.

1. Open an issue or discussion tagged `proposal`.
2. Fork the repo and create a new file in `/proposals` named:
   ```
   SIP-XXXX-short-title.md
   ```
3. Follow the [SIP Template](proposals/SIP-template.md).
4. Submit a Pull Request for review.

### 3. Review Process
- The proposal will be discussed publicly.
- Core maintainers will give feedback and request revisions if needed.
- Once approved, the change will be merged into the next protocol version.

---

## 📦 Repository Structure

```
/protocol/           # Finalized, versioned protocol definitions
    v1.0/
    v1.1/
    v2.0/

```

---

## 🔢 Versioning

We follow **Semantic Versioning**:

- **MAJOR** — Breaking changes (e.g., removing a command, altering payloads)
- **MINOR** — Backwards-compatible additions (e.g., new commands or fields)
- **PATCH** — Non-breaking clarifications and fixes



---

## 📅 Project Board

We organize protocol development using a [Kanban board](https://github.com/orgs/SweetDate-Calendar/projects/3/views/1) to track:
- Proposals under review
- Approved changes pending implementation
- Work in progress

---

## 📣 Stay Updated

- **Watch** this repository for release notifications.
- Participate in discussions and community calls.
- Follow announcements on our [documentation site](https://github.com/SweetDate-Calendar/sd_engine/discussions).

---

