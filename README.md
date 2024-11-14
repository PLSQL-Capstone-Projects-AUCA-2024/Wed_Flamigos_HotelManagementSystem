# Hotel Management System - Swimlane Diagram Documentation

## Overview
This swimlane diagram models the Hotel Management System process, from guest reservation through check-out. The process emphasizes interactions among the *Guest*, *Front Desk*, *Housekeeping*, and *Billing* departments, incorporating a decision point for room availability.

---

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
### 1. Guest Makes a Reservation
The journey begins when a guest submits a reservation request, either online or in person. At this stage, key details such as room type, check-in and check-out dates, and any special preferences are collected.
If the requested room is available, the reservation is confirmed, and the guest receives a confirmation message. In case the room is unavailable, alternative options are presented to the guest, such as adjusting the stay dates or selecting a different room type.
This step sets the foundation for the guest's overall experience, making accuracy and responsiveness crucial.
### 2. Front Desk Checks Room Availability
The front desk checks for room availability on the requested dates.
### 3. Decision: Room Availability Check
- *If rooms are available*, the front desk proceeds to confirm the reservation, recording all relevant booking details.
- *If no rooms are available*, the front desk informs the guest of unavailability, ending the process here for that reservation attempt.

### 4. Front Desk Confirms Reservation
Upon confirming room availability, the front desk finalizes the reservation and sends confirmation details to the guest.

### 5. Housekeeping Prepares Room for Guest
Housekeeping prepares the room by ensuring it is clean and stocked with necessary amenities, marking the room as “ready” for guest arrival.
### 6. Guest Arrives and Checks In
The guest arrives at the hotel and checks in at the front desk.

### 7. Front Desk Assigns Room and Checks In Guest
The front desk assigns the room to the guest, updating the room’s status to “occupied.”

### 8. Billing Initiates Billing Record
The billing system creates a new record for this reservation to track all charges associated with the guest’s stay.

### 9. Guest Uses Hotel Amenities
During their stay, the guest may use additional services like dining or spa treatments, which incur extra charges.

### 10. Front Desk Updates Billing with Amenity Charges
The front desk adds charges for amenities used by the guest to the billing record.

### 11. Housekeeping Schedules Room Cleaning
Housekeeping monitors room usage and schedules cleaning during or after the guest’s stay as necessary.

### 12. Guest Requests Check-Out
The guest requests check-out at the front desk when ready to leave.










