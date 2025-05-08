-- inserare produs in baza de date

ACCEPT seller_id NUMBER PROMPT 'Introduceti ID-ul vanzatorului: ';
ACCEPT product_name VARCHAR2 PROMPT 'Introduceti numele produsului: ';
ACCEPT price NUMBER PROMPT 'Introduceti pretul produsului: ';
ACCEPT stock NUMBER PROMPT 'Introduceti stocul produsului: ';
ACCEPT category VARCHAR2 PROMPT 'Introduceti categoria produsului: ';

BEGIN
    -- verificarea existentei seller-ului
    IF NOT EXISTS (SELECT 1 FROM Sellers WHERE SellerID = &seller_id) THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Vanzatorul nu exista!');
        ROLLBACK;
    ELSE
        
        INSERT INTO Products (Name, Price, Stock, Category, SellerID)
        VALUES ('&product_name', &price, &stock, '&category', &seller_id);

        DBMS_OUTPUT.PUT_LINE('Produsul a fost adaugat cu succes.');
        COMMIT;
    END IF;
END;
