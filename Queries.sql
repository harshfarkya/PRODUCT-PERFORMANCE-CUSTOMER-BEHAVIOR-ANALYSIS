CREATE DATABASE product_analytics;
USE product_analytics;

CREATE TABLE customers (
customer_id INT PRIMARY KEY,
name VARCHAR(100),
age INT,
gender VARCHAR(10),
location VARCHAR(100),
signup_date DATE
);

CREATE TABLE products (
product_id INT PRIMARY KEY,
name VARCHAR(100),
category VARCHAR(50),
price DECIMAL(10,2),
cost_price DECIMAL(10,2)
);

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
total_amount DECIMAL(10,2),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
order_item_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT,
unit_price DECIMAL(10,2),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE reviews (
review_id INT PRIMARY KEY,
customer_id INT,
product_id INT,
rating INT,
review_date DATE,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- Most Popular Products
-- Problem: Which products are sold most frequently?
SELECT p.name, SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY total_units_sold DESC
LIMIT 10;

-- High-Revenue Products
-- Problem: Which products generate the highest revenue?
SELECT p.name, SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY total_revenue DESC
LIMIT 10;

-- Product Return on Investment (ROI)
-- Problem: Which products are most profitable?
SELECT p.name, 
       SUM(oi.quantity * (oi.unit_price - p.cost_price)) AS total_profit
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY total_profit DESC
LIMIT 10;

-- Revenue by Product Category
-- Problem: How do different product categories perform?
SELECT category, SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
GROUP BY category
ORDER BY revenue DESC;


-- "How many customers are repeat buyers (loyal) versus one-time or occasional shoppers?"
SELECT 
  IF(order_count >= 5, 'Loyal Customer', 'One-time/Occasional Customer') AS customer_type,
  COUNT(*) AS number_of_customers
FROM (
  SELECT customer_id, COUNT(order_id) AS order_count
  FROM orders
  GROUP BY customer_id
) AS customer_orders
GROUP BY customer_type;

-- Average Order Value (AOV) by Customer Segment
-- Problem: How much do different customer segments spend per order?
SELECT c.gender, ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.gender;

-- Customer Lifetime Value (CLTV)
-- Problem: Which customers bring in the most revenue?
SELECT c.customer_id, c.name, SUM(o.total_amount) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY lifetime_value DESC
LIMIT 10;

-- Low-Performing Products
-- Problem: Which products sell the least?
SELECT p.name, SUM(oi.quantity) AS total_units_sold
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY total_units_sold ASC
LIMIT 10;

-- Rating vs. Sales Correlation
-- Problem: Do better-rated products sell more?
SELECT p.name, r.avg_rating, o.total_units_sold
FROM products p
LEFT JOIN (
    SELECT product_id, AVG(rating) AS avg_rating
    FROM reviews
    GROUP BY product_id
) r ON r.product_id = p.product_id
LEFT JOIN (
    SELECT product_id, SUM(quantity) AS total_units_sold
    FROM order_items
    GROUP BY product_id
) o ON o.product_id = p.product_id
ORDER BY r.avg_rating DESC
LIMIT 20; 

-- Purchase Frequency per Customer
-- Problem: How often do customers place orders?
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 50;



