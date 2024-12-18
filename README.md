# SQL-WIP

WORK IN PROGRESS 

[Initial Dataset](https://github.com/D-Wilkinson/SQL-WIP/tree/34802d17155ce26338d99ba5617d6432b5582c9a/Intial%20CSV%20Data)

[SQL Script](https://github.com/D-Wilkinson/SQL-WIP/blob/e52d06f14e4e4e75b5b1091cf06c133ee17ad3d5/Bike%20Store.sql)

# Bike Store Data Analysis

## Introduction
I utilised a publicly available Bike Store database downloaded from Kaggle, which consisted of 9 CSV files. The aim of this project was to perform data cleaning and analysis using MySQL Workbench.

### Skills Demonstrated:
- Inner Joins
- Subqueries
- Aggregate Functions
- Creating Views
- Converting Data Types
- Case Functions
## Data Preparation
Each CSV file was loaded into MySQL tables. I verified that the tables were imported successfully by ensuring the number of rows in the tables matched those shown in Excel.
## Data Cleaning
Checking for NULL Values:
 Tables were inspected for any missing values that could affect the analysis.


Removing Duplicates:
 Duplicate rows were identified and removed to ensure data accuracy.


Merging Names:
 First and last names of customers and staff were merged into a single column, simplifying data management. The original columns were removed.


Calculating Net Price:
 In the order_items table, a new column was added to calculate the net_price, incorporating quantity, price, and discounts.


Standardising Dates:
 All date fields were standardised to the DATE format. This resolved potential issues with sorting and filtering, as the original text format was inconsistent.



## Data Analysis
Sales by Staff:
 Using a subquery, I calculated the total sales made by each staff member.


Monthly Sales Trends:
 Total sales were aggregated by month, and a view was created for easier referencing in future queries.


Low Stock Products:
 Products with low stock levels were flagged for inventory management purposes.


Product Breakdown:
 The total number of products was grouped by both category and brand to understand product distribution.


Order Status Grouping:
 Orders were categorised based on their shipped status using a CASE function, enabling more detailed order tracking.



## Conclusion
The project demonstrated proficiency in data cleaning, transformation, and analysis using SQL. By leveraging subqueries, views, and advanced SQL functions, I provided actionable insights into sales performance, inventory management, and product distribution.
