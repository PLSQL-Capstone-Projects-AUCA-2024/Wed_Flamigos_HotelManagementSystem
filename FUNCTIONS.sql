-- FUNCTIONS
-- Calculating total bills

CREATE OR REPLACE FUNCTION calculate_total_bill(
    p_reservation_id IN Reservation.reservation_id%TYPE
) RETURN NUMBER IS
    v_room_price Rooms.price_per_night%TYPE;
    v_nights NUMBER;
    v_total_cost NUMBER;
    v_tax_rate CONSTANT NUMBER := 0.15; -- Example tax rate (15%)
BEGIN
    -- Fetch room price and calculate nights stayed
    SELECT r.price_per_night, (res.check_out_date - res.check_in_date)
    INTO v_room_price, v_nights
    FROM Reservation res
    JOIN Rooms r ON res.room_id = r.room_id
    WHERE res.reservation_id = p_reservation_id;

    -- Calculate total cost
    v_total_cost := (v_room_price * v_nights) * (1 + v_tax_rate);

    RETURN v_total_cost;
END;
/

-- Function calling
SET SERVEROUTPUT ON;
DECLARE
    v_total_bill NUMBER;
BEGIN
    -- Call the function
    v_total_bill := calculate_total_bill(1); -- Example reservation ID
    DBMS_OUTPUT.PUT_LINE('Total Bill: ' || v_total_bill);
END;
/


-- Verifying room availability

CREATE OR REPLACE FUNCTION is_room_available(
    p_room_id IN Rooms.room_id%TYPE,
    p_check_in_date IN DATE,
    p_check_out_date IN DATE
) RETURN BOOLEAN IS
    v_conflicts NUMBER;
BEGIN
    -- Check for overlapping reservations
    SELECT COUNT(*)
    INTO v_conflicts
    FROM Reservation
    WHERE room_id = p_room_id
      AND reservation_status = 'CONFIRMED'
      AND p_check_in_date < check_out_date
      AND p_check_out_date > check_in_date;

    -- Return FALSE if there are conflicts, otherwise TRUE
    RETURN (v_conflicts = 0);
END;
/

SET SERVEROUTPUT ON;
-- Function calling
DECLARE
    v_available BOOLEAN;
BEGIN
    -- Check availability
    v_available := is_room_available(1, SYSDATE, SYSDATE + 3); -- Room 1, 3-day stay

    IF v_available THEN
        DBMS_OUTPUT.PUT_LINE('Room is available.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Room is not available.');
    END IF;
END;
/
