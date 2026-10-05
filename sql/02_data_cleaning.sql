-- =========================================
-- E-commerce Sales Analysis
-- 02. Data Cleaning
-- =========================================

-- Select database
USE ecommerce_analysis;

/*
=========================================
Data Cleaning Decisions
=========================================

Missing Customer IDs: Keep
- Keep these rows because they can still be used
  for sales analysis.

Cancelled Transactions: Exclude
- Exclude cancelled transactions from regular sales analysis.
- Cancelled transactions are identified by invoice numbers
  starting with 'C'.

Negative Quantities: Keep unitprice = 0
- Negative quantities with invoice numbers starting with 'C'
  are treated as cancelled transactions.
- The remaining 1,336 rows have a unit price of zero.
- Keep these rows because they contribute zero revenue
  to the sales analysis.
  
Zero-price Rows: Keep
- 2,519 rows have a unit price of zero.
- Keep these rows because a zero unit price
  does not contribute to sales revenue.
    
Negative-price Rows: Exclude
- The two negative-price rows are labelled 'Adjust bad debt'.
- Exclude these rows from regular sales analysis.

Duplicate Records


*/


-- =========================================
-- Create Cleaning Table
-- =========================================

-- Create a separate table for data cleaning
CREATE TABLE online_retail_clean
LIKE online_retail;


-- Copy the original data
INSERT INTO online_retail_clean
SELECT *
FROM online_retail;


-- Check row counts
SELECT COUNT(*) AS original_rows
FROM online_retail;

SELECT COUNT(*) AS clean_table_rows
FROM online_retail_clean;


-- =========================================
-- 1. Cancelled Transactions
-- =========================================

-- Remove cancelled transactions
DELETE FROM online_retail_clean
WHERE invoiceno LIKE 'C%';


-- Verify that cancelled transactions were removed
SELECT COUNT(*) AS cancelled_rows_remaining
FROM online_retail_clean
WHERE invoiceno LIKE 'C%';


-- Check remaining rows
SELECT COUNT(*) AS clean_table_rows
FROM online_retail_clean;


-- =========================================
-- 2. Negative Quantities
-- =========================================

-- Check remaining negative quantities
SELECT COUNT(*) AS negative_quantity_rows
FROM online_retail_clean
WHERE quantity < 0;


-- Inspect negative quantity rows
SELECT *
FROM online_retail_clean
WHERE quantity < 0
LIMIT 10;


-- =========================================
-- 3. Zero-price rows
-- =========================================

-- Inspect zero-price rows
SELECT *
FROM online_retail_clean
WHERE unitprice = 0
LIMIT 10;


-- =========================================
-- 4. Negative-price rows
-- =========================================

-- Inspect negative-price rows
SELECT *
FROM online_retail_clean
WHERE unitprice < 0;


-- Remove negative-price rows
DELETE FROM online_retail_clean
WHERE unitprice < 0;


-- Verify that negative-price rows were removed
SELECT COUNT(*) AS negative_price_rows
FROM online_retail_clean
WHERE unitprice < 0;


-- =========================================
-- 5. Duplicate Records
-- =========================================

-- Identify duplicate groups
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
    FROM online_retail_clean
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
) AS duplicates; -- 4,847 duplicate groups


-- Calculate extra duplicate rows
SELECT SUM(duplicate_count - 1) AS extra_duplicate_rows
FROM (
    SELECT COUNT(*) AS duplicate_count
    FROM online_retail_clean
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
) AS duplicates; -- 5,231 extra duplicate rows


/*
=========================================
Duplicate Records Summary
=========================================

Current rows: 532,619
Duplicate groups: 4,847
Extra duplicate rows: 5,231

Duplicate Records are exact matches across
all columns and are removed using DISTINCT.
*/


-- Count rows after removing duplicate records
SELECT COUNT(*) AS deduplicated_rows
FROM (
    SELECT DISTINCT *
    FROM online_retail_clean
) AS deduplicated; -- 527,388


-- Create the deduplicated table
CREATE TABLE online_retail_deduplicated AS
SELECT DISTINCT *
FROM online_retail_clean;


/*
=========================================
Row Count Check
=========================================

Original rows: 541,909
Cancelled Transactions removed: 9,288
Negative-price Rows removed: 2
Rows before deduplication: 532,619
Extra Duplicate Rows removed: 5,231
Final rows: 527,388
*/


-- Check row counts
SELECT COUNT(*) AS original_rows
FROM online_retail; -- 541,909

SELECT COUNT(*) AS clean_table_rows
FROM online_retail_clean; -- 532,619

SELECT COUNT(*) AS deduplicated_table_rows
FROM online_retail_deduplicated; -- 527,388
