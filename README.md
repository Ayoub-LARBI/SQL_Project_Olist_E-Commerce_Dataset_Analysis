# 📊 Olist E-Commerce SQL Analysis

## 📌 Project Overview

This project analyzes the **Olist Brazilian E-Commerce Dataset** using **PostgreSQL** to answer key business questions related to sales performance, customer behavior, product performance, seller performance, and customer satisfaction.

The objective of this project is to demonstrate practical SQL skills by transforming raw transactional data into actionable business insights through data exploration, aggregations, joins, CTEs, window functions, and KPI analysis.

Check out the SQL queries and the insights here : [project_sql folder](sql_project)

A Power BI dashboard built on these queries is in a separate repository: [Olist Power BI dashboard]([ADD-YOUR-DASHBOARD-REPO-URL](https://github.com/Ayoub-LARBI/PowerBI_Project_Olist_E-Commerce_Dataset_Analysis)).

---
## 🗺️ Database Schema
<img width="1494" height="692" alt="Database Schema" src="https://github.com/user-attachments/assets/86361e72-894b-427d-9a31-2ae2cf61a2e7" />

## 🎯 Business Questions

### 💰 Revenue Analysis

* How much revenue did the marketplace generate?
* How did revenue evolve over time?
* Which months generated the highest sales?
* What is the average order value?

### 📦 Product Analysis

* Which product categories generate the most revenue?
* Which categories sell the most units?
* Which products generate the highest revenue?
* Which categories contribute the most to overall sales?

### 👥 Customer Analysis

* Which states and cities generate the most revenue?
* Who are the highest-value customers?
* What percentage of customers are repeat buyers?
* How is revenue distributed geographically?

### 🏪 Seller Analysis

* Which sellers generate the most revenue?
* Which seller states contribute the most sales?
* How concentrated is seller revenue?
* What does the seller ecosystem look like?

### ⭐ Customer Satisfaction Analysis

* What is the overall customer satisfaction level?
* Which categories receive the highest and lowest ratings?
* How do delivery delays impact customer satisfaction?
* How have review scores changed over time?

---

## 🗂️ Dataset Information

The dataset contains information about:

* 👥 Customers
* 📦 Orders
* 🛒 Order Items
* 💳 Payments
* ⭐ Reviews
* 🏪 Sellers
* 📍 Geolocation Data
* 🏷️ Product Categories

### 📅 Period Covered

September 2016 – October 2018

### 🔗 Dataset Source

https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

---

## 🛠️ Tools Used

* 🐘 PostgreSQL
* 💻 Visual Studio Code
* 🌿 Git
* 📂 GitHub

---

## 📁 Project Structure

```text
📦 SQL_PROJECT_OLIST
│
├── 📁 .vscode
│
├── 📁 csv_files
│   ├── 📄 olist_customers_dataset.csv
│   ├── 📄 olist_geolocation_dataset.csv
│   ├── 📄 olist_order_items_dataset.csv
│   ├── 📄 olist_order_payments_dataset.csv
│   ├── 📄 olist_order_reviews_dataset.csv
│   ├── 📄 olist_orders_dataset.csv
│   ├── 📄 olist_products_dataset.csv
│   ├── 📄 olist_sellers_dataset.csv
│   └── 📄 product_category_name_translation.csv
│
├── 📁 sql_load
│   └── 🗄️ data_load.sql
│
├── 📁 sql_project
│   ├── 🔍 01_exploration.sql
│   ├── 📝 01.5_exploration_notes.md
│   │
│   ├── 💰 02_revenue_analysis.sql
│   ├── 📈 02.5_revenue_insights.md
│   │
│   ├── 📦 03_product_analysis.sql
│   ├── 🏷️ 03.5_product_insights.md
│   │
│   ├── 👥 04_customer_analysis.sql
│   ├── 🧑‍💼 04.5_customer_insights.md
│   │
│   ├── 🏪 05_seller_analysis.sql
│   ├── 🤝 05.5_seller_insights.md
│   │
│   ├── ⭐ 06_reviews_analysis.sql
│   └── 💬 06.5_reviews_insights.md
│
└── 📘 README.md
```

---

## ▶️ How to Run

1. Create a PostgreSQL database and download the CSV files from the Kaggle link above into `csv_files/`.
2. Open `sql_load/data_load.sql`. The `COPY` commands read from absolute paths on the database server, so edit them to match where you saved `csv_files/`, or run them with psql's `\copy` and relative paths.
3. Run `sql_load/data_load.sql` to create and load the tables.
4. Run the scripts in `sql_project/` in order (`01` to `06`). The `.md` file next to each script has its results and insights.

---

## 🧠 SQL Skills Demonstrated

### 🔹 Data Exploration

* Dataset validation
* Data profiling
* Row count analysis
* Missing value checks

### 🔹 Data Analysis

* Joins
* Aggregations
* Filtering
* Grouping

### 🔹 Advanced SQL

* Common Table Expressions (CTEs)
* Window Functions
* Ranking Functions
* Running Totals
* Percentage Calculations

### 🔹 Business Intelligence

* Revenue Analysis
* Customer Segmentation
* Product Performance Analysis
* Seller Performance Analysis
* Customer Satisfaction Analysis

---

## 📊 Key Findings

### 💰 Revenue Insights

* Recorded payments totaled **R$16.0 million** (R$15.4M from delivered orders)
* Revenue grew significantly throughout 2017 and 2018
* November 2017 generated the highest monthly revenue
* Average order value was approximately **R$161**

### 📦 Product Insights

* Health & Beauty generated the highest revenue
* Bed, Bath & Table sold the highest number of units
* Revenue is distributed across multiple categories rather than relying on a single category
* Several categories contribute meaningfully to overall marketplace performance

### 👥 Customer Insights

* São Paulo generated approximately **37% of total revenue**
* **93,099 of 96,096 unique customers (about 97%)** bought only once
* Repeat customers account for a relatively small portion of the customer base
* Revenue is concentrated in Brazil's largest economic regions

### 🏪 Seller Insights

* São Paulo sellers generated over **64% of total seller revenue**
* Most sellers are classified as small sellers
* Revenue is concentrated among a small number of high-performing sellers
* Marketplace supply is heavily dependent on southeastern Brazil

### ⭐ Customer Satisfaction Insights

* Average review score: **4.09 / 5**
* Nearly **58% of reviews are 5-star ratings**
* On-time deliveries average **4.29 stars**
* Late deliveries average only **2.57 stars**
* Late deliveries are associated with much lower ratings (observational data)

---

## 🚀 Business Recommendations

### 📦 Improve Delivery Performance

Late delivery is the factor most strongly associated with low ratings in this analysis.

Focus on:

* Faster fulfillment
* Improved logistics tracking
* Better delivery accuracy

### 🏪 Diversify Seller Network

Reduce dependence on São Paulo by expanding seller acquisition efforts in other Brazilian states.

### 🔄 Increase Customer Retention

Develop strategies to convert one-time buyers into repeat customers through:

* Loyalty programs
* Personalized offers
* Post-purchase engagement

### 📉 Investigate Low-Rated Categories

Focus on improving customer experience in categories such as:

* Office Furniture
* Fashion Categories
* Fixed Telephony

### 📈 Scale Best Practices

Study top-performing sellers and highly rated product categories to identify successful operational practices that can be replicated across the marketplace.

---

## ⚠️ Limitations

* Observational data: findings describe associations, not causes.
* Revenue is not profit: the dataset has no cost data.
* Monthly, yearly and state revenue use `payment_value` across all order statuses (R$16.0M, of which R$15.4M comes from delivered orders). Category, product and seller revenue use item price excluding freight, so those totals are lower.
* Sep and Oct 2018 contain very few orders because the dataset ends in mid-October 2018, and 2016 is sparse. Treat both ends of the time series with caution.
* `customer_id` is unique per order, so customer analysis uses `customer_unique_id`.
* Seller segments (Top, High, Medium, Small) use fixed revenue cut-offs, not statistical groups.

---

## 🎓 What I Learned

Through this project I strengthened my ability to:

* Write complex SQL queries
* Analyze large datasets
* Build business KPIs
* Use CTEs and Window Functions
* Transform raw data into actionable insights
* Present findings in a business-oriented format

---

## 👨‍💻 Author

**Ayoub Larbi**

This project was completed as part of my data analytics portfolio to demonstrate SQL and business analysis skills.
