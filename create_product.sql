
CREATE TABLE PRODUCT1 (
    product_id      INT PRIMARY KEY IDENTITY(1,1),
    product_name    VARCHAR(100) NOT NULL,
    category_id     INT NOT NULL,
    brand           VARCHAR(50),
    price           DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES PRODUCT_CATEGORY1(category_id)
);