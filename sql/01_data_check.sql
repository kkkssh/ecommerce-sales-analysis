-- Select database
USE ecommerce_analysis;


-- 1. Check total number of rows
SELECT COUNT(*) AS total_rows
FROM online_retail;


-- 2. Check sample data
SELECT *
FROM online_retail
LIMIT 10;


-- 3. Check the date range
SELECT
    MIN(invoicedate) AS first_date,
    MAX(invoicedate) AS last_date
FROM online_retail;


