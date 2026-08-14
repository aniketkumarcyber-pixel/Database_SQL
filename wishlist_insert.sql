SET IDENTITY_INSERT WISHLIST ON;

INSERT INTO WISHLIST
(wishlist_id, student_id, product_id, added_date)
VALUES
(1, 1, 1, '2026-02-25');

INSERT INTO WISHLIST
(wishlist_id, student_id, product_id, added_date)
VALUES
(2, 1, 8, '2026-07-23');

INSERT INTO WISHLIST
(wishlist_id, student_id, product_id, added_date)
VALUES
(3, 1, 3, '2025-09-05');

INSERT INTO WISHLIST
(wishlist_id, student_id, product_id, added_date)
VALUES
(4, 2, 1, '2025-03-12');

INSERT INTO WISHLIST
(wishlist_id, student_id, product_id, added_date)
VALUES
(5, 2, 5, '2026-02-05');

INSERT INTO WISHLIST
(wishlist_id, student_id, product_id, added_date)
VALUES
(6, 4, 7, '2025-12-31');

SET IDENTITY_INSERT WISHLIST OFF;

SELECT * FROM WISHLIST;