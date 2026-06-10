-- =====================================================
-- 01_EXPLORATION.SQL
-- Dataset Familiarization & Data Quality Checks
-- =====================================================

-- =====================================================
-- Table Sizes
-- =====================================================

SELECT 'customers' AS table_name, COUNT(*) AS row_count
FROM customers

UNION ALL

SELECT 'orders', COUNT(*)
FROM orders

UNION ALL

SELECT 'order_items', COUNT(*)
FROM order_items

UNION ALL

SELECT 'products', COUNT(*)
FROM products

UNION ALL

SELECT 'sellers', COUNT(*)
FROM sellers

UNION ALL

SELECT 'order_payments', COUNT(*)
FROM order_payments

UNION ALL

SELECT 'order_reviews', COUNT(*)
FROM order_reviews

UNION ALL

SELECT 'geolocation', COUNT(*)
FROM geolocation;


-- =====================================================
-- Explore Orders Status
-- =====================================================

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- =====================================================
-- Purchase Date Range
-- =====================================================

SELECT
    MIN(order_purchase_timestamp) AS first_order,
    MAX(order_purchase_timestamp) AS last_order
FROM orders;


-- =====================================================
-- Number of Customers
-- =====================================================

SELECT
    COUNT(DISTINCT customer_id) AS customers
FROM customers;


-- =====================================================
-- Number of Sellers
-- =====================================================

SELECT
    COUNT(DISTINCT seller_id) AS sellers
FROM sellers;


-- =====================================================
-- Product Categories
-- =====================================================

SELECT
    COUNT(DISTINCT product_category_name) AS categories
FROM products;


-- =====================================================
-- Top 10 States by Customer Count
-- =====================================================

SELECT
    customer_state,
    COUNT(*) AS customers
FROM customers
GROUP BY customer_state
ORDER BY customers DESC
LIMIT 10;


-- =====================================================
-- Top 10 States by Seller Count
-- =====================================================

SELECT
    seller_state,
    COUNT(*) AS sellers
FROM sellers
GROUP BY seller_state
ORDER BY sellers DESC
LIMIT 10;


-- =====================================================
-- Missing Values Check
-- =====================================================

SELECT
    COUNT(*) AS total_products,
    COUNT(product_category_name) AS category_present
FROM products;


SELECT
    COUNT(*) AS total_reviews,
    COUNT(review_comment_message) AS reviews_with_comments
FROM order_reviews;


-- =====================================================
-- Average Review Score
-- =====================================================

SELECT
    ROUND(AVG(review_score),2) AS avg_review_score
FROM order_reviews;


-- =====================================================
-- Payment Types
-- =====================================================

SELECT
    payment_type,
    COUNT(*) AS total_payments
FROM order_payments
GROUP BY payment_type
ORDER BY total_payments DESC;


-- =====================================================
-- Average Order Value
-- =====================================================

SELECT
    ROUND(AVG(payment_value),2) AS avg_payment_value
FROM order_payments;