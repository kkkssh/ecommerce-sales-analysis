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

