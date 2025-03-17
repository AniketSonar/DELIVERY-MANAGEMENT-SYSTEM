-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 06, 2025 at 02:13 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `amazon`
--

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` varchar(50) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `name`, `email`, `username`, `password`, `created_at`, `role`) VALUES
(1, 'Aniket Chandrakant Sonar', 'aniketsonar7083@gmail.com', 'SonarAniket', 'Aniket@23', '2025-02-25 16:34:10', 'user'),
(2, 'Karan Anil Pawar', 'karanpawar912313@gmail.com', 'Karan', 'Karan@23', '2025-02-27 04:57:35', 'user'),
(3, 'Chandrakant Ramesh Sonar', 'abc@gmail.com', 'Chandrakant', 'Chandu@23', '2025-03-05 12:42:58', 'user'),
(4, 'Aniket Chandrakant Sonar', 'aniketsonar7083@outlook.com', 'Aniket', 'Aniket@23', '2025-03-06 11:41:15', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `end_route`
--

CREATE TABLE `end_route` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `delivered` int(11) DEFAULT NULL,
  `delivery_attempt` int(11) DEFAULT NULL,
  `pickup_done` int(11) DEFAULT NULL,
  `reject` int(11) DEFAULT NULL,
  `mfn` int(11) DEFAULT NULL,
  `mpos` int(11) DEFAULT NULL,
  `c2d` int(11) DEFAULT NULL,
  `volumetric_parcel` int(11) DEFAULT NULL,
  `oda_km` int(11) DEFAULT NULL,
  `odometer_kms` int(11) DEFAULT NULL,
  `odometer_image` varchar(255) DEFAULT NULL,
  `cash_500` int(11) DEFAULT NULL,
  `cash_200` int(11) DEFAULT NULL,
  `cash_100` int(11) DEFAULT NULL,
  `cash_50` int(11) DEFAULT NULL,
  `cash_20` int(11) DEFAULT NULL,
  `cash_10` int(11) DEFAULT NULL,
  `cash_5` int(11) DEFAULT NULL,
  `cash_2` int(11) DEFAULT NULL,
  `cash_1` int(11) DEFAULT NULL,
  `routes` text DEFAULT NULL,
  `total_cash_deposit` int(11) DEFAULT NULL,
  `created_at` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `end_route`
--

INSERT INTO `end_route` (`id`, `username`, `delivered`, `delivery_attempt`, `pickup_done`, `reject`, `mfn`, `mpos`, `c2d`, `volumetric_parcel`, `oda_km`, `odometer_kms`, `odometer_image`, `cash_500`, `cash_200`, `cash_100`, `cash_50`, `cash_20`, `cash_10`, `cash_5`, `cash_2`, `cash_1`, `routes`, `total_cash_deposit`, `created_at`) VALUES
(1, 'SonarAniket', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'static/uploads/Screenshot (20).png', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', NULL, '2025-03-05'),
(2, 'Karan', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'static/uploads/Screenshot (26).png', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', NULL, '2025-03-05'),
(3, 'Karan', 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'static/uploads/Screenshot (26).png', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', NULL, '2025-03-05'),
(4, 'Karan', 25, 3, 5, 2, 1, 10, 15, 3, 10500, 10550, 'static/uploads/Screenshot (20).png', 5, 6, 10, 0, 0, 0, 0, 0, 0, 0, '', 15000, '2025-03-05'),
(5, 'Karan', 25, 3, 5, 2, 1, 10, 15, 3, 10500, 10550, 'static/uploads/Screenshot (20).png', 5, 6, 10, 0, 0, 0, 0, 0, 0, 0, '', 15000, '2025-03-05'),
(6, 'SonarAniket', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'static/uploads/Screenshot (23).png', 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, '', 10000, '2025-03-05'),
(7, 'SonarAniket', 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 'static/uploads/Screenshot (59).png', 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, '', 5400, '2025-03-05'),
(8, 'SonarAniket', 3, 3, 3, 3, 3, 3, 3, 3, 33, 4, 'static/uploads/Screenshot (22).png', 1, 1, 2, 1, 0, 0, 0, 0, 0, 0, '', 3000, '2025-03-05'),
(9, 'SonarAniket', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 'static/uploads/Screenshot (20).png', 4, 4, 4, 2, 0, 0, 0, 0, 0, 0, '', 11000, '2025-03-05'),
(10, 'SonarAniket', 1, 1, 1, 1, 1, 1, 1, 1, 11, 15, 'static/uploads/imresizer-1688381054874.jpg', 1, 1, 1, 1, 4, 0, 0, 0, 0, 0, '', 3000, '2025-03-05'),
(11, 'SonarAniket', 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 'static/uploads/Screenshot (57).png', 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'devpur,main_city,wadibhokar_road', 10000, '2025-03-05'),
(12, 'SonarAniket', 50, 3, 5, 1, 3, 10, 12, 5, 10505, 10555, 'static/uploads/Screenshot (24).png', 2, 2, 2, 6, 0, 0, 0, 0, 0, 0, 'devpur,main_city,wadibhokar_road', 6000, '2025-03-05'),
(13, 'SonarAniket', 75, 6, 12, 3, 10, 10, 20, 5, 10500, 10550, 'static/uploads/Screenshot (73).png', 1, 16, 20, 16, 2, 0, 0, 7, 9, 7, 'nakane_road,out_area,station_road', 15760, '2025-03-05'),
(14, 'SonarAniket', 40, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'static/uploads/Screenshot (116).png', 111, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'devpur,malegaon_road,station_road', 222000, '2025-03-05'),
(15, 'SonarAniket', 40, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'static/uploads/Screenshot (116).png', 111, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'devpur,malegaon_road,station_road', 222000, '2025-03-05'),
(16, 'SonarAniket', 40, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'static/uploads/Screenshot (116).png', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'devpur,malegaon_road,station_road', 2000, '2025-03-05'),
(17, 'SonarAniket', 40, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'static/uploads/Screenshot (116).png', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'devpur,malegaon_road,station_road', 2000, '2025-03-05'),
(18, 'SonarAniket', 40, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'static/uploads/Screenshot (116).png', 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'devpur,malegaon_road,station_road', 22000, '2025-03-05'),
(19, 'SonarAniket', 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 'static/uploads/Screenshot (57).png', 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'devpur,main city,wadibhokar road', 10000, '2025-03-05'),
(20, 'SonarAniket', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'static/uploads/Screenshot (25).png', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Devpur,Main City,Malegaon Road,Nakane Road,Other,Out Area,Sakri Road,Station Road,Wadibhokar Road', 2000, '2025-03-05'),
(21, 'SonarAniket', 1, 1, 1, 1, 1, 1, 1, 1, 15000, 15001, 'static/uploads/GEAR 5.jpeg', 152, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 304000, '2025-03-05'),
(22, 'Karan', 12, 1, 1, 1, 11, 1, 2, 1, 1, 10, 'static/uploads/GEAR 5.jpeg', 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Devpur,Malegaon Road,Out Area', 2500, '2025-03-05'),
(23, 'Chandrakant', 45, 3, 1, 2, 0, 0, 10, 5, 10500, 10550, 'static/uploads/artlogo-co.png', 2, 5, 10, 10, 0, 0, 0, 0, 0, 0, 'Devpur,Main City', 9500, '2025-03-05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `end_route`
--
ALTER TABLE `end_route`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `end_route`
--
ALTER TABLE `end_route`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
