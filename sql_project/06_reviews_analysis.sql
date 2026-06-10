-- =====================================================
-- 06_REVIEWS_ANALYSIS.SQL
-- Customer Satisfaction Analysis
-- =====================================================

-- =====================================================
-- Question 1:
-- Review score distribution
-- =====================================================

SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;


-- =====================================================
-- Question 2:
-- Average review score
-- =====================================================

SELECT
    ROUND(AVG(review_score), 2) AS avg_review_score
FROM order_reviews;


-- =====================================================
-- Question 3:
-- Average review score by order status
-- =====================================================

SELECT
    o.order_status,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    COUNT(*) AS reviews
FROM orders o
JOIN order_reviews r
    ON o.order_id = r.order_id
GROUP BY o.order_status
ORDER BY avg_review_score DESC;


-- =====================================================
-- Question 4:
-- Review score by product category
-- =====================================================

SELECT
    COALESCE(t.product_category_name_english,
             p.product_category_name) AS category,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    COUNT(*) AS reviews
FROM order_reviews r
JOIN orders o
    ON r.order_id = o.order_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
GROUP BY category
HAVING COUNT(*) >= 50
ORDER BY avg_review_score DESC
LIMIT 20;


-- =====================================================
-- Question 5:
-- Lowest-rated categories
-- =====================================================

SELECT
    COALESCE(t.product_category_name_english,
             p.product_category_name) AS category,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    COUNT(*) AS reviews
FROM order_reviews r
JOIN orders o
    ON r.order_id = o.order_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
GROUP BY category
HAVING COUNT(*) >= 50
ORDER BY avg_review_score ASC
LIMIT 20;


-- =====================================================
-- Question 6:
-- Reviews containing written comments
-- =====================================================

SELECT
    COUNT(*) AS total_reviews,
    COUNT(review_comment_message) AS reviews_with_comments,
    ROUND(
        COUNT(review_comment_message) * 100.0 /
        COUNT(*),
        2
    ) AS comment_percentage
FROM order_reviews;


-- =====================================================
-- Question 7:
-- Monthly review trends
-- =====================================================

SELECT
    TO_CHAR(DATE_TRUNC('month', review_creation_date), 'YYYY-MM-DD') AS month,
    ROUND(AVG(review_score), 2) AS avg_review_score,
    COUNT(*) AS reviews
FROM order_reviews
GROUP BY month
ORDER BY month;


-- =====================================================
-- Question 8:
-- Review score and delivery performance
-- =====================================================

SELECT
    CASE
        WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date
            THEN 'On Time'
        ELSE 'Late'
    END AS delivery_status,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    COUNT(*) AS reviews
FROM orders o
JOIN order_reviews r
    ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status;


-- =====================================================
-- Question 9:
-- Review score distribution (%)
-- =====================================================

SELECT
    review_score,
    COUNT(*) AS reviews,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;


-- =====================================================
-- Question 10:
-- Monthly customer satisfaction trend
-- =====================================================

WITH monthly_reviews AS (
    SELECT
        TO_CHAR(DATE_TRUNC('month', review_creation_date),'YYYY-MM-DD') AS month,
        AVG(review_score) AS avg_score
    FROM order_reviews
    GROUP BY month
)

SELECT
    month,
    ROUND(avg_score, 2) AS avg_review_score,
    ROUND(
        AVG(avg_score) OVER (
            ORDER BY month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS rolling_3_month_avg
FROM monthly_reviews
ORDER BY month;