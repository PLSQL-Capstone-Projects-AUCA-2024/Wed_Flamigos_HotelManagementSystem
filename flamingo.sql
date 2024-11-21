ALTER PLUGGABLE DATABASE wed_flamingo_hotelManagementSystem OPEN;
SHOW PDBS;
ALTER SESSION SET CONTAINER = wed_flamingo_hotelManagementSystem;

-- Table creation

CREATE TABLE Guests (
    guest_id NUMBER NOT NULL PRIMARY KEY,
    first_name VARCHAR2(20) NOT NULL,
    last_name VARCHAR2(20) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    phone_number VARCHAR2(20) NOT NULL,
    address VARCHAR2(255)
);

CREATE TABLE Rooms (
    room_id NUMBER NOT NULL PRIMARY KEY,
    room_number VARCHAR2(20) NOT NULL UNIQUE,
    room_type VARCHAR2(20) NOT NULL,
    price_per_night NUMBER(10, 2) NOT NULL,
    availability_status NUMBER(1) DEFAULT 1 NOT NULL,
    max_occupancy NUMBER NOT NULL
);

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

CREATE TABLE Billing (
    billing_id NUMBER NOT NULL PRIMARY KEY,
    reservation_id NUMBER NOT NULL,
    amount NUMBER(10, 2) NOT NULL,
    payment_status VARCHAR2(20) DEFAULT 'Pending',
    payment_method VARCHAR2(20),
    FOREIGN KEY (reservation_id) REFERENCES Reservation(reservation_id)
);


CREATE TABLE Inventory (
    item_id NUMBER NOT NULL PRIMARY KEY,
    item_name VARCHAR2(20) NOT NULL,
    quantity NUMBER DEFAULT 0 NOT NULL,
    reorder_level NUMBER NOT NULL
);


INSERT INTO Guests (guest_id, first_name, last_name, email, phone_number, address) VALUES (1, 'John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St');
INSERT INTO Guests (guest_id, first_name, last_name, email, phone_number, address) VALUES (2, 'Jane', 'Smith', 'jane.smith@example.com', '0987654321', '456 Elm St');
INSERT INTO Guests (guest_id, first_name, last_name, email, phone_number, address) VALUES (3, 'Michael', 'Brown', 'michael.brown@example.com', '1122334455', '789 Pine St');
INSERT INTO Guests (guest_id, first_name, last_name, email, phone_number, address) VALUES (4, 'Emily', 'Davis', 'emily.davis@example.com', '6677889900', '321 Oak St');
INSERT INTO Guests (guest_id, first_name, last_name, email, phone_number, address) VALUES (5, 'Chris', 'Taylor', 'chris.taylor@example.com', '5544332211', '654 Maple St');


INSERT INTO Rooms (room_id, room_number, room_type, price_per_night, availability_status, max_occupancy) VALUES (1, '101', 'Single', 50.00, 1, 1);
INSERT INTO Rooms (room_id, room_number, room_type, price_per_night, availability_status, max_occupancy) VALUES (2, '102', 'Double', 75.00, 1, 2);
INSERT INTO Rooms (room_id, room_number, room_type, price_per_night, availability_status, max_occupancy) VALUES (3, '103', 'Suite', 120.00, 1, 4);
INSERT INTO Rooms (room_id, room_number, room_type, price_per_night, availability_status, max_occupancy) VALUES (4, '104', 'Double', 75.00, 1, 2);
INSERT INTO Rooms (room_id, room_number, room_type, price_per_night, availability_status, max_occupancy) VALUES (5, '105', 'Single', 50.00, 0, 1);


INSERT INTO Reservation (reservation_id, guest_id, room_id, check_in_date, check_out_date, reservation_status) VALUES (1, 1, 1, TO_DATE('2024-11-20', 'YYYY-MM-DD'), TO_DATE('2024-11-25', 'YYYY-MM-DD'), 'Confirmed');
INSERT INTO Reservation (reservation_id, guest_id, room_id, check_in_date, check_out_date, reservation_status) VALUES (2, 2, 2, TO_DATE('2024-11-22', 'YYYY-MM-DD'), TO_DATE('2024-11-26', 'YYYY-MM-DD'), 'Pending');
INSERT INTO Reservation (reservation_id, guest_id, room_id, check_in_date, check_out_date, reservation_status) VALUES (3, 3, 3, TO_DATE('2024-11-23', 'YYYY-MM-DD'), TO_DATE('2024-11-27', 'YYYY-MM-DD'), 'Confirmed');
INSERT INTO Reservation (reservation_id, guest_id, room_id, check_in_date, check_out_date, reservation_status) VALUES (4, 4, 4, TO_DATE('2024-11-24', 'YYYY-MM-DD'), TO_DATE('2024-11-28', 'YYYY-MM-DD'), 'Cancelled');
INSERT INTO Reservation (reservation_id, guest_id, room_id, check_in_date, check_out_date, reservation_status) VALUES (5, 5, 5, TO_DATE('2024-11-25', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), 'Confirmed');

INSERT INTO Staff (staff_id, first_name, last_name, position, email, phone_number, assigned_room_id) VALUES (1, 'Alice', 'Johnson', 'Manager', 'alice.johnson@example.com', '1234567891', NULL);
INSERT INTO Staff (staff_id, first_name, last_name, position, email, phone_number, assigned_room_id) VALUES (2, 'Bob', 'Williams', 'Receptionist', 'bob.williams@example.com', '1234567892', 1);
INSERT INTO Staff (staff_id, first_name, last_name, position, email, phone_number, assigned_room_id) VALUES (3, 'Catherine', 'Jones', 'Housekeeping', 'catherine.jones@example.com', '1234567893', 2);
INSERT INTO Staff (staff_id, first_name, last_name, position, email, phone_number, assigned_room_id) VALUES (4, 'Daniel', 'Garcia', 'Chef', 'daniel.garcia@example.com', '1234567894', NULL);
INSERT INTO Staff (staff_id, first_name, last_name, position, email, phone_number, assigned_room_id) VALUES (5, 'Evelyn', 'Martinez', 'Housekeeping', 'evelyn.martinez@example.com', '1234567895', 3);


INSERT INTO Billing (billing_id, reservation_id, amount, payment_status, payment_method) VALUES (1, 1, 250.00, 'Paid', 'Credit Card');
INSERT INTO Billing (billing_id, reservation_id, amount, payment_status, payment_method) VALUES (2, 2, 300.00, 'Pending', 'Cash');
INSERT INTO Billing (billing_id, reservation_id, amount, payment_status, payment_method) VALUES (3, 3, 480.00, 'Paid', 'Debit Card');
INSERT INTO Billing (billing_id, reservation_id, amount, payment_status, payment_method) VALUES (4, 4, 300.00, 'Cancelled', NULL);
INSERT INTO Billing (billing_id, reservation_id, amount, payment_status, payment_method) VALUES (5, 5, 500.00, 'Paid', 'Credit Card');


INSERT INTO Inventory (item_id, item_name, quantity, reorder_level) VALUES (1, 'Towels', 100, 20);
INSERT INTO Inventory (item_id, item_name, quantity, reorder_level) VALUES (2, 'Soap', 200, 50);
INSERT INTO Inventory (item_id, item_name, quantity, reorder_level) VALUES (3, 'Shampoo', 150, 30);
INSERT INTO Inventory (item_id, item_name, quantity, reorder_level) VALUES (4, 'Bed Sheets', 80, 15);
INSERT INTO Inventory (item_id, item_name, quantity, reorder_level) VALUES (5, 'Pillows', 60, 10);
