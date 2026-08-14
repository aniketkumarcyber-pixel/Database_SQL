USE novacart_student_analytics2;
GO

SET IDENTITY_INSERT dbo.PURCHASE ON;

INSERT INTO dbo.PURCHASE
(purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime)
VALUES
(1, 1, 1, '2026-04-23', 1, 120, 'Debit Card', 'Standard', 'Yes');

INSERT INTO dbo.PURCHASE
(purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime)
VALUES
(2, 2, 2, '2025-10-08', 1, 249, 'Cash on Delivery', 'Standard', 'No');

INSERT INTO dbo.PURCHASE
(purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime)
VALUES
(3, 3, 3, '2025-10-06', 1, 2499, 'Credit Card', 'Express', 'No');

INSERT INTO dbo.PURCHASE
(purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime)
VALUES
(4, 4, 6, '2026-06-06', 2, 1998, 'Debit Card', 'Scheduled', 'Yes');

INSERT INTO dbo.PURCHASE
(purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime)
VALUES
(5, 5, 2, '2025-10-24', 1, 499, 'Credit Card', 'Express', 'Yes');

INSERT INTO dbo.PURCHASE
(purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime)
VALUES
(6, 6, 4, '2026-01-18', 1, 1499, 'Debit Card', 'Scheduled', 'Yes');

SET IDENTITY_INSERT dbo.PURCHASE OFF;
GO

SELECT * FROM dbo.PURCHASE;