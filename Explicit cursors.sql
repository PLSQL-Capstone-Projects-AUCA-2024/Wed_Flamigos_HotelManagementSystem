-- Explicit cursors
-- Expire Old Reservations

DECLARE
    CURSOR cur_pending_Reservation IS
        SELECT reservation_id, guest_id, room_id, check_in_date
        FROM Reservation
        WHERE reservation_status = 'Pending' AND check_in_date < SYSDATE;

    v_reservation_id Reservation.reservation_id%TYPE;
    v_guest_id Reservation.guest_id%TYPE;
    v_room_id Reservation.room_id%TYPE;
    v_check_in_date Reservation.check_in_date%TYPE;
BEGIN
    -- Open the cursor
    OPEN cur_pending_Reservation;

    -- Loop through each record in the cursor
    LOOP
        FETCH cur_pending_Reservation INTO v_reservation_id, v_guest_id, v_room_id, v_check_in_date;
        EXIT WHEN cur_pending_Reservation%NOTFOUND;

        -- Update the reservation status to 'Expired'
        UPDATE Reservation
        SET reservation_status = 'Expired'
        WHERE reservation_id = v_reservation_id;
    END LOOP;

    -- Close the cursor
    CLOSE cur_pending_Reservation;
END;
/


DECLARE
    -- Cursor to fetch upcoming reservations
    CURSOR cur_upcoming_reservations IS
        SELECT r.reservation_id, g.guest_id, g.email, r.check_in_date
        FROM Reservation r
        JOIN Guests g ON r.guest_id = g.guest_id
        WHERE r.reservation_status = 'CONFIRMED'
          AND r.check_in_date BETWEEN SYSDATE AND SYSDATE + 7;

    -- Variables to hold fetched data
    v_reservation_id Reservation.reservation_id%TYPE;
    v_guest_id Guests.guest_id%TYPE;
    v_email Guests.email%TYPE;
    v_check_in_date Reservation.check_in_date%TYPE;
BEGIN
    -- Open the cursor
    OPEN cur_upcoming_reservations;

    -- Loop through each row in the cursor
    LOOP
        FETCH cur_upcoming_reservations INTO v_reservation_id, v_guest_id, v_email, v_check_in_date;

        -- Exit the loop when no more rows are found
        EXIT WHEN cur_upcoming_reservations%NOTFOUND;

        -- Send a notification to the guest (mocked as DBMS_OUTPUT in this case)
        DBMS_OUTPUT.PUT_LINE('Notification sent to: ' || v_email || 
                             ' for reservation ID: ' || v_reservation_id || 
                             ', Check-in Date: ' || v_check_in_date);
    END LOOP;

    -- Close the cursor
    CLOSE cur_upcoming_reservations;

    DBMS_OUTPUT.PUT_LINE('Notifications for upcoming reservations have been sent.');
END;
/
