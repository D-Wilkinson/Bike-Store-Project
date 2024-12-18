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
![IMG1](https://github.com/user-attachments/assets/b78562c3-80ca-40a6-815b-6d902ea0a9f5)
![IMG2](https://github.com/user-attachments/assets/a4dfd864-73e0-4186-8064-fb2c064b8260)


Removing Duplicates:
 Duplicate rows were identified and removed to ensure data accuracy.
![IMG3](https://github.com/user-attachments/assets/dbc25f7d-530f-4b6d-9afe-085f2091613b)
![IMG4](https://github.com/user-attachments/assets/c993a801-b8a1-408e-9557-30c38e2ece6f)


Merging Names:
 First and last names of customers and staff were merged into a single column, simplifying data management. The original columns were removed.
![IMG5](https://github.com/user-attachments/assets/0cf09f77-5140-446d-aa1a-e22a92d65a64)
![IMG6](https://github.com/user-attachments/assets/4e462345-ea09-4b61-86b3-1448211827ae)
![IMG7](https://github.com/user-attachments/assets/faed00fc-cbbe-4ab3-838d-862063d6ce19)


Calculating Net Price:
 In the order_items table, a new column was added to calculate the net_price, incorporating quantity, price, and discounts.
![IMG8](https://github.com/user-attachments/assets/826832fe-9edc-4103-8f13-4f43ac547efb)


Standardising Dates:
 All date fields were standardised to the DATE format. This resolved potential issues with sorting and filtering, as the original text format was inconsistent.
![IMG9](https://github.com/user-attachments/assets/c2b6885a-4881-49c5-9a8c-12926cbafb4d)



## Data Analysis
Sales by Staff:
 Using a subquery, I calculated the total sales made by each staff member.
![IMG10](https://github.com/user-attachments/assets/bc2e647f-25e9-45c7-aae4-4e61df4e51e1)


Monthly Sales Trends:
 Total sales were aggregated by month, and a view was created for easier referencing in future queries.
![IMG11](https://github.com/user-attachments/assets/c99acdfb-f6dd-4e58-b642-d87f0851aa4f)


Low Stock Products:
 Products with low stock levels were flagged for inventory management purposes.
![IMG12](https://github.com/user-attachments/assets/63c725c3-9c6d-4774-93f8-1ed3c516d9fb)


Product Breakdown:
 The total number of products was grouped by both category and brand to understand product distribution.
![IMG13](https://github.com/user-attachments/assets/b2608867-46a7-42fb-acfa-62edb1c392f2)


Order Status Grouping:
 Orders were categorised based on their shipped status using a CASE function, enabling more detailed order tracking.
![IMG14](https://github.com/user-attachments/assets/9e030728-ca46-4e1a-a279-9e086f419f75)



## Conclusion
The project demonstrated proficiency in data cleaning, transformation, and analysis using SQL. By leveraging subqueries, views, and advanced SQL functions, I provided actionable insights into sales performance, inventory management, and product distribution.
