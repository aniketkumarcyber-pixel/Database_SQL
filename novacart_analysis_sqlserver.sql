/* =====================================================================
   NovaCart E-Commerce : Student Buying Pattern Analysis
   DATABASE SCHEMA (DDL) -- Microsoft SQL Server / SSMS (T-SQL)
   =====================================================================
   How to run in SSMS:
   1. Open SQL Server Management Studio, connect to your server.
   2. Open this file (File > Open > File...).
   3. Click "Execute" (or press F5) to run the whole script top to bottom.
   The script creates its own database (NovaCart_Student_Analytics),
   so you do not need to create one manually first.
   ===================================================================== */

IF DB_ID('NovaCart_Student_Analytics') IS NOT NULL
BEGIN
    ALTER DATABASE NovaCart_Student_Analytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE NovaCart_Student_Analytics;
END
GO

CREATE DATABASE NovaCart_Student_Analytics;
GO

USE NovaCart_Student_Analytics;
GO

-- ---------------------------------------------------------------------
-- Drop tables if they already exist (safe re-run), children before parents
-- ---------------------------------------------------------------------
IF OBJECT_ID('dbo.REVIEW', 'U')   IS NOT NULL DROP TABLE dbo.REVIEW;
IF OBJECT_ID('dbo.WISHLIST', 'U') IS NOT NULL DROP TABLE dbo.WISHLIST;
IF OBJECT_ID('dbo.PURCHASE', 'U') IS NOT NULL DROP TABLE dbo.PURCHASE;
IF OBJECT_ID('dbo.PRODUCT', 'U')  IS NOT NULL DROP TABLE dbo.PRODUCT;
IF OBJECT_ID('dbo.PRODUCT_CATEGORY', 'U') IS NOT NULL DROP TABLE dbo.PRODUCT_CATEGORY;
IF OBJECT_ID('dbo.STUDENT', 'U')  IS NOT NULL DROP TABLE dbo.STUDENT;
GO

-- ---------------------------------------------------------------------
-- STUDENT
-- ---------------------------------------------------------------------
CREATE TABLE dbo.STUDENT (
    student_id      INT IDENTITY(1,1) PRIMARY KEY,
    student_name    VARCHAR(100) NOT NULL,
    age             INT NOT NULL,
    age_group       VARCHAR(30) NULL,
    gender          VARCHAR(10) NULL,
    city            VARCHAR(50) NULL,
    email           VARCHAR(100) NOT NULL UNIQUE
);
GO

-- ---------------------------------------------------------------------
-- PRODUCT_CATEGORY
-- ---------------------------------------------------------------------
CREATE TABLE dbo.PRODUCT_CATEGORY (
    category_id     INT IDENTITY(1,1) PRIMARY KEY,
    category_name   VARCHAR(50) NOT NULL,
    is_eco_friendly VARCHAR(3) NOT NULL DEFAULT ('No')
);
GO

-- ---------------------------------------------------------------------
-- PRODUCT
-- ---------------------------------------------------------------------
CREATE TABLE dbo.PRODUCT (
    product_id      INT IDENTITY(1,1) PRIMARY KEY,
    product_name    VARCHAR(100) NOT NULL,
    category_id     INT NOT NULL,
    brand           VARCHAR(50) NULL,
    price           DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Product_Category FOREIGN KEY (category_id)
        REFERENCES dbo.PRODUCT_CATEGORY(category_id)
);
GO

-- ---------------------------------------------------------------------
-- PURCHASE  (transactional fact table)
-- ---------------------------------------------------------------------
CREATE TABLE dbo.PURCHASE (
    purchase_id         INT IDENTITY(1,1) PRIMARY KEY,
    student_id          INT NOT NULL,
    product_id          INT NOT NULL,
    purchase_date       DATE NOT NULL,
    quantity            INT NOT NULL DEFAULT (1),
    amount              DECIMAL(10,2) NOT NULL,
    payment_method      VARCHAR(30) NULL,
    delivery_preference VARCHAR(20) NULL,
    is_prime             VARCHAR(3) NOT NULL DEFAULT ('No'),
    CONSTRAINT FK_Purchase_Student FOREIGN KEY (student_id)
        REFERENCES dbo.STUDENT(student_id),
    CONSTRAINT FK_Purchase_Product FOREIGN KEY (product_id)
        REFERENCES dbo.PRODUCT(product_id)
);
GO

-- ---------------------------------------------------------------------
-- REVIEW
-- ---------------------------------------------------------------------
CREATE TABLE dbo.REVIEW (
    review_id       INT IDENTITY(1,1) PRIMARY KEY,
    purchase_id     INT NOT NULL,
    rating          INT NOT NULL,
    comment         VARCHAR(255) NULL,
    review_date     DATE NULL,
    CONSTRAINT FK_Review_Purchase FOREIGN KEY (purchase_id)
        REFERENCES dbo.PURCHASE(purchase_id),
    CONSTRAINT CK_Review_Rating CHECK (rating BETWEEN 1 AND 5)
);
GO

-- ---------------------------------------------------------------------
-- WISHLIST
-- ---------------------------------------------------------------------
CREATE TABLE dbo.WISHLIST (
    wishlist_id     INT IDENTITY(1,1) PRIMARY KEY,
    student_id      INT NOT NULL,
    product_id      INT NOT NULL,
    added_date      DATE NULL,
    CONSTRAINT FK_Wishlist_Student FOREIGN KEY (student_id)
        REFERENCES dbo.STUDENT(student_id),
    CONSTRAINT FK_Wishlist_Product FOREIGN KEY (product_id)
        REFERENCES dbo.PRODUCT(product_id)
);
GO

/* =====================================================================
   SAMPLE / FULL DATA LOAD (DML)
   Full dataset: 60 students, 10 categories, 25 products,
   310 purchases, 220 reviews, 106 wishlist rows.
   ===================================================================== */

