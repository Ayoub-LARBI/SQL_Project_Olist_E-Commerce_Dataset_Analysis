-- =====================================================
-- 03_PRODUCT_ANALYSIS.SQL
-- Product Performance Analysis
-- =====================================================

-- =====================================================
-- Question 1:
-- Which product categories generate the most revenue?
-- =====================================================

SELECT
    COALESCE(t.product_category_name_english,
             p.product_category_name) AS category,
    ROUND(SUM(oi.price), 0) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
GROUP BY category
ORDER BY revenue DESC
LIMIT 10;


-- =====================================================
-- Question 2:
-- Which product categories sell the most units?
-- =====================================================

SELECT
    COALESCE(t.product_category_name_english,
             p.product_category_name) AS category,
    COUNT(*) AS units_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
GROUP BY category
ORDER BY units_sold DESC
LIMIT 10;


-- =====================================================
-- Question 3:
-- Which product categories have the highest average price?
-- =====================================================

SELECT
    COALESCE(t.product_category_name_english,
             p.product_category_name) AS category,
    ROUND(AVG(oi.price), 0) AS avg_price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
GROUP BY category
HAVING COUNT(*) >= 20
ORDER BY avg_price DESC
LIMIT 10;


-- =====================================================
-- Question 4:
-- Top 10 revenue-generating products
-- =====================================================

SELECT
    oi.product_id,
    ROUND(SUM(oi.price), 0) AS revenue
FROM order_items oi
GROUP BY oi.product_id
ORDER BY revenue DESC
LIMIT 10;


-- =====================================================
-- Question 5:
-- Categories with the most orders
-- =====================================================

SELECT
    COALESCE(t.product_category_name_english,
             p.product_category_name) AS category,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
GROUP BY category
ORDER BY total_orders DESC
LIMIT 10;


-- =====================================================
-- Question 6:
-- Revenue contribution by category (%)
-- =====================================================

WITH category_revenue AS (
    SELECT
        COALESCE(t.product_category_name_english,
                 p.product_category_name) AS category,
        SUM(oi.price) AS revenue
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN product_category_name_translation t
        ON p.product_category_name = t.product_category_name
    GROUP BY category
)

SELECT
    category,
    ROUND(revenue, 0) AS revenue,
    ROUND(
        revenue * 100.0 /
        SUM(revenue) OVER (),
        2
    ) AS revenue_pct
FROM category_revenue
ORDER BY revenue DESC
LIMIT 15;


-- =====================================================
-- Question 7:
-- Top categories by revenue and units sold
-- =====================================================

WITH category_metrics AS (
    SELECT
        COALESCE(t.product_category_name_english,
                 p.product_category_name) AS category,
        ROUND(SUM(oi.price), 0) AS revenue,
        COUNT(*) AS units_sold
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN product_category_name_translation t
        ON p.product_category_name = t.product_category_name
    GROUP BY category
)

SELECT
    category,
    revenue,
    units_sold
FROM category_metrics
ORDER BY revenue DESC
LIMIT 15;


-- =====================================================
-- Question 8:
-- Product revenue ranking (Window Function)
-- =====================================================

WITH product_revenue AS (
    SELECT
        product_id,
        SUM(price) AS revenue
    FROM order_items
    GROUP BY product_id
)

SELECT
    product_id,
    ROUND(revenue, 0) AS revenue,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank
FROM product_revenue
ORDER BY revenue DESC
LIMIT 20;
