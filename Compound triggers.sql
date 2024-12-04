create or replace TRIGGER room_availability
FOR INSERT OR UPDATE OR DELETE ON Reservation
COMPOUND TRIGGER

    -- Declare a collection to track affected room IDs
    TYPE t_room_ids IS TABLE OF Rooms.room_id%TYPE;
    v_room_ids t_room_ids := t_room_ids();

    -- BEFORE EACH ROW: Collect affected room IDs
    BEFORE EACH ROW IS
    BEGIN
        IF INSERTING THEN
            v_room_ids.EXTEND;
            v_room_ids(v_room_ids.LAST) := :NEW.room_id;
        ELSIF UPDATING THEN
            v_room_ids.EXTEND;
            v_room_ids(v_room_ids.LAST) := :OLD.room_id; -- Old room ID
            IF :NEW.room_id != :OLD.room_id THEN
                v_room_ids.EXTEND;
                v_room_ids(v_room_ids.LAST) := :NEW.room_id; -- New room ID
            END IF;
        ELSIF DELETING THEN
            v_room_ids.EXTEND;
            v_room_ids(v_room_ids.LAST) := :OLD.room_id;
        END IF;
    END BEFORE EACH ROW;

    -- AFTER STATEMENT: Update room availability status
    AFTER STATEMENT IS
    BEGIN
        -- Loop through all affected room IDs
        FOR i IN v_room_ids.FIRST .. v_room_ids.LAST LOOP
            -- Check if the room has any active reservation
            DECLARE
                v_active_reservations NUMBER;
            BEGIN
                SELECT COUNT(*)
                INTO v_active_reservations
                FROM Reservation
                WHERE room_id = v_room_ids(i)
                  AND reservation_status = 'CONFIRMED';

                -- Update the availability status of the room
                IF v_active_reservations > 0 THEN
                    UPDATE Rooms
                    SET availability_status = 0 -- Unavailable
                    WHERE room_id = v_room_ids(i);
                ELSE
                    UPDATE Rooms
                    SET availability_status = 1 -- Available
                    WHERE room_id = v_room_ids(i);
                END IF;
            END;
        END LOOP;
    END AFTER STATEMENT;

END room_availability;
/