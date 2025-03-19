/*📌 Phase 1: Exploring & Understanding the Dataset
1) Count the total rows in each table and unic id's*/
SELECT COUNT(brand_id) AS TotalRows
FROM brands;
SELECT COUNT(DISTINCT brand_id) AS TotalBrands
FROM brands;

SELECT COUNT(category_id) AS TotalRows
FROM categories;
SELECT COUNT(DISTINCT category_id) AS TotalCategories
FROM categories

SELECT COUNT(customer_id) AS TotalRows
FROM customers;
SELECT COUNT(DISTINCT customer_id) AS TotalCustomers
FROM customers;

SELECT COUNT(order_id) AS TotalRows
FROM order_items;
SELECT COUNT(DISTINCT order_id) AS TotalOrders
FROM order_items

SELECT COUNT(product_id) AS TotalRows
FROM products;
SELECT COUNT(DISTINCT product_id) AS TotalProducts
FROM products

SELECT COUNT(store_id) AS TotalRows
FROM stores;
SELECT COUNT(DISTINCT store_id) AS TotalStores
FROM stores;

/*Finding unique useful values*/

SELECT DISTINCT(city) AS Cities
FROM customers

SELECT brand_name AS Brand
FROM brands

SELECT product_name AS Product,
	products.model_year AS ModelYear,
	products.list_price AS Price
FROM products

--Finding dates data range
SELECT MAX(order_date) AS NearDate,
		MIN(Order_date) AS FurtherDate,
		MAX(shipped_date) AS NearShip,
		MIN(shipped_date) AS FurtherShip
FROM orders

--Checking for NULL values in important columns 
SELECT email, phone, city, last_name
FROM customers
WHERE phone IS NULL --0 matches
--I've realized that the NULLS are typed like NULL
SELECT email, phone, city, last_name
FROM customers
WHERE phone LIKE 'NULL'

SELECT email, phone, city, last_name
FROM customers
WHERE last_name IS NULL -- 0 matches


--Stores information: 3 total stores.
SELECT store_name AS Store,
		city AS City,
		state AS State
FROM stores

--Counting total products for each brand and then category.

SELECT COUNT(DISTINCT product_id) AS TotalProducts,
	B.brand_name As Brand
FROM products p
JOIN brands b ON b.brand_id = p.brand_id
GROUP BY b.brand_name
ORDER BY TotalProducts DESC

SELECT COUNT(DISTINCT product_id) AS TotalProducts,
		c.category_name AS Category
FROM products p 
JOIN categories c ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY TotalProducts DESC
