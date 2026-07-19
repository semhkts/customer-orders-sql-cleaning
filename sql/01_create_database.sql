-- Creates the database and raw customer orders table.
/*
Author: Sam
Project: Customer Orders Data Cleaning
Purpose: Create the database and raw table.
*/

CREATE DATABASE customer_orders_project;

USE customer_orders_project;

CREATE TABLE raw_customer_orders (
    order_id INT,
    customer_name VARCHAR(100),
    email VARCHAR(150),
    city VARCHAR(100),
    order_date VARCHAR(50),
    product VARCHAR(100),
    quantity INT,
    unit_price DECIMAL(10,2),
    payment_status VARCHAR(50)
);
