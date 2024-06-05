CREATE TABLE `users` (
    `uid` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL,
    `password` CHAR(64) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `phone` CHAR(10),
    `identity` CHAR(20) NOT NULL,
    `has_permit` BOOL NOT NULL,
    `bookings` INT NOT NULL DEFAULT 0,
    PRIMARY KEY (`uid`),
    CONSTRAINT `c_bookings` CHECK (`bookings` <= 3),
    CONSTRAINT `c_id_type` CHECK (`identity` IN (`staff`, `admin`, `visitor`))
);

CREATE TABLE `uw_spots` (
    `sid` INT NOT NULL AUTO_INCREMENT,
    `location` VARCHAR(50) NOT NULL,
    `parking_type` CHAR(20) NOT NULL,
    `latitude` VARCHAR(50) NOT NULL,
    `longitude` VARCHAR(50) NOT NULL,
    `maxstay` FLOAT,
    `price` FLOAT,
    `number_good` INT, 
    PRIMARY KEY (`sid`,`location`),
    CONSTRAINT `c_park_type` CHECK (`parking_type` IN (`permit`, `free`, `transponder`))
);

CREATE TABLE `cw_spots` (
    `sid` INT NOT NULL AUTO_INCREMENT,
    `location` VARCHAR(50) NOT NULL,
    `address` VARCHAR(64) NOT NULL,
    `parking_type` CHAR(20) NOT NULL,
    `latitude` VARCHAR(50) NOT NULL,
    `longitude` VARCHAR(50) NOT NULL,
    `maxstay` FLOAT,
    `price` FLOAT,
    `number_good` INT, 
    PRIMARY KEY (`sid`,`location`),
    CONSTRAINT `c_park_type` CHECK (`parking_type` IN (`permit`, `free`, `transponder`))
);

CREATE TABLE `booking` (
    `bid` INT NOT NULL AUTO_INCREMENT,
    `uid` INT NOT NULL,
    `sid` INT NOT NULL,
    `location` VARCHAR(50) NOT NULL,
    `address` VARCHAR(64),
    `create_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    `start_time` TIME NOT NULL,
    `length_of_stay` FLOAT,
    `end_time` TIME NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `price` FLOAT,
    `status` CHAR(10) NOT NULL,
    PRIMARY KEY (`bid`),
    CONSTRAINT `c_status` CHECK (`status` IN (`booked`, `cancelled`))
);
