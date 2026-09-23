-- ================================
-- DATABASE CREATION
-- ================================
CREATE DATABASE IF NOT EXISTS amazon;
USE amazon;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- ================================
-- TABLE: da_data
-- ================================
CREATE TABLE `da_data` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) DEFAULT NULL,
  `delivered` INT(11) DEFAULT NULL,
  `delivery_attempt` INT(11) DEFAULT NULL,
  `pickup_done` INT(11) DEFAULT NULL,
  `reject` INT(11) DEFAULT NULL,
  `mfn` INT(11) DEFAULT NULL,
  `mpos` INT(11) DEFAULT NULL,
  `c2d` INT(11) DEFAULT NULL,
  `volumetric_parcel` INT(11) DEFAULT NULL,
  `oda_km` INT(11) DEFAULT NULL,
  `odometer_kms` INT(11) DEFAULT NULL,
  `odometer_image` VARCHAR(255) DEFAULT NULL,
  `cash_500` INT(11) DEFAULT NULL,
  `cash_200` INT(11) DEFAULT NULL,
  `cash_100` INT(11) DEFAULT NULL,
  `cash_50` INT(11) DEFAULT NULL,
  `cash_20` INT(11) DEFAULT NULL,
  `cash_10` INT(11) DEFAULT NULL,
  `cash_5` INT(11) DEFAULT NULL,
  `cash_2` INT(11) DEFAULT NULL,
  `cash_1` INT(11) DEFAULT NULL,
  `routes` TEXT DEFAULT NULL,
  `total_cash_deposit` INT(11) DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ================================
-- INSERT: da_data
-- ================================
INSERT INTO da_data (username, delivered, delivery_attempt, pickup_done, reject, mfn, mpos, c2d, volumetric_parcel, oda_km, odometer_kms, odometer_image, cash_500, cash_200, cash_100, cash_50, cash_20, cash_10, cash_5, cash_2, cash_1, routes, total_cash_deposit) VALUES
('Aniket', 46, 6, 11, 4, 21, 17, 5, 4, 12, 100, 'odometer_1.jpg', 6, 8, 11, 8, 7, 11, 4, 1, 3, 'Main City', 6375),
('Aniket', 40, 2, 7, 5, 22, 14, 13, 5, 11, 96, 'odometer_4.jpg', 5, 8, 19, 13, 12, 18, 8, 1, 1, 'Other', 7113);

-- ================================
-- TABLE: employee
-- ================================
CREATE TABLE `employee` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `role` VARCHAR(50) NOT NULL DEFAULT 'user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ================================
-- INSERT: employee
-- ================================
INSERT INTO `employee` (`name`, `email`, `username`, `password`, `role`) VALUES
('Aniket Chandrakant Sonar','aniketsonar7083@gmail.com','Aniket','Aniket@23','user'),
('Aniket Chandrakant Sonar','aniketsonar7083@outlook.com','Admin','Admin@23','admin');
	


COMMIT;
