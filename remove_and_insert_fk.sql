USE novacart_student_analytics2;
GO

-- Remove the WRONG foreign key
ALTER TABLE dbo.PURCHASE
DROP CONSTRAINT FK__PURCHASE__produc__66603565;
GO

-- Create the CORRECT foreign key
ALTER TABLE dbo.PURCHASE
ADD CONSTRAINT FK_PURCHASE_PRODUCT
FOREIGN KEY (product_id)
REFERENCES dbo.PRODUCT(product_id);
GO