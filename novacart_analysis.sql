-- =====================================================================
-- NovaCart E-Commerce : Student Buying Pattern Analysis
-- DATABASE SCHEMA (DDL)
-- =====================================================================


USE novacart_student_analytics2;

CREATE TABLE STUDENT2 (
    student_id      INT PRIMARY KEY IDENTITY(1,1),
    student_name    VARCHAR(100) NOT NULL,
    age             INT NOT NULL,
    age_group       VARCHAR(30),
    gender          VARCHAR(10),
    city            VARCHAR(50),
    email           VARCHAR(100) UNIQUE
);

CREATE TABLE PRODUCT_CATEGORY (
    category_id     INT PRIMARY KEY IDENTITY(1,1),
    category_name   VARCHAR(50) NOT NULL,
    is_eco_friendly VARCHAR(3) DEFAULT 'No'
);

CREATE TABLE PRODUCT (
    product_id      INT PRIMARY KEY IDENTITY(1,1),
    product_name    VARCHAR(100) NOT NULL,
    category_id     INT NOT NULL,
    brand           VARCHAR(50),
    price           DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES PRODUCT_CATEGORY(category_id)
);

CREATE TABLE PURCHASE (
    purchase_id         INT PRIMARY KEY IDENTITY(1,1),
    student_id          INT NOT NULL,
    product_id          INT NOT NULL,
    purchase_date       DATE NOT NULL,
    quantity            INT DEFAULT 1,
    amount              DECIMAL(10,2) NOT NULL,
    payment_method      VARCHAR(30),
    delivery_preference VARCHAR(20),
    is_prime            VARCHAR(3) DEFAULT 'No',
    FOREIGN KEY (student_id) REFERENCES STUDENT1(student_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id)
);

CREATE TABLE REVIEW (
    review_id       INT PRIMARY KEY IDENTITY(1,1),
    purchase_id     INT NOT NULL,
    rating          INT CHECK (rating BETWEEN 1 AND 5),
    comment         VARCHAR(255),
    review_date     DATE,
    FOREIGN KEY (purchase_id) REFERENCES PURCHASE(purchase_id)
);

CREATE TABLE WISHLIST (
    wishlist_id     INT PRIMARY KEY IDENTITY(1,1),
    student_id      INT NOT NULL,
    product_id      INT NOT NULL,
    added_date      DATE,
    FOREIGN KEY (student_id) REFERENCES STUDENT2(student_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id)
);

-- =====================================================================
-- SAMPLE DATA (first few rows shown; full dataset in the attached workbook)
-- =====================================================================

-- STUDENT
INSERT INTO STUDENT2 (student_id, student_name, age, age_group, gender, city, email) VALUES (1, 'Krishna Sharma', 15, '13-15 (Middle School)', 'Female', 'Hyderabad', 'krishna.sharma1@studentmail.com');
INSERT INTO STUDENT2 (student_id, student_name, age, age_group, gender, city, email) VALUES (2, 'Kiara Reddy', 15, '13-15 (Middle School)', 'Male', 'Jaipur', 'kiara.reddy2@studentmail.com');
INSERT INTO STUDENT2 (student_id, student_name, age, age_group, gender, city, email) VALUES (3, 'Sai Das', 14, '13-15 (Middle School)', 'Male', 'Bengaluru', 'sai.das3@studentmail.com');
INSERT INTO STUDENT2 (student_id, student_name, age, age_group, gender, city, email) VALUES (4, 'Sai Mehta', 13, '13-15 (Middle School)', 'Male', 'Jaipur', 'sai.mehta4@studentmail.com');
INSERT INTO STUDENT2 (student_id, student_name, age, age_group, gender, city, email) VALUES (5, 'Saanvi Bhatt', 14, '13-15 (Middle School)', 'Male', 'Ahmedabad', 'saanvi.bhatt5@studentmail.com');
INSERT INTO STUDENT2 (student_id, student_name, age, age_group, gender, city, email) VALUES (6, 'Isha Kapoor', 13, '13-15 (Middle School)', 'Male', 'Kolkata', 'isha.kapoor6@studentmail.com');

-- PRODUCT_CATEGORY
INSERT INTO PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (1, 'Stationery & Books', 'Yes');
INSERT INTO PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (2, 'Electronics & Gadgets', 'No');
INSERT INTO PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (3, 'Fashion & Apparel', 'No');
INSERT INTO PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (4, 'Footwear', 'No');
INSERT INTO PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (5, 'Backpacks & Bags', 'Yes');
INSERT INTO PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (6, 'Beauty & Personal Care', 'No');
INSERT INTO PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (7, 'Sports & Fitness', 'Yes');
INSERT INTO PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (8, 'Food & Snacks', 'No');
INSERT INTO PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (9, 'Home & Dorm Essentials', 'Yes');
INSERT INTO PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (10, 'Mobile Accessories', 'No');

