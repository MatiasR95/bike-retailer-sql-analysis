/*📌 Phase 5: Store & Regional Performance.
 Compare store performance by revenue and number of orders*/

 SELECT ROUND(SUM(oi.quantity * oi.list_price),1) AS TotalRevenue,
		COUNT(DISTINCT o.order_id) AS TotalOrders,
		s.store_name AS Store
 FROM orders o
 JOIN order_items oi ON oi.order_id = o.order_id
 JOIN stores s ON s.store_id = o.store_id
 GROUP BY s.store_name
 ORDER BY TotalRevenue DESC

 -- Finding the store with the highest average order value
 SELECT TOP 1 
    s.store_name AS Store,
    AVG(oi.quantity * oi.list_price) AS AvgOrderValue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN stores s ON s.store_id = o.store_id
GROUP BY s.store_name
ORDER BY AvgOrderValue DESC;

--Finding the store with most customers
SELECT COUNT(DISTINCT o.customer_id) AS TotalCustomers,
		s.store_name AS Store
FROM orders o
JOIN stores s ON s.store_id = o.store_id
GROUP BY s.store_name 
ORDER BY TotalCustomers DESC
