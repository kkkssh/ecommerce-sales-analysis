-- =========================================
-- E-commerce Sales Analysis
-- 03. Sales Analysis
-- =========================================

-- Select database
USE ecommerce_analysis;


-- Monthly Sales Trend
-- Sales by Country
-- Top Products
-- Customer Purchasing Behaviour


-- =========================================
-- 1. Monthly Sales Trend
-- =========================================

-- Monthly Revenue
SELECT
    YEAR(invoicedate) AS year,
    MONTH(invoicedate) AS month,
    SUM(quantity * unitprice) AS revenue
FROM online_retail_deduplicated
GROUP BY
    YEAR(invoicedate),
    MONTH(invoicedate)
ORDER BY
    year,
    month;

-- Highest Revenue: November 2011 - £1,503,866.78
-- Lowest Revenue: February 2011 - £522,545.56
-- Revenue was generally higher in the second half of 2011.
-- November 2011 had the highest monthly revenue.


-- Monthly Sales Quantity
SELECT
    YEAR(invoicedate) AS year,
    MONTH(invoicedate) AS month,
    SUM(quantity) AS sales_quantity
FROM online_retail_deduplicated
GROUP BY
    YEAR(invoicedate),
    MONTH(invoicedate)
ORDER BY
    year,
    month;

-- Highest Sales Quantity: November 2011 - 749,777
-- Lowest Sales Quantity: February 2011 - 280,239
-- November 2011 also had the highest sales quantity.


-- Monthly Number of Orders
SELECT
    YEAR(invoicedate) AS year,
    MONTH(invoicedate) AS month,
    COUNT(DISTINCT invoiceno) AS number_of_orders
FROM online_retail_deduplicated
GROUP BY
    YEAR(invoicedate),
    MONTH(invoicedate)
ORDER BY
    year,
    month;

-- Highest Number of Orders: November 2011 - 3,021
-- Lowest Number of Orders: December 2011 - 869
-- November 2011 had the highest number of orders as well.


-- Average Order Value (AOV) = Revenue / Number of Orders
SELECT
    YEAR(invoicedate) AS year,
    MONTH(invoicedate) AS month,
    ROUND(SUM(quantity * unitprice) / COUNT(DISTINCT invoiceno), 2)
    AS average_order_value
FROM online_retail_deduplicated
GROUP BY
    YEAR(invoicedate),
    MONTH(invoicedate)
ORDER BY
    year,
    month;

-- Highest AOV: December 2011 - £733.94
-- Lowest AOV: April 2011 - £357.03
-- November AOV: £497.80
-- November did not have the highest AOV.
-- December 2011 is a partial month, so it should be interpreted with caution.


-- =========================================
-- Monthly Sales Summary
-- =========================================

-- Summary query to compare all monthly sales metrics
SELECT
    YEAR(invoicedate) AS year,
    MONTH(invoicedate) AS month,
    SUM(quantity * unitprice) AS revenue,
    SUM(quantity) AS sales_quantity,
    COUNT(DISTINCT invoiceno) AS number_of_orders,
    ROUND(SUM(quantity * unitprice) / COUNT(DISTINCT invoiceno), 2)
    AS average_order_value
FROM online_retail_deduplicated
GROUP BY
    YEAR(invoicedate),
    MONTH(invoicedate)
ORDER BY
    year,
    month;
