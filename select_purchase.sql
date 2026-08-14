SELECT
    p.purchase_id,
    p.product_id,
    pr.product_name,
    pc.category_name,
    p.amount
FROM PURCHASE AS p
JOIN PRODUCT AS pr
    ON p.product_id = pr.product_id
JOIN PRODUCT_CATEGORY AS pc
    ON pr.category_id = pc.category_id;