/*
Author: Sam Aktas
Project: Customer Orders Data Cleaning with SQL
File: 04_validation.sql

Purpose:
Validate the cleaned dataset and confirm that major
data-quality issues have been resolved.
*/

USE customer_orders_project;

-- 1. Check total rows
SELECT COUNT(*) AS total_rows
FROM cleaned_customer_orders;


-- 2. Check for duplicate order IDs
SELECT
    order_id,
    COUNT(*) AS number_of_records
FROM cleaned_customer_orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- 3. Check missing customer names
SELECT *
FROM cleaned_customer_orders
WHERE customer_name IS NULL
   OR TRIM(customer_name) = '';


-- 4. Check missing or invalid emails
SELECT *
FROM cleaned_customer_orders
WHERE email IS NULL
   OR email NOT LIKE '%@%.%';


-- 5. Check city consistency
SELECT DISTINCT city
FROM cleaned_customer_orders
ORDER BY city;


-- 6. Check payment status consistency
SELECT DISTINCT payment_status
FROM cleaned_customer_orders
ORDER BY payment_status;


-- 7. Check invalid quantities
SELECT *
FROM cleaned_customer_orders
WHERE quantity IS NULL
   OR CAST(quantity AS SIGNED) <= 0;


-- 8. Check invalid prices
SELECT *
FROM cleaned_customer_orders
WHERE unit_price IS NULL
   OR CAST(unit_price AS DECIMAL(10,2)) <= 0;


-- 9. Final cleaned dataset
SELECT *
FROM cleaned_customer_orders
ORDER BY order_id;
