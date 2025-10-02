-- Create Customers table
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50)
);

-- Create Transactions table
CREATE TABLE Transactions (
    transaction_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customers(customer_id),
    date DATE,
    amount NUMERIC(10,2),
    product_category VARCHAR(50)
);

-- Create Loyalty table
CREATE TABLE Loyalty (
    customer_id INT REFERENCES Customers(customer_id),
    loyalty_points INT,
    membership_level VARCHAR(20)
);


-- Customers
INSERT INTO Customers (name, age, gender, city)
VALUES
('Alice', 28, 'Female', 'New York'),
('Bob', 35, 'Male', 'Los Angeles'),
('Carol', 42, 'Female', 'Chicago');

-- Transactions
INSERT INTO Transactions (customer_id, date, amount, product_category)
VALUES
(1, '2025-01-15', 250.00, 'Electronics'),
(2, '2025-02-10', 100.00, 'Clothing'),
(1, '2025-03-05', 300.00, 'Electronics');

-- Loyalty
INSERT INTO Loyalty (customer_id, loyalty_points, membership_level)
VALUES
(1, 1200, 'Gold'),
(2, 600, 'Silver'),
(3, 300, 'Bronze');


--DATA ANALYSIS PROJECT
--TOTAL SPEND PER CUSTOMER
SELECT c.name, SUM(t.amount) AS total_spent
FROM Customers c
JOIN Transactions t ON c.customer_id = t.customer_id
GROUP BY c.name;

--Average transaction amount by membership level--

SELECT l.membership_level, AVG(t.amount) AS avg_spent
FROM Loyalty l
JOIN Transactions t ON l.customer_id = t.customer_id
GROUP BY l.membership_level;

--customer segmentation by total spend--

SELECT c.name,
       SUM(t.amount) AS total_spent,
       CASE 
         WHEN SUM(t.amount) > 500 THEN 'High Value'
         WHEN SUM(t.amount) BETWEEN 200 AND 500 THEN 'Medium Value'
         ELSE 'Low Value'
       END AS segment
FROM Customers c
JOIN Transactions t ON c.customer_id = t.customer_id
GROUP BY c.name;

--top products  category by spend

SELECT product_category, SUM(amount) AS total_sales
FROM Transactions
GROUP BY product_category
ORDER BY total_sales DESC;



--loyalty points vs spending correlation 
SELECT c.name, l.loyalty_points, SUM(t.amount) AS total_spent
FROM Customers c
JOIN Loyalty l ON c.customer_id = l.customer_id
JOIN Transactions t ON c.customer_id = t.customer_id
GROUP BY c.name, l.loyalty_points;


















