---
title: Basic 
nav_order: 1000
layout: home
has_children: true
---
# What Is a Calendar Backend?  

A **calendar backend** is the **engine that powers scheduling, booking, and time management** for websites and apps.  

It doesn’t decide how the site looks or how the booking form is designed. That’s the job of the **site developer or theme provider**. Instead, the backend takes care of the **hard logic**: making sure bookings don’t overlap, sending confirmations, handling cancellations, and managing reminders.  

---

## Who Handles What?  

- **The Bureau / Developer / Theme Provider**  
  - Builds the site or app (e.g., WordPress site, custom React app).  
  - Designs the user experience (forms, buttons, dashboards).  
  - Integrates external services like **payment gateways**, **file storage**, and **email providers**.  
  - Connects the site to SweetDate for calendar logic.  

- **SweetDate**  
  - Manages calendars and bookings.  
  - Prevents double-bookings.  
  - Handles invitations, acceptances, cancellations, and rescheduling.  
  - Schedules reminders and notifications.  
  - Supports multi-tenant setups (e.g., one hotel chain with many hotels, each with many rooms and calendars).  

Together, these pieces form a complete solution.  

---

## Example 1: Hotels  

- **Developer builds** a hotel booking website.  
- **UX/UI**: the bureau designs how users search for rooms, pick dates, and enter payment info.  
- **Payment**: handled by Stripe, PayPal, etc.  
- **Calendar backend (SweetDate)**:  
  - Tracks which rooms are available.  
  - Saves the booking into the right room’s calendar.  
  - Sends confirmations and schedules reminders.  

---

## Example 2: Tennis Matchmaking  

- **Developer builds** a community sports site.  
- **UX/UI**: the bureau designs player profiles, search, and match requests.  
- **Other services**: payments if required (e.g., for court rental).  
- **Calendar backend (SweetDate)**:  
  - Player A sends an invitation to Player B.  
  - Player B accepts or declines.  
  - Both calendars are updated.  
  - If canceled, notifications are sent automatically.  

---

## Everyday Calendar Backend Features  

- Multi-tenancy (hotel chain → hotels → rooms → calendars).  
- Conflict management (no double-bookings).  
- Invitations, accept/decline, cancellations, rescheduling.  
- Automated reminders and confirmations.  
- Full audit trail (who booked, canceled, changed).  

---

## Why Use a Calendar Backend?  

Calendars sound simple — but the logic is **hard to build**.  

By **offloading calendar complexity to SweetDate**, developers and agencies:  
- Save time and money.  
- Deliver reliable, tested booking flows.  
- Focus on **UX, payments, and business features** — while SweetDate handles the scheduling engine.  

---

## Responsibilities Overview  

```
+--------------------+-------------------+--------------------+
| Bureau / Developer | Other Services    | SweetDate Backend  |
+--------------------+-------------------+--------------------+
| - UX / UI design   | - Payments        | - Booking logic    |
| - Site structure   | - File storage    | - No double-book   |
| - Integrations     | - Email delivery  | - Invitations      |
|                    |                   | - Reminders        |
+--------------------+-------------------+--------------------+
```

This clearly shows **boundaries**:  
- Bureau handles **what the user sees**.  
- Other services handle **their specialties** (payment, email, storage).  
- SweetDate handles **calendars and scheduling logic**.  


# SweetDate — A Fundamental Description

SweetDate is a **calendar backend**. That means it is a system that provides the **core logic** for managing calendars, bookings, and events. It doesn’t decide how the website looks or how the app works — instead, it provides the **engine** that developers and businesses can plug into their websites and services.  

Think of it like electricity: you don’t build your own power plant to light up your house. You connect to the grid. SweetDate is the **“calendar grid”** for modern websites and apps.  

---

## The Players

1. **End Users**  
   - The people who want to book something.  
   - Examples:  
     - A tennis player booking a court.  
     - A client booking time with a lawyer.  
     - A family reserving a spot with a travel agency.  

2. **Businesses & Organizations**  
   - The service providers who need to handle bookings.  
   - Examples:  
     - The tennis club.  
     - The law office.  
     - The travel agency.  

3. **Web Agencies (Bureaus)**  
   - The developers and designers who build websites for businesses.  
   - They integrate tools like payment systems, storage, email — and SweetDate for calendar features.  
   - Examples in Aarhus:  
     - **Klean**  
     - **Novicell**  
     - **1508**  

4. **Theme Vendors**  
   - Companies or individuals who sell pre-made website templates (e.g., for WordPress).  
   - A theme could already include SweetDate, or the agency could add it afterwards.  
   - SweetDate could also provide its own themes for popular industries (e.g., sports clubs, law firms).  

---

## The Business Model

- Each **site** that integrates SweetDate pays for access to the SaaS.  
- Just like with payment gateways, email providers, or file storage, SweetDate is one of the **building blocks** that agencies use to deliver a full solution.  

---

## Why Use SweetDate?

- Because it’s **faster, cheaper, and better** than building a booking system from scratch.  
- Agencies and businesses save time and focus on what makes their service unique.  
- End users get reliable and easy-to-use booking experiences.  

---

## Sketch for the Graphic / Diagram

Imagine a **layered diagram**:  

```
+---------------------------------------------------+
|                   End Users                       |
|  (Tennis players, clients, travelers)             |
+---------------------------------------------------+
                        │
                        ▼
+---------------------------------------------------+
|      Businesses & Organizations                   |
|  (Tennis clubs, law firms, travel agencies)       |
+---------------------------------------------------+
                        │
                        ▼
+---------------------------------------------------+
|         Web Agencies / Bureaus                    |
|  (Klean, Novicell, 1508)                          |
|  - Build websites and apps                        |
|  - Add Payment Gateway, Storage, Email,           |
|    and Calendar Backend (SweetDate)               |
+---------------------------------------------------+
                        │
                        ▼
+---------------------------------------------------+
|                 SweetDate SaaS                    |
|   - Calendar logic                                |
|   - Booking management                            |
|   - Multi-tenant backend                          |
+---------------------------------------------------+
```

👉 In a more **friendly illustration**:  
- On the **left side**, little icons of **end users** (person with tennis racket, businessperson, family with suitcase).  
- In the **middle**, logos/buildings for **businesses** (tennis club, lawyer office, travel agency).  
- Below them, **web agencies** shown as designers/developers with laptops.  
- On the **right side**, a **“cloud” labeled SweetDate** connected to the agencies’ work, next to other blocks (payment, email, storage).  
