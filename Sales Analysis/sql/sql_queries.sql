-- ==========================================
-- SALES ANALYSIS PROJECT - SQL QUERIES
-- ==========================================

USE sales_analysis;

-- ==========================================
-- 1. Total Number of Rows
-- ==========================================

SELECT COUNT(*) AS total_rows
FROM orders;

-- ==========================================
-- 2. Total Revenue
-- ==========================================

SELECT ROUND(SUM(sales), 2) AS total_revenue
FROM orders;

-- ==========================================
-- 3. Total Profit
-- ==========================================

SELECT ROUND(SUM(profit), 2) AS total_profit
FROM orders;

-- ==========================================
-- 4. Total Unique Orders
-- ==========================================

SELECT COUNT(DISTINCT `Order ID`) AS total_orders
FROM orders;

-- ==========================================
-- 5. Total Unique Customers
-- ==========================================

SELECT COUNT(DISTINCT `Customer ID`) AS total_customers
FROM orders;

-- ==========================================
-- 6. Sales by Region
-- ==========================================

SELECT
    Region,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY Region
ORDER BY total_sales DESC;

-- ==========================================
-- 7. Profit by Category
-- ==========================================

SELECT
    Category,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY Category
ORDER BY total_profit DESC;

-- ==========================================
-- 8. Top 10 Customers by Sales
-- ==========================================

SELECT
    `Customer Name`,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;

-- ==========================================
-- 9. Top 10 Products by Sales
-- ==========================================

SELECT
    `Product Name`,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 10;

-- ==========================================
-- 10. Monthly Sales Trend
-- ==========================================

SELECT
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS sales_year,
    MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS sales_month,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY sales_year, sales_month
ORDER BY sales_year, sales_month;

-- ==========================================
-- 11. Sales by Sub-Category
-- ==========================================

SELECT
    `Sub-Category`,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY `Sub-Category`
ORDER BY total_sales DESC;

-- ==========================================
-- 12. Average Discount by Category
-- ==========================================

SELECT
    Category,
    ROUND(AVG(discount), 2) AS average_discount
FROM orders
GROUP BY Category
ORDER BY average_discount DESC;