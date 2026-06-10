-- =====================================================
-- 05_SELLER_ANALYSIS.SQL
-- Seller Performance Analysis
-- =====================================================

-- =====================================================
-- Question 1:
-- Which sellers generate the most revenue?
-- =====================================================

SELECT
    s.seller_id,
    ROUND(SUM(oi.price), 0) AS revenue
FROM sellers s
JOIN order_items oi
    ON s.seller_id = oi.seller_id
GROUP BY s.seller_id
ORDER BY revenue DESC
LIMIT 20;


-- =====================================================
-- Question 2:
-- Which states generate the most seller revenue?
-- =====================================================

SELECT
    s.seller_state,
    ROUND(SUM(oi.price), 0) AS revenue
FROM sellers s
JOIN order_items oi
    ON s.seller_id = oi.seller_id
GROUP BY s.seller_state
ORDER BY revenue DESC;


-- =====================================================
-- Question 3:
-- Which sellers sold the most units?
-- =====================================================

SELECT
    s.seller_id,
    COUNT(*) AS units_sold
FROM sellers s
JOIN order_items oi
    ON s.seller_id = oi.seller_id
GROUP BY s.seller_id
ORDER BY units_sold DESC
LIMIT 20;


-- =====================================================
-- Question 4:
-- Average revenue per seller by state
-- =====================================================

SELECT
    seller_state,
    ROUND(AVG(revenue), 0) AS avg_revenue_per_seller
FROM (
    SELECT
        s.seller_state,
        s.seller_id,
        SUM(oi.price) AS revenue
    FROM sellers s
    JOIN order_items oi
        ON s.seller_id = oi.seller_id
    GROUP BY s.seller_state, s.seller_id
) seller_revenue
GROUP BY seller_state
ORDER BY avg_revenue_per_seller DESC;


-- =====================================================
-- Question 5:
-- Revenue contribution by seller state
-- =====================================================

WITH state_revenue AS (
    SELECT
        s.seller_state,
        SUM(oi.price) AS revenue
    FROM sellers s
    JOIN order_items oi
        ON s.seller_id = oi.seller_id
    GROUP BY s.seller_state
)

SELECT
    seller_state,
    ROUND(revenue, 0) AS revenue,
    ROUND(
        revenue * 100.0 /
        SUM(revenue) OVER (),
        2
    ) AS revenue_pct
FROM state_revenue
ORDER BY revenue DESC;


-- =====================================================
-- Question 6:
-- Seller performance segmentation
-- =====================================================

WITH seller_revenue AS (
    SELECT
        seller_id,
        SUM(price) AS revenue
    FROM order_items
    GROUP BY seller_id
)

SELECT
    CASE
        WHEN revenue >= 100000 THEN 'Top Seller'
        WHEN revenue >= 50000 THEN 'High Performer'
        WHEN revenue >= 10000 THEN 'Medium Performer'
        ELSE 'Small Seller'
    END AS seller_segment,
    COUNT(*) AS sellers
FROM seller_revenue
GROUP BY seller_segment
ORDER BY sellers DESC;


-- =====================================================
-- Question 7:
-- Top seller states by seller count
-- =====================================================

SELECT
    seller_state,
    COUNT(*) AS seller_count
FROM sellers
GROUP BY seller_state
ORDER BY seller_count DESC;