-- =========================================
-- E-commerce Sales Analysis
-- 01. Data Check
-- =========================================

-- Select database
USE ecommerce_analysis;


-- =========================================
-- 1. Check Total Number of Rows
-- =========================================

SELECT COUNT(*) AS total_rows
FROM online_retail;


-- =========================================
-- 2. Check Sample Data
-- =========================================

SELECT *
FROM online_retail
LIMIT 10;


-- =========================================
-- 3. Check Date Range
-- =========================================

SELECT
    MIN(invoicedate) AS first_date,
    MAX(invoicedate) AS last_date
FROM online_retail;


-- =========================================
-- 4. Check Missing Values
-- =========================================

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


-- =========================================
-- 5. Check Cancelled Transactions
-- =========================================

SELECT COUNT(*) AS cancelled_rows
FROM online_retail
WHERE invoiceno LIKE 'C%';


-- Inspect cancelled transactions
SELECT *
FROM online_retail
WHERE invoiceno LIKE 'C%'
LIMIT 10;


-- =========================================
-- 6. Check Negative Quantities
-- =========================================

SELECT COUNT(*) AS negative_quantity_rows
FROM online_retail
WHERE quantity < 0;


-- Inspect negative quantity records
SELECT *
FROM online_retail
WHERE quantity < 0
LIMIT 10;


-- =========================================
-- 7. Check Non-positive Prices
-- =========================================

SELECT
    SUM(unitprice = 0) AS zero_price_rows,
    SUM(unitprice < 0) AS negative_price_rows
FROM online_retail;


-- Inspect zero-price records
SELECT *
FROM online_retail
WHERE unitprice = 0
LIMIT 10;


-- Inspect negative-price records
SELECT *
FROM online_retail
WHERE unitprice < 0;


-- =========================================
-- 8. Check Duplicate Rows
-- =========================================

-- Purpose:
-- Identify identical rows and measure the extent of duplication.
-- Use the results to inform data cleaning decisions.


-- Purpose:
-- Find rows where all column values are identical.
-- Why:
-- Check whether the dataset contains duplicate records.

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


-- Purpose:
-- Count the number of duplicate groups.
-- Why:
-- See how many groups contain identical rows.

SELECT COUNT(*) AS duplicate_groups
FROM (
    SELECT
        invoiceno,
        stockcode,
        description,
        quantity,
        invoicedate,
        unitprice,
        customerid,
        country
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
    HAVING COUNT(*) > 1
) AS duplicates;


-- Purpose:
-- Count all rows belonging to duplicate groups.
-- Why:
-- See how many records are affected by duplicates.

SELECT SUM(duplicate_count) AS total_rows_in_duplicate_groups
FROM (
    SELECT COUNT(*) AS duplicate_count
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
    HAVING COUNT(*) > 1
) AS duplicates;


-- Purpose:
-- Count the extra rows beyond the first occurrence
-- in each duplicate group.
-- Why:
-- Count the extra rows in each duplicate group, 
-- keeping one row per group.

SELECT SUM(duplicate_count - 1) AS extra_duplicate_rows
FROM (
    SELECT COUNT(*) AS duplicate_count
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
    HAVING COUNT(*) > 1
) AS duplicates;


-- Purpose:
-- Count duplicate groups that appear at least three times.
-- Why:
-- Find groups that appear more than twice.

SELECT COUNT(*) AS duplicate_groups_over_2
FROM (
    SELECT
        invoiceno,
        stockcode,
        description,
        quantity,
        invoicedate,
        unitprice,
        customerid,
        country
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
    HAVING COUNT(*) > 2
) AS duplicates;


-- Purpose:
-- Display duplicate groups that appear at least three times.
-- Why:
-- Check the details of groups that appear more than twice.

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
HAVING COUNT(*) > 2;


-- Purpose:
-- Count duplicate groups by their repetition frequency.
-- Why:
-- See how often each duplicate group appears.

SELECT
    duplicate_count,
    COUNT(*) AS group_count
FROM (
    SELECT COUNT(*) AS duplicate_count
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
    HAVING COUNT(*) > 1
) AS duplicates
GROUP BY duplicate_count
ORDER BY duplicate_count;


-- =========================================
-- 9. Investigate Negative Quantities and Cancellations
-- =========================================

-- Purpose:
-- Check whether negative quantity rows are associated
-- with cancellation invoice numbers starting with 'C'.

SELECT
    SUM(quantity < 0 AND invoiceno LIKE 'C%')
        AS negative_qty_cancelled_rows,
    SUM(quantity < 0 AND invoiceno NOT LIKE 'C%')
        AS negative_qty_non_cancelled_rows
FROM online_retail;

-- Result:
-- 9,288 rows have negative quantities and invoice numbers
-- starting with 'C'.
-- 1,336 rows have negative quantities but invoice numbers
-- that do not start with 'C'.


-- Inspect negative quantity rows without cancellation invoice numbers
SELECT *
FROM online_retail
WHERE quantity < 0
    AND invoiceno NOT LIKE 'C%'
LIMIT 10;


-- Check negative quantity rows without cancellation invoice numbers
-- that also have zero prices
SELECT
    SUM(
        quantity < 0
        AND invoiceno NOT LIKE 'C%'
        AND unitprice = 0
    ) AS negative_qty_non_cancelled_zero_price_rows
FROM online_retail;

-- Result:
-- All 1,336 negative quantity rows without cancellation
-- invoice numbers have a unit price of zero.


-- =========================================
-- 10. Investigate Zero and Negative Unit Prices
-- =========================================

-- Count rows with zero or negative unit prices
SELECT
    SUM(unitprice = 0) AS zero_price_rows,
    SUM(unitprice < 0) AS negative_price_rows
FROM online_retail;

-- Result:
-- 2,519 rows have zero unit prices.
-- 2 rows have negative unit prices.


-- Inspect rows with zero unit prices
SELECT *
FROM online_retail
WHERE unitprice = 0
LIMIT 10;


-- Inspect rows with negative unit prices
SELECT *
FROM online_retail
WHERE unitprice < 0;

-- Result:
-- Both negative-price records have the description
-- 'Adjust bad debt', stock code 'B', and a unit price
-- of -11,062.06.




