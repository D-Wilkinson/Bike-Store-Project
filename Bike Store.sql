-- Bike Store Relational Database

-- Load csv files into tables using import wizard, for larger tables use the following commands:
-- These commands are for the stocks.csv for an example:

DELETE from stocks;

SET GLOBAL local_infile=1;

LOAD DATA LOCAL INFILE 'C:\\Users\\Dan\\Desktop\\SQL Project\\Bike Store Relational Database\\stocks.csv' INTO TABLE stocks
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- Check each table has been imported correctly:

SELECT * FROM bikestore_db.brands;
SELECT * FROM bikestore_db.categories;
SELECT * FROM bikestore_db.customers;
SELECT * FROM bikestore_db.order_items;
SELECT * FROM bikestore_db.orders;
SELECT * FROM bikestore_db.products;
SELECT * FROM bikestore_db.staffs;
SELECT * FROM bikestore_db.stocks;
SELECT * FROM bikestore_db.stores;

-- Number of rows in each table should equal number of rows in each csv:

SELECT COUNT(*) FROM bikestore_db.customers; -- 1445
SELECT COUNT(*) FROM bikestore_db.orders; -- 1615
-- etc.

-- Data cleaning:

-- Handling NULL Values:

-- Customers contain null values in phone column
-- This statement calculates the percentage of rows that don't contain a NULL value:

SELECT  (COUNT(phone)/(SELECT COUNT(*) FROM bikestore_db.customers)) * 100 AS PercentageNotNull FROM bikestore_db.customers
WHERE NOT phone IS NULL;

-- Only 12.3% of the rows contain data that is not NULL, therefore it is best to drop this column from the table:

ALTER TABLE bikestore_db.customers
DROP COLUMN phone;

-- Check that phone column has been dropped:

SELECT * FROM bikestore_db.customers;

-- Orders contain null values in the 'shipped_date' column
-- Perform same type of calculation as before:

SELECT  (COUNT(shipped_date)/(SELECT COUNT(*) FROM bikestore_db.orders)) * 100 AS PercentageNotNull FROM bikestore_db.orders
WHERE NOT shipped_date IS NULL;

-- 89.5% of the rows contain data that is not NULL, therefore dropping the column is not a good idea.
-- Looking at the table, the order status holds values of 1,2,3 and 4. Only 4 contains ship dates
-- therefore 1,2 and 3 must mean the order has not been shipped yet.
-- I will keep these rows for now but can filter them out later eg. If I wanted to check only shipped orders.


-- See if there are any duplicate rows in the larger datasets:

-- The following statement groups the rows in the table and counts each unique combination of cells,
-- if the count is greater than 1 that means a row has been duplicated and is displayed as the output.

SELECT *, COUNT(*) AS count
FROM bikestore_db.customers
GROUP BY customer_id, first_name, last_name, email, street, city, state, zip_code
HAVING count > 1;

-- The output returns an empty table therefore there are no duplicate rows, repeat this for the other tables:

SELECT *, COUNT(*) AS count
FROM bikestore_db.order_items
GROUP BY order_id,	item_id,	product_id,	quantity,	list_price,	discount
HAVING count > 1;

SELECT *, COUNT(*) AS count
FROM bikestore_db.orders
GROUP BY order_id,	customer_id,	order_status,	order_date,	required_date,	shipped_date,	store_id,	staff_id
HAVING count > 1;

SELECT *, COUNT(*) AS count
FROM bikestore_db.products
GROUP BY product_id,	product_name,	brand_id,	category_id,	model_year,	list_price
HAVING count > 1;

SELECT *, COUNT(*) AS count
FROM bikestore_db.stocks
GROUP BY store_id,	product_id,	quantity
HAVING count > 1;

-- No rows have been returned therefore none of the tables contain duplicate rows.

-- The customers and staffs tables contains first and last names, I will join/concatenate these columns together:
-- Add a new name column to the table:
ALTER TABLE bikestore_db.customers
ADD COLUMN full_name VARCHAR(255);

