# RoomLogg-PRO
R scripts to display recorded data from **dnt RoomLogg PRO**

***dnt RoomLoog PRO*** records the readings from up to eight sensors on an SD card.

The data is saved in CSV files in the HISTORY folder. This application imports the data into a SQL database using a BASH script. The R scripts retrieve measured values from the database, evaluate the data and draw corresponding diagrams.

## Installation

For installation, load this repository into a directory on your computer.

To create the SQL database with a ***dnt RoomLogg PRO*** and 5 sensors as an example, run the SQL script ***init-db*** in the SQL directory as root.

```
    mysql --user=root --password < SQL/init-db.sql```
```

This script will create a database ***RoomLogg*** with three tables ***logger***, ***sensor*** and ***reports***.

Your can manage multiple ***dnt RoomLogg PRO*** with multiple sensors.

In order to be able to access the SQL database with the R script, copy the sample configuration file ***SQL/RoomLogg.conf*** to the directory ***~/R/sql.conf.d/*** in your home directory and adjust the user and password according to your needs.

I recommend creating your own user who has access to the database. Don't use root.

## Import own data

To import your own data into the database, copy the data from the HISTORY folder to the HISTORY folder in the repository.

Then go to the bash directory and convert the data with the BASH script  ***convert4import***. All data is written to a file ***/tmp/RoomLogg.csv***. This file is then imported into the database using the SQL script ***/SQL/import-reprots.sql***.

```
    cd bash
    ./convert4import
    cd ../SQL
    mysql --user=youruser --password  < import-reports.sql
```

## R-Scripts

The R-Scripts are located in the folder ***R/***. They draw different charts. The diagrams are stored in sub-folders of ***png***.

### lines.r

***lines.r*** Draws a simple line chart, which is only useful when the period is not to long.

Output is stored in ***png/lines/***.

### boxplots.r

***boxplots.r*** draws boxplots of temperature or humidity for days, weeks or months.

Output is stored in ***png/boxplots/***.

tbc