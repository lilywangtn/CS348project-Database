CREATE TABLE `users` (
    `uid` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL,
    `password` VARCHAR(50) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `phone` CHAR(10),
    `identity` CHAR(20) NOT NULL,
    `booking_num` INT NOT NULL DEFAULT 0,
    PRIMARY KEY (`uid`),
    CONSTRAINT `c_bookings` CHECK (`booking_num` <= 3),
    CONSTRAINT `c_id_type` CHECK (`identity` IN ("staff", "admin", "visitor", "student"))
);

CREATE TABLE `permit_holders` (
    `uid` INT NOT NULL,
    `type` CHAR(20) NOT NULL,
    `start_time` TIME NOT NULL,
    `end_time` TIME NOT NULL,
    PRIMARY KEY (`uid`),
    FOREIGN KEY (`uid`) REFERENCES `users`(`uid`),
    CONSTRAINT `c_type` CHECK (`type` IN ("accessible", "staff", "student"))
);

CREATE TABLE `lots` (
    `lid` INT NOT NULL AUTO_INCREMENT,
    `area` CHAR(2) NOT NULL,
    `address` VARCHAR(64) NOT NULL,
    `lot_name` VARCHAR(50) NOT NULL,
    `capacity` INT NOT NULL,
    PRIMARY KEY (`lid`),
    CONSTRAINT `c_area` CHECK (`area` IN ("uw", "cw"))
);

CREATE TABLE `spots` (
    `lid` INT NOT NULL,
    `sid` INT NOT NULL,
    `parking_type` CHAR(20) NOT NULL,
    `latitude` VARCHAR(50) NOT NULL,
    `longitude` VARCHAR(50) NOT NULL,
    `maxstay` FLOAT,
    `price` FLOAT,
    `like_num` INT, 
    PRIMARY KEY (`lid`, `sid`),
    FOREIGN KEY (`lid`) REFERENCES `lots`(`lid`),
    CONSTRAINT `c_park_type` CHECK (`parking_type` IN ("permit", "pay", "accessible", "free"))
);

CREATE TABLE `bookings` (
    `bid` INT NOT NULL AUTO_INCREMENT,
    `uid` INT NOT NULL,
    `lid` INT NOT NULL,
    `sid` INT NOT NULL,
    `create_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    `start_time` TIME NOT NULL,
    `length_of_stay` FLOAT NOT NULL,
    `end_time` TIME NOT NULL,
    `price` FLOAT,
    `status` BOOL NOT NULL,
    PRIMARY KEY (`bid`),
    FOREIGN KEY (`uid`) REFERENCES `users`(`uid`),
    FOREIGN KEY (`lid`,`sid`) REFERENCES `spots`(`lid`,`sid`)
);
