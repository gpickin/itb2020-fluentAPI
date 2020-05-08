-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.12 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table fluentapi.rants
CREATE TABLE IF NOT EXISTS `rants` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `body` text NOT NULL,
  `createdDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifiedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rants_userId` (`userId`),
  CONSTRAINT `fk_rants_userId` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=latin1;

-- Dumping data for table fluentapi.rants: ~23 rows (approximately)
/*!40000 ALTER TABLE `rants` DISABLE KEYS */;
INSERT INTO `rants` (`id`, `body`, `createdDate`, `modifiedDate`, `userId`) VALUES
	(4, 'Another rant', '2020-05-03 23:00:07', '2020-05-03 23:00:07', 2),
	(6, 'Another rant, where\'s my soapbox2', '2020-05-03 23:07:39', '2020-05-04 11:22:48', 3),
	(7, 'Another rant, where\'s my soapbox23', '2020-05-03 23:20:22', '2020-05-07 11:43:07', 2),
	(8, 'Another rant, where\'s my soapbox2', '2020-05-04 11:21:31', '2020-05-04 11:21:31', 2),
	(9, 'Another rant, where\'s my soapbox2', '2020-05-04 12:05:18', '2020-05-04 12:05:18', 2),
	(10, 'Another rant, where\'s my soapbox2', '2020-05-04 12:05:44', '2020-05-04 12:05:44', 2),
	(11, 'Another rant, where\'s my soapbox2', '2020-05-04 20:58:28', '2020-05-04 20:58:28', 2),
	(12, 'Another rant, where\'s my soapbox2', '2020-05-04 20:59:44', '2020-05-04 20:59:44', 2),
	(13, 'Another rant, where\'s my soapbox2', '2020-05-04 21:06:16', '2020-05-04 21:06:16', 2),
	(14, 'Another rant, where\'s my soapbox2', '2020-05-04 21:09:03', '2020-05-04 21:09:03', 2),
	(15, 'Another rant, where\'s my soapbox2', '2020-05-04 21:09:13', '2020-05-04 21:09:13', 2),
	(16, 'Another rant, where\'s my soapbox2', '2020-05-04 21:15:10', '2020-05-04 21:15:10', 2),
	(18, 'Another rant, where\'s my soapbox2', '2020-05-07 09:29:06', '2020-05-07 09:29:06', 2),
	(19, 'Another rant, where\'s my soapbox2', '2020-05-07 09:30:38', '2020-05-07 09:30:38', 2),
	(20, 'Another rant, where\'s my soapbox2', '2020-05-07 09:30:46', '2020-05-07 09:30:46', 2),
	(23, 'Another rant, where\'s my soapbox2', '2020-05-07 09:36:04', '2020-05-07 09:36:04', 2),
	(24, 'Another rant, where\'s my soapbox2', '2020-05-07 09:37:03', '2020-05-07 09:37:03', 2),
	(25, 'Another rant, where\'s my soapbox2', '2020-05-07 09:46:15', '2020-05-07 09:46:15', 2),
	(110, 'Testing test test', '2020-05-07 22:18:43', '2020-05-07 22:18:43', 2),
	(111, 'Testing test test', '2020-05-07 22:19:31', '2020-05-07 22:19:31', 2),
	(112, 'Scott likes me preso', '2020-05-07 22:19:37', '2020-05-07 22:19:37', 5),
	(113, 'Scott seems to like my preso', '2020-05-07 22:20:32', '2020-05-07 22:20:32', 2);
/*!40000 ALTER TABLE `rants` ENABLE KEYS */;

-- Dumping structure for table fluentapi.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `createdDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifiedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table fluentapi.users: ~6 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `email`, `password`, `createdDate`, `modifiedDate`) VALUES
	(2, 'gpickin', 'gavin@ortussolutions.com', '$2a$12$JKiBJZF352Tfm/c3PpeslOBKRAwtXlwczMPKeUV1raD0d1cwh5B5.', '2018-10-04 17:55:19', '2018-10-04 17:55:19'),
	(3, 'luis', 'lmajano@ortussolutions.com', '$2a$12$kSM/7Q5WgJ/xaKfLYwbPj.4QVJZo7tonT/h/PFDoUwfW3GDV/AttC', '2018-10-05 09:07:14', '2018-10-05 09:07:14'),
	(4, 'brad', 'brad@ortussolutions.com', '$2a$12$Vbb4dYywI5X.1qKEV2mDzeOTZk3iHIDfEtz80SoMT0KkFWTkb.PB6', '2018-10-05 09:29:37', '2018-10-05 09:29:37'),
	(5, 'javier', 'jquintero@ortussolutions.com', '$2a$12$UIEOglSflvGUbn5sHeBZ1.sAlaoBI4rpNOCIk2vF8R2KKz.ihP9/W', '2018-10-05 09:30:32', '2018-10-05 09:30:32'),
	(6, 'scott', 'scott@scott.com', '$2a$12$OjIpxecG9AlZTgVGV1jsvOegTwbqgJ29PlUkfomGsK/6hsVicsRW.', '2018-10-05 09:32:07', '2018-10-05 09:32:07'),
	(7, 'mike', 'mikep@netxn.com', '$2a$12$WWUwFEAoDGx.vB0jE54xser1myMUSwUMYo/aNn0cSGa8l6DQe67Q2', '2018-10-05 09:33:00', '2018-10-05 09:33:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
