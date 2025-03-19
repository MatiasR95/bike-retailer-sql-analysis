/*📌 Phase 3: Customer Behavior Analysis*/
--1) How many unique customers have placed orders?
WITH TotalOrders AS (
    SELECT COUNT(DISTINCT o.order_id) AS TotalOrders,
           c.customer_id
    FROM orders o
    JOIN customers c ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
)
SELECT COUNT(*) AS TotalUniqueCustomers
FROM TotalOrders;
;

--2) How many customers placed only 1 order vs. multiple orders?
WITH CustomerOrderCount AS (
    SELECT c.customer_id,
           COUNT(DISTINCT o.order_id) AS TotalOrders
    FROM orders o
    JOIN customers c ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
)
SELECT 
    COUNT(CASE WHEN TotalOrders = 1 THEN 1 END) AS SingleOrderCustomers,
    COUNT(CASE WHEN TotalOrders > 1 THEN 1 END) AS MultipleOrderCustomers
FROM CustomerOrderCount;



--Finding the top 5 highest-spending customers
SELECT TOP 5 
    c.customer_id,
    c.first_name + ' ' + c.last_name AS Customer,
    ROUND(SUM(oi.quantity * oi.list_price),1) AS TotalSpent
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY TotalSpent DESC;
;


--Percentage of revenue from repeat customers
WITH TotalSpended AS (
    SELECT 
        customer_id,
        ROUND(SUM(oi.quantity * oi.list_price),1) AS TotalSpent,
        COUNT(DISTINCT o.order_id) AS TotalOrders
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    GROUP BY customer_id
),
RepeatedCustomers AS (
    SELECT SUM(TotalSpent) AS RepeatCustomerRevenue
    FROM TotalSpended
    WHERE TotalOrders > 1
),
TotalSales AS (
    SELECT SUM(TotalSpent) AS TotalRevenue
    FROM TotalSpended
)
SELECT 
    ts.TotalRevenue, 
    rc.RepeatCustomerRevenue, 
    ROUND((rc.RepeatCustomerRevenue * 100.0) / ts.TotalRevenue, 2) AS RepeatCustomerRevenuePercentage
FROM TotalSales ts, RepeatedCustomers rc;


--Analyzing average order value per customer
WITH TotalSpended AS
(SELECT SUM(oi.quantity * oi.list_price) AS TotalSpended,
		o.customer_id AS CustomerID,
		COUNT(DISTINCT o.order_id) AS TotalOrders
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.customer_id)
SELECT AVG(TotalSpended) AS AVGSpended,
		AVG(TotalSpended)/ TotalOrders AS AVGPerOrder,
		CustomerID 
FROM TotalSpended
GROUP BY CustomerID, TotalOrders
