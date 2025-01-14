-- Create TRANSACTION_HISTORY table
CREATE TABLE TRANSACTION_HISTORY (
    TRANSACTION_ID INT AUTO_INCREMENT PRIMARY KEY,
    USER_ID INT,
    TRANSACTION_TYPE VARCHAR(50) NOT NULL,
    TRANSACTION_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
    TRANSACTION_AMOUNT DECIMAL(10, 2) NOT NULL,
    CREATED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
    UPDATED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
    GROUP_ID INT,
    FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID),
    FOREIGN KEY (GROUP_ID) REFERENCES EXPENSES_GROUP(GROUP_ID)
);