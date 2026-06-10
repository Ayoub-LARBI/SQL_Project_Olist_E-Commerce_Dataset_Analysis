-- =====================================================
-- 04_CUSTOMER_ANALYSIS.SQL
-- Customer Behavior & Value Analysis
-- =====================================================

-- =====================================================
-- Question 1:
-- Which states generate the most revenue?
-- =====================================================

SELECT
    c.customer_state,
    ROUND(SUM(p.payment_value), 0) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC
LIMIT 10;


-- =====================================================
-- Question 2:
-- Which cities generate the most revenue?
-- =====================================================

SELECT
    c.customer_city,
    ROUND(SUM(p.payment_value), 0) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_city
ORDER BY revenue DESC
LIMIT 10;


-- =====================================================
-- Question 3:
-- Which states place the most orders?
-- =====================================================

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC
LIMIT 10;


-- =====================================================
-- Question 4:
-- Average order value by state
-- =====================================================

SELECT
    c.customer_state,
    ROUND(AVG(p.payment_value), 0) AS avg_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_state
HAVING COUNT(*) > 100
ORDER BY avg_order_value DESC
LIMIT 10;


-- =====================================================
-- Question 5:
-- Top 20 customers by spending
-- =====================================================

SELECT
    c.customer_unique_id,
    ROUND(SUM(p.payment_value), 0) AS lifetime_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY lifetime_value DESC
LIMIT 20;


-- =====================================================
-- Question 6:
-- Revenue Contribution by State
-- =====================================================

WITH state_revenue AS (
    SELECT
        c.customer_state,
        SUM(p.payment_value) AS revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_payments p
        ON o.order_id = p.order_id
    GROUP BY c.customer_state
)

SELECT
    customer_state,
    ROUND(revenue, 0) AS revenue,
    ROUND(
        revenue * 100.0 /
        SUM(revenue)  OVER (),
        2
    ) AS revenue_pct
FROM state_revenue
ORDER BY revenue DESC
LIMIT 15;


-- =====================================================
-- Question 7:
-- How many purchases do customers make?
-- =====================================================

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    order_count,
    COUNT(*) AS customers
FROM customer_orders
GROUP BY order_count
ORDER BY order_count;


-- =====================================================
-- Question 8:
-- Repeat Customers vs One-Time Customers
-- =====================================================

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    CASE
        WHEN order_count = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customers
FROM customer_orders
GROUP BY customer_type;


-- =====================================================
-- Question 9:
-- Top States by Customer Count and Revenue
-- =====================================================

SELECT
    c.customer_state,
    COUNT(DISTINCT c.customer_unique_id) AS customers,
    ROUND(SUM(p.payment_value), 0) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC
LIMIT 15;