-- STUDENT (60 rows)
SET IDENTITY_INSERT dbo.STUDENT ON;
GO
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (1, 'Krishna Sharma', 15, '13-15 (Middle School)', 'Female', 'Hyderabad', 'krishna.sharma1@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (2, 'Kiara Reddy', 15, '13-15 (Middle School)', 'Male', 'Jaipur', 'kiara.reddy2@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (3, 'Sai Das', 14, '13-15 (Middle School)', 'Male', 'Bengaluru', 'sai.das3@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (4, 'Sai Mehta', 13, '13-15 (Middle School)', 'Male', 'Jaipur', 'sai.mehta4@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (5, 'Saanvi Bhatt', 14, '13-15 (Middle School)', 'Male', 'Ahmedabad', 'saanvi.bhatt5@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (6, 'Isha Kapoor', 13, '13-15 (Middle School)', 'Male', 'Kolkata', 'isha.kapoor6@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (7, 'Dhruv Kapoor', 13, '13-15 (Middle School)', 'Male', 'Pune', 'dhruv.kapoor7@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (8, 'Reyansh Iyer', 14, '13-15 (Middle School)', 'Male', 'Pune', 'reyansh.iyer8@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (9, 'Yash Kulkarni', 14, '13-15 (Middle School)', 'Male', 'Ahmedabad', 'yash.kulkarni9@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (10, 'Rohit Nair', 14, '13-15 (Middle School)', 'Male', 'Jaipur', 'rohit.nair10@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (11, 'Riya Kulkarni', 14, '13-15 (Middle School)', 'Male', 'Mumbai', 'riya.kulkarni11@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (12, 'Aditya Rao', 14, '13-15 (Middle School)', 'Male', 'Hyderabad', 'aditya.rao12@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (13, 'Reyansh Chatterjee', 14, '13-15 (Middle School)', 'Female', 'Pune', 'reyansh.chatterjee13@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (14, 'Ananya Joshi', 14, '13-15 (Middle School)', 'Male', 'Chennai', 'ananya.joshi14@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (15, 'Arjun Kulkarni', 15, '13-15 (Middle School)', 'Male', 'Jaipur', 'arjun.kulkarni15@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (16, 'Myra Gupta', 17, '16-18 (High School)', 'Female', 'Chennai', 'myra.gupta16@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (17, 'Varun Rao', 18, '16-18 (High School)', 'Female', 'Bengaluru', 'varun.rao17@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (18, 'Kiara Verma', 17, '16-18 (High School)', 'Female', 'Chennai', 'kiara.verma18@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (19, 'Arjun Mehta', 18, '16-18 (High School)', 'Female', 'Hyderabad', 'arjun.mehta19@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (20, 'Karan Chatterjee', 18, '16-18 (High School)', 'Female', 'Delhi', 'karan.chatterjee20@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (21, 'Anika Reddy', 16, '16-18 (High School)', 'Female', 'Lucknow', 'anika.reddy21@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (22, 'Nisha Das', 17, '16-18 (High School)', 'Female', 'Hyderabad', 'nisha.das22@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (23, 'Ishaan Agarwal', 17, '16-18 (High School)', 'Male', 'Bengaluru', 'ishaan.agarwal23@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (24, 'Krishna Reddy', 18, '16-18 (High School)', 'Male', 'Kolkata', 'krishna.reddy24@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (25, 'Aman Iyer', 17, '16-18 (High School)', 'Female', 'Lucknow', 'aman.iyer25@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (26, 'Sneha Agarwal', 17, '16-18 (High School)', 'Male', 'Mumbai', 'sneha.agarwal26@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (27, 'Rohit Kapoor', 18, '16-18 (High School)', 'Female', 'Mumbai', 'rohit.kapoor27@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (28, 'Riya Bose', 16, '16-18 (High School)', 'Female', 'Bengaluru', 'riya.bose28@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (29, 'Anika Agarwal', 16, '16-18 (High School)', 'Male', 'Chennai', 'anika.agarwal29@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (30, 'Neha Kulkarni', 16, '16-18 (High School)', 'Male', 'Pune', 'neha.kulkarni30@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (31, 'Ananya Bhatt', 19, '19-22 (Undergraduate)', 'Female', 'Ahmedabad', 'ananya.bhatt31@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (32, 'Vivaan Nair', 21, '19-22 (Undergraduate)', 'Female', 'Hyderabad', 'vivaan.nair32@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (33, 'Vihaan Rao', 19, '19-22 (Undergraduate)', 'Male', 'Ahmedabad', 'vihaan.rao33@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (34, 'Arjun Bhatt', 20, '19-22 (Undergraduate)', 'Male', 'Ahmedabad', 'arjun.bhatt34@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (35, 'Varun Gupta', 21, '19-22 (Undergraduate)', 'Female', 'Hyderabad', 'varun.gupta35@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (36, 'Rohit Mehta', 21, '19-22 (Undergraduate)', 'Female', 'Pune', 'rohit.mehta36@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (37, 'Priya Agarwal', 22, '19-22 (Undergraduate)', 'Male', 'Hyderabad', 'priya.agarwal37@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (38, 'Kiara Iyer', 21, '19-22 (Undergraduate)', 'Male', 'Lucknow', 'kiara.iyer38@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (39, 'Varun Rao', 20, '19-22 (Undergraduate)', 'Male', 'Mumbai', 'varun.rao39@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (40, 'Vihaan Rao', 19, '19-22 (Undergraduate)', 'Male', 'Pune', 'vihaan.rao40@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (41, 'Arjun Agarwal', 20, '19-22 (Undergraduate)', 'Female', 'Ahmedabad', 'arjun.agarwal41@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (42, 'Aadhya Bhatt', 20, '19-22 (Undergraduate)', 'Female', 'Hyderabad', 'aadhya.bhatt42@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (43, 'Rahul Bose', 20, '19-22 (Undergraduate)', 'Male', 'Mumbai', 'rahul.bose43@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (44, 'Nisha Joshi', 22, '19-22 (Undergraduate)', 'Female', 'Ahmedabad', 'nisha.joshi44@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (45, 'Vihaan Nair', 19, '19-22 (Undergraduate)', 'Female', 'Pune', 'vihaan.nair45@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (46, 'Reyansh Rao', 24, '23-26 (Postgraduate)', 'Male', 'Jaipur', 'reyansh.rao46@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (47, 'Priya Reddy', 26, '23-26 (Postgraduate)', 'Male', 'Chennai', 'priya.reddy47@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (48, 'Sneha Rao', 23, '23-26 (Postgraduate)', 'Female', 'Jaipur', 'sneha.rao48@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (49, 'Reyansh Verma', 23, '23-26 (Postgraduate)', 'Male', 'Hyderabad', 'reyansh.verma49@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (50, 'Ananya Bose', 26, '23-26 (Postgraduate)', 'Female', 'Hyderabad', 'ananya.bose50@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (51, 'Meera Verma', 24, '23-26 (Postgraduate)', 'Female', 'Bengaluru', 'meera.verma51@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (52, 'Aryan Kapoor', 26, '23-26 (Postgraduate)', 'Female', 'Kolkata', 'aryan.kapoor52@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (53, 'Varun Pillai', 24, '23-26 (Postgraduate)', 'Male', 'Chennai', 'varun.pillai53@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (54, 'Aadhya Verma', 23, '23-26 (Postgraduate)', 'Female', 'Bengaluru', 'aadhya.verma54@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (55, 'Vihaan Das', 26, '23-26 (Postgraduate)', 'Male', 'Bengaluru', 'vihaan.das55@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (56, 'Neha Iyer', 24, '23-26 (Postgraduate)', 'Male', 'Lucknow', 'neha.iyer56@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (57, 'Arjun Rao', 26, '23-26 (Postgraduate)', 'Male', 'Lucknow', 'arjun.rao57@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (58, 'Myra Das', 23, '23-26 (Postgraduate)', 'Male', 'Kolkata', 'myra.das58@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (59, 'Isha Das', 25, '23-26 (Postgraduate)', 'Female', 'Hyderabad', 'isha.das59@studentmail.com');
INSERT INTO dbo.STUDENT (student_id, student_name, age, age_group, gender, city, email) VALUES (60, 'Kabir Rao', 25, '23-26 (Postgraduate)', 'Female', 'Delhi', 'kabir.rao60@studentmail.com');
GO
SET IDENTITY_INSERT dbo.STUDENT OFF;
GO

-- PRODUCT_CATEGORY (10 rows)
SET IDENTITY_INSERT dbo.PRODUCT_CATEGORY ON;
GO
INSERT INTO dbo.PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (1, 'Stationery & Books', 'Yes');
INSERT INTO dbo.PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (2, 'Electronics & Gadgets', 'No');
INSERT INTO dbo.PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (3, 'Fashion & Apparel', 'No');
INSERT INTO dbo.PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (4, 'Footwear', 'No');
INSERT INTO dbo.PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (5, 'Backpacks & Bags', 'Yes');
INSERT INTO dbo.PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (6, 'Beauty & Personal Care', 'No');
INSERT INTO dbo.PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (7, 'Sports & Fitness', 'Yes');
INSERT INTO dbo.PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (8, 'Food & Snacks', 'No');
INSERT INTO dbo.PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (9, 'Home & Dorm Essentials', 'Yes');
INSERT INTO dbo.PRODUCT_CATEGORY (category_id, category_name, is_eco_friendly) VALUES (10, 'Mobile Accessories', 'No');
GO
SET IDENTITY_INSERT dbo.PRODUCT_CATEGORY OFF;
GO

-- PRODUCT (25 rows)
SET IDENTITY_INSERT dbo.PRODUCT ON;
GO
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (1, 'Notebook Set (5 pcs)', 1, 'Classmate', 249);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (2, 'Recycled Paper Notebook', 1, 'Navneet', 199);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (3, 'Gel Pen Pack', 1, 'Cello', 99);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (4, 'Wireless Earbuds', 2, 'boAt', 1499);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (5, 'Bluetooth Speaker', 2, 'JBL', 2499);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (6, 'Power Bank 10000mAh', 2, 'Mi', 999);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (7, 'Smart Watch', 2, 'Noise', 2999);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (8, 'Graphic Print T-Shirt', 3, 'H&M', 699);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (9, 'Denim Jeans', 3, 'Levis', 1899);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (10, 'Hoodie', 3, 'Roadster', 1299);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (11, 'Casual Sneakers', 4, 'Bata', 1599);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (12, 'Running Shoes', 4, 'Puma', 2799);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (13, 'Laptop Backpack', 5, 'Wildcraft', 1799);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (14, 'Jute College Bag (Eco)', 5, 'Fabindia', 1099);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (15, 'Face Wash', 6, 'Nivea', 249);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (16, 'Lip Balm Combo', 6, 'Mamaearth', 349);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (17, 'Yoga Mat', 7, 'Decathlon', 899);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (18, 'Skipping Rope', 7, 'Boldfit', 299);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (19, 'Bamboo Water Bottle (Eco)', 9, 'Milton', 449);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (20, 'LED Desk Lamp', 9, 'Philips', 699);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (21, 'Instant Noodles Pack', 8, 'Maggi', 120);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (22, 'Protein Bar Box', 8, 'Yoga Bar', 499);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (23, 'Phone Case', 10, 'Spigen', 399);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (24, 'USB-C Cable', 10, 'Mi', 249);
INSERT INTO dbo.PRODUCT (product_id, product_name, category_id, brand, price) VALUES (25, 'Bluetooth Neckband', 2, 'boAt', 899);
GO
SET IDENTITY_INSERT dbo.PRODUCT OFF;
GO

-- PURCHASE (310 rows)
SET IDENTITY_INSERT dbo.PURCHASE ON;
GO
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (1, 1, 21, '2026-04-23', 1, 120, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (2, 1, 15, '2025-10-08', 1, 249, 'Cash on Delivery', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (3, 1, 5, '2025-10-06', 1, 2499, 'Credit Card', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (4, 1, 6, '2026-06-06', 2, 1998, 'Debit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (5, 1, 22, '2025-10-24', 1, 499, 'Credit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (6, 1, 4, '2026-01-18', 1, 1499, 'Debit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (7, 1, 23, '2025-12-14', 1, 399, 'Debit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (8, 2, 2, '2026-07-22', 1, 199, 'Net Banking', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (9, 2, 1, '2025-11-06', 1, 249, 'Debit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (10, 2, 18, '2026-06-15', 2, 598, 'UPI', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (11, 2, 23, '2026-06-07', 1, 399, 'UPI', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (12, 3, 5, '2026-02-05', 1, 2499, 'Debit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (13, 3, 7, '2025-10-23', 1, 2999, 'Debit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (14, 3, 20, '2025-12-31', 1, 699, 'Credit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (15, 3, 1, '2026-02-18', 1, 249, 'Net Banking', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (16, 3, 9, '2025-10-26', 1, 1899, 'Net Banking', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (17, 4, 7, '2026-02-27', 2, 5998, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (18, 4, 1, '2026-03-24', 1, 249, 'Debit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (19, 4, 25, '2026-02-27', 1, 899, 'Cash on Delivery', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (20, 5, 4, '2025-12-01', 1, 1499, 'Cash on Delivery', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (21, 5, 4, '2026-02-24', 2, 2998, 'Debit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (22, 6, 19, '2026-01-09', 1, 449, 'UPI', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (23, 6, 1, '2026-03-06', 1, 249, 'Net Banking', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (24, 6, 20, '2025-11-03', 1, 699, 'Debit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (25, 6, 22, '2026-02-15', 2, 998, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (26, 6, 18, '2025-12-08', 1, 299, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (27, 7, 24, '2026-07-13', 1, 249, 'Cash on Delivery', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (28, 7, 18, '2026-02-03', 1, 299, 'Debit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (29, 7, 19, '2026-04-27', 1, 449, 'Net Banking', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (30, 7, 17, '2025-11-26', 2, 1798, 'UPI', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (31, 7, 3, '2026-02-06', 1, 99, 'Credit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (32, 7, 1, '2026-01-04', 1, 249, 'Net Banking', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (33, 7, 15, '2026-07-20', 2, 498, 'Cash on Delivery', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (34, 8, 13, '2025-11-15', 1, 1799, 'UPI', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (35, 8, 8, '2026-05-24', 1, 699, 'Net Banking', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (36, 8, 4, '2025-11-08', 2, 2998, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (37, 8, 25, '2026-07-11', 2, 1798, 'Cash on Delivery', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (38, 8, 6, '2026-04-19', 2, 1998, 'Debit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (39, 9, 25, '2026-07-18', 2, 1798, 'Credit Card', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (40, 9, 3, '2025-12-30', 1, 99, 'Debit Card', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (41, 9, 18, '2025-11-10', 1, 299, 'Credit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (42, 9, 23, '2025-12-19', 1, 399, 'UPI', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (43, 9, 11, '2026-04-01', 2, 3198, 'UPI', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (44, 9, 13, '2026-06-22', 1, 1799, 'Net Banking', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (45, 9, 12, '2026-03-19', 1, 2799, 'Net Banking', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (46, 9, 16, '2026-01-18', 1, 349, 'Net Banking', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (47, 10, 11, '2025-11-24', 2, 3198, 'Net Banking', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (48, 10, 13, '2025-10-13', 1, 1799, 'Net Banking', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (49, 10, 6, '2026-01-12', 1, 999, 'Net Banking', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (50, 10, 15, '2026-02-20', 1, 249, 'Net Banking', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (51, 10, 9, '2026-04-29', 1, 1899, 'UPI', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (52, 11, 8, '2025-09-21', 1, 699, 'UPI', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (53, 11, 1, '2026-01-01', 1, 249, 'Credit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (54, 11, 19, '2026-04-27', 1, 449, 'Debit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (55, 11, 20, '2025-11-23', 1, 699, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (56, 12, 19, '2026-03-23', 2, 898, 'Credit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (57, 12, 4, '2026-07-05', 1, 1499, 'UPI', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (58, 12, 12, '2026-03-09', 2, 5598, 'UPI', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (59, 12, 1, '2026-05-09', 2, 498, 'UPI', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (60, 13, 15, '2026-04-11', 1, 249, 'Credit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (61, 13, 20, '2026-04-27', 2, 1398, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (62, 13, 11, '2025-10-15', 1, 1599, 'Debit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (63, 13, 25, '2026-06-19', 2, 1798, 'Cash on Delivery', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (64, 13, 11, '2026-05-12', 1, 1599, 'Debit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (65, 13, 7, '2026-01-11', 1, 2999, 'Debit Card', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (66, 13, 18, '2026-05-23', 1, 299, 'Credit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (67, 14, 14, '2026-06-12', 2, 2198, 'Credit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (68, 14, 21, '2026-04-18', 2, 240, 'UPI', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (69, 14, 8, '2026-01-03', 2, 1398, 'Debit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (70, 14, 16, '2026-04-06', 1, 349, 'Cash on Delivery', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (71, 14, 23, '2026-01-17', 2, 798, 'Debit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (72, 14, 4, '2026-02-09', 1, 1499, 'UPI', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (73, 14, 7, '2026-05-06', 1, 2999, 'Debit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (74, 15, 7, '2025-12-26', 1, 2999, 'Debit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (75, 15, 1, '2026-01-19', 1, 249, 'UPI', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (76, 16, 5, '2025-10-23', 2, 4998, 'UPI', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (77, 16, 16, '2026-04-14', 2, 698, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (78, 16, 9, '2025-10-29', 2, 3798, 'UPI', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (79, 16, 3, '2025-11-17', 1, 99, 'Credit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (80, 16, 3, '2025-10-31', 1, 99, 'Cash on Delivery', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (81, 16, 25, '2026-04-19', 2, 1798, 'Net Banking', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (82, 16, 10, '2026-07-10', 1, 1299, 'UPI', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (83, 17, 22, '2025-11-20', 1, 499, 'Credit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (84, 17, 6, '2026-03-29', 1, 999, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (85, 17, 10, '2025-12-28', 1, 1299, 'Debit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (86, 17, 23, '2025-10-07', 2, 798, 'Credit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (87, 18, 4, '2025-11-16', 1, 1499, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (88, 18, 2, '2026-02-05', 1, 199, 'Cash on Delivery', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (89, 18, 15, '2026-04-28', 1, 249, 'Debit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (90, 18, 9, '2026-04-13', 2, 3798, 'UPI', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (91, 18, 14, '2026-07-07', 1, 1099, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (92, 19, 22, '2026-01-16', 1, 499, 'Cash on Delivery', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (93, 19, 16, '2026-01-21', 2, 698, 'Credit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (94, 19, 21, '2025-10-17', 2, 240, 'Net Banking', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (95, 20, 11, '2025-11-22', 1, 1599, 'Debit Card', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (96, 20, 10, '2026-06-09', 2, 2598, 'UPI', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (97, 20, 11, '2026-02-13', 1, 1599, 'UPI', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (98, 20, 22, '2026-03-31', 2, 998, 'UPI', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (99, 21, 25, '2026-07-18', 2, 1798, 'Net Banking', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (100, 21, 9, '2026-01-26', 1, 1899, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (101, 21, 4, '2026-07-20', 1, 1499, 'Cash on Delivery', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (102, 21, 10, '2026-06-10', 1, 1299, 'Net Banking', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (103, 21, 4, '2025-10-31', 2, 2998, 'Credit Card', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (104, 21, 17, '2026-04-01', 1, 899, 'Net Banking', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (105, 22, 18, '2026-03-16', 1, 299, 'Credit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (106, 22, 3, '2026-04-01', 1, 99, 'Debit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (107, 22, 1, '2026-01-31', 1, 249, 'Cash on Delivery', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (108, 22, 5, '2026-06-03', 2, 4998, 'Net Banking', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (109, 22, 18, '2026-04-22', 2, 598, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (110, 23, 13, '2026-03-30', 1, 1799, 'UPI', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (111, 23, 23, '2026-03-17', 2, 798, 'Credit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (112, 23, 5, '2025-10-22', 1, 2499, 'Net Banking', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (113, 23, 1, '2026-03-29', 1, 249, 'Credit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (114, 23, 9, '2026-07-17', 1, 1899, 'Net Banking', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (115, 23, 11, '2026-02-10', 2, 3198, 'Net Banking', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (116, 24, 3, '2026-07-21', 1, 99, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (117, 24, 14, '2026-07-22', 1, 1099, 'UPI', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (118, 24, 23, '2025-09-15', 1, 399, 'UPI', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (119, 24, 10, '2026-03-11', 1, 1299, 'Net Banking', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (120, 24, 17, '2026-06-17', 2, 1798, 'Credit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (121, 24, 3, '2026-07-15', 2, 198, 'Credit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (122, 25, 15, '2026-04-24', 1, 249, 'Debit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (123, 25, 15, '2026-06-07', 1, 249, 'Credit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (124, 25, 12, '2026-07-25', 1, 2799, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (125, 26, 10, '2026-03-16', 1, 1299, 'Net Banking', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (126, 26, 13, '2026-06-22', 1, 1799, 'Debit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (127, 26, 1, '2026-01-19', 2, 498, 'UPI', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (128, 26, 20, '2026-01-25', 2, 1398, 'Credit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (129, 26, 8, '2026-07-15', 1, 699, 'Debit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (130, 27, 4, '2026-02-06', 1, 1499, 'Net Banking', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (131, 27, 24, '2025-10-17', 1, 249, 'Debit Card', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (132, 27, 6, '2025-11-07', 1, 999, 'Cash on Delivery', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (133, 27, 6, '2026-05-05', 1, 999, 'Debit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (134, 27, 4, '2025-10-09', 2, 2998, 'Credit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (135, 27, 18, '2025-10-17', 1, 299, 'Net Banking', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (136, 27, 18, '2026-04-21', 1, 299, 'Debit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (137, 28, 13, '2025-10-26', 1, 1799, 'Credit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (138, 28, 20, '2026-07-10', 1, 699, 'Credit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (139, 28, 21, '2026-02-02', 2, 240, 'Net Banking', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (140, 28, 2, '2026-02-03', 1, 199, 'Net Banking', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (141, 28, 8, '2026-03-18', 1, 699, 'Net Banking', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (142, 28, 19, '2026-04-01', 1, 449, 'UPI', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (143, 29, 2, '2025-12-21', 1, 199, 'Net Banking', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (144, 29, 12, '2026-03-08', 1, 2799, 'Cash on Delivery', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (145, 29, 2, '2026-01-20', 2, 398, 'Credit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (146, 29, 3, '2026-07-25', 1, 99, 'Cash on Delivery', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (147, 30, 11, '2025-11-04', 1, 1599, 'Cash on Delivery', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (148, 30, 25, '2026-06-28', 1, 899, 'Credit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (149, 30, 25, '2026-07-03', 1, 899, 'UPI', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (150, 30, 5, '2025-11-29', 1, 2499, 'UPI', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (151, 30, 5, '2026-03-03', 1, 2499, 'Credit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (152, 30, 1, '2026-01-14', 1, 249, 'UPI', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (153, 30, 17, '2025-10-03', 1, 899, 'Net Banking', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (154, 30, 17, '2026-04-20', 1, 899, 'Cash on Delivery', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (155, 31, 22, '2026-04-23', 1, 499, 'UPI', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (156, 31, 13, '2025-10-26', 2, 3598, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (157, 31, 3, '2026-02-12', 1, 99, 'Cash on Delivery', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (158, 31, 5, '2026-07-17', 1, 2499, 'Cash on Delivery', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (159, 31, 13, '2026-04-21', 1, 1799, 'Cash on Delivery', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (160, 31, 4, '2026-06-10', 1, 1499, 'Credit Card', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (161, 31, 8, '2026-02-21', 2, 1398, 'Net Banking', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (162, 32, 4, '2026-04-07', 1, 1499, 'Debit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (163, 32, 12, '2026-05-01', 1, 2799, 'UPI', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (164, 32, 3, '2025-10-20', 2, 198, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (165, 32, 19, '2025-11-02', 1, 449, 'Net Banking', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (166, 32, 24, '2026-01-26', 1, 249, 'Cash on Delivery', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (167, 32, 4, '2025-11-19', 1, 1499, 'Net Banking', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (168, 32, 12, '2025-10-29', 1, 2799, 'Debit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (169, 33, 14, '2026-07-09', 1, 1099, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (170, 33, 9, '2026-02-21', 1, 1899, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (171, 33, 5, '2025-10-06', 2, 4998, 'Credit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (172, 33, 3, '2026-03-12', 1, 99, 'Net Banking', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (173, 33, 6, '2026-02-07', 1, 999, 'Debit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (174, 33, 2, '2025-11-20', 1, 199, 'Cash on Delivery', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (175, 33, 9, '2026-04-06', 2, 3798, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (176, 33, 14, '2025-12-20', 1, 1099, 'Cash on Delivery', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (177, 34, 4, '2026-07-01', 1, 1499, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (178, 34, 2, '2026-03-22', 1, 199, 'Cash on Delivery', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (179, 34, 7, '2025-12-18', 1, 2999, 'Credit Card', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (180, 34, 11, '2025-09-04', 1, 1599, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (181, 34, 6, '2026-03-14', 1, 999, 'Cash on Delivery', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (182, 35, 18, '2025-10-07', 1, 299, 'Net Banking', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (183, 35, 14, '2026-04-24', 1, 1099, 'UPI', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (184, 35, 19, '2026-07-25', 2, 898, 'Net Banking', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (185, 35, 13, '2026-02-14', 1, 1799, 'Credit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (186, 35, 23, '2025-10-16', 1, 399, 'Net Banking', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (187, 35, 14, '2026-05-27', 2, 2198, 'UPI', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (188, 36, 11, '2026-02-18', 1, 1599, 'Credit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (189, 36, 17, '2026-02-26', 1, 899, 'Debit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (190, 36, 8, '2025-11-14', 1, 699, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (191, 36, 20, '2025-10-09', 1, 699, 'Credit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (192, 36, 15, '2026-06-17', 2, 498, 'Cash on Delivery', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (193, 36, 5, '2025-10-05', 2, 4998, 'Net Banking', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (194, 36, 9, '2026-02-28', 1, 1899, 'Cash on Delivery', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (195, 37, 15, '2025-09-30', 1, 249, 'Debit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (196, 37, 21, '2026-07-12', 1, 120, 'Cash on Delivery', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (197, 37, 15, '2026-04-19', 1, 249, 'Cash on Delivery', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (198, 37, 11, '2026-05-15', 2, 3198, 'Credit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (199, 37, 4, '2025-10-14', 1, 1499, 'Cash on Delivery', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (200, 38, 8, '2026-04-13', 2, 1398, 'Cash on Delivery', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (201, 38, 12, '2026-01-23', 1, 2799, 'Net Banking', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (202, 39, 20, '2026-07-21', 1, 699, 'Debit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (203, 39, 4, '2026-01-24', 2, 2998, 'Debit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (204, 39, 11, '2026-06-26', 1, 1599, 'Credit Card', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (205, 39, 21, '2025-11-06', 2, 240, 'Cash on Delivery', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (206, 39, 10, '2026-02-16', 2, 2598, 'Credit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (207, 39, 21, '2026-05-19', 2, 240, 'Debit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (208, 39, 10, '2025-12-19', 1, 1299, 'Debit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (209, 40, 5, '2025-10-10', 1, 2499, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (210, 40, 22, '2026-07-14', 1, 499, 'Credit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (211, 40, 5, '2025-12-02', 1, 2499, 'Cash on Delivery', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (212, 41, 14, '2025-12-31', 1, 1099, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (213, 41, 25, '2025-12-29', 2, 1798, 'Cash on Delivery', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (214, 42, 16, '2026-03-08', 1, 349, 'Cash on Delivery', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (215, 42, 25, '2026-03-15', 1, 899, 'Cash on Delivery', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (216, 42, 6, '2026-07-07', 1, 999, 'Credit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (217, 42, 21, '2026-03-10', 2, 240, 'Cash on Delivery', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (218, 42, 10, '2025-11-22', 1, 1299, 'Debit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (219, 42, 14, '2025-12-23', 1, 1099, 'Net Banking', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (220, 42, 14, '2026-03-22', 1, 1099, 'Cash on Delivery', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (221, 42, 13, '2026-03-11', 1, 1799, 'Credit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (222, 43, 23, '2025-11-14', 1, 399, 'Credit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (223, 43, 16, '2026-04-29', 1, 349, 'Net Banking', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (224, 44, 1, '2025-12-20', 1, 249, 'Credit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (225, 44, 4, '2025-12-31', 1, 1499, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (226, 45, 14, '2025-10-03', 2, 2198, 'UPI', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (227, 45, 21, '2025-11-13', 1, 120, 'Debit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (228, 45, 20, '2026-01-02', 1, 699, 'Cash on Delivery', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (229, 46, 22, '2026-05-27', 1, 499, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (230, 46, 13, '2025-09-23', 2, 3598, 'Net Banking', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (231, 46, 24, '2026-03-02', 1, 249, 'UPI', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (232, 46, 24, '2026-06-25', 1, 249, 'Debit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (233, 46, 12, '2025-11-29', 1, 2799, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (234, 46, 21, '2025-11-09', 1, 120, 'UPI', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (235, 46, 2, '2025-12-13', 1, 199, 'UPI', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (236, 47, 10, '2026-06-06', 2, 2598, 'Net Banking', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (237, 47, 25, '2026-01-25', 1, 899, 'Debit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (238, 47, 9, '2026-03-08', 1, 1899, 'Net Banking', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (239, 47, 13, '2025-12-05', 1, 1799, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (240, 48, 17, '2025-10-13', 1, 899, 'Net Banking', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (241, 48, 20, '2026-06-07', 1, 699, 'Debit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (242, 48, 3, '2026-01-30', 1, 99, 'Debit Card', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (243, 48, 6, '2026-02-27', 2, 1998, 'Net Banking', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (244, 49, 14, '2026-07-25', 1, 1099, 'UPI', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (245, 49, 12, '2025-09-16', 1, 2799, 'Credit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (246, 49, 2, '2025-10-05', 1, 199, 'Credit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (247, 49, 12, '2026-06-18', 2, 5598, 'UPI', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (248, 49, 22, '2026-03-09', 2, 998, 'Debit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (249, 49, 19, '2026-05-30', 1, 449, 'Debit Card', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (250, 50, 9, '2025-10-29', 1, 1899, 'UPI', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (251, 50, 16, '2026-06-15', 2, 698, 'UPI', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (252, 50, 23, '2025-12-19', 2, 798, 'Cash on Delivery', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (253, 50, 7, '2025-11-09', 1, 2999, 'UPI', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (254, 50, 23, '2025-10-15', 2, 798, 'Debit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (255, 50, 23, '2026-06-09', 1, 399, 'Cash on Delivery', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (256, 50, 6, '2026-03-05', 1, 999, 'Cash on Delivery', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (257, 51, 5, '2026-05-11', 1, 2499, 'UPI', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (258, 51, 15, '2026-07-11', 1, 249, 'UPI', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (259, 51, 13, '2026-05-28', 2, 3598, 'Net Banking', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (260, 52, 11, '2026-04-19', 1, 1599, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (261, 52, 5, '2025-11-06', 1, 2499, 'Net Banking', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (262, 52, 4, '2026-02-03', 1, 1499, 'Credit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (263, 53, 8, '2026-05-24', 1, 699, 'Debit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (264, 53, 7, '2025-11-04', 1, 2999, 'Debit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (265, 53, 17, '2026-07-01', 1, 899, 'Cash on Delivery', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (266, 53, 22, '2026-06-16', 1, 499, 'UPI', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (267, 53, 2, '2025-12-17', 1, 199, 'Cash on Delivery', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (268, 53, 16, '2026-02-02', 1, 349, 'Net Banking', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (269, 53, 10, '2025-10-08', 2, 2598, 'UPI', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (270, 54, 16, '2025-12-14', 2, 698, 'Debit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (271, 54, 11, '2026-02-24', 1, 1599, 'Net Banking', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (272, 54, 17, '2026-02-11', 1, 899, 'Credit Card', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (273, 54, 9, '2026-01-05', 2, 3798, 'Credit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (274, 54, 10, '2026-07-13', 2, 2598, 'Net Banking', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (275, 55, 11, '2025-12-07', 1, 1599, 'Credit Card', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (276, 55, 16, '2026-05-13', 1, 349, 'UPI', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (277, 55, 17, '2026-01-02', 2, 1798, 'Credit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (278, 55, 2, '2026-01-23', 1, 199, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (279, 55, 10, '2025-10-26', 1, 1299, 'Net Banking', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (280, 55, 24, '2026-03-26', 1, 249, 'Debit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (281, 55, 2, '2026-03-05', 1, 199, 'Cash on Delivery', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (282, 55, 13, '2026-06-09', 2, 3598, 'Debit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (283, 56, 4, '2026-03-11', 2, 2998, 'Debit Card', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (284, 56, 25, '2025-12-11', 1, 899, 'Cash on Delivery', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (285, 56, 17, '2025-09-24', 1, 899, 'UPI', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (286, 57, 16, '2025-11-16', 2, 698, 'Cash on Delivery', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (287, 57, 11, '2025-11-23', 1, 1599, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (288, 57, 19, '2026-05-18', 1, 449, 'Cash on Delivery', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (289, 57, 23, '2026-05-02', 1, 399, 'UPI', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (290, 57, 22, '2026-04-02', 1, 499, 'Cash on Delivery', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (291, 57, 20, '2026-01-14', 2, 1398, 'Cash on Delivery', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (292, 57, 24, '2026-06-26', 1, 249, 'Net Banking', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (293, 57, 5, '2025-09-17', 1, 2499, 'Cash on Delivery', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (294, 58, 1, '2026-02-08', 2, 498, 'Net Banking', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (295, 58, 23, '2026-03-30', 1, 399, 'Cash on Delivery', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (296, 58, 24, '2025-11-10', 1, 249, 'Cash on Delivery', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (297, 59, 16, '2026-02-08', 2, 698, 'Credit Card', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (298, 59, 18, '2026-01-14', 1, 299, 'Cash on Delivery', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (299, 59, 8, '2026-06-13', 1, 699, 'Debit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (300, 59, 25, '2025-12-16', 1, 899, 'Net Banking', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (301, 59, 12, '2026-01-26', 1, 2799, 'UPI', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (302, 59, 13, '2025-11-14', 1, 1799, 'Debit Card', 'Standard', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (303, 59, 23, '2026-02-25', 1, 399, 'Net Banking', 'Scheduled', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (304, 60, 16, '2025-12-13', 1, 349, 'Cash on Delivery', 'Express', 'No');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (305, 60, 5, '2026-07-13', 1, 2499, 'Cash on Delivery', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (306, 60, 2, '2026-07-24', 1, 199, 'Credit Card', 'Standard', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (307, 60, 14, '2026-04-30', 1, 1099, 'UPI', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (308, 60, 1, '2026-03-28', 1, 249, 'Net Banking', 'Express', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (309, 60, 25, '2026-02-12', 1, 899, 'Debit Card', 'Scheduled', 'Yes');
INSERT INTO dbo.PURCHASE (purchase_id, student_id, product_id, purchase_date, quantity, amount, payment_method, delivery_preference, is_prime) VALUES (310, 60, 25, '2026-06-21', 1, 899, 'Credit Card', 'Scheduled', 'Yes');
GO
SET IDENTITY_INSERT dbo.PURCHASE OFF;
GO

-- REVIEW (220 rows)
SET IDENTITY_INSERT dbo.REVIEW ON;
GO
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (1, 2, 5, 'Not satisfied, quality could be better.', '2025-10-09');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (2, 4, 4, 'Average product, packaging was poor.', '2026-06-07');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (3, 5, 4, 'Delivery was fast, product as expected.', '2025-10-30');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (4, 6, 5, 'Value for money purchase.', '2026-01-21');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (5, 8, 3, 'Delivery was fast, product as expected.', '2026-07-28');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (6, 9, 4, 'Average product, packaging was poor.', '2025-11-09');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (7, 10, 4, 'Average product, packaging was poor.', '2026-06-25');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (8, 11, 3, 'Product was okay, took long to deliver.', '2026-06-14');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (9, 12, 3, 'Delivery was fast, product as expected.', '2026-02-08');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (10, 14, 5, 'Good quality product, worth the price.', '2026-01-05');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (11, 15, 4, 'Average product, packaging was poor.', '2026-02-24');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (12, 16, 5, 'Good quality product, worth the price.', '2025-10-31');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (13, 17, 5, 'Good quality product, worth the price.', '2026-03-01');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (14, 18, 3, 'Average product, packaging was poor.', '2026-03-26');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (15, 19, 5, 'Loved it, highly recommend to friends.', '2026-03-09');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (16, 20, 5, 'Value for money purchase.', '2025-12-04');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (17, 21, 5, 'Loved it, highly recommend to friends.', '2026-03-03');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (18, 28, 5, 'Delivery was fast, product as expected.', '2026-02-12');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (19, 29, 5, 'Delivery was fast, product as expected.', '2026-05-07');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (20, 30, 5, 'Excellent product, will buy again.', '2025-12-06');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (21, 31, 3, 'Value for money purchase.', '2026-02-08');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (22, 32, 5, 'Value for money purchase.', '2026-01-06');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (23, 34, 2, 'Not satisfied, quality could be better.', '2025-11-24');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (24, 35, 4, 'Value for money purchase.', '2026-05-29');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (25, 37, 5, 'Excellent product, will buy again.', '2026-07-21');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (26, 38, 4, 'Delivery was fast, product as expected.', '2026-04-28');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (27, 41, 5, 'Good quality product, worth the price.', '2025-11-15');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (28, 42, 5, 'Product was okay, took long to deliver.', '2025-12-25');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (29, 44, 5, 'Product was okay, took long to deliver.', '2026-06-29');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (30, 45, 5, 'Not satisfied, quality could be better.', '2026-03-25');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (31, 46, 5, 'Product was okay, took long to deliver.', '2026-01-27');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (32, 47, 5, 'Good quality product, worth the price.', '2025-11-25');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (33, 49, 5, 'Product was okay, took long to deliver.', '2026-01-21');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (34, 50, 3, 'Value for money purchase.', '2026-02-26');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (35, 51, 3, 'Delivery was fast, product as expected.', '2026-04-30');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (36, 53, 5, 'Good quality product, worth the price.', '2026-01-05');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (37, 54, 3, 'Good quality product, worth the price.', '2026-05-05');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (38, 55, 5, 'Good quality product, worth the price.', '2025-11-27');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (39, 57, 4, 'Excellent product, will buy again.', '2026-07-06');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (40, 58, 5, 'Excellent product, will buy again.', '2026-03-19');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (41, 59, 5, 'Loved it, highly recommend to friends.', '2026-05-13');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (42, 60, 3, 'Excellent product, will buy again.', '2026-04-18');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (43, 61, 2, 'Not satisfied, quality could be better.', '2026-05-04');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (44, 62, 2, 'Loved it, highly recommend to friends.', '2025-10-22');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (45, 64, 4, 'Not satisfied, quality could be better.', '2026-05-17');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (46, 65, 5, 'Value for money purchase.', '2026-01-15');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (47, 67, 5, 'Value for money purchase.', '2026-06-13');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (48, 68, 5, 'Not satisfied, quality could be better.', '2026-04-25');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (49, 69, 3, 'Delivery was fast, product as expected.', '2026-01-11');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (50, 71, 5, 'Excellent product, will buy again.', '2026-01-18');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (51, 72, 5, 'Good quality product, worth the price.', '2026-02-11');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (52, 73, 5, 'Excellent product, will buy again.', '2026-05-14');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (53, 74, 5, 'Average product, packaging was poor.', '2025-12-27');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (54, 75, 3, 'Delivery was fast, product as expected.', '2026-01-27');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (55, 77, 5, 'Product was okay, took long to deliver.', '2026-04-18');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (56, 78, 5, 'Product was okay, took long to deliver.', '2025-11-06');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (57, 79, 4, 'Average product, packaging was poor.', '2025-11-23');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (58, 80, 4, 'Delivery was fast, product as expected.', '2025-11-08');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (59, 82, 3, 'Loved it, highly recommend to friends.', '2026-07-17');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (60, 83, 5, 'Not satisfied, quality could be better.', '2025-11-21');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (61, 84, 5, 'Product was okay, took long to deliver.', '2026-04-03');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (62, 85, 4, 'Product was okay, took long to deliver.', '2026-01-07');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (63, 87, 5, 'Loved it, highly recommend to friends.', '2025-11-21');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (64, 89, 5, 'Value for money purchase.', '2026-05-06');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (65, 90, 5, 'Not satisfied, quality could be better.', '2026-04-16');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (66, 92, 5, 'Good quality product, worth the price.', '2026-01-25');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (67, 93, 5, 'Good quality product, worth the price.', '2026-01-22');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (68, 94, 5, 'Excellent product, will buy again.', '2025-10-19');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (69, 96, 4, 'Loved it, highly recommend to friends.', '2026-06-10');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (70, 97, 5, 'Value for money purchase.', '2026-02-21');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (71, 98, 4, 'Product was okay, took long to deliver.', '2026-04-01');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (72, 99, 5, 'Average product, packaging was poor.', '2026-07-19');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (73, 100, 5, 'Product was okay, took long to deliver.', '2026-01-29');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (74, 101, 3, 'Not satisfied, quality could be better.', '2026-07-24');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (75, 102, 4, 'Loved it, highly recommend to friends.', '2026-06-15');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (76, 104, 5, 'Value for money purchase.', '2026-04-11');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (77, 105, 5, 'Average product, packaging was poor.', '2026-03-18');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (78, 106, 5, 'Good quality product, worth the price.', '2026-04-03');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (79, 107, 4, 'Value for money purchase.', '2026-02-01');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (80, 108, 5, 'Delivery was fast, product as expected.', '2026-06-11');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (81, 110, 4, 'Delivery was fast, product as expected.', '2026-04-08');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (82, 112, 5, 'Value for money purchase.', '2025-10-27');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (83, 113, 2, 'Average product, packaging was poor.', '2026-04-07');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (84, 114, 2, 'Loved it, highly recommend to friends.', '2026-07-18');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (85, 116, 5, 'Product was okay, took long to deliver.', '2026-07-23');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (86, 117, 4, 'Product was okay, took long to deliver.', '2026-07-31');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (87, 118, 5, 'Not satisfied, quality could be better.', '2025-09-17');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (88, 119, 5, 'Good quality product, worth the price.', '2026-03-13');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (89, 120, 5, 'Loved it, highly recommend to friends.', '2026-06-27');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (90, 123, 5, 'Good quality product, worth the price.', '2026-06-12');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (91, 125, 3, 'Product was okay, took long to deliver.', '2026-03-23');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (92, 126, 5, 'Product was okay, took long to deliver.', '2026-06-24');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (93, 128, 4, 'Delivery was fast, product as expected.', '2026-01-27');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (94, 129, 4, 'Not satisfied, quality could be better.', '2026-07-22');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (95, 130, 3, 'Good quality product, worth the price.', '2026-02-11');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (96, 131, 5, 'Delivery was fast, product as expected.', '2025-10-20');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (97, 132, 4, 'Product was okay, took long to deliver.', '2025-11-09');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (98, 133, 4, 'Delivery was fast, product as expected.', '2026-05-15');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (99, 134, 4, 'Product was okay, took long to deliver.', '2025-10-10');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (100, 135, 4, 'Delivery was fast, product as expected.', '2025-10-26');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (101, 138, 3, 'Product was okay, took long to deliver.', '2026-07-13');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (102, 139, 4, 'Value for money purchase.', '2026-02-05');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (103, 140, 4, 'Product was okay, took long to deliver.', '2026-02-08');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (104, 141, 2, 'Average product, packaging was poor.', '2026-03-22');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (105, 143, 5, 'Value for money purchase.', '2025-12-23');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (106, 144, 1, 'Product was okay, took long to deliver.', '2026-03-14');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (107, 146, 5, 'Value for money purchase.', '2026-07-31');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (108, 147, 5, 'Not satisfied, quality could be better.', '2025-11-09');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (109, 148, 5, 'Excellent product, will buy again.', '2026-07-06');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (110, 149, 5, 'Loved it, highly recommend to friends.', '2026-07-08');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (111, 151, 5, 'Excellent product, will buy again.', '2026-03-09');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (112, 152, 5, 'Product was okay, took long to deliver.', '2026-01-20');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (113, 153, 4, 'Not satisfied, quality could be better.', '2025-10-12');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (114, 154, 5, 'Excellent product, will buy again.', '2026-04-28');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (115, 157, 5, 'Product was okay, took long to deliver.', '2026-02-20');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (116, 158, 4, 'Average product, packaging was poor.', '2026-07-20');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (117, 161, 5, 'Value for money purchase.', '2026-03-03');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (118, 162, 4, 'Product was okay, took long to deliver.', '2026-04-16');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (119, 163, 5, 'Delivery was fast, product as expected.', '2026-05-03');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (120, 165, 4, 'Good quality product, worth the price.', '2025-11-12');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (121, 167, 4, 'Loved it, highly recommend to friends.', '2025-11-26');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (122, 168, 3, 'Excellent product, will buy again.', '2025-11-07');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (123, 170, 5, 'Excellent product, will buy again.', '2026-03-01');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (124, 171, 4, 'Not satisfied, quality could be better.', '2025-10-12');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (125, 173, 4, 'Delivery was fast, product as expected.', '2026-02-09');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (126, 176, 4, 'Excellent product, will buy again.', '2025-12-29');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (127, 177, 4, 'Value for money purchase.', '2026-07-09');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (128, 178, 4, 'Delivery was fast, product as expected.', '2026-03-23');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (129, 180, 5, 'Not satisfied, quality could be better.', '2025-09-08');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (130, 181, 4, 'Loved it, highly recommend to friends.', '2026-03-23');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (131, 182, 4, 'Product was okay, took long to deliver.', '2025-10-10');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (132, 183, 5, 'Product was okay, took long to deliver.', '2026-04-25');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (133, 186, 4, 'Good quality product, worth the price.', '2025-10-20');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (134, 187, 5, 'Delivery was fast, product as expected.', '2026-06-06');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (135, 188, 5, 'Not satisfied, quality could be better.', '2026-02-24');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (136, 189, 4, 'Average product, packaging was poor.', '2026-03-06');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (137, 190, 5, 'Product was okay, took long to deliver.', '2025-11-24');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (138, 191, 3, 'Loved it, highly recommend to friends.', '2025-10-17');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (139, 192, 5, 'Average product, packaging was poor.', '2026-06-27');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (140, 193, 5, 'Loved it, highly recommend to friends.', '2025-10-07');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (141, 194, 3, 'Loved it, highly recommend to friends.', '2026-03-03');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (142, 195, 4, 'Not satisfied, quality could be better.', '2025-10-10');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (143, 196, 3, 'Not satisfied, quality could be better.', '2026-07-21');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (144, 197, 4, 'Not satisfied, quality could be better.', '2026-04-25');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (145, 199, 5, 'Good quality product, worth the price.', '2025-10-22');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (146, 200, 5, 'Value for money purchase.', '2026-04-20');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (147, 201, 4, 'Value for money purchase.', '2026-01-31');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (148, 202, 4, 'Excellent product, will buy again.', '2026-07-26');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (149, 203, 3, 'Average product, packaging was poor.', '2026-01-27');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (150, 205, 5, 'Value for money purchase.', '2025-11-15');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (151, 206, 4, 'Average product, packaging was poor.', '2026-02-25');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (152, 208, 5, 'Good quality product, worth the price.', '2025-12-27');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (153, 209, 5, 'Delivery was fast, product as expected.', '2025-10-14');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (154, 210, 5, 'Value for money purchase.', '2026-07-19');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (155, 211, 5, 'Value for money purchase.', '2025-12-04');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (156, 213, 5, 'Loved it, highly recommend to friends.', '2026-01-08');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (157, 214, 3, 'Not satisfied, quality could be better.', '2026-03-12');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (158, 217, 4, 'Not satisfied, quality could be better.', '2026-03-16');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (159, 219, 4, 'Delivery was fast, product as expected.', '2025-12-26');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (160, 225, 5, 'Excellent product, will buy again.', '2026-01-03');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (161, 229, 4, 'Average product, packaging was poor.', '2026-06-03');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (162, 230, 2, 'Delivery was fast, product as expected.', '2025-09-30');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (163, 231, 4, 'Loved it, highly recommend to friends.', '2026-03-10');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (164, 233, 1, 'Delivery was fast, product as expected.', '2025-12-07');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (165, 234, 5, 'Delivery was fast, product as expected.', '2025-11-18');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (166, 235, 5, 'Excellent product, will buy again.', '2025-12-21');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (167, 236, 5, 'Loved it, highly recommend to friends.', '2026-06-15');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (168, 237, 4, 'Value for money purchase.', '2026-01-31');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (169, 240, 5, 'Value for money purchase.', '2025-10-14');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (170, 241, 5, 'Value for money purchase.', '2026-06-15');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (171, 242, 5, 'Excellent product, will buy again.', '2026-02-02');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (172, 244, 5, 'Average product, packaging was poor.', '2026-07-27');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (173, 245, 4, 'Loved it, highly recommend to friends.', '2025-09-19');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (174, 246, 5, 'Excellent product, will buy again.', '2025-10-12');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (175, 247, 5, 'Good quality product, worth the price.', '2026-06-22');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (176, 248, 3, 'Excellent product, will buy again.', '2026-03-18');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (177, 249, 1, 'Loved it, highly recommend to friends.', '2026-06-01');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (178, 251, 3, 'Delivery was fast, product as expected.', '2026-06-19');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (179, 252, 5, 'Delivery was fast, product as expected.', '2025-12-21');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (180, 253, 5, 'Not satisfied, quality could be better.', '2025-11-16');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (181, 256, 5, 'Not satisfied, quality could be better.', '2026-03-07');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (182, 257, 1, 'Not satisfied, quality could be better.', '2026-05-19');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (183, 258, 3, 'Not satisfied, quality could be better.', '2026-07-18');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (184, 259, 4, 'Excellent product, will buy again.', '2026-05-30');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (185, 261, 3, 'Product was okay, took long to deliver.', '2025-11-12');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (186, 263, 3, 'Average product, packaging was poor.', '2026-05-26');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (187, 264, 5, 'Average product, packaging was poor.', '2025-11-05');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (188, 266, 4, 'Excellent product, will buy again.', '2026-06-23');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (189, 267, 2, 'Excellent product, will buy again.', '2025-12-25');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (190, 268, 4, 'Delivery was fast, product as expected.', '2026-02-11');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (191, 270, 4, 'Loved it, highly recommend to friends.', '2025-12-17');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (192, 271, 5, 'Product was okay, took long to deliver.', '2026-03-02');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (193, 272, 3, 'Value for money purchase.', '2026-02-13');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (194, 273, 2, 'Average product, packaging was poor.', '2026-01-09');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (195, 274, 2, 'Product was okay, took long to deliver.', '2026-07-22');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (196, 275, 5, 'Product was okay, took long to deliver.', '2025-12-14');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (197, 277, 4, 'Not satisfied, quality could be better.', '2026-01-07');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (198, 278, 2, 'Excellent product, will buy again.', '2026-01-26');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (199, 279, 4, 'Delivery was fast, product as expected.', '2025-10-31');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (200, 280, 5, 'Excellent product, will buy again.', '2026-03-27');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (201, 281, 5, 'Delivery was fast, product as expected.', '2026-03-13');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (202, 282, 2, 'Not satisfied, quality could be better.', '2026-06-11');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (203, 283, 3, 'Good quality product, worth the price.', '2026-03-14');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (204, 284, 4, 'Average product, packaging was poor.', '2025-12-14');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (205, 285, 5, 'Average product, packaging was poor.', '2025-09-26');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (206, 287, 5, 'Average product, packaging was poor.', '2025-12-02');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (207, 288, 5, 'Delivery was fast, product as expected.', '2026-05-26');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (208, 289, 4, 'Value for money purchase.', '2026-05-12');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (209, 290, 3, 'Delivery was fast, product as expected.', '2026-04-12');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (210, 291, 3, 'Good quality product, worth the price.', '2026-01-15');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (211, 293, 2, 'Loved it, highly recommend to friends.', '2025-09-24');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (212, 295, 5, 'Good quality product, worth the price.', '2026-04-08');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (213, 298, 3, 'Excellent product, will buy again.', '2026-01-21');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (214, 300, 5, 'Loved it, highly recommend to friends.', '2025-12-18');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (215, 301, 5, 'Not satisfied, quality could be better.', '2026-01-30');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (216, 305, 4, 'Average product, packaging was poor.', '2026-07-18');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (217, 306, 4, 'Good quality product, worth the price.', '2026-07-30');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (218, 307, 4, 'Average product, packaging was poor.', '2026-05-10');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (219, 308, 4, 'Value for money purchase.', '2026-04-01');
INSERT INTO dbo.REVIEW (review_id, purchase_id, rating, comment, review_date) VALUES (220, 310, 5, 'Not satisfied, quality could be better.', '2026-06-22');
GO
SET IDENTITY_INSERT dbo.REVIEW OFF;
GO

-- WISHLIST (106 rows)
SET IDENTITY_INSERT dbo.WISHLIST ON;
GO
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (1, 1, 1, '2026-02-25');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (2, 1, 8, '2026-07-23');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (3, 1, 18, '2025-09-05');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (4, 2, 1, '2026-03-12');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (5, 2, 25, '2026-02-05');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (6, 4, 17, '2025-12-31');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (7, 5, 16, '2026-01-22');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (8, 5, 2, '2025-10-18');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (9, 5, 5, '2025-09-23');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (10, 6, 17, '2026-03-31');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (11, 7, 15, '2025-10-14');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (12, 7, 24, '2026-06-25');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (13, 9, 5, '2026-07-01');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (14, 9, 21, '2026-06-18');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (15, 9, 13, '2025-10-02');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (16, 9, 3, '2026-04-11');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (17, 10, 8, '2026-01-28');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (18, 11, 11, '2026-02-15');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (19, 11, 13, '2026-02-10');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (20, 12, 9, '2025-12-13');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (21, 12, 8, '2025-11-09');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (22, 12, 3, '2026-06-27');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (23, 14, 4, '2025-11-24');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (24, 15, 15, '2025-11-01');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (25, 15, 11, '2026-06-02');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (26, 15, 14, '2026-03-03');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (27, 16, 15, '2026-02-05');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (28, 17, 9, '2025-11-20');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (29, 17, 4, '2026-02-03');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (30, 17, 3, '2026-07-06');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (31, 19, 11, '2025-11-15');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (32, 21, 12, '2026-03-22');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (33, 22, 2, '2025-11-29');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (34, 22, 22, '2025-09-16');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (35, 22, 10, '2026-03-27');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (36, 22, 9, '2026-04-20');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (37, 23, 24, '2026-04-25');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (38, 23, 18, '2025-10-23');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (39, 23, 8, '2025-11-11');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (40, 23, 4, '2025-11-02');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (41, 26, 5, '2025-12-11');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (42, 27, 12, '2025-10-14');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (43, 27, 22, '2026-06-26');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (44, 27, 21, '2026-06-28');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (45, 28, 3, '2025-10-04');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (46, 28, 1, '2025-12-11');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (47, 29, 5, '2025-11-02');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (48, 29, 3, '2025-09-22');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (49, 29, 11, '2026-04-25');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (50, 31, 19, '2026-04-10');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (51, 32, 16, '2026-04-07');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (52, 32, 1, '2025-11-28');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (53, 32, 13, '2026-03-01');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (54, 33, 6, '2026-01-19');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (55, 34, 15, '2025-09-18');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (56, 34, 5, '2026-07-12');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (57, 35, 20, '2026-05-14');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (58, 35, 8, '2026-03-30');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (59, 35, 21, '2026-06-09');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (60, 35, 10, '2026-05-04');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (61, 38, 13, '2026-04-03');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (62, 38, 5, '2025-12-12');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (63, 39, 8, '2026-03-15');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (64, 39, 21, '2026-03-03');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (65, 39, 18, '2026-05-04');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (66, 39, 1, '2026-06-06');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (67, 40, 12, '2026-02-12');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (68, 40, 19, '2026-03-18');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (69, 40, 17, '2026-01-17');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (70, 41, 1, '2026-02-11');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (71, 42, 8, '2025-09-30');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (72, 42, 1, '2026-04-30');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (73, 42, 25, '2026-05-30');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (74, 42, 9, '2026-03-03');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (75, 43, 8, '2026-01-02');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (76, 43, 6, '2026-01-15');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (77, 43, 4, '2026-06-01');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (78, 43, 22, '2025-09-29');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (79, 44, 19, '2026-03-18');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (80, 45, 6, '2026-07-01');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (81, 45, 8, '2026-02-10');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (82, 46, 19, '2026-02-28');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (83, 46, 1, '2026-06-18');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (84, 47, 5, '2026-06-05');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (85, 47, 19, '2026-02-06');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (86, 47, 7, '2025-11-29');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (87, 47, 16, '2026-05-10');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (88, 51, 20, '2025-12-22');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (89, 53, 16, '2025-12-13');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (90, 53, 1, '2025-11-06');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (91, 53, 11, '2026-02-22');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (92, 53, 20, '2025-11-30');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (93, 54, 2, '2025-11-15');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (94, 54, 1, '2026-06-28');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (95, 55, 25, '2025-10-27');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (96, 56, 12, '2026-03-22');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (97, 56, 3, '2026-06-28');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (98, 56, 23, '2025-10-22');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (99, 56, 22, '2026-02-20');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (100, 57, 11, '2025-11-20');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (101, 57, 5, '2026-04-12');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (102, 58, 21, '2026-06-15');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (103, 58, 11, '2026-07-12');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (104, 58, 6, '2026-03-02');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (105, 59, 22, '2026-06-29');
INSERT INTO dbo.WISHLIST (wishlist_id, student_id, product_id, added_date) VALUES (106, 60, 13, '2026-02-05');
GO
SET IDENTITY_INSERT dbo.WISHLIST OFF;
GO

/* =====================================================================
   ANALYTICAL SQL QUERIES  (T-SQL / SQL Server syntax)
   ===================================================================== */

-- Q1. Most preferred shopping category (by number of orders)
SELECT pc.category_name, COUNT(*) AS total_orders, SUM(p.amount) AS total_spend
FROM dbo.PURCHASE p
JOIN dbo.PRODUCT pr ON p.product_id = pr.product_id
JOIN dbo.PRODUCT_CATEGORY pc ON pr.category_id = pc.category_id
GROUP BY pc.category_name
ORDER BY total_orders DESC;
GO

-- Q2. Average spend per student
SELECT s.student_id, s.student_name, ROUND(AVG(p.amount),2) AS avg_spend,
       COUNT(*) AS total_orders
FROM dbo.PURCHASE p
JOIN dbo.STUDENT s ON p.student_id = s.student_id
GROUP BY s.student_id, s.student_name
ORDER BY avg_spend DESC;
GO

-- Q3. Spending behaviour and purchase frequency by age group
SELECT s.age_group, COUNT(*) AS total_orders,
       SUM(p.amount) AS total_spend,
       ROUND(SUM(p.amount) * 1.0 / COUNT(*), 2) AS avg_order_value
FROM dbo.PURCHASE p
JOIN dbo.STUDENT s ON p.student_id = s.student_id
GROUP BY s.age_group
ORDER BY total_spend DESC;
GO

-- Q4. Frequently purchased brands (Top 10)
SELECT TOP (10) pr.brand, COUNT(*) AS orders
FROM dbo.PURCHASE p
JOIN dbo.PRODUCT pr ON p.product_id = pr.product_id
GROUP BY pr.brand
ORDER BY orders DESC;
GO

-- Q5. Seasonal / monthly shopping trend
SELECT FORMAT(purchase_date, 'yyyy-MM') AS [month],
       COUNT(*) AS total_orders, SUM(amount) AS total_spend
FROM dbo.PURCHASE
GROUP BY FORMAT(purchase_date, 'yyyy-MM')
ORDER BY [month];
GO

-- Q6. Prime vs Non-Prime average order value
SELECT is_prime, COUNT(*) AS orders, ROUND(AVG(amount),2) AS avg_order_value
FROM dbo.PURCHASE
GROUP BY is_prime;
GO

-- Q7. Delivery preference distribution
SELECT delivery_preference, COUNT(*) AS orders
FROM dbo.PURCHASE
GROUP BY delivery_preference
ORDER BY orders DESC;
GO

-- Q8. Customer satisfaction through ratings (category-wise)
SELECT pc.category_name, ROUND(AVG(CAST(r.rating AS DECIMAL(4,2))),2) AS avg_rating,
       COUNT(r.review_id) AS total_reviews
FROM dbo.REVIEW r
JOIN dbo.PURCHASE p ON r.purchase_id = p.purchase_id
JOIN dbo.PRODUCT pr ON p.product_id = pr.product_id
JOIN dbo.PRODUCT_CATEGORY pc ON pr.category_id = pc.category_id
GROUP BY pc.category_name
ORDER BY avg_rating DESC;
GO

-- Q9. Payment method analysis
SELECT payment_method, COUNT(*) AS orders,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM dbo.PURCHASE), 1) AS pct_of_orders
FROM dbo.PURCHASE
GROUP BY payment_method
ORDER BY orders DESC;
GO

-- Q10. Eco-friendly vs non-eco category spend share (sustainability view)
SELECT pc.is_eco_friendly, COUNT(*) AS orders, SUM(p.amount) AS total_spend
FROM dbo.PURCHASE p
JOIN dbo.PRODUCT pr ON p.product_id = pr.product_id
JOIN dbo.PRODUCT_CATEGORY pc ON pr.category_id = pc.category_id
GROUP BY pc.is_eco_friendly;
GO

-- Q11. Wishlist items not yet purchased (potential recommendation candidates)
SELECT s.student_name, pr.product_name, w.added_date
FROM dbo.WISHLIST w
JOIN dbo.STUDENT s ON w.student_id = s.student_id
JOIN dbo.PRODUCT pr ON w.product_id = pr.product_id
LEFT JOIN dbo.PURCHASE p
       ON p.student_id = w.student_id AND p.product_id = w.product_id
WHERE p.purchase_id IS NULL;
GO

-- Q12. Simple "customers also bought" style recommendation base query
-- (co-purchase pairs within the same student, for a given product)
SELECT TOP (5) p2.product_id, pr2.product_name, COUNT(*) AS co_occurrence
FROM dbo.PURCHASE p1
JOIN dbo.PURCHASE p2
     ON p1.student_id = p2.student_id AND p1.product_id <> p2.product_id
JOIN dbo.PRODUCT pr2 ON p2.product_id = pr2.product_id
WHERE p1.product_id = 4   -- example: students who bought product_id 4 ...
GROUP BY p2.product_id, pr2.product_name
ORDER BY co_occurrence DESC;
GO
