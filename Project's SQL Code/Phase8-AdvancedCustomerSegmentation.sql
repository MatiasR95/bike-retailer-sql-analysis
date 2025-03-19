/*📌 Phase 8: Customer Segmentation Analysis
📊 Goal: Understand customer behavior and demographics to target the right audience effectively.

📌 1. Customer Segmentation by Location (City & State)
"Which states contribute the most revenue, and how does revenue distribution vary across cities?"*/
WITH RevenuePerState AS(
SELECT c.state AS State,
		ROUND(SUM(oi.quantity * oi.list_price) - SUM(oi.quantity * oi.list_price * oi.discount),1) AS TotalRevenue,
		RANK() OVER(ORDER BY (SUM(oi.quantity * oi.list_price) - SUM(oi.quantity * oi.list_price * oi.discount)) DESC) AS Rank,
		SUM(SUM(oi.quantity * oi.list_price) - SUM(oi.quantity * oi.list_price * oi.discount)) OVER() AS RunningTotal
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.state
)
SELECT *, (TotalRevenue / RunningTotal) * 100 AS PercentageOfTotal,
		CASE WHEN((TotalRevenue / RunningTotal) * 100) > 50 THEN 'High Revenue'
		ELSE 'Low Revenue' END AS RevenueCategory
FROM RevenuePerState;

/*📌 2. High-Value vs. Low-Value Customers (Customer Tiers)
💡 Question:
"Can we classify customers into tiers based on how much they spend?"*/
WITH TotalSpent AS (
    SELECT 
        o.customer_id,
        ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)),1) AS TotalSpent,
        PERCENT_RANK() OVER (ORDER BY SUM(oi.quantity * oi.list_price * (1 - oi.discount)) DESC) AS RankPercentage
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    GROUP BY o.customer_id
)
SELECT *, 
    CASE 
        WHEN RankPercentage <= 0.25 THEN 'VIP'
        WHEN RankPercentage <= 0.50 THEN 'Regular'
        ELSE 'Low-Spending'
    END AS ClientCategory
FROM TotalSpent
ORDER BY TotalSpent DESC;


/*📌 3. Analyzing Recency of Customer Purchases
💡 Question:
"Who are our most recent vs. least recent customers, and should we re-engage inactive ones?"*/
WITH OrderDays AS
(SELECT COUNT(DISTINCT o.order_id) AS TotalOrders,
		MAX(o.order_date) AS LastOrder,
		MIN(o.order_date) AS FirstOrder,
		DATEDIFF(DAY, MAX(o.order_date),'2019-01-01') AS DaysSinceLastOrder,-- Here I pretend we are on 1-1-2019
		c.first_name + ' ' + c.last_name AS Customer
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.first_name, c.last_name)
SELECT *, 
		CASE
		WHEN DaysSinceLastOrder < 200 THEN 'Active'
		WHEN DaysSinceLastOrder BETWEEN 200 AND 400 THEN 'Dormant'
		WHEN DaysSinceLastOrder > 400 THEN 'Churned'
		END AS ClientStatus
FROM OrderDays
ORDER BY DaysSinceLastOrder ASC

/*📌 4. Finding Loyal Customers vs. One-Time Buyers
💡 Question:
"Which customers make repeat purchases, and how does their spending compare to one-time buyers?"*/
WITH TotalOrders AS
(SELECT c.first_name + ' ' + c.last_name AS Customer,
		COUNT(DISTINCT o.order_id) AS TotalOrders,
		ROUND(SUM(oi.quantity * oi.list_price) - SUM(oi.quantity * oi.list_price * oi.discount),1) AS TotalSpended,
		CASE
			WHEN COUNT(DISTINCT o.order_id) > 1 THEN 'Repeted Customer'
			WHEN COUNT(DISTINCT o.order_id) = 1 THEN 'One Time Buyer'
			END AS CustomersLabel
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.first_name, c.last_name)
SELECT *,
		SUM(TotalSpended) OVER(PARTITION BY CustomersLabel) AS TotalPerLabel,
		AVG(TotalSpended) OVER(PARTITION BY CustomersLabel) AS AVGPerLabel
FROM TotalOrders
ORDER BY TotalOrders DESC, TotalSpended DESC
