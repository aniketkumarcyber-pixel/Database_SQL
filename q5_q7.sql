
-- Q4. Frequently purchased brands
SELECT TOP 10 pr.brand, COUNT(*) AS orders
FROM PURCHASE p
JOIN PRODUCT pr ON p.product_id = pr.product_id
GROUP BY pr.brand
ORDER BY orders DESC;

-- Q5. Seasonal / monthly shopping trend
SELECT FORMAT(purchase_date, 'yyyy-MM') AS month,
       COUNT(*) AS total_orders, SUM(amount) AS total_spend
FROM PURCHASE
GROUP BY FORMAT(purchase_date, 'yyyy-MM')
ORDER BY month;

-- Q6. Prime vs Non-Prime average order value
SELECT is_prime, COUNT(*) AS orders, ROUND(AVG(amount),2) AS avg_order_value
FROM PURCHASE
GROUP BY is_prime;

-- Q7. Delivery preference distribution
SELECT delivery_preference, COUNT(*) AS orders
FROM PURCHASE
GROUP BY delivery_preference
ORDER BY orders DESC;