-- A trigger to prevent double booking

CREATE OR REPLACE TRIGGER prevent_double_booking
BEFORE INSERT OR UPDATE ON Reservation
FOR EACH ROW
DECLARE
    overlapping_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO overlapping_count
    FROM Reservation
    WHERE room_id = :NEW.room_id
      AND :NEW.check_in_date < check_out_date
      AND :NEW.check_out_date > check_in_date
      AND reservation_status = 'CONFIRMED';

    IF overlapping_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Room is already booked for the selected dates.');
    END IF;
END;
/

