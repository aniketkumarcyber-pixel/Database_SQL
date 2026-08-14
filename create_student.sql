
CREATE TABLE STUDENT (
    student_id      INT PRIMARY KEY IDENTITY(1,1),
    student_name    VARCHAR(100) NOT NULL,
    age             INT NOT NULL,
    age_group       VARCHAR(30),
    gender          VARCHAR(10),
    city            VARCHAR(50),
    email           VARCHAR(100) UNIQUE
);