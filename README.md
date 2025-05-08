# Retail Store Database Schema

## Project Objective

The goal of this project is to design and implement the database schema for a retail store. In this store, users can register either as buyers (customers) or as sellers.

Sellers can upload new products and modify prices of existing listings, while customers can place orders, confirm them, or cancel them.

This has both scripts to manage and populate tables, and test constraints.

Everything is meant to be run on Oracle Database.

![image](https://github.com/user-attachments/assets/2898c67a-7893-41be-ab1a-13f5c02b5366)

---

## Tables

### 1. Table: Sellers

**Description:** Stores information about sellers (companies or individuals).

**Columns:**

* `SellerID`: Primary key, uniquely identifies each seller.
* `Name`: Seller's name.
* `Email`: Seller's email (unique).
* `Phone`: Seller's phone number (unique).
* `Address`: Seller's address.

**Constraints:**

* `SellerID` is the primary key.
* `Email` and `Phone` must be unique.

---

### 2. Table: Products

**Description:** Stores information about products.

**Columns:**

* `ProductID`: Primary key, uniquely identifies each product.
* `Name`: Product name.
* `Price`: Product price, must be positive.
* `Stock`: Product stock, must be non-negative.
* `Category`: Product category.
* `SellerID`: Foreign key referencing the seller (from Sellers table).

**Constraints:**

* `ProductID` is the primary key.
* `Price` must be greater than 0.
* `Stock` must be non-negative.
* `SellerID` is a foreign key referencing `Sellers.SellerID`.

---

### 3. Table: Customers

**Description:** Stores information about customers.

**Columns:**

* `CustomerID`: Primary key, uniquely identifies each customer.
* `Name`: Customer name (unique).
* `Email`: Customer email (unique).
* `Phone`: Customer phone number (unique).

**Constraints:**

* `CustomerID` is the primary key.
* `Name`, `Email`, and `Phone` must be unique.

---

### 4. Table: Orders

**Description:** Stores information about orders placed by customers.

**Columns:**

* `OrderID`: Primary key, uniquely identifies each order.
* `CustomerID`: Foreign key referencing a customer (from Customers table).
* `OrderDate`: Date of order placement (default: current date).
* `Total`: Order total, must be zero or positive.

**Constraints:**

* `OrderID` is the primary key.
* `CustomerID` is a foreign key referencing `Customers.CustomerID`.
* `Total` must be >= 0.

---

### 5. Table: OrderDetails

**Description:** Stores details about products in each order.

**Columns:**

* `OrderID`: Primary key, links details to an order (from Orders table).
* `ProductID`: Foreign key, links to a product (from Products table).
* `Quantity`: Quantity of the ordered product (must be positive).
* `Subtotal`: Subtotal for the ordered product (must be positive).
* `Delivered`: Delivery status (`Y` = delivered, `N` = not delivered).
* `OrderDate`: Date the product was added to the order (default: current date).

**Constraints:**

* `OrderID` is the primary key.
* `Quantity` must be > 0.
* `Subtotal` must be positive.
* `OrderID` is a foreign key referencing `Orders.OrderID`.
* `ProductID` is a foreign key referencing `Products.ProductID`.
* `Delivered` must only accept values `'Y'` or `'N'`.

---

## Entity Relationships

* **Sellers–Products:** One-to-many: a seller can list multiple products, but each product belongs to one seller.
* **Customers–Orders:** One-to-many: a customer can place multiple orders, but each order belongs to one customer.
* **Orders–OrderDetails:** One-to-one: each order has a single associated order detail entry.
* **Products–OrderDetails:** One-to-many: a product can appear in many order details, each order detail entry references one product.

---

## Use Cases

1. **Register a new customer (buyer).**
2. **Register a new seller.**
3. **Upload a new product by a seller:** Allowed if the `SellerID` is valid.
4. **Modify the price of an existing product:** Allowed if the product ID is valid and new price meets constraints.
5. **Attach order details.**
6. **Confirm an order (mark as Delivered):** Verify if the order ID exists, and update `Delivered` to `'Y'`.
7. **Cancel an order:** Restore product stock, delete order details and the order.
8. **Update product stock after placing an order:** Use a transaction to decrement stock after a successful order.
9. **Display all products listed by a seller.**

---

## Normalization Principles

### First Normal Form (1NF)

* All tables contain atomic values in each column.
* No repeating groups or arrays.
* Each row is unique and identified by a primary key.

### Second Normal Form (2NF)

* All non-key attributes are fully dependent on the entire primary key.
* No partial dependencies.
* Example: In `Products`, all columns depend on `ProductID`.

### Third Normal Form (3NF)

* No transitive dependencies between non-key attributes.
* Example: In `Orders`, `Total` depends directly on `OrderID` and not on any non-key attributes.

---

This schema is designed for efficiency, data integrity, and to minimize redundancy using the principles of database normalization.

# E-R diagram

![image](https://github.com/user-attachments/assets/683a21db-c99c-481b-9d30-095025ee9461)
