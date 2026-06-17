USE sales_analysis;

-- ==========================================
-- CASE WHEN
-- ==========================================

SELECT
    `Order ID`,
    sales,
    CASE
        WHEN sales > 500 THEN 'High Profit'
        WHEN sales BETWEEN 100 AND 500 THEN 'Medium Profit'
        ELSE 'Low Profit'
    END AS order_type
FROM orders;

-- ==========================================
-- CASE WHEN with Aggregation
-- ==========================================

SELECT
    SUM(
        CASE
            WHEN profit > 500 THEN 1
            ELSE 0
        END
    ) AS high_profit_orders,

    SUM(
        CASE
            WHEN profit BETWEEN 100 AND 500 THEN 1
            ELSE 0
        END
    ) AS medium_profit_orders,

    SUM(
        CASE
            WHEN profit < 100 THEN 1
            ELSE 0
        END
    ) AS low_profit_orders

FROM orders;

-- ==========================================
-- Subquery
-- Products with sales greater than average
-- ==========================================

SELECT
    `Product Name`,
    sales
FROM orders
WHERE sales >
(
    SELECT AVG(sales)
    FROM orders
);

-- ==========================================
-- CTE (Common Table Expression)
-- ==========================================

WITH category_sales AS
(
    SELECT
        Category,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY Category
)

SELECT *
FROM category_sales
WHERE total_sales > 700000;

-- ==========================================
-- RANK()
-- ==========================================

SELECT
    `Product Name`,
    SUM(sales) AS total_sales,

    RANK() OVER
    (
        ORDER BY SUM(sales) DESC
    ) AS sales_rank

FROM orders

GROUP BY `Product Name`;

-- ==========================================
-- DENSE_RANK()
-- ==========================================

SELECT
    `Product Name`,
    SUM(sales) AS total_sales,

    DENSE_RANK() OVER
    (
        ORDER BY SUM(sales) DESC
    ) AS dense_sales_rank

FROM orders

GROUP BY `Product Name`;

-- ==========================================
-- ROW_NUMBER()
-- ==========================================

SELECT
    `Product Name`,
    SUM(sales) AS total_sales,

    ROW_NUMBER() OVER
    (
        ORDER BY SUM(sales) DESC
    ) AS row_num

FROM orders

GROUP BY `Product Name`;

-- ==========================================
-- LAG()
-- Previous year's sales
-- ==========================================

WITH yearly_sales AS
(
    SELECT
        YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS sales_year,
        ROUND(SUM(sales),2) AS total_sales

    FROM orders

    GROUP BY
        YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
)

SELECT

    sales_year,

    total_sales,

    LAG(total_sales)
    OVER
    (
        ORDER BY sales_year
    ) AS previous_year_sales

FROM yearly_sales;

-- ==========================================
-- LAG() with Year-over-Year Growth
-- ==========================================

WITH yearly_sales AS
(
    SELECT
        YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS sales_year,
        ROUND(SUM(sales),2) AS total_sales

    FROM orders

    GROUP BY
        YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y'))
)

SELECT

    sales_year,

    total_sales,

    LAG(total_sales)
    OVER
    (
        ORDER BY sales_year
    ) AS previous_year_sales,

    ROUND
    (
        total_sales
        -
        LAG(total_sales)
        OVER
        (
            ORDER BY sales_year
        ),
        2
    ) AS growth

FROM yearly_sales;