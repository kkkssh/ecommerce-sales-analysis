-- =========================================
-- E-commerce Sales Analysis
-- 04. Customer Analysis
-- =========================================

-- Select database
USE ecommerce_analysis;


-- 1. Customer Overview
-- 2. Customer Revenue
-- 3. Customer Purchase Frequency
-- 4. Top 5 Customers by Revenue
-- 5. Repeat Customers


-- =========================================
-- 1. Customer Overview
-- =========================================

SELECT
    COUNT(DISTINCT customerid) AS number_of_customers
FROM online_retail_deduplicated
WHERE customerid IS NOT NULL;

-- Number of Customers: 4,339


-- =========================================
-- 2. Customer Revenue
-- =========================================

SELECT
    customerid,
    SUM(quantity * unitprice) AS revenue
FROM online_retail_deduplicated
WHERE customerid IS NOT NULL
GROUP BY
    customerid
ORDER BY
    revenue DESC;


-- =========================================
-- 3. Customer Purchase Frequency
-- =========================================

SELECT
    customerid,
    COUNT(DISTINCT invoiceno) AS number_of_orders
FROM online_retail_deduplicated
WHERE customerid IS NOT NULL
GROUP BY
    customerid
ORDER BY
    number_of_orders DESC;


-- =========================================
-- 4. Top 5 Customers by Revenue
-- =========================================

SELECT
    customerid,
    SUM(quantity * unitprice) AS revenue
FROM online_retail_deduplicated
WHERE customerid IS NOT NULL
GROUP BY
    customerid
ORDER BY
    revenue DESC
LIMIT 5;

-- Customer 14646 - £280,206.02
-- Customer 18102 - £259,657.30
-- Customer 17450 - £194,390.79
-- Customer 16446 - £168,472.50
-- Customer 14911 - £143,711.17


-- =========================================
-- 5. Repeat Customers
-- =========================================

SELECT
    COUNT(*) AS repeat_customers
FROM (
	SELECT
	    customerid,
	    COUNT(DISTINCT invoiceno) AS number_of_orders
	FROM online_retail_deduplicated
	WHERE customerid IS NOT NULL
	GROUP BY
	    customerid
	HAVING number_of_orders > 1
) AS repeat_customer_list;

-- Total Customers: 4,339
-- Repeat Customers: 2,845
-- One-time Customers: 1,494




