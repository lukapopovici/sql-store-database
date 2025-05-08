-- inserare client in baza de date
SET SERVEROUTPUT ON;

-- declararea variabilelor pentru datele clientului
VARIABLE customer_name VARCHAR2(100);
VARIABLE customer_email VARCHAR2(100);
VARIABLE customer_phone VARCHAR2(15);

-- acceptarea inputului utilizatorului
ACCEPT customer_name PROMPT 'Introduceti numele clientului: ';
ACCEPT customer_email PROMPT 'Introduceti emailul clientului: ';
ACCEPT customer_phone PROMPT 'Introduceti telefonul clientului: ';

-- salvarea valorilor introduse in variabile
BEGIN
    :customer_name := '&customer_name';
    :customer_email := '&customer_email';
    :customer_phone := '&customer_phone';
END;
/

-- tranzactie pentru inserarea clientului
DECLARE
    email_exists NUMBER := 0;
    phone_exists NUMBER := 0;
BEGIN
    -- verifica daca emailul exista deja
    SELECT COUNT(*)
    INTO email_exists
    FROM Customers
    WHERE Email = :customer_email;

    -- verifica daca telefonul exista deja
    SELECT COUNT(*)
    INTO phone_exists
    FROM Customers
    WHERE Phone = :customer_phone;

    -- daca emailul sau telefonul exista, arunca erori
    IF email_exists > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Emailul "' || :customer_email || '" este deja utilizat!');
        ROLLBACK;
        RETURN;
    ELSIF phone_exists > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Telefonul "' || :customer_phone || '" este deja utilizat!');
        ROLLBACK;
        RETURN;
    END IF;

    -- daca nu exista conflicte, insereaza clientul
    INSERT INTO Customers (Name, Email, Phone)
    VALUES (:customer_name, :customer_email, :customer_phone);

    -- confirma tranzactia
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Clientul "' || :customer_name || '" a fost inserat cu succes.');
EXCEPTION
    WHEN OTHERS THEN
        -- in caz de eroare, anuleaza tranzactia
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('A aparut o eroare: ' || SQLERRM);
END;
