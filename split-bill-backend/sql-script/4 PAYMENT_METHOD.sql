-- Create PAYMENT_METHOD table
CREATE TABLE PAYMENT_METHOD (
    METHOD_ID INT AUTO_INCREMENT PRIMARY KEY,
    METHOD_NAME VARCHAR(50) NOT NULL,
    CARD_NUMBER VARCHAR(50),
    ACCOUNT_NO VARCHAR(50),
    CREATED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
    UPDATED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    USER_ID INT,
    FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID)
);