# 🚲 SQL Data Analysis Project: Bike Retailer Business Insights  

## 📊 Project Overview  
This project analyzes **three years of sales data (2016-2018) for a bike retailer with three stores across different states**. The business has experienced a **consistent decline in performance, with 2018 being its worst year**, making it crucial to analyze revenue trends, customer behavior, product sales, and logistics.  

This project applies **advanced SQL techniques** to simulate real-world business analysis, aiming to answer key questions stakeholders would ask about revenue, customer segmentation, and store performance.  

## 🛠️ SQL Techniques & Tools Used  
This project showcases **key SQL skills**, demonstrating how structured queries and data transformations can lead to actionable business insights.  

✔ **Data Exploration & Cleaning:** Checking for missing values, duplicate records, and data inconsistencies.  
✔ **Advanced Joins & CTEs:** `INNER JOIN`, `LEFT JOIN`, `WITH (CTE)`, optimizing complex queries.  
✔ **Aggregations & Window Functions:** `SUM()`, `COUNT()`, `AVG()`, `RANK()`, `PARTITION BY` for ranking customers and revenue.  
✔ **Customer Segmentation & Classification:** `CASE`, `DATEDIFF()`, applying **RFM (Recency, Frequency, Monetary) analysis**.  
✔ **Revenue & Business Performance:** `GROUP BY YEAR(order_date)`, identifying **yearly trends and underperforming areas**.  
✔ **Shipping & Logistics:** Analyzing **on-time vs. delayed orders** and average shipping times.  

## 📂 Project Structure & SQL Queries  
The SQL code is **organized into 8 phases**, each tackling a different business question:  

### **📌 Phase 1: Data Exploration & Cleaning**  
✔ Understanding database structure using `INFORMATION_SCHEMA.COLUMNS`.  
✔ Checking for **NULL values and duplicated data**.  
✔ Identifying the **earliest and latest sales records (2016-2018)**.  

### **📌 Phase 2: Business Performance Analysis**  
✔ Yearly revenue comparison & business trend analysis.  
✔ Identifying the **best-performing store** by revenue.  
✔ Evaluating the impact of **discounts on total revenue**.  

### **📌 Phase 3: Customer Behavior & Segmentation**  
✔ Classifying **repeat vs. one-time customers**.  
✔ Identifying the **top 5 highest-spending customers**.  
✔ Analyzing customer revenue contribution using `CASE`.  

### **📌 Phase 4: Product Performance Analysis**  
✔ Determining **best-selling products** and most profitable categories.  
✔ Ranking **top revenue-generating brands**.  
✔ Evaluating discount impact on specific product categories.  

### **📌 Phase 5: Store & Regional Performance**  
✔ Ranking **stores based on revenue and sales volume**.  
✔ Finding the **highest average order value per store**.  
✔ Comparing state-wise revenue contributions.  

### **📌 Phase 6: Shipping & Logistics**  
✔ Analyzing **average shipping time per store and state**.  
✔ Identifying **late shipments and their business impact**.  
✔ Assessing order fulfillment rates.  

### **📌 Phase 7: Customer Retention & RFM Analysis**  
✔ Implementing **RFM Segmentation**:  
   - **Recency:** How long since a customer’s last purchase?  
   - **Frequency:** How often do they buy?  
   - **Monetary Value:** How much have they spent?  
✔ Categorizing customers into **VIP, Regular, and Low-Spending** groups.  

### **📌 Phase 8: Advanced Customer Segmentation**  
✔ Classifying **high-value vs. low-value customers** based on total spending (`PERCENT_RANK()`).  
✔ Identifying **most recent vs. least recent customers**.  
✔ Analyzing **loyal customers vs. one-time buyers**.  

## 📥 How to Use the SQL Files  
Each phase of the analysis is stored in a **separate SQL file** for clarity.  
To run the queries, simply:  
1. Open **Microsoft SQL Server Management Studio (SSMS)** or a compatible SQL environment.  
2. Load the corresponding `.sql` file.  
3. Run the queries and explore the results.  

---

## 🔗 Resources & Links  
📌 **Full SQL Code on GitHub:** [(https://github.com/MatiasR95/bike-retailer-sql-analysis/tree/main/Project's%20SQL%20Code)](#)  
📂 **Portfolio Website:** [https://matirossi87mr.wixsite.com/matiasrossi-porfolio](#)  
👥 **Connect with Me on LinkedIn:** [www.linkedin.com/in/matias-rossi-95-data-strength](#)  

🚀 **Stay tuned for business insights and recommendations based on this analysis!**  
