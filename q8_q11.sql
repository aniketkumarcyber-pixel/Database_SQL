-- Q8. Customer satisfaction through ratings (category-wise)

SELECT
    pc.category_name,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    COUNT(r.review_id) AS total_reviews
FROM REVIEW r
JOIN PURCHASE p
    ON r.purchase_id = p.purchase_id
JOIN PRODUCT pr
    ON p.product_id = pr.product_id
JOIN PRODUCT_CATEGORY pc
    ON pr.category_id = pc.category_id
GROUP BY pc.category_name
ORDER BY avg_rating DESC;

-- Q9. Payment method analysis
SELECT payment_method, COUNT(*) AS orders,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM PURCHASE), 1) AS pct_of_orders
FROM PURCHASE
GROUP BY payment_method
ORDER BY orders DESC;

-- Q10. Eco-friendly vs non-eco category spend share (sustainability view)
SELECT pc.is_eco_friendly, COUNT(*) AS orders, SUM(p.amount) AS total_spend
FROM PURCHASE p
JOIN PRODUCT pr ON p.product_id = pr.product_id
JOIN PRODUCT_CATEGORY pc ON pr.category_id = pc.category_id
GROUP BY pc.is_eco_friendly;

-- Q11. Wishlist items not yet purchased

SELECT
    s.student_name,
    pr.product_name,
    w.added_date
FROM WISHLIST w
JOIN STUDENT s
    ON w.student_id = s.student_id
JOIN PRODUCT pr
    ON w.product_id = pr.product_id
LEFT JOIN PURCHASE p
    ON p.student_id = w.student_id
    AND p.product_id = w.product_id
WHERE p.purchase_id IS NULL;