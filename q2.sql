-- Q2. Average spend per student
SELECT s.student_id, s.student_name, ROUND(AVG(p.amount),2) AS avg_spend,
       COUNT(*) AS total_orders
FROM PURCHASE p
JOIN STUDENT s ON p.student_id = s.student_id
GROUP BY s.student_id, s.student_name
ORDER BY avg_spend DESC;