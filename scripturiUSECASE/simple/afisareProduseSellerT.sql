SET SERVEROUTPUT ON;

-- acceptarea id-ului sellerului
ACCEPT seller_id NUMBER PROMPT 'Introduceti ID-ul sellerului: ';

-- verificarea existentei sellerului
DECLARE
    seller_exists NUMBER := 0;
BEGIN
    -- verifica daca sellerul exista
    SELECT COUNT(*)
    INTO seller_exists
    FROM Sellers
    WHERE SellerID = &seller_id;

    IF seller_exists = 0 THEN
        -- daca sellerul nu exista, afiseaza un mesaj
        DBMS_OUTPUT.PUT_LINE('Eroare: Sellerul cu ID-ul &seller_id nu exista.');
    ELSE
        -- daca sellerul exista, afiseaza produsele asociate
        DBMS_OUTPUT.PUT_LINE('Produsele pentru sellerul cu ID-ul &seller_id:');
        FOR prod IN (SELECT ProductID, Name, Price, Stock, Category 
                     FROM Products 
                     WHERE SellerID = &seller_id) LOOP
            DBMS_OUTPUT.PUT_LINE('ID Produs: ' || prod.ProductID ||
                                 ', Nume: ' || prod.Name ||
                                 ', Pret: ' || prod.Price ||
                                 ', Stoc: ' || prod.Stock ||
                                 ', Categorie: ' || prod.Category);
        END LOOP;
    END IF;
END;
