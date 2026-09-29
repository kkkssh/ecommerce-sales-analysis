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


-- 4. Check missing values
SELECT
    COUNT(*) AS total_rows,
    SUM(invoiceno IS NULL) AS missing_invoice_no,
	SUM(quantity IS NULL) AS missing_quantity,
    SUM(customerid IS NULL) AS missing_customer_id,
    SUM(description IS NULL) AS missing_description,
    SUM(stockcode IS NULL) AS missing_stockcode,
    SUM(invoicedate IS NULL) AS missing_invoice_date,
    SUM(unitprice IS NULL) AS missing_unit_price,
    SUM(country IS NULL) AS missing_country
FROM online_retail;


-- 5. Check cancelled transactions
SELECT COUNT(*) AS cancelled_rows
FROM online_retail
WHERE invoiceno LIKE 'C%';

-- Inspect cancelled transactions
SELECT *
FROM online_retail
WHERE invoiceno LIKE 'C%'
LIMIT 10;


-- 6. Check negative quantities
SELECT COUNT(*) AS negative_quantity_rows
FROM online_retail
WHERE quantity < 0;

-- Inspect negative quantity records
SELECT *
FROM online_retail
WHERE quantity < 0
LIMIT 10;


-- 7. Check non-positive prices
SELECT COUNT(*) AS non_positive_price_rows
FROM online_retail
WHERE unitprice <= 0;

-- Inspect non-positive price records
SELECT *
FROM online_retail
WHERE unitprice <= 0
LIMIT 10;


-- 8. Check duplicate rows
SELECT
    invoiceno,
    stockcode,
    description,
    quantity,
    invoicedate,
    unitprice,
    customerid,
    country,
    COUNT(*) AS duplicate_count
FROM online_retail
GROUP BY
    invoiceno,
    stockcode,
    description,
    quantity,
    invoicedate,
    unitprice,
    customerid,
    country
HAVING COUNT(*) > 1;


