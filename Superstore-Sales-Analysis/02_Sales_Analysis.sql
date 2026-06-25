CREATE DATABASE superstore_portfolio;
USE superstore_portfolio;

CREATE TABLE superstore_sales (
    row_id INT,
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country_region VARCHAR(100),
    city VARCHAR(100),
    state_province VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(100),
    product_name VARCHAR(255),
    sales DECIMAL(12,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(12,2)
);

DESC superstore_sales;

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_superstore.csv'
INTO TABLE superstore_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_rows
FROM superstore_sales;

SELECT
    ROUND(SUM(sales),2) AS Total_Sales
FROM superstore_sales;

SELECT
    ROUND(SUM(profit),2) AS Total_Profit
FROM superstore_sales;

SELECT
    category,
    ROUND(SUM(sales),2) AS Total_Sales
FROM superstore_sales
GROUP BY category
ORDER BY Total_Sales DESC;

SELECT
    category,
    ROUND(SUM(profit),2) AS Total_Profit
FROM superstore_sales
GROUP BY category
ORDER BY Total_Profit DESC;

SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(
        SUM(sales) * 100 /
        (SELECT SUM(sales) FROM superstore_sales),
        2
    ) AS sales_percentage
FROM superstore_sales
GROUP BY category
ORDER BY total_sales DESC;

SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(
        SUM(sales) * 100 /
        (SELECT SUM(sales) FROM superstore_sales),
        2
    ) AS sales_percentage
FROM superstore_sales
GROUP BY region
ORDER BY total_sales DESC;

SELECT
    segment,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(
        SUM(sales) * 100 /
        (SELECT SUM(sales) FROM superstore_sales),
        2
    ) AS sales_percentage
FROM superstore_sales
GROUP BY segment
ORDER BY total_sales DESC;

SELECT
    product_name,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore_sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    sub_category,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore_sales
GROUP BY sub_category
ORDER BY total_sales DESC;

SELECT
    state_province,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore_sales
GROUP BY state_province
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    region,
    ROUND(AVG(profit),2) AS average_profit
FROM superstore_sales
GROUP BY region
ORDER BY average_profit DESC;

SELECT
    segment,
    ROUND(AVG(discount)*100,2) AS average_discount_percentage
FROM superstore_sales
GROUP BY segment
ORDER BY average_discount_percentage DESC;

SELECT
    MONTHNAME(order_date) AS Month,
    ROUND(SUM(sales),2) AS Total_Sales
FROM superstore_sales
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY Total_Sales DESC;

SELECT
    category,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin_percentage
FROM superstore_sales
GROUP BY category
ORDER BY profit_margin_percentage DESC;
