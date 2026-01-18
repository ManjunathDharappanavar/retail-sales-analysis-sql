# Retail Sales Analysis using SQL

## 📊 Project Overview

This project demonstrates end-to-end SQL analysis of retail transaction data to extract actionable business insights. The analysis focuses on understanding sales performance, customer behavior, time-based trends, and product category dynamics. This project showcases my ability to clean data, write complex SQL queries, and translate business questions into analytical insights suitable for data-driven decision-making.

**Author:** Manjunath Gopal Dharappanavar  
**Database:** MySQL  
**Project Type:** Data Analytics Portfolio Project

---

## 🎯 Objective

The primary objective of this project is to analyze retail sales data to:
- Identify revenue patterns and key performance metrics
- Understand customer purchasing behavior
- Discover time-based sales trends (daily, weekly, monthly)
- Evaluate product category performance
- Provide data-driven recommendations for business optimization

---

## 📁 Dataset Description

The dataset contains **1,987 retail transaction records** with the following attributes:

| Column Name       | Description                                      |
|-------------------|--------------------------------------------------|
| `transactions_id` | Unique identifier for each transaction (Primary Key) |
| `sale_date`       | Date when the transaction occurred               |
| `sale_time`       | Time of the transaction                          |
| `customer_id`     | Unique identifier for each customer              |
| `gender`          | Gender of the customer (Male/Female)             |
| `age`             | Age of the customer                              |
| `category`        | Product category (Beauty, Clothing, Electronics) |
| `quantity`        | Number of units purchased                        |
| `price_per_unit`  | Price per unit of the product                    |
| `cogs`            | Cost of Goods Sold                               |
| `total_sale`      | Total transaction value                          |

**Data Source:** Synthetic retail transaction data (assumed for portfolio demonstration)

---

## 🛠️ Tools & Technologies Used

- **Database Management System:** MySQL
- **SQL Techniques:** Aggregate functions, GROUP BY, HAVING, subqueries, date functions, window functions
- **Data Analysis:** Data cleaning, exploratory data analysis (EDA), business metrics calculation
- **Version Control:** Git & GitHub

---

## 🗂️ Database & Table Schema
```sql
CREATE DATABASE MyProject;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender ENUM('Male', 'Female'),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit INT,
    cogs FLOAT,
    total_sale FLOAT
);
```

---

## 🧹 Data Cleaning Steps

Before analysis, the dataset was validated to ensure data quality:

1. **Null Value Check:** Verified all critical columns for missing or null values across all fields (transactions_id, sale_date, sale_time, customer_id, gender, age, category, quantity, price_per_unit, cogs, total_sale)
2. **Data Integrity:** Confirmed primary key uniqueness and proper data types
3. **Initial Exploration:** Reviewed sample records and total row count to understand data structure
4. **Result:** No null values detected; dataset is clean and ready for analysis

**SQL Query for Data Cleaning:**
```sql
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
```

---

## 💼 Business Questions Answered

### Basic Metrics

**1. How many total transactions are there?**  
- **Answer:** 1,987 transactions  
- Establishes the scope of the dataset
```sql
SELECT COUNT(*) FROM retail_sales;
```

---

**2. How many unique customers made purchases?**  
- **Answer:** 155 unique customers  
- Indicates customer base size and repeat purchase potential
```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```

---

**3. What is the total revenue generated?**  
- **Answer:** ₹908,230  
- Key performance indicator for overall business performance
```sql
SELECT SUM(total_sale) FROM retail_sales;
```

---

**4. What is the average transaction value?**  
- **Answer:** ₹457.09  
- Helps understand typical customer spending behavior
```sql
SELECT ROUND(AVG(total_sale), 2) FROM retail_sales;
```

---

**5. What are the minimum and maximum sale values?**  
- **Answer:** Max = ₹2,000, Min = ₹25  
- Shows the range of transaction sizes
```sql
SELECT MAX(total_sale) AS max_sales, MIN(total_sale) AS min_sales FROM retail_sales;
```

---

**6. How many product categories exist?**  
- **Answer:** 3 categories (Beauty, Clothing, Electronics)  
- Defines product portfolio breadth
```sql
SELECT COUNT(DISTINCT category) FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;
```

---

**7. What is the average price per unit across all products?**  
- **Answer:** ₹179.92  
- Indicates average product pricing
```sql
SELECT ROUND(AVG(price_per_unit), 2) FROM retail_sales;
```

---

**8. What is the total quantity sold?**  
- **Answer:** 4,995 units  
- Measures sales volume beyond revenue
```sql
SELECT SUM(quantity) FROM retail_sales;
```

---

### Time-Based Analysis

**9. What are the total sales per day/week?**  
- Analyzed daily sales trends and sales distribution across days of the week
- Identifies patterns in customer shopping behavior by day

**Sales per Day:**
```sql
SELECT sale_date, SUM(total_sale) 
FROM retail_sales 
GROUP BY sale_date 
ORDER BY sale_date DESC;
```

