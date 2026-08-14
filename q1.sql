-- Q1. Most preferred shopping category (by number of orders)
SELECT pc.category_name, COUNT(*) AS total_orders, SUM(p.amount) AS total_spend
FROM PURCHASE p
JOIN PRODUCT pr ON p.product_id = pr.product_id
JOIN PRODUCT_CATEGORY pc ON pr.category_id = pc.category_id
GROUP BY pc.category_name
ORDER BY total_orders DESC;