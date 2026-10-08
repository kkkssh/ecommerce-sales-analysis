-- =========================================
-- E-commerce Sales Analysis
-- 05. Advanced Analysis
-- =========================================

USE ecommerce_analysis;


-- =========================================
-- 1. Customer Segmentation
-- =========================================

-- Create a customer-level summary using a CTE
-- and classify customers by Revenue using CASE WHEN.

WITH customer_summary AS (
    SELECT
        customerid,
        SUM(quantity * unitprice) AS revenue,
        COUNT(DISTINCT invoiceno) AS number_of_orders
    FROM online_retail_deduplicated
    WHERE customerid IS NOT NULL
    GROUP BY customerid
)
SELECT
    customerid,
    revenue,
    number_of_orders,
    CASE
        WHEN revenue >= 10000 THEN 'High Value'
        WHEN revenue >= 5000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_summary;


-- =========================================
-- 2. Customer Segment Distribution
-- =========================================

-- Use a subquery to count customers in each segment.

WITH customer_summary AS (
    SELECT
        customerid,
        SUM(quantity * unitprice) AS revenue,
        COUNT(DISTINCT invoiceno) AS number_of_orders
    FROM online_retail_deduplicated
    WHERE customerid IS NOT NULL
    GROUP BY customerid
)
SELECT
    customer_segment,
    COUNT(customerid) AS number_of_customers
FROM (
    SELECT
        customerid,
        revenue,
        number_of_orders,
        CASE
            WHEN revenue >= 10000 THEN 'High Value'
            WHEN revenue >= 5000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM customer_summary
) AS customer_segments
GROUP BY customer_segment
ORDER BY number_of_customers DESC;





