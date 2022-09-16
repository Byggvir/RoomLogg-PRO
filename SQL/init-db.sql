DROP DATABASE IF EXISTS `RoomLogg`;
CREATE DATABASE IF NOT EXISTS RoomLogg;

GRANT ALL ON RoomLogg.* to 'weather'@'localhost' ;

FLUSH PRIVILEGES;

USE `RoomLogg`;

--
-- Table structure for table `sensor`
--

DROP TABLE IF EXISTS `devices`;

CREATE TABLE `devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devtype` char(64) DEFAULT NULL,
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

INSERT INTO `devices` VALUES 
    ( 1, 'WeatherScreen PRO', 'Mittelerde', 'Zingsheimstraße 31, 53359 Rheinbach', 50.6209, 6.9616)
  , ( 2, 'RoomLogg PRO', 'Kirche', 'Ramershovener Straße 6, 53359 Rheinbach', 50.6267, 6.9548);

INSERT INTO `sensors` VALUES 
    ( 1, 1, 'EG Ost', 'DNT000005' )
  , ( 1, 2, 'OG 1 Ost', 'DNT000005' )
  , ( 1, 3, 'OG 1 West', 'DNT000005' )
  , ( 1, 4, 'DG Ost', 'DNT000005' )
  , ( 1, 5, 'DG West', 'DNT000005' )
  , ( 1, 8, 'Wintergarten', 'DNT000005' )
  , ( 2, 1, 'Empore 1', 'DNT000005' )
  , ( 2, 2, 'Empore 2', 'DNT000005' )
  , ( 2, 3, 'Empore 3', 'DNT000005' )
  , ( 2, 4, 'Altar', 'DNT000005' )
  , ( 2, 5, 'Außen', 'DNT000005' )
  , ( 2, 6, 'Foyer', 'DNT000005' )
;  
