-- script pentru confirmarea livrarii unei comenzi

ACCEPT order_id NUMBER PROMPT 'Introduceti ID-ul comenzii pentru confirmare livrare: ';

DECLARE
    v_order_count NUMBER;
BEGIN
    -- verifica daca comanda exista in OrderDetails
    SELECT COUNT(*) INTO v_order_count
    FROM OrderDetails
    WHERE OrderID = &order_id;

    IF v_order_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Comanda nu exista in OrderDetails.');
        ROLLBACK;
        RETURN;
    END IF;
END;
/

BEGIN
    -- actualizeaza campul Delivered la 'Y'
    UPDATE OrderDetails
    SET Delivered = 'Y'
    WHERE OrderID = &order_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Livrarea a fost confirmata pentru Comanda ID: ' || &order_id);
END;
