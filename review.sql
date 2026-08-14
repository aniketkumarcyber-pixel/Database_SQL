-- REVIEW

SET IDENTITY_INSERT REVIEW ON;

INSERT INTO REVIEW
(review_id, purchase_id, rating, comment, review_date)
VALUES
(1, 2, 5, 'Not satisfied, quality could be better.', '2025-10-09');

INSERT INTO REVIEW
(review_id, purchase_id, rating, comment, review_date)
VALUES
(2, 4, 4, 'Average product, packaging was poor.', '2026-06-07');

INSERT INTO REVIEW
(review_id, purchase_id, rating, comment, review_date)
VALUES
(3, 5, 4, 'Delivery was fast, product as expected.', '2025-10-30');

INSERT INTO REVIEW
(review_id, purchase_id, rating, comment, review_date)
VALUES
(4, 6, 5, 'Value for money purchase.', '2026-01-21');

INSERT INTO REVIEW
(review_id, purchase_id, rating, comment, review_date)
VALUES
(5, 1, 3, 'Delivery was fast, product was as expected.', '2026-07-28');

INSERT INTO REVIEW
(review_id, purchase_id, rating, comment, review_date)
VALUES
(6, 3, 4, 'Average product, packaging was poor.', '2025-11-09');

SET IDENTITY_INSERT REVIEW OFF;