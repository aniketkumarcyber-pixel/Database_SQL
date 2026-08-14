-- Q12. Simple "customers also bought" style recommendation base query
-- (co-purchase pairs within the same category, for a given student's last purchase)
SELECT TOP 5
    p2.product_id,
    pr2.product_name,
    COUNT(*) AS co_occurrence
FROM PURCHASE p1
JOIN PURCHASE p2 
    ON p1.student_id = p2.student_id 
    AND p1.product_id <> p2.product_id
JOIN PRODUCT pr2 
    ON p2.product_id = pr2.product_id
WHERE p1.product_id = 4
GROUP BY p2.product_id, pr2.product_name
ORDER BY co_occurrence DESC;