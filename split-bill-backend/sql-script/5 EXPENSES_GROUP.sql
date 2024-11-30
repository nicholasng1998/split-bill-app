-- Create EXPENSES_GROUP table
CREATE TABLE EXPENSES_GROUP (
    GROUP_ID INT AUTO_INCREMENT PRIMARY KEY,
    GROUP_NAME VARCHAR(100) NOT NULL,
    TOTAL_EXPENSES DECIMAL(10, 2) DEFAULT 0,
    PAID_AMOUNT DECIMAL(10, 2) DEFAULT 0,
    OUTSTANDING_AMOUNT DECIMAL(10, 2) DEFAULT 0,
    STATUS VARCHAR(20) NOT NULL,
    HOST INT,
    DUE_DATE DATE,
    CREATED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
    UPDATED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);