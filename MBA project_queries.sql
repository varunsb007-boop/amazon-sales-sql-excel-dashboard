


   ============================================================
   1. BUSINESS OVERVIEW KPIs
   Purpose: Understand overall scale and performance of business
   ============================================================ 

-- Total Revenue (excluding cancelled orders)
SELECT ROUND(SUM(amount), 2) AS total_revenue
FROM amazon_sale_report
WHERE qty > 0;

-- Total Units Sold (excluding cancelled orders)
SELECT SUM(qty) AS total_units_sold
FROM amazon_sale_report
WHERE qty > 0;


   ============================================================
   2. PRODUCT PERFORMANCE ANALYSIS
   Purpose: Identify top revenue generating products and categories
   ============================================================ 

-- Top 10 SKUs by Revenue
SELECT 
    sku, 
    SUM(amount) AS total_revenue,
    SUM(qty) AS total_units_sold,
    ROUND(SUM(amount) / SUM(qty), 2) AS avg_revenue_per_unit
FROM amazon_sale_report
WHERE qty > 0
GROUP BY sku
ORDER BY total_revenue DESC
LIMIT 10;

-- Category-wise Revenue and Units Sold
SELECT 
    category,
    SUM(amount) AS total_revenue,
    SUM(qty) AS total_units_sold
FROM amazon_sale_report
WHERE qty > 0
GROUP BY category
ORDER BY total_revenue DESC;


   ============================================================
   3. OPERATIONAL PERFORMANCE ANALYSIS
   Purpose: Evaluate fulfilment efficiency and order status health
   ============================================================ 

-- Fulfilment Performance Analysis
SELECT 
    fulfilment,
    SUM(amount) AS total_revenue,
    SUM(qty) AS total_units_sold,
    ROUND(SUM(amount) / SUM(qty), 2) AS avg_revenue_per_unit
FROM amazon_sale_report 
WHERE qty > 0
GROUP BY fulfilment
ORDER BY total_revenue DESC;

-- Order Status Distribution
SELECT 
    status,
    COUNT(*) AS total_orders,
    ROUND(SUM(amount), 2) AS total_revenue
FROM amazon_sale_report
GROUP BY status
ORDER BY total_revenue DESC;


   ============================================================
   4. CUSTOMER SEGMENTATION ANALYSIS
   Purpose: Compare B2B vs B2C business contribution
   ============================================================ 

SELECT 
    CASE 
        WHEN b2b = 'true' THEN 'B2B'
        ELSE 'B2C'
    END AS customer_type,
    COUNT(*) AS total_orders,
    SUM(qty) AS total_units_sold,
    ROUND(SUM(amount), 2) AS total_revenue,
    ROUND(SUM(amount) / SUM(qty), 2) AS avg_revenue_per_unit
FROM amazon_sale_report
WHERE qty > 0
GROUP BY customer_type;


   ============================================================
   5. SALES TREND ANALYSIS
   Purpose: Identify monthly revenue and volume trends
   ============================================================ 

SELECT 
    DATE_FORMAT(date, '%Y-%m') AS month,
    SUM(amount) AS revenue,
    SUM(qty) AS units
FROM amazon_sale_report
WHERE qty > 0
GROUP BY month
ORDER BY month;
