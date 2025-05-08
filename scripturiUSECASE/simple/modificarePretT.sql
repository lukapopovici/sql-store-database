ACCEPT product_id NUMBER PROMPT 'Introduceti ID-ul produsului: ';
ACCEPT new_price NUMBER PROMPT 'Introduceti noul pret al produsului: ';

DECLARE
    v_exists NUMBER;  -- variabila pentru a verifica existenta produsului
BEGIN
    -- verificarea existentei produsului in tabelul Products
    SELECT COUNT(*)
    INTO v_exists
    FROM Products
    WHERE ProductID = &product_id;

    IF v_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Produsul cu ID-ul specificat nu exista!');
        ROLLBACK;
    ELSIF &new_price <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Noul pret trebuie sa fie mai mare decat 0!');
        ROLLBACK;
    ELSE
        -- actualizarea pretului produsului
        UPDATE Products
        SET Price = &new_price
        WHERE ProductID = &product_id;

        DBMS_OUTPUT.PUT_LINE('Pretul produsului a fost actualizat cu succes.');
        COMMIT; -- confirmarea tranzactiei
    END IF;
END;
