/*
Author: Sam Aktas
Project: Customer Orders Data Cleaning with SQL
File: 01_create_database.sql

Purpose:
Create the project database and the table used to import
the original messy customer orders dataset.
*/

-- Create the database if it does not already exist
CREATE DATABASE IF NOT EXISTS customer_orders_project;

-- Select the database
USE customer_orders_project;

-- Remove the raw table if it already exists
-- This allows the script to be run again during development
DROP TABLE IF EXISTS raw_customer_orders;

-- Create the raw data table
CREATE TABLE raw_customer_orders (
    order_id VARCHAR(20),
    customer_name VARCHAR(100),
    email VARCHAR(150),
    city VARCHAR(100),
    order_date VARCHAR(50),
    product VARCHAR(100),
    quantity VARCHAR(20),
    unit_price VARCHAR(30),
    payment_status VARCHAR(50)
);
