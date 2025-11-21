-- ===============================================
-- TASK 5: SQL JOINS (INNER, LEFT, RIGHT, FULL)
-- ===============================================
use ecommerce;
-- Drop tables if they already exist
ALTER TABLE orderdetails 
DROP FOREIGN KEY orderdetails_ibfk_1;

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

-- ========================
-- 1. Create Tables
-- ========================

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    amount INT
);

-- ========================
-- 2. Insert Sample Data
-- ========================

INSERT INTO Customers (customer_id, name, city) VALUES
(1, 'Amit', 'Pune'),
(2, 'Manasi', 'Mumbai'),
(3, 'Riya', 'Delhi'),
(4, 'Karan', 'Chennai');   -- customer with no orders

INSERT INTO Orders (order_id, customer_id, product, amount) VALUES
(101, 1, 'Laptop', 50000),
(102, 1, 'Mouse', 700),
(103, 2, 'Keyboard', 1200),
(104, 5, 'Monitor', 8000); -- order with no matching customer

-- ========================
-- 3. INNER JOIN
-- ========================
-- Returns only matching rows from both tables

SELECT 
    Customers.customer_id,
    Customers.name,
    Orders.order_id,
    Orders.product,
    Orders.amount
FROM Customers
INNER JOIN Orders
    ON Customers.customer_id = Orders.customer_id;

-- ========================
-- 4. LEFT JOIN
-- ========================
-- Returns all customers, even if they have no orders

SELECT 
    Customers.customer_id,
    Customers.name,
    Orders.order_id,
    Orders.product
FROM Customers
LEFT JOIN Orders
    ON Customers.customer_id = Orders.customer_id;

-- ========================
-- 5. RIGHT JOIN (MySQL only)
-- ========================
-- Returns all orders, even if there is no matching customer
-- Note: SQLite does NOT support RIGHT JOIN

SELECT 
    Customers.customer_id,
    Customers.name,
    Orders.order_id,
    Orders.product
FROM Customers
RIGHT JOIN Orders
    ON Customers.customer_id = Orders.customer_id;

-- ========================
-- 6. FULL OUTER JOIN (MySQL/SQLite workaround using UNION)
-- ========================
-- Shows all customers + all orders

SELECT 
    Customers.customer_id,
    Customers.name,
    Orders.order_id,
    Orders.product
FROM Customers
LEFT JOIN Orders
    ON Customers.customer_id = Orders.customer_id

UNION

SELECT 
    Customers.customer_id,
    Customers.name,
    Orders.order_id,
    Orders.product
FROM Customers
RIGHT JOIN Orders
    ON Customers.customer_id = Orders.customer_id;

-- ========================
-- 7. CROSS JOIN
-- ========================
-- Produces Cartesian product

SELECT 
    Customers.name,
    Orders.product
FROM Customers
CROSS JOIN Orders;

-- ========================
-- 8. SELF JOIN (Example)
-- ========================
-- Example: same city customers

SELECT 
    A.name AS Customer1,
    B.name AS Customer2,
    A.city
FROM Customers A
JOIN Customers B
    ON A.city = B.city 
   AND A.customer_id <> B.customer_id;

-- ========================
-- END OF SCRIPT
-- ========================
