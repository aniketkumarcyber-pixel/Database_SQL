CREATE TABLE WISHLIST (
    wishlist_id     INT PRIMARY KEY IDENTITY(1,1),
    student_id      INT NOT NULL,
    product_id      INT NOT NULL,
    added_date      DATE,
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT1(product_id)
);