#!/usr/bin/env Rscript
#
#
# Script: boxplots.r
#
# Stand: 2022-09-07
# (c) 2022 by Thomas Arend, Rheinbach
# E-Mail: thomas@arend-rhb.de
#

MyScriptName <- "datalogger"

options(OutDec=',')

require(data.table)
library(tidyverse)
library(grid)
library(gridExtra)
library(gtable)
library(lubridate)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(scales)
library(ragg)

# Set Working directory to git root

if (rstudioapi::isAvailable()){
  
  # When called in RStudio
  SD <- unlist(str_split(dirname(rstudioapi::getSourceEditorContext()$path),'/'))
  
} else {
  
  #  When called from command line 
  SD = ( function() return( if(length(sys.parents())==1) getwd() else dirname(sys.frame(1)$ofile) ) )()
  SD <- unlist(str_split(SD,'/'))
  
}

WD <- paste(SD[1:(length(SD))],collapse='/')
if ( SD[length(SD)] != "R" ) {
  
  WD <- paste( WD,"/R", sep = '')

}

setwd(WD)

source("lib/myfunctions.r")
source("lib/sql.r")

# Set output directory for diagrams

outdir <- '../png/boxplots/'
dir.create( outdir , showWarnings = FALSE, recursive = FALSE, mode = "0777")


today <- Sys.Date()
heute <- format(today, "%Y%m%d")

SQL <- paste( 
  'select * from reports;'
)

RoomLogg <- RunSQL(SQL)

# Jahr

J <- year(RoomLogg$dateutc)
JJ <- unique(J)

# Year of calendarweek

isoJ <- isoyear(RoomLogg$dateutc)
isoJJ <- unique(isoJ)

# Factor dateutc

RoomLogg$Jahre <- factor( J, levels = JJ, labels = JJ)
RoomLogg$Monate <- factor( month(RoomLogg$dateutc), levels = 1:12, labels = Monatsnamen)

RoomLogg$KwJahre <- factor( isoJ, levels = isoJJ, labels = isoJJ)
RoomLogg$Kw <- factor( isoweek(RoomLogg$dateutc), levels = 1:53, labels = paste('Kw', 1:53))

RoomLogg$Tag <- factor( yday(RoomLogg$dateutc), levels = 1:366, labels = 1:366 )

for ( id in unique(RoomLogg$sensor_id) ) {
  
  SQLsensor <- paste('select * from sensor as S join logger as L on S.logger_id = L.id where S.id = ', id, ';')
  SensorInfo <- RunSQL(SQLsensor)
  
  L <- RoomLogg %>% filter ( sensor_id == id )
  scl <- max(L$Temperature) / max(L$Humidity)
  
  L %>% ggplot() + 
    geom_boxplot( aes( x = Kw , y = Temperature, fill = Jahre ) , size = 1 ) +
    scale_y_continuous( labels = function (x) format(x, big.mark = ".", decimal.mark= ',', scientific = FALSE )) +
    expand_limits( y = 15) +
    expand_limits( y = 30) +
    theme_ipsum() +
    theme(  legend.position="right"
            , axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1) ) +
    labs( title = paste( 'RoomLogg Sensor:', SensorInfo$name[1],'-', SensorInfo$sensorlocation )
          , subtitle = 'Temperatur'
          , x = "Datum/Zeit"
          , y = "Temperatur [°C]"
          , colour = 'Jahr'
          , caption = paste( "Stand:", heute )
    ) -> P
  
  ggsave(   
    file = paste( outdir, 'Temperature', id, '.png', sep='')
    , plot = P
    , device = 'png'
    , bg = "white"
    , width = 1920
    , height = 1080
    , units = "px"
    , dpi = 144
  )

  L %>% ggplot() + 
    geom_boxplot( aes( x = Kw , y = Humidity, fill = Jahre ) , size = 1 ) +
    scale_y_continuous( labels = function (x) format(x, big.mark = ".", decimal.mark= ',', scientific = FALSE )) +
    expand_limits( y = 15) +
    expand_limits( y = 30) +
    theme_ipsum() +
    theme(  legend.position="right"
            , axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1) ) +
    labs( title = paste( 'RoomLogg Sensor:', SensorInfo$name[1],'-', SensorInfo$sensorlocation )
          , subtitle = 'Temperatur'
          , x = "Datum/Zeit"
          , y = "Luftfeuchtigkeit [%]"
          , colour = 'Jahr'
          , caption = paste( "Stand:", heute )
    ) -> P
  
  ggsave(   
    file = paste( outdir, 'Humidity', id, '.png', sep='')
    , plot = P
    , device = 'png'
    , bg = "white"
    , width = 1920
    , height = 1080
    , units = "px"
    , dpi = 144
  )
}