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
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT1(product_id)
);