# Query to build the join data frame
require("RCurl")
require("jsonlite")
require("dplyr")
require("tidyr")
require("ggplot2")


Above4cali <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * FROM ABOVE4CALI WHERE ROWNUM <= 35"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_law229', PASS='orcl_law229', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

Above4OU <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * FROM ABOVE4OU WHERE ROWNUM <= 35"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_law229', PASS='orcl_law229', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

Recentca <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * FROM RECENTCA WHERE ROWNUM <= 35"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_law229', PASS='orcl_law229', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

Recentou <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * FROM RECENTOU WHERE ROWNUM <= 35"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_law229', PASS='orcl_law229', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

names(Above4OU);
names(Above4cali);
names(Recentca);
names(Recentou)

left_join(Above4cali, Above4OU, by = "MAG") %>% ggplot(aes(x=LATITUDE.x, y=LONGITUDE.x, color=PLACE.x))+geom_point()

right_join(Above4cali, Above4OU, by = "DEPTH") %>% ggplot(aes(x=LATITUDE.x, y=LONGITUDE.x, color=PLACE.x))+geom_point()

inner_join(Above4cali, Above4OU, by = "MAG") %>% ggplot(aes(x=LATITUDE.x, y=LONGITUDE.x, color=PLACE.x))+geom_point()

full_join(Above4cali, Above4OU, by = "DEPTH") %>% ggplot(aes(x=LATITUDE.x, y=LONGITUDE.x, color=PLACE.x))+geom_point()

semi_join(Above4cali, Above4OU, by = "MAG") %>% ggplot(aes(x=LATITUDE, y=LONGITUDE, color=PLACE))+geom_point()

anti_join(Above4cali, Above4OU, by = "DEPTH") %>% ggplot(aes(x=LATITUDE, y=LONGITUDE, color=PLACE))+geom_point()

#bind_rows(Above4cali, Above4OU) %>% ggplot(aes(x=LATITUDE, y=LONGITUDE, color=PLACE))+geom_point()





















