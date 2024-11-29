-- cmd(admin) command to start server: net start MySQL80
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