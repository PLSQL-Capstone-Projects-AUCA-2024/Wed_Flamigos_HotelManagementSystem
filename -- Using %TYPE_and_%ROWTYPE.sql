-- Using %TYPE
SET SERVEROUTPUT ON;
DECLARE
    v_room_price Rooms.price_per_night%TYPE; -- Adapts to the data type of Rooms.price_per_night
    v_total_cost NUMBER;
    v_reservation_id Reservation.reservation_id%TYPE;
BEGIN
    SELECT price_per_night
    INTO v_room_price
    FROM Rooms
    WHERE room_id = 1; -- Example room ID

    -- Calculate the total cost for 5 nights
    v_total_cost := v_room_price * 5;

    DBMS_OUTPUT.PUT_LINE('Total Cost for 5 nights: ' || v_total_cost);
END;
/

--Using %ROWTYPE
SET SERVEROUTPUT ON;
DECLARE
    v_reservation Reservation%ROWTYPE; -- Record variable with all columns from the Reservations table
BEGIN
    SELECT *
    INTO v_reservation
    FROM Reservation
    WHERE reservation_id = 1; -- Example reservation ID

    -- Process the reservation details
    DBMS_OUTPUT.PUT_LINE('Reservation Details: Guest ID: ' || v_reservation.guest_id ||
                         ', Room ID: ' || v_reservation.room_id ||
                         ', Check-In: ' || v_reservation.check_in_date ||
                         ', Check-Out: ' || v_reservation.check_out_date);
END;
/
