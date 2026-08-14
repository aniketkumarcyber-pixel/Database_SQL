
CREATE TABLE PRODUCT_CATEGORY1 (
    category_id     INT PRIMARY KEY IDENTITY(1,1),
    category_name   VARCHAR(50) NOT NULL,
    is_eco_friendly VARCHAR(3) DEFAULT 'No'
);