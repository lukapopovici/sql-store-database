-- script pentru anularea unei comenzi

ACCEPT order_id NUMBER PROMPT 'Introduceti ID-ul comenzii de anulat: ';

DECLARE
    v_order_count NUMBER;
    v_product_id NUMBER;
    v_quantity NUMBER;
BEGIN
    -- verifica daca comanda exista
    SELECT COUNT(*)
    INTO v_order_count
    FROM Orders
    WHERE OrderID = &order_id;

    IF v_order_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Comanda nu exista.');
        ROLLBACK;
        RETURN;
    END IF;

    -- obtine ProductID si Quantity din OrderDetails
    SELECT ProductID, Quantity
    INTO v_product_id, v_quantity
    FROM OrderDetails
    WHERE OrderID = &order_id;

    -- restabileste stocul produsului
    UPDATE Products
    SET Stock = Stock + v_quantity
    WHERE ProductID = v_product_id;

    DBMS_OUTPUT.PUT_LINE('Produsul cu ID-ul: ' || v_product_id || ' a fost restabilit cu cantitatea: ' || v_quantity);

    -- sterge comanda din OrderDetails
    DELETE FROM OrderDetails
    WHERE OrderID = &order_id;

    -- sterge comanda din Orders
    DELETE FROM Orders
    WHERE OrderID = &order_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Comanda cu ID-ul: ' || &order_id || ' a fost anulata cu succes.');
END;
