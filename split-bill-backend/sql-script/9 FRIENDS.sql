-- Create FRIENDS table
CREATE TABLE FRIENDS (
    USER_ID INT,
    FRIEND_USER_ID INT,
    PRIMARY KEY (USER_ID, FRIEND_USER_ID)
);