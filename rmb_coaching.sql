-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2026 at 02:48 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rmb_coaching`
--
CREATE DATABASE IF NOT EXISTS `rmb_coaching` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `rmb_coaching`;

-- --------------------------------------------------------

--
-- Table structure for table `cartitems`
--

CREATE TABLE `cartitems` (
  `Id` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `CourseId` int(11) NOT NULL,
  `AddedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `Id` int(11) NOT NULL,
  `Title` varchar(200) NOT NULL,
  `ShortDescription` varchar(300) NOT NULL,
  `Description` text NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `DurationInDays` int(11) NOT NULL,
  `Category` varchar(100) NOT NULL,
  `DifficultyLevel` varchar(50) NOT NULL,
  `ImageUrl` varchar(500) DEFAULT NULL,
  `IsSubscription` tinyint(1) NOT NULL DEFAULT 0,
  `IsActive` tinyint(1) NOT NULL DEFAULT 1,
  `CreatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`Id`, `Title`, `ShortDescription`, `Description`, `Price`, `DurationInDays`, `Category`, `DifficultyLevel`, `ImageUrl`, `IsSubscription`, `IsActive`, `CreatedAt`) VALUES
(1, 'Kezdő tömegnövelő edzésterv', 'Izomtömeg-növelő program kezdőknek', '4 hetes részletes edzésterv és alap étrendi ajánlások.', 7990.00, 30, 'Tömegnövelés', 'Kezdő', '/images/tomegkezdo.jpg', 0, 1, '2026-04-03 15:46:32'),
(2, 'Fogyás és forma program', 'Zsírégető edzésterv', 'Otthoni és konditermi elemeket tartalmazó 6 hetes program.', 8990.00, 42, 'Fogyás', 'Kezdő', '/images/fogyas.jpg', 0, 1, '2026-04-03 15:46:32'),
(3, 'Haladó erőnövelő program', 'Erő és teljesítmény növelése', 'Haladó szintű progresszív edzésprogram.', 10990.00, 60, 'Erőnlét', 'Haladó', '/images/ero.jpg', 0, 1, '2026-04-03 15:46:32');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `Id` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `CourseId` int(11) NOT NULL,
  `PriceAtPurchase` decimal(10,2) NOT NULL,
  `OrderDate` datetime NOT NULL DEFAULT current_timestamp(),
  `IsCancelled` tinyint(1) NOT NULL DEFAULT 0,
  `CancelledAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `Id` int(11) NOT NULL,
  `FullName` varchar(150) NOT NULL,
  `Email` varchar(150) NOT NULL,
  `PhoneNumber` varchar(30) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `Role` varchar(20) NOT NULL DEFAULT 'User',
  `CreatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`Id`, `FullName`, `Email`, `PhoneNumber`, `PasswordHash`, `Role`, `CreatedAt`) VALUES
(1, 'balazs', 'balazs@balazs.balazs', 'balazs', '100000.dEFLVuJFRa6T67N7i3bQjg==.7EXJ4cYdmu3GhG7yK9edBcLWhiwPb8OVAh+2oLZZbww=', 'Admin', '2026-04-06 14:09:31'),
(2, 'balazs', 'balazs@balazs', 'balazs', '100000.5X4VpzM8Sh0P1I1K4sCsOQ==.vPHS0JeOj5oCGt0R1+gOdLhzQMKIbS5Wl5fjdDPC5Hs=', 'User', '2026-04-06 14:33:40');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cartitems`
--
ALTER TABLE `cartitems`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `UQ_CartItems_UserId` (`UserId`),
  ADD KEY `FK_CartItems_Courses` (`CourseId`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `FK_Orders_Users` (`UserId`),
  ADD KEY `FK_Orders_Courses` (`CourseId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `UQ_Users_Email` (`Email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cartitems`
--
ALTER TABLE `cartitems`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cartitems`
--
ALTER TABLE `cartitems`
  ADD CONSTRAINT `FK_CartItems_Courses` FOREIGN KEY (`CourseId`) REFERENCES `courses` (`Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_CartItems_Users` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK_Orders_Courses` FOREIGN KEY (`CourseId`) REFERENCES `courses` (`Id`),
  ADD CONSTRAINT `FK_Orders_Users` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
