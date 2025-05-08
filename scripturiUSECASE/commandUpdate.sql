-- script pentru plasarea unei comenzi si detaliile acesteia

ACCEPT customer_id NUMBER PROMPT 'Introduceti ID-ul clientului: ';
ACCEPT product_id NUMBER PROMPT 'Introduceti ID-ul produsului: ';
ACCEPT quantity NUMBER PROMPT 'Introduceti cantitatea: ';

DECLARE
    v_customer_count NUMBER;
BEGIN
    -- verifica daca clientul exista
    SELECT COUNT(*) INTO v_customer_count
    FROM Customers
    WHERE CustomerID = &customer_id;

    IF v_customer_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Clientul nu exista.');
        ROLLBACK;
        RETURN;
    END IF;
END;
/

DECLARE
    v_product_count NUMBER;
    v_stock NUMBER;
    v_price NUMBER;
    v_subtotal NUMBER;
BEGIN
    -- verifica daca produsul exista, verifica stocul si asigura ca stocul nu este 0
    SELECT COUNT(*), Stock, Price INTO v_product_count, v_stock, v_price
    FROM Products
    WHERE ProductID = &product_id
    GROUP BY Stock, Price;

    IF v_product_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Produsul nu exista.');
        ROLLBACK;
        RETURN;
    END IF;

    IF v_stock = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Produsul nu este in stoc.');
        ROLLBACK;
        RETURN;
    END IF;

    IF v_stock < &quantity THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Stoc insuficient.');
        ROLLBACK;
        RETURN;
    END IF;

    -- calculeaza subtotalul
    v_subtotal := &quantity * v_price;

    -- insereaza in tabela Orders
    INSERT INTO Orders (CustomerID, Total)
    VALUES (&customer_id, v_subtotal);

    -- obtine OrderID-ul generat
    DECLARE
        v_order_id NUMBER;
    BEGIN
        SELECT OrderID INTO v_order_id
        FROM Orders
        WHERE ROWNUM = 1
        ORDER BY OrderID DESC;

        -- insereaza in tabela OrderDetails
        INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Subtotal)
        VALUES (v_order_id, &product_id, &quantity, v_subtotal);

        -- actualizeaza stocul produsului
        UPDATE Products
        SET Stock = Stock - &quantity
        WHERE ProductID = &product_id;

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Comanda a fost plasata cu succes. ID Comanda: ' || v_order_id);
    END;
END;
/
