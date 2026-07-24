/*
Author: Sam Aktas
Project: Customer Orders Data Cleaning with SQL
File: 03_data_cleaning.sql

Purpose:
Clean and standardise the raw customer orders dataset.
*/

USE customer_orders_project;

-- 1. Create a working copy so the raw data stays unchanged
DROP TABLE IF EXISTS cleaned_customer_orders;

CREATE TABLE cleaned_customer_orders AS
SELECT *
FROM raw_customer_orders;


-- 2. Remove extra spaces from text fields
UPDATE cleaned_customer_orders
SET
    customer_name = TRIM(customer_name),
    email = TRIM(email),
    city = TRIM(city),
    product = TRIM(product),
    payment_status = TRIM(payment_status);


-- 3. Standardise city names
UPDATE cleaned_customer_orders
SET city = CONCAT(
    UPPER(LEFT(LOWER(city), 1)),
    SUBSTRING(LOWER(city), 2)
);


-- 4. Standardise payment statuses
UPDATE cleaned_customer_orders
SET payment_status =
    CASE
        WHEN LOWER(payment_status) IN ('paid', 'complete')
            THEN 'Paid'
        WHEN LOWER(payment_status) = 'pending'
            THEN 'Pending'
        WHEN LOWER(payment_status) IN ('refund', 'refunded')
            THEN 'Refunded'
        ELSE NULL
    END;


-- 5. Clean prices by removing the dollar sign
UPDATE cleaned_customer_orders
SET unit_price = REPLACE(unit_price, '$', '');


-- 6. Convert blank strings to NULL
UPDATE cleaned_customer_orders
SET customer_name = NULL
WHERE customer_name = '';

UPDATE cleaned_customer_orders
SET email = NULL
WHERE email = '';

UPDATE cleaned_customer_orders
SET payment_status = NULL
WHERE payment_status = '';


-- 7. Remove duplicate order IDs
DELETE c1
FROM cleaned_customer_orders c1
JOIN cleaned_customer_orders c2
    ON c1.order_id = c2.order_id
   AND c1.customer_name = c2.customer_name
   AND c1.product = c2.product
   AND c1.order_date = c2.order_date
   AND c1.quantity = c2.quantity
   AND c1.unit_price = c2.unit_price
WHERE c1.order_id = '1003'
LIMIT 1;


-- 8. Replace invalid quantities with NULL
UPDATE cleaned_customer_orders
SET quantity = NULL
WHERE quantity NOT REGEXP '^[0-9]+$'
   OR CAST(quantity AS SIGNED) <= 0;


-- 9. Replace invalid prices with NULL
UPDATE cleaned_customer_orders
SET unit_price = NULL
WHERE unit_price NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';


-- 10. Replace invalid email formats with NULL
UPDATE cleaned_customer_orders
SET email = NULL
WHERE email IS NOT NULL
  AND email NOT LIKE '%@%.%';


-- 11. Review cleaned data
SELECT *
FROM cleaned_customer_orders
ORDER BY order_id;
