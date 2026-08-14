
-- Q3. Spending behaviour and purchase frequency by age group
SELECT s.age_group, COUNT(*) AS total_orders,
       SUM(p.amount) AS total_spend,
       ROUND(SUM(p.amount)/COUNT(*),2) AS avg_order_value
FROM PURCHASE p
JOIN STUDENT s ON p.student_id = s.student_id
GROUP BY s.age_group
ORDER BY total_spend DESC;