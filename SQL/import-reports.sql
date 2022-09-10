use RoomLogg;

LOAD DATA LOCAL 
INFILE '/tmp/RoomLoggReports.csv'      
INTO TABLE `sensorreports`
FIELDS TERMINATED BY ','
IGNORE 0 ROWS;
