-- Create USER table
CREATE TABLE USER (
    USER_ID INT AUTO_INCREMENT PRIMARY KEY,
    IDENTITY_NO VARCHAR(50) NOT NULL,
    MOBILE_NO VARCHAR(20) NOT NULL,
    USERNAME VARCHAR(50) NOT NULL,
    PASSWORD VARCHAR(255) NOT NULL,
    CREATED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
    UPDATED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);