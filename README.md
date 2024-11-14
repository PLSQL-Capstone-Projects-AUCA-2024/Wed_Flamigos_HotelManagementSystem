# Hotel Management System - Swimlane Diagram Documentation

## Overview
This swimlane diagram models the Hotel Management System process, from guest reservation through check-out. The process emphasizes interactions among the Guest, Front Desk, Housekeeping, and Billing departments, incorporating a decision point for room availability.

---

## Swimlanes and Their Roles

- *Guest*: Initiates the reservation, checks in, uses hotel amenities, and makes payment at check-out.
- *Front Desk*: Manages room availability, confirms reservations, checks guests in, assigns rooms, updates billing with additional charges, and handles final check-out.
- *Housekeeping*: Prepares rooms for check-in and schedules cleaning as needed during the guest’s stay.
- *Billing*: Creates and updates billing records, generates the final invoice, and processes payment upon check-out.

---

## Step-by-Step Flow Description with Decision Point

### 1. Guest Makes Reservation
The guest starts by making a reservation request.

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

### 13. Front Desk Finalizes Billing
The front desk reviews the billing record to ensure all charges are accurate and complete.

### 14. Billing Generates Final Invoice
The billing department generates the final invoice, detailing all room charges and additional service costs.

### 15. Billing Processes Payment
The guest pays the final invoice, completing the financial transaction.

### 16. Guest Receives Invoice and Pays
The guest receives a copy of the paid invoice as a receipt, concluding the check-out process.

---

## Purpose and Benefits
This swimlane diagram clarifies roles and responsibilities within the hotel management workflow, ensuring smooth guest experiences and efficient departmental coordination. Key benefits include:

- *Billing Accuracy*: The decision point ensures accurate room availability during booking, preventing overbookings and streamlining guest check-in.
- *Efficient Room Turnover*: Updating room status after check-out aids housekeeping in managing room readiness.
- *Enhanced Guest Experience*: Collecting feedback from guests supports ongoing service improvements, promoting overall satisfaction.
