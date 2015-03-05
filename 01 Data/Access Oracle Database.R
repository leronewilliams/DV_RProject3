# Query to build the join data frame
require("RCurl")
require("jsonlite")
require("dplyr")
require("ggplot2")
quake <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT r1.LATITUDE, r1.LONGITUDE, r1.PLACE, r2.LATITUDE, r2.LONGITUDE, r2.PLACE, r1.MAG, r2.MAG FROM ABOVE4CALI r1 JOIN ABOVE4OU r2 ON (r1.MAG = r2.MAG)"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_law229', PASS='orcl_law229', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
quake %>% ggplot(aes(x=LATITUDE, y = LONGITUDE , color = PLACE)) + geom_point()
