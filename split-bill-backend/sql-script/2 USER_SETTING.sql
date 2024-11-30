-- Create USER_SETTING table
CREATE TABLE USER_SETTING (
    SETTING_ID INT AUTO_INCREMENT PRIMARY KEY,
    IS_ENABLED_P2P BOOLEAN NOT NULL DEFAULT FALSE,
    MAX_LEND_AMOUNT DECIMAL(10, 2),
    USER_ID INT,
    FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID)
);
