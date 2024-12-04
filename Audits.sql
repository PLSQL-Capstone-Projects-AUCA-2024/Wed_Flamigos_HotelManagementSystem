-- Audits
-- Logging changes to sensitive data
CREATE TABLE Audit_Logs (
    log_id NUMBER PRIMARY KEY,
    table_name VARCHAR2(50),
    operation VARCHAR2(10),
    changed_by VARCHAR2(50),
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_value VARCHAR2(4000),
    new_value VARCHAR2(4000)
);

CREATE OR REPLACE TRIGGER trg_audit_guest_changes
AFTER INSERT OR UPDATE OR DELETE ON Guests
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO Audit_Logs (log_id, table_name, operation, changed_by, old_value, new_value)
        VALUES (
            audit_seq.NEXTVAL,
            'Guests',
            'INSERT',
            USER, -- Captures the database user who made the change
            NULL,
            'Guest Added: ' || :NEW.first_name || ' ' || :NEW.last_name || ', Email: ' || :NEW.email
        );
    ELSIF UPDATING THEN
        INSERT INTO Audit_Logs (log_id, table_name, operation, changed_by, old_value, new_value)
        VALUES (
            audit_seq.NEXTVAL,
            'Guests',
            'UPDATE',
            USER,
            'Old Email: ' || :OLD.email,
            'New Email: ' || :NEW.email
        );
    ELSIF DELETING THEN
        INSERT INTO Audit_Logs (log_id, table_name, operation, changed_by, old_value, new_value)
        VALUES (
            audit_seq.NEXTVAL,
            'Guests',
            'DELETE',
            USER,
            'Deleted Guest: ' || :OLD.first_name || ' ' || :OLD.last_name || ', Email: ' || :OLD.email,
            NULL
        );
    END IF;
END;
/

