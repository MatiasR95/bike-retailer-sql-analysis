/*📌 Phase 2: General Business Performance Analysis
1)Total revenue and number of orders per year (2016, 2017, 2018)*/

SELECT ROUND(SUM(oi.quantity * oi.list_price),1) AS TotalRevenue,
		ROUND(COUNT(DISTINCT o.order_id),1) AS TotalOrders,
		YEAR(o.order_date) AS Year
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY YEAR(o.order_date) -- I should include the function YEAR too.

--2) Total revenue per store (Which store is performing best?)
SELECT s.store_name AS Store,
		ROUND(SUM(oi.quantity * oi.list_price),1) AS TotalRevenue,
		RANK() OVER(ORDER BY SUM(oi.quantity * oi.list_price) DESC) AS Rank
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN stores s ON s.store_id = o.store_id
GROUP BY s.store_name
ORDER BY TotalRevenue DESC

--3) Top 10 orders ever made
SELECT TOP 10 o.order_id AS OrderID, o.order_date AS OrderDate,
		ROUND(SUM(oi.quantity * oi.list_price),1) AS TotalRevenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id, o.order_date
ORDER BY TotalRevenue DESC

--4) Comparing monthly sales across years (Seasonal trends?)
SELECT ROUND(SUM(oi.quantity * oi.list_price),1) AS TotalRevenue,
		MONTH(o.order_date) AS Month,
		YEAR (o.order_date) AS Year,
		LAG(ROUND(SUM(oi.quantity * oi.list_price),1)) OVER(PARTITION BY YEAR (o.order_date) ORDER BY MONTH(o.order_date),YEAR (o.order_date)  ) AS Lag
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY MONTH(o.order_date), YEAR (o.order_date)
ORDER BY Year ASC, Month ASC
