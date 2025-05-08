-- Populare tabel Sellers
INSERT INTO Sellers (Name, Email, Phone, Address) VALUES ('Ion Popescu', 'ion.popescu@example.com', '0721234567', 'Strada Libertatii 10, Bucuresti');
INSERT INTO Sellers (Name, Email, Phone, Address) VALUES ('Maria Ionescu', 'maria.ionescu@example.com', '0734567890', 'Strada Victoriei 5, Cluj-Napoca');
INSERT INTO Sellers (Name, Email, Phone, Address) VALUES ('George Enescu', 'george.enescu@example.com', '0745678901', 'Strada Muzicii 3, Iasi');
INSERT INTO Sellers (Name, Email, Phone, Address) VALUES ('Ana Marin', 'ana.marin@example.com', '0756789012', 'Strada Florilor 20, Timisoara');
INSERT INTO Sellers (Name, Email, Phone, Address) VALUES ('Vasile Dumitru', 'vasile.dumitru@example.com', '0767890123', 'Strada Campului 15, Brasov');

-- Populare tabel Products
INSERT INTO Products (Name, Price, Stock, Category, SellerID) VALUES ('Laptop Lenovo', 3500.99, 10, 'Electronice', 1);
INSERT INTO Products (Name, Price, Stock, Category, SellerID) VALUES ('Telefon Samsung', 2400.50, 15, 'Electronice', 2);
INSERT INTO Products (Name, Price, Stock, Category, SellerID) VALUES ('Televizor LG', 3000.75, 7, 'Electronice', 3);
INSERT INTO Products (Name, Price, Stock, Category, SellerID) VALUES ('Masina de spalat', 2000.00, 5, 'Electrocasnice', 4);
INSERT INTO Products (Name, Price, Stock, Category, SellerID) VALUES ('Frigider Beko', 2500.30, 8, 'Electrocasnice', 5);
INSERT INTO Products (Name, Price, Stock, Category, SellerID) VALUES ('Aragaz Arctic', 1800.00, 6, 'Electrocasnice', 1);

-- Populare tabel Customers
INSERT INTO Customers (Name, Email, Phone) VALUES ('Andrei Popa', 'andrei.popa@example.com', '0789012345');
INSERT INTO Customers (Name, Email, Phone) VALUES ('Elena Stoica', 'elena.stoica@example.com', '0790123456');
INSERT INTO Customers (Name, Email, Phone) VALUES ('Mihai Radulescu', 'mihai.radulescu@example.com', '0711234567');
INSERT INTO Customers (Name, Email, Phone) VALUES ('Ioana Grigorescu', 'ioana.grigorescu@example.com', '0722345678');
INSERT INTO Customers (Name, Email, Phone) VALUES ('Dan Iacob', 'dan.iacob@example.com', '0733456789');

-- Populare tabel Orders
INSERT INTO Orders (CustomerID, OrderDate, Total) VALUES (1, SYSDATE - 5, 7000.50);
INSERT INTO Orders (CustomerID, OrderDate, Total) VALUES (2, SYSDATE - 3, 2400.50);
INSERT INTO Orders (CustomerID, OrderDate, Total) VALUES (3, SYSDATE - 7, 5500.75);
INSERT INTO Orders (CustomerID, OrderDate, Total) VALUES (4, SYSDATE - 1, 2000.00);
INSERT INTO Orders (CustomerID, OrderDate, Total) VALUES (5, SYSDATE - 2, 1800.00);

-- Populare tabel OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Subtotal, Delivered, OrderDate) VALUES (1, 1, 2, 7000.50, 'Y', SYSDATE - 5);
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Subtotal, Delivered, OrderDate) VALUES (2, 2, 1, 2400.50, 'N', SYSDATE - 3);
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Subtotal, Delivered, OrderDate) VALUES (3, 3, 2, 5500.75, 'Y', SYSDATE - 7);
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Subtotal, Delivered, OrderDate) VALUES (4, 4, 1, 2000.00, 'N', SYSDATE - 1);
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Subtotal, Delivered, OrderDate) VALUES (5, 5, 1, 1800.00, 'N', SYSDATE - 2);
