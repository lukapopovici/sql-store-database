SET SERVEROUTPUT ON;

-- declararea variabilelor pentru datele sellerului
VARIABLE seller_name VARCHAR2(100);
VARIABLE seller_email VARCHAR2(100);
VARIABLE seller_phone VARCHAR2(15);
VARIABLE seller_address VARCHAR2(200);

-- acceptarea inputului utilizatorului
ACCEPT seller_name PROMPT 'Introduceti numele sellerului: ';
ACCEPT seller_email PROMPT 'Introduceti emailul sellerului: ';
ACCEPT seller_phone PROMPT 'Introduceti telefonul sellerului: ';
ACCEPT seller_address PROMPT 'Introduceti adresa sellerului: ';

-- salvarea valorilor introduse in variabile
BEGIN
    :seller_name := '&seller_name';
    :seller_email := '&seller_email';
    :seller_phone := '&seller_phone';
    :seller_address := '&seller_address';
END;
/

-- tranzactie pentru inserarea sellerului
DECLARE
    email_exists NUMBER := 0;
    phone_exists NUMBER := 0;
BEGIN
    -- verifica daca emailul exista deja
    SELECT COUNT(*)
    INTO email_exists
    FROM Sellers
    WHERE Email = :seller_email;

    -- verifica daca telefonul exista deja
    SELECT COUNT(*)
    INTO phone_exists
    FROM Sellers
    WHERE Phone = :seller_phone;

    -- daca emailul sau telefonul exista, arunca erori
    IF email_exists > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Emailul "' || :seller_email || '" este deja utilizat!');
        ROLLBACK;
        RETURN;
    ELSIF phone_exists > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Telefonul "' || :seller_phone || '" este deja utilizat!');
        ROLLBACK;
        RETURN;
    END IF;

    -- daca nu exista conflicte, insereaza sellerul
    INSERT INTO Sellers (Name, Email, Phone, Address)
    VALUES (:seller_name, :seller_email, :seller_phone, :seller_address);

    -- confirma tranzactia
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Sellerul "' || :seller_name || '" a fost inserat cu succes.');
EXCEPTION
    WHEN OTHERS THEN
        -- in caz de eroare, anuleaza tranzactia
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('A aparut o eroare: ' || SQLERRM);
END;
