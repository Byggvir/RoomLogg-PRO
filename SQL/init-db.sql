DROP DATABASE IF EXISTS `RoomLogg`;
CREATE DATABASE IF NOT EXISTS RoomLogg;

GRANT ALL ON RoomLogg.* to 'weather'@'localhost' IDENTIFIED BY 'big4ahTheici3see7goo1ooh';

FLUSH PRIVILEGES;

USE `RoomLogg`;

--
-- Table structure for table `sensor`
--

DROP TABLE IF EXISTS `devices`;

CREATE TABLE `devices` (
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

CREATE TABLE `sensors` (
  `device_id` int(11) NOT NULL,
  `channel` int(11) NOT NULL,
  `sensorlocation` char(64) DEFAULT NULL,
  `sensortype` char(64) DEFAULT NULL,
  PRIMARY KEY (`device_id`, `channel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `sensorreports`;

CREATE TABLE `sensorreports` (
  `device_id` int(11) NOT NULL,
  `channel` int(11) NOT NULL,
  `dateutc` datetime NOT NULL,
  `Temperature` double DEFAULT NULL,
  `Humidity` double DEFAULT NULL,
  `Dewpoint` double DEFAULT NULL,
  `HeatIndex` double DEFAULT NULL,
  PRIMARY KEY ( `device_id`,`channel`, `dateutc` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `devices` VALUES (1, 'Kirche', 'Ramershovener Straße 6, 53359 Rheinbach', 50.626652096, 6.954796314);
INSERT INTO `devices` VALUES (2, 'Mittelerde', 'Zingsheimstraße 31, 53359 Rheinbach', 50.6209, 6.9616);

INSERT INTO `sensors` VALUES ( 1 , 1, 'Empore 1', 'DNT000005' ) ;
INSERT INTO `sensors` VALUES ( 1 , 2, 'Empore 2', 'DNT000005' ) ;
INSERT INTO `sensors` VALUES ( 1 , 3, 'Altar', 'DNT000005' ) ;
INSERT INTO `sensors` VALUES ( 1 , 4, 'tbd', 'DNT000005' ) ;
INSERT INTO `sensors` VALUES ( 1 , 5, 'Außen', 'DNT000005' ) ;

INSERT INTO `sensors` VALUES (2 , 2, 'Schlafzimmer', 'DNT000005') ;
INSERT INTO `sensors` VALUES (2 , 4, 'Daniel', 'DNT000005') ;
INSERT INTO `sensors` VALUES (2 , 5, 'Stephan', 'DNT000005') ;
INSERT INTO `sensors` VALUES (2 , 8, 'Wintergarten', 'DNT000005') ;

