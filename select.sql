USE novacart_student_analytics2;
GO

SELECT DB_NAME() AS Current_Database;

SELECT 
    product_id,
    product_name
FROM dbo.PRODUCT
WHERE product_id IN (1,2,3,4,6);

SELECT 
    student_id,
    student_name
FROM dbo.STUDENT
WHERE student_id IN (1,2,3,4,5,6);

SELECT
    fk.name AS Foreign_Key,
    OBJECT_SCHEMA_NAME(fk.parent_object_id) AS Child_Schema,
    OBJECT_NAME(fk.parent_object_id) AS Child_Table,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS Child_Column,
    OBJECT_SCHEMA_NAME(fk.referenced_object_id) AS Parent_Schema,
    OBJECT_NAME(fk.referenced_object_id) AS Parent_Table,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS Parent_Column
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc
    ON fk.object_id = fkc.constraint_object_id
WHERE OBJECT_NAME(fk.parent_object_id) = 'PURCHASE';