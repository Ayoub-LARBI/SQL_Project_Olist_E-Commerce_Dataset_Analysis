-- =====================================================
-- 02_REVENUE_ANALYSIS.SQL
-- Revenue Performance Analysis
-- =====================================================

-- =====================================================
-- Question 1:
-- What is the total revenue generated?
-- =====================================================

SELECT
    ROUND(SUM(payment_value), 0) AS total_revenue
FROM order_payments;


-- =====================================================
-- Question 2:
-- How many orders generated revenue?
-- =====================================================

SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM order_payments;


-- =====================================================
-- Question 3:
-- What is the average revenue per order?
-- =====================================================

SELECT
    ROUND(
        SUM(payment_value) /
        COUNT(DISTINCT order_id),
        0
    ) AS avg_order_value
FROM order_payments;


-- =====================================================
-- Question 4:
-- How has revenue changed by year?
-- =====================================================

SELECT
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
    ROUND(SUM(p.payment_value),0) AS revenue
FROM orders o
JOIN order_payments p
    ON o.order_id = p.order_id
GROUP BY year
ORDER BY year;


-- =====================================================
-- Question 5:
-- How has revenue changed month by month?
-- =====================================================

SELECT
    TO_CHAR(DATE_TRUNC('month', o.order_purchase_timestamp), 'YYYY-MM-DD')  AS month,
    ROUND(SUM(p.payment_value),0) AS revenue
FROM orders o
JOIN order_payments p
    ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;


-- =====================================================
-- Question 6:
-- Top 10 months by revenue
-- =====================================================

SELECT
   TO_CHAR(DATE_TRUNC('month', o.order_purchase_timestamp), 'YYYY-MM-DD') AS month,
    ROUND(SUM(p.payment_value),0) AS revenue
FROM orders o
JOIN order_payments p
    ON o.order_id = p.order_id
GROUP BY month
ORDER BY revenue DESC
LIMIT 10;


-- =====================================================
-- Question 7:
-- Revenue by order status
-- =====================================================

SELECT
    o.order_status,
    ROUND(SUM(p.payment_value),0) AS revenue
FROM orders o
JOIN order_payments p
    ON o.order_id = p.order_id
GROUP BY o.order_status
ORDER BY revenue DESC;


-- =====================================================
-- Question 8:
-- Monthly order volume
-- =====================================================

SELECT
    TO_CHAR(DATE_TRUNC('month', order_purchase_timestamp), 'YYYY-MM-DD') AS month,
    COUNT(*) AS orders
FROM orders
GROUP BY month
ORDER BY month;


-- =====================================================
-- Question 9:
-- Running cumulative revenue over time
-- Demonstrates window functions
-- =====================================================

WITH monthly_revenue AS (
    SELECT
        TO_CHAR(DATE_TRUNC('month', o.order_purchase_timestamp), 'YYYY-MM-DD')  AS month,
        ROUND(SUM(p.payment_value),0) AS revenue
    FROM orders o
    JOIN order_payments p
        ON o.order_id = p.order_id
    GROUP BY month
)

SELECT
    month,
    revenue,
    SUM(revenue) OVER (
        ORDER BY month
    ) AS cumulative_revenue
FROM monthly_revenue
ORDER BY month;