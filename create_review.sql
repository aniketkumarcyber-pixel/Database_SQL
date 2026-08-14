CREATE TABLE REVIEW (
    review_id       INT PRIMARY KEY IDENTITY(1,1),
    purchase_id     INT NOT NULL,
    rating          INT CHECK (rating BETWEEN 1 AND 5),
    comment         VARCHAR(255),
    review_date     DATE,
    FOREIGN KEY (purchase_id) REFERENCES PURCHASE(purchase_id)
);