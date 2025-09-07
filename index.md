---
title: Home  
layout: home
nav_order: 1 
---

# SDIP (SweetDate Implementation Protocol) 
---

This document describes the methods supported by **SweetDate**  
It serves as a reference for developers on how to communicate with the engine.  

**Note:** Currently, only **REST**  endpoint are available.


## API Versioning

We distinguish between:

- **SDIP Spec Version** — the protocol document version (semantic versioning: `MAJOR.MINOR.PATCH`), e.g. `1.0.0`.
- **API Version** — the runtime version used by clients when calling the engine. Only the **MAJOR** must match for compatibility.

