 # Product Analytics SQL Project

This project contains SQL scripts for analyzing product, customer, and sales data for a retail business. The queries help answer key business questions about product performance, customer behavior, and sales trends.

## Database Schema

The database consists of the following tables:

- **customers**: Stores customer details (ID, name, age, gender, location, signup date).
- **products**: Stores product details (ID, name, category, price, cost price).
- **orders**: Stores order details (ID, customer ID, order date, total amount).
- **order_items**: Stores items in each order (ID, order ID, product ID, quantity, unit price).
- **reviews**: Stores product reviews (ID, customer ID, product ID, rating, review date).

## Key Queries

- **Most Popular Products**: Lists products sold most frequently.
- **High-Revenue Products**: Shows products generating the highest revenue.
- **Product ROI**: Identifies most profitable products.
- **Revenue by Category**: Compares revenue across product categories.
- **Customer Loyalty**: Counts loyal vs. one-time/occasional customers.
- **Average Order Value by Segment**: Shows average order value by customer gender.
- **Customer Lifetime Value**: Ranks customers by total revenue generated.
- **Low-Performing Products**: Lists products with lowest sales.
- **Rating vs. Sales Correlation**: Analyzes if better-rated products sell more.
- **Purchase Frequency per Customer**: Shows how often customers place orders.

## Usage

1. Run the SQL script in your MySQL environment.
2. The script will create the database, tables, and run the analytics queries.
3. Review the query results to gain insights into product and customer performance.

## File Structure

- [`Queries.sql`](Queries.sql): Main SQL script containing schema and analytics queries.
