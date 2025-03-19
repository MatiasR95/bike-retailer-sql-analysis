/*📌 Phase 6: Shipping & Logistics Analysis
1) Calculate the average shipping time per store*/
WITH Shippments AS
(SELECT o.order_date, o.shipped_date,
	DATEDIFF(DAY, o.order_date, o.shipped_date) AS ShippingTime,
		s.store_name, o.order_id
FROM orders o
JOIN stores s ON s.store_id = o.store_id
WHERE o.order_date NOT LIKE 'NULL' AND o.shipped_date NOT LIKE 'NULL')
SELECT AVG(ShippingTime) AS AVGSHIP,
		store_name
FROM Shippments
GROUP BY store_name;

--2) percentage of orders that were shipped late
WITH DaysToShip AS (
    SELECT 
        DATEDIFF(DAY, o.required_date, o.shipped_date) AS DaysToShip,
        o.order_id AS OrderID
    FROM orders o
)
SELECT 
    COUNT(*) AS TotalOrders,
    SUM(CASE WHEN DaysToShip > 0 THEN 1 ELSE 0 END) AS LateOrders,
    (SUM(CASE WHEN DaysToShip > 0 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS LateOrderPercentage
FROM DaysToShip;
