-- =====================================================
-- OLIST E-COMMERCE DATABASE SCHEMA
-- =====================================================

DROP TABLE IF EXISTS order_payments CASCADE;
DROP TABLE IF EXISTS order_reviews CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS sellers CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS geolocation CASCADE;
DROP TABLE IF EXISTS product_category_name_translation CASCADE;

-- =====================================================
-- CUSTOMERS
-- =====================================================

CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

-- =====================================================
-- SELLERS
-- =====================================================

CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

-- =====================================================
-- PRODUCTS
-- =====================================================

CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g NUMERIC,
    product_length_cm NUMERIC,
    product_height_cm NUMERIC,
    product_width_cm NUMERIC
);

-- =====================================================
-- PRODUCT CATEGORY TRANSLATION
-- =====================================================

CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);

-- =====================================================
-- ORDERS
-- =====================================================

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),

    order_status VARCHAR(30),

    order_purchase_timestamp TIMESTAMP,

    order_approved_at TIMESTAMP,

    order_delivered_carrier_date TIMESTAMP,

    order_delivered_customer_date TIMESTAMP,

    order_estimated_delivery_date TIMESTAMP,

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- =====================================================
-- ORDER ITEMS
-- =====================================================

CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),

    shipping_limit_date TIMESTAMP,

    price NUMERIC(10,2),

    freight_value NUMERIC(10,2),

    PRIMARY KEY(order_id, order_item_id),

    CONSTRAINT fk_order_items_order
        FOREIGN KEY(order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_order_items_product
        FOREIGN KEY(product_id)
        REFERENCES products(product_id),

    CONSTRAINT fk_order_items_seller
        FOREIGN KEY(seller_id)
        REFERENCES sellers(seller_id)
);

-- =====================================================
-- ORDER PAYMENTS
-- =====================================================

CREATE TABLE order_payments (
    order_id VARCHAR(50),

    payment_sequential INT,

    payment_type VARCHAR(50),

    payment_installments INT,

    payment_value NUMERIC(10,2),

    PRIMARY KEY(order_id, payment_sequential),

    CONSTRAINT fk_payments_order
        FOREIGN KEY(order_id)
        REFERENCES orders(order_id)
);

-- =====================================================
-- ORDER REVIEWS
-- =====================================================

CREATE TABLE order_reviews (
    review_id VARCHAR(50),

    order_id VARCHAR(50),

    review_score INT,

    review_comment_title TEXT,

    review_comment_message TEXT,

    review_creation_date TIMESTAMP,

    review_answer_timestamp TIMESTAMP,

    PRIMARY KEY(review_id, order_id),

    CONSTRAINT fk_reviews_order
        FOREIGN KEY(order_id)
        REFERENCES orders(order_id)
);

-- =====================================================
-- GEOLOCATION
-- =====================================================

CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT,

    geolocation_lat NUMERIC(12,8),

    geolocation_lng NUMERIC(12,8),

    geolocation_city VARCHAR(100),

    geolocation_state VARCHAR(10)
);

ALTER TABLE customers OWNER TO postgres;
ALTER TABLE sellers OWNER TO postgres;
ALTER TABLE products OWNER TO postgres;
ALTER TABLE product_category_name_translation OWNER TO postgres;
ALTER TABLE orders OWNER TO postgres;
ALTER TABLE order_items OWNER TO postgres;
ALTER TABLE order_payments OWNER TO postgres;
ALTER TABLE order_reviews OWNER TO postgres;
ALTER TABLE geolocation OWNER TO postgres;

-- =====================================================
-- USEFUL INDEXES
-- =====================================================

CREATE INDEX idx_orders_customer
ON orders(customer_id);

CREATE INDEX idx_order_items_product
ON order_items(product_id);

CREATE INDEX idx_order_items_seller
ON order_items(seller_id);

CREATE INDEX idx_payments_order
ON order_payments(order_id);

CREATE INDEX idx_reviews_order
ON order_reviews(order_id);

CREATE INDEX idx_products_category
ON products(product_category_name);

copy customers
FROM 'D:\SQL_Project_Olist_E-Commerce_Dataset_Analysis\csv_files\olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;

copy sellers
FROM 'D:\SQL_Project_Olist_E-Commerce_Dataset_Analysis\csv_files\olist_sellers_dataset.csv'
DELIMITER ','
CSV HEADER;

copy products
FROM 'D:\SQL_Project_Olist_E-Commerce_Dataset_Analysis\csv_files\olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;

copy product_category_name_translation
FROM 'D:\SQL_Project_Olist_E-Commerce_Dataset_Analysis\csv_files\product_category_name_translation.csv'
DELIMITER ','
CSV HEADER;

copy orders
FROM 'D:\SQL_Project_Olist_E-Commerce_Dataset_Analysis\csv_files\olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

copy order_items
FROM 'D:\SQL_Project_Olist_E-Commerce_Dataset_Analysis\csv_files\olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

copy order_payments
FROM 'D:\SQL_Project_Olist_E-Commerce_Dataset_Analysis\csv_files\olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

copy order_reviews
FROM 'D:\SQL_Project_Olist_E-Commerce_Dataset_Analysis\csv_files\olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;

copy geolocation
FROM 'D:\SQL_Project_Olist_E-Commerce_Dataset_Analysis\csv_files\olist_geolocation_dataset.csv'
DELIMITER ','
CSV HEADER;

