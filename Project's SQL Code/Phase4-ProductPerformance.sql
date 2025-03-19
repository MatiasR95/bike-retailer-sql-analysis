/*📌 Phase 4: Product Performance Analysis
1) top 10 best-selling products by revenue*/
SELECT TOP 10 ROUND(SUM(oi.quantity * oi.List_price),1) AS TotalRevenue,
	oi.product_id AS ProductID,
	p.product_name AS ProductName,
	p.model_year AS ModelYear
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY oi.product_id, p.product_name, p.model_year
ORDER BY TotalRevenue DESC

--2) Top 3 best-selling brands
SELECT TOP 3 ROUND(SUM(oi.quantity * oi.List_price),1) AS TotalRevenue,
		b.brand_id AS BrandID,
		b.brand_name AS Brand
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
JOIN brands b ON b.brand_id = p.brand_id
GROUP BY b.brand_id, b.brand_name
ORDER BY TotalRevenue DESC

--3)TOP 3 sold product category
SELECT TOP 3 SUM(oi.quantity) AS TotalUnitsSold,
		p.category_id AS CategoryID,
		c.category_name CategoryName
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
JOIN categories c ON c.category_id = p.category_id
GROUP BY p.category_id, c.category_name
ORDER BY TotalUnitsSold DESC

--4) Total revenue per brand and its percentage of total revenue
WITH TotalsPerBrand AS (
    SELECT 
        b.brand_name AS Brand,
        SUM(oi.quantity * oi.list_price) AS TotalRevenue
    FROM order_items oi
    JOIN products p ON p.product_id = oi.product_id
    JOIN brands b ON b.brand_id = p.brand_id
    GROUP BY b.brand_name
)SELECT 
    Brand,
    TotalRevenue,
    ROUND((TotalRevenue * 100.0) / SUM(TotalRevenue) OVER (), 2) AS Percentage
FROM TotalsPerBrand
ORDER BY TotalRevenue DESC;
