DROP DATABASE IF EXISTS `RoomLogg`;
CREATE DATABASE IF NOT EXISTS RoomLogg;

GRANT ALL ON RoomLogg.* to 'weather'@'localhost' IDENTIFIED BY 'big4ahTheici3see7goo1ooh';

FLUSH PRIVILEGES;

USE `RoomLogg`;

--
-- Table structure for table `sensor`
--

DROP TABLE IF EXISTS `logger`;

CREATE TABLE `logger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(64) DEFAULT NULL,
  `location` char(64) DEFAULT NULL,
  `location_lat` double DEFAULT NULL,
  `location_long` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  INDEX `location` (`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `sensor`;

CREATE TABLE `sensor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logger_id` int(11) NOT NULL,
  `channel` int(11) NOT NULL,
  `sensorlocation` char(64) DEFAULT NULL,
  `sensortype` char(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX (`logger_id`, `channel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;

CREATE TABLE `reports` (
  `sensor_id` int(11) NOT NULL,
  `dateutc` datetime NOT NULL,
  `Temperature` double DEFAULT NULL,
  `Humidity` double DEFAULT NULL,
  `Dewpoint` double DEFAULT NULL,
  `HeatIndex` double DEFAULT NULL,
  PRIMARY KEY ( `sensor_id`, `dateutc` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `logger` VALUES (1, 'Kirche', 'Ramershovener Straße 6, 53359 Rheinbach', 50.626652096, 6.954796314);

INSERT INTO `sensor` VALUES (1, 1 , 1, 'Empore 1', 'DNT000005') ;
INSERT INTO `sensor` VALUES (2, 1 , 2, 'Empore 2', 'DNT000005') ;
INSERT INTO `sensor` VALUES (3, 1 , 3, 'Altar', 'DNT000005') ;
INSERT INTO `sensor` VALUES (4, 1 , 4, 'tbd', 'DNT000005') ;
INSERT INTO `sensor` VALUES (5, 1 , 3, 'Außen', 'DNT000005') ;