-- PRODUCT
INSERT INTO PRODUCT (product_id, product_name, category_id, brand, price) VALUES (1, 'Notebook Set (5 pcs)', 1, 'Classmate', 249);
INSERT INTO PRODUCT (product_id, product_name, category_id, brand, price) VALUES (2, 'Recycled Paper Notebook', 1, 'Navneet', 199);
INSERT INTO PRODUCT (product_id, product_name, category_id, brand, price) VALUES (3, 'Gel Pen Pack', 1, 'Cello', 99);
INSERT INTO PRODUCT (product_id, product_name, category_id, brand, price) VALUES (4, 'Wireless Earbuds', 2, 'boAt', 1499);
INSERT INTO PRODUCT (product_id, product_name, category_id, brand, price) VALUES (5, 'Bluetooth Speaker', 2, 'JBL', 2499);
INSERT INTO PRODUCT (product_id, product_name, category_id, brand, price) VALUES (6, 'Power Bank 10000mAh', 2, 'Mi', 999);
INSERT INTO PRODUCT (product_id, product_name, category_id, brand, price) VALUES (7, 'Smart Watch', 2, 'Noise', 2999);
INSERT INTO PRODUCT (product_id, product_name, category_id, brand, price) VALUES (8, 'Graphic Print T-Shirt', 3, 'H&M', 699);

-- PURCHASE
INSERT INTO PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (1, 1, 21, '2026-04-23', 1, 120, 'Debit Card', 'Standard', 'Yes');
INSERT INTO PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (2, 1, 15, '2025-10-08', 1, 249, 'Cash on Delivery', 'Standard', 'No');
INSERT INTO PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (3, 1, 5, '2025-10-06', 1, 2499, 'Credit Card', 'Express', 'No');
INSERT INTO PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (4, 1, 6, '2026-06-06', 2, 1998, 'Debit Card', 'Scheduled', 'Yes');
INSERT INTO PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (5, 1, 22, '2025-10-24', 1, 499, 'Credit Card', 'Express', 'Yes');
INSERT INTO PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (6, 1, 4, '2026-01-18', 1, 1499, 'Debit Card', 'Scheduled', 'Yes');

-- REVIEW
INSERT INTO REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (1, 2, 5, 'Not satisfied, quality could be better.', '2025-10-09');
INSERT INTO REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (2, 4, 4, 'Average product, packaging was poor.', '2026-06-07');
INSERT INTO REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (3, 5, 4, 'Delivery was fast, product as expected.', '2025-10-30');
INSERT INTO REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (4, 6, 5, 'Value for money purchase.', '2026-01-21');
INSERT INTO REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (5, 8, 3, 'Delivery was fast, product as expected.', '2026-07-28');
INSERT INTO REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (6, 9, 4, 'Average product, packaging was poor.', '2025-11-09');

-- WISHLIST
INSERT INTO WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (1, 1, 1, '2026-02-25');
INSERT INTO WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (2, 1, 8, '2026-07-23');
INSERT INTO WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (3, 1, 18, '2025-09-05');
INSERT INTO WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (4, 2, 1, '2026-03-12');
INSERT INTO WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (5, 2, 25, '2026-02-05');
INSERT INTO WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (6, 4, 17, '2025-12-31');

-- =====================================================================
-- ANALYTICAL SQL QUERIES
-- =====================================================================

-- Q1. Most preferred shopping category (by number of orders)
SELECT pc.category_name, COUNT(*) AS total_orders, SUM(p.amount) AS total_spend
FROM PURCHASE p
JOIN PRODUCT pr ON p.product_id = pr.product_id
JOIN PRODUCT_CATEGORY pc ON pr.category_id = pc.category_id
GROUP BY pc.category_name
ORDER BY total_orders DESC;

-- Q2. Average spend per student
SELECT s.student_id, s.student_name, ROUND(AVG(p.amount),2) AS avg_spend,
       COUNT(*) AS total_orders
FROM PURCHASE p
JOIN STUDENT2 s ON p.student_id = s.student_id
GROUP BY s.student_id, s.student_name
ORDER BY avg_spend DESC;

-- Q3. Spending behaviour and purchase frequency by age group
SELECT s.age_group, COUNT(*) AS total_orders,
       SUM(p.amount) AS total_spend,
       ROUND(SUM(p.amount)/COUNT(*),2) AS avg_order_value
FROM PURCHASE p
JOIN STUDENT2 s ON p.student_id = s.student_id
GROUP BY s.age_group
ORDER BY total_spend DESC;

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

-- Q8. Customer satisfaction through ratings (category-wise)
SELECT pc.category_name, ROUND(AVG(r.rating),2) AS avg_rating, COUNT(r.review_id) AS total_reviews
FROM REVIEW r
JOIN PURCHASE p ON r.purchase_id = p.purchase_id
JOIN PRODUCT pr ON p.product_id = pr.product_id
JOIN PRODUCT_CATEGORY pc ON pr.category_id = pc.category_id
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

-- Q11. Wishlist items not yet purchased (potential recommendation candidates)
SELECT s.student_name, pr.product_name, w.added_date
FROM WISHLIST w
JOIN STUDENT2 s ON w.student_id = s.student_id
JOIN PRODUCT pr ON w.product_id = pr.product_id
LEFT JOIN PURCHASE p ON p.student_id = w.student_id AND p.product_id = w.product_id
WHERE p.purchase_id IS NULL;

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
