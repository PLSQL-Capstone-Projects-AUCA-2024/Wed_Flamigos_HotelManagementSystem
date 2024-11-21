# HOTEL MANAGEMENT SYSTEM

## Problem Statement:
In the hospitality industry, hotels face challenges in managing guest services efficiently due to disconnected processes and manual management of reservations, check-ins, billing, and housekeeping. This fragmented approach often results in booking errors, inconsistent billing, and delayed services, leading to customer dissatisfaction and operational inefficiencies. A comprehensive, centralized Hotel Management System (HMS) is needed to streamline operations, reduce human errors, and improve guest experience by automating bookings, room assignments, billing, and resource management, while providing real-time insights to support data-driven decisions for hotel management.

## Objectives
- Automate and Centralize Booking Management
- Enhance Guest Experience
- Optimize Resource Management
- Enable Data-Driven Decision-Making

## Main Entities
- Guests
- Rooms
- Reservations
- Staff
- Billing
- Inventory

## Expected outcomes of the database solution
- Seamless and error-free bookings
- Enhanced operational efficiency
- Consistent and accurate billings
- Optimized resource allocation
- Informed Decision-making
---
# Swimlane
## Overview
This swimlane diagram models the Hotel Management System process, from guest reservation through check-out. The process emphasizes interactions among the *Guest*, *Front Desk*, *Housekeeping*, and *Billing* departments, incorporating a decision point for room availability.
!["Swimlane"](swimlane.drawio.png)
## Swimlanes and Their Roles

### 1. Guest 
Acts as the primary user of hotel services, initiating the reservation process, checking in, enjoying the amenities, and completing payment at check-out.
### 2. Front Desk
Oversees key operational tasks, including managing room availability, confirming reservations, checking in guests, assigning rooms, updating bills for any additional charges, and ensuring a smooth check-out process.
### 3. Housekeeping
Plays a vital role in guest satisfaction by preparing rooms for check-in, performing regular cleaning during the stay, and responding to specific cleaning requests.
### 4. Billing
Ensures accurate financial transactions by creating and maintaining billing records, generating the final invoice, and processing payments efficiently during check-out.
In a well-coordinated hospitality system, these roles work in tandem to deliver a seamless experience for guests while maintaining operational efficiency.

## Step-by-Step Flow Description with Decision Point
**1. Guest Makes a Reservation**

**2. Front Desk Checks Room Availability**

**3. Decision: Room Availability Check**

**4. Front Desk Confirms Reservation**

**5. Housekeeping Prepares Room for Guest**

**6. Guest Arrives and Checks In**

**7. Front Desk Assigns Room and Checks In Guest**

**8. Billing Initiates Billing Record**

**9. Guest Uses Hotel Amenities**

**10. Front Desk Updates Billing with Amenity Charges**

**11. Housekeeping Schedules Room Cleaning**

**12. Guest Requests Check-Out**

**13. Front Desk Finalizes Billing**

**14. Billing Generates Final Invoice**

**15. Guest Receives Invoice and Pays**

## Purpose and Benefits
This swimlane diagram clarifies roles and responsibilities within the hotel management workflow, ensuring smooth guest experiences and efficient departmental coordination. Key benefits include:
- **Billing Accuracy**
  The decision point ensures accurate room availability during booking, preventing overbookings and streamlining guest check-in.
- **Efficient Room Turnover**
  Updating room status after check-out aids housekeeping in managing room readiness.
- **Enhanced Guest Experience**
  Collecting feedback from guests supports ongoing service improvements, promoting overall satisfaction.
  ---
# Table Creation
The table were created in the database for each entity and below are the commands used for table creation

## Guests Table
```sql
CREATE TABLE Guests (
    guest_id NUMBER NOT NULL PRIMARY KEY,
    first_name VARCHAR2(20) NOT NULL,
    last_name VARCHAR2(20) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    phone_number VARCHAR2(20) NOT NULL,
    address VARCHAR2(255)
);
```

## Rooms Table
```sql
CREATE TABLE Rooms (
    room_id NUMBER NOT NULL PRIMARY KEY,
    room_number VARCHAR2(20) NOT NULL UNIQUE,
    room_type VARCHAR2(20) NOT NULL,
    price_per_night NUMBER(10, 2) NOT NULL,
    availability_status NUMBER(1) DEFAULT 1 NOT NULL,
    max_occupancy NUMBER NOT NULL
);
```

## Reservation Table

```sql
CREATE TABLE Reservation (
    reservation_id NUMBER NOT NULL PRIMARY KEY,
    guest_id NUMBER NOT NULL,
    room_id NUMBER NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    reservation_status VARCHAR2(20) DEFAULT 'Pending',
    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);
```

## Staff Table

```sql
CREATE TABLE Staff (
    staff_id NUMBER NOT NULL PRIMARY KEY,
    first_name VARCHAR2(20) NOT NULL,
    last_name VARCHAR2(20) NOT NULL,
    position VARCHAR2(20) NOT NULL,
    email VARCHAR2(100) NOT NULL UNIQUE,
    phone_number VARCHAR2(20) NOT NULL,
    assigned_room_id NUMBER,
    FOREIGN KEY (assigned_room_id) REFERENCES Rooms(room_id)
);
```

## Billing Table

```sql
CREATE TABLE Billing (
    billing_id NUMBER NOT NULL PRIMARY KEY,
    reservation_id NUMBER NOT NULL,
    amount NUMBER(10, 2) NOT NULL,
    payment_status VARCHAR2(20) DEFAULT 'Pending',
    payment_method VARCHAR2(20),
    FOREIGN KEY (reservation_id) REFERENCES Reservation(reservation_id)
);
```

## Inventor Table

```sql
CREATE TABLE Inventory (
    item_id NUMBER NOT NULL PRIMARY KEY,
    item_name VARCHAR2(20) NOT NULL,
    quantity NUMBER DEFAULT 0 NOT NULL,
    reorder_level NUMBER NOT NULL
);
```
---
# ERD Of The Project
![HotelManagementSystem_ERD](https://github.com/user-attachments/assets/1a893541-9b7c-4d79-9c96-8212a0e25dca)
