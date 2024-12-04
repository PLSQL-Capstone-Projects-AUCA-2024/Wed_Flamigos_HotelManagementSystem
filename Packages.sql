-- Packages
-- Reservation management
-- Package specification
CREATE OR REPLACE PACKAGE Reservation_Pkg AS
    -- Public Procedures and Functions
    PROCEDURE create_reservation(
        p_guest_id IN Guests.guest_id%TYPE,
        p_room_id IN Rooms.room_id%TYPE,
        p_check_in_date IN DATE,
        p_check_out_date IN DATE
    );

    PROCEDURE update_reservation_status(
        p_reservation_id IN Reservations.reservation_id%TYPE,
        p_status IN VARCHAR2
    );

    FUNCTION check_room_availability(
        p_room_id IN Rooms.room_id%TYPE,
        p_check_in_date IN DATE,
        p_check_out_date IN DATE
    ) RETURN BOOLEAN;

    FUNCTION calculate_total_bill(
        p_reservation_id IN Reservations.reservation_id%TYPE
    ) RETURN NUMBER;
END Reservation_Pkg;
/

-- Package body

CREATE OR REPLACE PACKAGE BODY Reservation_Pkg AS

    -- Procedure to Create a Reservation
    PROCEDURE create_reservation(
        p_guest_id IN Guests.guest_id%TYPE,
        p_room_id IN Rooms.room_id%TYPE,
        p_check_in_date IN DATE,
        p_check_out_date IN DATE
    ) IS
    BEGIN
        -- Check if the room is available
        IF NOT check_room_availability(p_room_id, p_check_in_date, p_check_out_date) THEN
            RAISE_APPLICATION_ERROR(-20001, 'Room is not available for the selected dates.');
        END IF;

        -- Insert reservation into the database
        INSERT INTO Reservations (reservation_id, guest_id, room_id, check_in_date, check_out_date, status, created_at)
        VALUES (reservation_seq.NEXTVAL, p_guest_id, p_room_id, p_check_in_date, p_check_out_date, 'CONFIRMED', SYSDATE);

        DBMS_OUTPUT.PUT_LINE('Reservation created successfully.');
    END create_reservation;

    -- Procedure to Update Reservation Status
    PROCEDURE update_reservation_status(
        p_reservation_id IN Reservations.reservation_id%TYPE,
        p_status IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Reservations
        SET status = p_status
        WHERE reservation_id = p_reservation_id;

        DBMS_OUTPUT.PUT_LINE('Reservation status updated successfully.');
    END update_reservation_status;

    -- Function to Check Room Availability
    FUNCTION check_room_availability(
        p_room_id IN Rooms.room_id%TYPE,
        p_check_in_date IN DATE,
        p_check_out_date IN DATE
    ) RETURN BOOLEAN IS
        v_conflicts NUMBER;
    BEGIN
        -- Check for overlapping reservations
        SELECT COUNT(*)
        INTO v_conflicts
        FROM Reservations
        WHERE room_id = p_room_id
          AND status = 'CONFIRMED'
          AND p_check_in_date < check_out_date
          AND p_check_out_date > check_in_date;

        RETURN (v_conflicts = 0);
    END check_room_availability;

    -- Function to Calculate Total Bill
    FUNCTION calculate_total_bill(
        p_reservation_id IN Reservations.reservation_id%TYPE
    ) RETURN NUMBER IS
        v_room_price Rooms.price_per_night%TYPE;
        v_nights NUMBER;
        v_total_cost NUMBER;
        v_tax_rate CONSTANT NUMBER := 0.15; -- 15% tax
    BEGIN
        -- Fetch room price and calculate nights
        SELECT r.price_per_night, (res.check_out_date - res.check_in_date)
        INTO v_room_price, v_nights
        FROM Reservations res
        JOIN Rooms r ON res.room_id = r.room_id
        WHERE res.reservation_id = p_reservation_id;

        -- Calculate total cost
        v_total_cost := (v_room_price * v_nights) * (1 + v_tax_rate);

        RETURN v_total_cost;
    END calculate_total_bill;

END Reservation_Pkg;
/
