-- Script de testare a constrângerilor pentru tabele

-- 1. Testare cheie primară (Primary Key)
-- Încercăm să introducem două rânduri cu același ID în tabelul Customers.
BEGIN
    INSERT INTO Customers (CustomerID, Name, Email, Phone)
    VALUES (1, 'Ion Popescu', 'ion.popescu@example.com', '0712345678');
    
    INSERT INTO Customers (CustomerID, Name, Email, Phone)
    VALUES (1, 'Maria Ionescu', 'maria.ionescu@example.com', '0723456789'); -- Eroare așteptată
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Test cheie primară: Eroare detectată cu succes.');
END;
/

-- 2. Testare unicitate (Unique Constraint)
-- Încercăm să introducem două rânduri cu același email în tabelul Sellers.
BEGIN
    INSERT INTO Sellers (Name, Email, Phone, Address)
    VALUES ('Vasile Andrei', 'vasile.andrei@example.com', '0734567890', 'Strada Florilor 12');
    
    INSERT INTO Sellers (Name, Email, Phone, Address)
    VALUES ('Andrei Vasilescu', 'vasile.andrei@example.com', '0745678901', 'Strada Teiului 45'); -- Eroare așteptată
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Test unicitate: Eroare detectată cu succes.');
END;
/

-- 3. Testare constrângere CHECK
-- Încercăm să introducem un produs cu un preț negativ.
BEGIN
    INSERT INTO Products (Name, Price, Stock, Category, SellerID)
    VALUES ('Televizor Samsung', -500.00, 10, 'Electronice', 1); -- Eroare așteptată
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Test CHECK: Eroare detectată cu succes.');
END;
/

-- 4. Testare cheie externă (Foreign Key)
-- Încercăm să legăm un produs de un SellerID care nu există.
BEGIN
    INSERT INTO Products (Name, Price, Stock, Category, SellerID)
    VALUES ('Laptop Lenovo', 3500.00, 5, 'Electronice', 999); -- Eroare așteptată
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Test cheie externă: Eroare detectată cu succes.');
END;
/

-- 5. Testare constrângere NOT NULL
-- Încercăm să inserăm o comandă fără un CustomerID.
BEGIN
    INSERT INTO Orders (OrderID, CustomerID, OrderDate, Total)
    VALUES (NULL, NULL, SYSDATE, 500.00); -- Eroare așteptată
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Test NOT NULL: Eroare detectată cu succes.');
END;
/

-- 6. Testare relație între OrderDetails și stocuri (logică aplicație)
-- Încercăm să inserăm o cantitate mai mare decât stocul disponibil.
BEGIN
    INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Subtotal, Delivered)
    VALUES (1, 2, 1000, 45000.00, 'N'); -- Eroare așteptată
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Test logică aplicație: Eroare detectată cu succes.');
END;
/
