-- Retail Sales Analysis Project
-- Author: Manjunath Gopal Dharappanavar
-- Database: MySQL
-- Description: SQL analysis of retail transactions including sales,
-- customers, time-based trends, and category performance

-- DATABASE & TABLE CREATION
-- CREATING DATABASE 
CREATE DATABASE MyProject;
use MyProject;

-- CREATING TABLE RETAIL SALES
CREATE TABLE retail_sales
	(
		transactions_id INT PRIMARY KEY,	
		sale_date DATE,
		sale_time TIME,	
		customer_id INT,	
		gender ENUM('Male', 'Female'),
		age	INT,
		category VARCHAR(15),	
		quantity	INT,
		price_per_unit INT,	
		cogs FLOAT,
		total_sale FLOAT
	);
    

    
-- DISPLAYING DATA
SELECT * FROM retail_sales LIMIT 10;
SELECT COUNT(*) FROM retail_sales;

-- DATA CLEANING
SELECT * FROM retail_sales 
WHERE 
    transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantity IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;

-- BUSINESS QUESTIONS

-- BASIC METRICS
-- 1. How many total transactions are there? ans: 1987
SELECT COUNT(*) FROM retail_sales;

-- 2. How many unique customers made purchases? ans: 155
SELECT COUNT(DISTINCT customer_id) FROM retail_sales; 

-- 3. What is the total revenue (total_sale) generated? ans: 908230
SELECT SUM(total_sale) FROM retail_sales;

-- 4. What is the average transaction value? ans: 457.09
SELECT ROUND(AVG(total_sale), 2) FROM retail_sales;

-- 5. What is the minimum and maximum sale value? ans: max sales - 2000, min sales - 25
SELECT MAX(total_sale) as max_sales, MIN(total_sale) as min_sales FROM retail_sales;

-- 6. How many product categories exist? ans: 3
SELECT COUNT(DISTINCT category) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales; -- 3 categories 1. Beauty 2. Clothing 3. Electronics

-- 7. What is the average price per unit across all products? ans: 179.92
SELECT ROUND(AVG(price_per_unit), 2) FROM retail_sales;

-- 8. What is the total quantity sold? ans: 4995
SELECT SUM(quantity) FROM retail_sales;

-- TIME-BASED ANALYSIS

-- 9. What are the total sales per day?
SELECT sale_date, SUM(total_sale) FROM total_sale GROUP BY sale_date ORDER BY sale_date DESC;

-- sales per day of the week?
SELECT 
DAYNAME(sale_date) as day_of_week, 
SUM(total_sale) 
FROM retail_sales 
GROUP BY day_of_week 
ORDER BY FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- 10. What are the total sales per month?
SELECT
MONTHNAME(sale_date) as month_of_year,
SUM(total_sale)
FROM retail_sales
GROUP BY month_of_year
ORDER BY MONTH(MIN(sale_date));

-- 11. Which day had the highest sales? ans: 10-10-2022
SELECT 
sale_date,
SUM(total_sale) AS total_daily_sale
FROM retail_sales 
GROUP BY sale_date 
HAVING SUM(total_sale) = (
	SELECT MAX(daily_sum) FROM (
		SELECT SUM(total_sale) as daily_sum FROM retail_sales GROUP BY sale_date
    ) as daily_totals
);

-- 12. Which month generated the most revenue? ans: December - 141025
SELECT 
MONTHNAME(sale_date) AS month_of_year,
SUM(total_sale) 
FROM retail_sales 
GROUP BY month_of_year
HAVING SUM(total_sale) = (
	SELECT MAX(monthly_sum) FROM (
		SELECT 
		MONTHNAME(sale_date) AS monthly,
		SUM(total_sale) AS monthly_sum
		FROM retail_sales GROUP BY monthly
    ) as monthly_max
);

    


