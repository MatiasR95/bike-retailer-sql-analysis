/*📌 Phase 7: Customer Retention & RFM Analysis
RFM Segmentation:
Recency: How many days since each customer’s last purchase?
Frequency: How many orders has each customer made?
Monetary: How much has each customer spent?*/

SELECT  MAX(o.order_date) AS LastPurchase,
		DATEDIFF(DAY, '2019-01-01', MAX(o.order_date)) AS TimeSinceLastPurchase, 
		COUNT(DISTINCT o.order_id) AS TotalOrders,
		ROUND(SUM(oi.quantity * oi.list_price),1) - ROUND(SUM(oi.quantity * list_price * oi.discount),1) AS TotalSpent,
		c.first_name + ' ' + c.last_name AS Customer
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY TotalOrders DESC, TimeSinceLastPurchase DESC
