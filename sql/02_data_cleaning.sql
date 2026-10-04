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

Missing Customer IDs:
- Keep these rows because they can still be used
  for sales analysis.

Cancelled Transactions:
- Exclude cancelled transactions from regular sales analysis.
- Cancelled transactions are identified by invoice numbers
  starting with 'C'.

Negative Quantities:
- Negative quantities with invoice numbers starting with 'C'
  are treated as cancelled transactions.
- 1,336 negative-quantity rows do not have cancellation
  invoice numbers and have a unit price of zero.
- These rows require further investigation before deciding
  whether to exclude them.

*/

-- Create a separate table for data cleaning
CREATE TABLE online_retail_clean
LIKE online_retail;

-- Copy the original data
INSERT INTO online_retail_clean
SELECT *
FROM online_retail;

-- Check the tables
SELECT COUNT(*) AS original_rows
FROM online_retail;

SELECT COUNT(*) AS clean_table_rows
FROM online_retail_clean;