-- concatenate strings from the first and last name and add them into the new column:

UPDATE bikestore_db.customers
SET full_name = CONCAT(first_name,' ',last_name);

-- Drop the first_name and last_name columns:

ALTER TABLE bikestore_db.customers
DROP COLUMN first_name,
DROP COLUMN last_name;

-- Change the postition of the new column from the end of the table to the 2nd position:

ALTER TABLE bikestore_db.customers
MODIFY COLUMN full_name VARCHAR(255) AFTER customer_id;

-- Check that it has worked:

SELECT * FROM bikestore_db.customers;

-- Now I will repeat this for the staffs table:

ALTER TABLE bikestore_db.staffs
ADD COLUMN full_name VARCHAR(255);

UPDATE bikestore_db.staffs
SET full_name = CONCAT(first_name,' ',last_name);

ALTER TABLE bikestore_db.staffs
DROP COLUMN first_name,
DROP COLUMN last_name;

ALTER TABLE bikestore_db.staffs
MODIFY COLUMN full_name VARCHAR(255) AFTER staff_id;

SELECT * FROM bikestore_db.staffs;


-- I will add a new column into the order_items table that calculates the net price for each order, as
-- this will be used frequently in analysis and will save time having to type the calculation each time:

ALTER TABLE order_items 
ADD net_price DOUBLE
AS (quantity * list_price * (1 - discount));

-- Convert data type of dates from TEXT to DATE for standardisation:

ALTER TABLE `bikestore_db`.`orders` 
CHANGE COLUMN `order_date` `order_date` DATE NULL DEFAULT NULL ,
CHANGE COLUMN `required_date` `required_date` DATE NULL DEFAULT NULL ,
CHANGE COLUMN `shipped_date` `shipped_date` DATE NULL DEFAULT NULL ;

-- Data analysis 

-- Find the total sales made by each staff member:

-- When formatting the total_sales in GBP and trying to order by highest to lowest, it does not work
-- properly as it has been converted from numeric to string, and sorts alphabetically.
-- To fix this issue I will use a subquery, the numeric value is used for sorting within
-- the subquery, and only the formatted sales are selected in the final result. 

SELECT full_name, CONCAT('£', FORMAT(total_sales_raw, 0)) AS total_sales
FROM
(
SELECT st.full_name, SUM(oi.net_price) AS total_sales_raw
FROM staffs st
JOIN orders o ON st.staff_id = o.staff_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY st.full_name
)
AS sales_data
ORDER BY total_sales_raw DESC; -- Values checked through same method in Excel are correct.

-- Monthly Sales Trends:

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(oi.net_price) AS total_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month; -- These values have been checked with Excel power query and are correct.

-- Format the output in GBP to the nearest pound for cleaner presentation, and create a view for easier referencing:

CREATE VIEW monthly_sales AS
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, CONCAT('£',FORMAT(SUM(oi.net_price),0)) AS total_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

-- View the ouput:

SELECT * FROM bikestore_db.monthly_sales;

-- Low Stock Products across stores (Less Than 10 Units):

SELECT p.product_name, s.store_name, st.quantity
FROM stocks st
JOIN products p ON st.product_id = p.product_id
JOIN stores s ON st.store_id = s.store_id
WHERE st.quantity < 10
ORDER BY st.quantity;

-- Total Products by Category:

SELECT c.category_name, COUNT(p.product_id) AS total_products
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY 1;

-- Total Products by Brand:

SELECT b.brand_name, COUNT(p.product_id) AS total_products
FROM brands b
JOIN products p ON b.brand_id = p.brand_id
GROUP BY 1;

-- Total orders by status to date:

SELECT  CASE WHEN order_status = 4 THEN 'Shipped' ELSE 'Not Shipped' END AS Status , COUNT(*) AS total_orders
FROM orders
GROUP BY Status;