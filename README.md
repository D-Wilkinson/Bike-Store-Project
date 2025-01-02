# SQL-WIP

WORK IN PROGRESS 

[Initial Dataset](https://github.com/D-Wilkinson/SQL-WIP/tree/34802d17155ce26338d99ba5617d6432b5582c9a/Intial%20CSV%20Data)

[SQL Script](https://github.com/D-Wilkinson/SQL-WIP/blob/09094eae6423be2ff98841a1d8819bb0e8956214/Bike%20Store.sql)

[PowerBI Dashboard .pbix](https://github.com/D-Wilkinson/Bike-Store-Project/blob/768d87ee1c7900530b83617f1034dc9c92fa8752/Bike%20Store%20Dashboard.pbix)

[PowerBI Dashboard .pdf](https://github.com/D-Wilkinson/Bike-Store-Project/blob/768d87ee1c7900530b83617f1034dc9c92fa8752/Bike%20Store%20Dashboard.pdf)

If you want to use these statements yourself, download the [Database Setup.sql](https://github.com/D-Wilkinson/SQL-WIP/blob/e8e9bd90aad4f9550794ae3eb9e56dfe97de0263/Database%20Setup.sql) file and open MySQL workbench with a new empty schema, then run the sql script to create the tables etc. Then you can use the ‘Bike Store.sql’ statements yourself.

# Bike Store Project

## Introduction
I utilised a publicly available Bike Store database downloaded from [Kaggle](https://www.kaggle.com/datasets/dillonmyrick/bike-store-sample-database), which consisted of 9 CSV files. The aim of this project was to perform data cleaning and analysis using MySQL Workbench to demonstrate SQL skills, and then to load the manipulated data into PowerBI to create visualisations.

### Skills Demonstrated:
- Inner Joins
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
![IMG2](https://github.com/user-attachments/assets/c7ff8d77-4c29-4f58-ade9-571dc040f39b)


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

In the following statements I create a view for each query, which stores the results in a table,
this can then easily be imported into PowerBI to create visualisations.

Sales by Staff:
 Using inner joins, I calculated the total sales made by each staff member.
 
![IMG10](https://github.com/user-attachments/assets/bf3932e0-1f7f-4bf4-9baa-414503e6259f)



Monthly Sales Trends:
 Total sales were aggregated by month.
 

![IMG11](https://github.com/user-attachments/assets/24fa7b3f-b8c8-4f6a-af05-1e1c74acb86a)


Low Stock Products:
 Products with low stock levels were flagged for inventory management purposes.
 
![IMG12](https://github.com/user-attachments/assets/7c69469c-8a8d-494d-afdc-44ebda74bb46)


Product Breakdown:
 The total number of products were grouped by both category and brand to understand product distribution.
 
 ![IMG13](https://github.com/user-attachments/assets/65b265f9-eca2-4391-a6fd-038f636ba5af)


Order Status Grouping:
 Orders were categorised based on their shipped status using a CASE function, enabling more detailed order tracking.
 
![IMG14](https://github.com/user-attachments/assets/399fce56-23e0-47b2-aceb-b3f436a6be8e)



## Conclusion
The project demonstrated proficiency in data cleaning, transformation, and analysis using SQL. By leveraging views, and advanced SQL functions, I provided actionable insights into sales performance, inventory management, and product distribution through PowerBI.
