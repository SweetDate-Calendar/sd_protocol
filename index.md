---
title: Home  
layout: home
nav_order: 1 
---

# SDIP (SweetDate Implementation Protocol) 
---
This document serves as a reference for developers of language specific implementations.

The document is not intended for developers that uses the **SweetDate** to implement applications for end users.
on how to communicate with the engine. 

This document describes the methods supported by **SweetDate** and how to bridge the implementation to the **Rest API**
 

**Note:** Currently, only **REST**  endpoint are available.


## API Versioning

We distinguish between:

- **SDIP Spec Version** — the protocol document version (semantic versioning: `MAJOR.MINOR.PATCH`), e.g. `1.0.0`.
- **API Version** — the runtime version used by clients when calling the engine. Only the **MAJOR** must match for compatibility.

