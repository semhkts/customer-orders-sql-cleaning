/*
Author: Sam Aktas
Project: Customer Orders Data Cleaning with SQL
File: 02_data_exploration.sql

Purpose:
Explore the raw customer orders dataset and identify
data-quality problems before cleaning.
*/

USE customer_orders_project;

-- 1. Preview the raw data
SELECT *
FROM raw_customer_orders
LIMIT 20;

-- 2. Count the total number of rows
SELECT COUNT(*) AS total_rows
FROM raw_customer_orders;

-- 3. Check the number of unique order IDs
SELECT COUNT(DISTINCT order_id) AS unique_order_ids
FROM raw_customer_orders;

-- 4. Find duplicate order IDs
SELECT
    order_id,
    COUNT(*) AS number_of_records
FROM raw_customer_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 5. Find missing customer names
SELECT *
FROM raw_customer_orders
WHERE customer_name IS NULL
   OR TRIM(customer_name) = '';

-- 6. Find missing email addresses
SELECT *
FROM raw_customer_orders
WHERE email IS NULL
   OR TRIM(email) = '';

-- 7. Review city-name variations
SELECT DISTINCT city
FROM raw_customer_orders
ORDER BY city;

-- 8. Review payment-status variations
SELECT DISTINCT payment_status
FROM raw_customer_orders
ORDER BY payment_status;

-- 9. Review all date formats
SELECT DISTINCT order_date
FROM raw_customer_orders
ORDER BY order_date;

-- 10. Find suspicious quantities
SELECT *
FROM raw_customer_orders
WHERE quantity IS NULL
   OR TRIM(quantity) = ''
   OR quantity NOT REGEXP '^-?[0-9]+$'
   OR CAST(quantity AS SIGNED) <= 0;

-- 11. Find suspicious prices
SELECT *
FROM raw_customer_orders
WHERE unit_price IS NULL
   OR TRIM(unit_price) = ''
   OR REPLACE(unit_price, '$', '') NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';

-- 12. Find suspicious email formats
SELECT *
FROM raw_customer_orders
WHERE email IS NOT NULL
  AND TRIM(email) <> ''
  AND email NOT LIKE '%@%.%';