**Sales per Day of the Week:**
```sql
SELECT 
    DAYNAME(sale_date) AS day_of_week, 
    SUM(total_sale) 
FROM retail_sales 
GROUP BY day_of_week 
ORDER BY FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
```

---

**10. What are the total sales per month?**  
- Calculated monthly revenue distribution
- Reveals seasonal or cyclical sales patterns
```sql
SELECT
    MONTHNAME(sale_date) AS month_of_year,
    SUM(total_sale)
FROM retail_sales
GROUP BY month_of_year
ORDER BY MONTH(MIN(sale_date));
```

---

**11. Which day had the highest sales?**  
- **Answer:** October 10, 2022  
- Highlights peak sales day for promotional analysis
```sql
SELECT 
    sale_date,
    SUM(total_sale) AS total_daily_sale
FROM retail_sales 
GROUP BY sale_date 
HAVING SUM(total_sale) = (
    SELECT MAX(daily_sum) FROM (
        SELECT SUM(total_sale) AS daily_sum FROM retail_sales GROUP BY sale_date
    ) AS daily_totals
);
```

---

**12. Which month generated the most revenue?**  
- **Answer:** December with ₹141,025  
- Indicates strongest performing month, likely driven by holiday shopping
```sql
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
    ) AS monthly_max
);
```

---

## 🔍 Key Insights Summary

Based on the SQL analysis, the following insights were derived:

- **Customer Engagement:** With 155 unique customers generating 1,987 transactions, the average customer made approximately **12.8 purchases**, indicating strong repeat customer behavior
- **Revenue Performance:** Total revenue of ₹908,230 with an average transaction value of ₹457.09 demonstrates healthy sales activity
- **Transaction Range:** Wide variance between minimum (₹25) and maximum (₹2,000) sales suggests diverse product mix and customer segments
- **Product Portfolio:** Three distinct categories (Beauty, Clothing, Electronics) provide diversification
- **Seasonal Trends:** December emerged as the top-performing month (₹141,025), suggesting strong year-end sales, likely driven by holiday shopping
- **Peak Sales Day:** October 10, 2022 recorded the highest single-day sales, warranting further investigation into promotional activities or external factors
- **Volume Metrics:** 4,995 total units sold across all transactions, averaging approximately 2.5 units per transaction

---

## 📈 Suggested Visualizations

To effectively communicate these insights, the following visualizations are recommended:

1. **Monthly Revenue Trend (Line Chart)**  
   - Maps to: Question 10, 12  
   - Shows revenue progression over months to identify seasonal patterns

2. **Sales by Day of Week (Bar Chart)**  
   - Maps to: Question 9  
   - Highlights which days drive the most revenue for staffing and inventory planning

3. **Product Category Distribution (Pie Chart)**  
   - Maps to: Question 6  
   - Displays proportion of sales across Beauty, Clothing, and Electronics

4. **Transaction Value Distribution (Histogram)**  
   - Maps to: Question 4, 5  
   - Shows frequency distribution of transaction sizes

5. **Top 10 Sales Days (Bar Chart)**  
   - Maps to: Question 11  
   - Identifies peak sales days for promotional pattern analysis

6. **Customer Purchase Frequency (Bar Chart)**  
   - Maps to: Question 2  
   - Analyzes repeat purchase behavior and customer loyalty

7. **Daily Sales Trend (Line Chart)**  
   - Maps to: Question 9  
   - Tracks day-by-day sales performance to spot trends and anomalies

---

## 🚀 Project Status & Next Steps

**Current Status:** Day 1 - Data Import, Cleaning & Basic Analysis ✅

**Upcoming Analysis (Future Days):**
- Customer segmentation analysis (age, gender demographics)
- Product category performance deep-dive
- Time-based sales patterns (hourly trends)
- Customer lifetime value calculation
- Profitability analysis using COGS data
- Correlation analysis between variables
- Advanced SQL techniques (window functions, CTEs)
- Dashboard creation for visualization

---

## 🔧 How to Run This Project

### Prerequisites
- MySQL Server installed
- MySQL Workbench or any SQL client

### Steps

1. **Clone the Repository**
```bash
   git clone https://github.com/yourusername/retail-sales-analysis-sql.git
   cd retail-sales-analysis-sql
```

2. **Set Up Database**
   - Open MySQL Workbench or your preferred SQL client
   - Run the database and table creation scripts from `schema.sql`

3. **Import Data**
   - Load the retail sales dataset into the `retail_sales` table
   - Verify data import with `SELECT COUNT(*) FROM retail_sales;`

4. **Execute Analysis Queries**
   - Run the SQL queries from `day1_analysis.sql`
   - Review results for each business question

5. **Review Results**
   - Compare outputs with the documented answers in this README
   - Export results for visualization in Excel/Tableau/Power BI

---

## 📫 Contact

**Manjunath Gopal Dharappanavar**

For questions, feedback, or collaboration opportunities, feel free to reach out!

---

## 📝 License

This project is open source and available for educational and portfolio purposes.

---

**⭐ If you found this project helpful, please consider starring the repository!**
