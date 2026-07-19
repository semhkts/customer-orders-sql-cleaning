/*
Purpose:
Explore the raw dataset before cleaning.
*/

USE customer_orders_project;

-- Preview the data
SELECT *
FROM raw_customer_orders
LIMIT 20;

-- Count total rows
SELECT COUNT(*)
FROM raw_customer_orders;
