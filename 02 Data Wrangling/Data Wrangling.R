require("dplyr")
require("tidyr")
require("jsonlite")
#Generates the "Female" and "Male"columns from the "SEX" column

names(Above4OU);
names(Above4cali);
names(Recentca);
names(Recentou);

justCA <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT MAG,PLACE FROM CLEANEDRECENTCAL "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_law229', PASS='orcl_law229', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
justOU <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT MAG, PLACE FROM CLEANEDRECENTOU "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_law229', PASS='orcl_law229', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

combinedAll <- bind_rows(justCA, justOU)
p2 <- combinedAll %>%  ggplot(aes(x=PLACE, y=MAG, color=PLACE))+geom_boxplot()
p2 <- p2 + theme(legend.position="none") + labs(x="State", y="Magnitude") + theme(plot.title=element_text(size=20, face="bold")) + labs(title='Typical Range of Earthquakes')
p2

#working!
above4CA <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT MAG, PLACE FROM CLEANABOVE4CALI "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_law229', PASS='orcl_law229', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
above4OU <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT MAG, PLACE FROM CLEANEDABOVE4OU "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_law229', PASS='orcl_law229', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

p3 <- above4CA  %>%  ggplot(aes(x=PLACE, color=PLACE))+geom_bar(stat="bin")
p3 <- p3 + scale_y_continuous(limits=c(0,1250)) + theme(legend.position="none") + labs(x="State", y="Number of Level 4 and Above Earthquakes") + theme(plot.title=element_text(size=20, face="bold")) + labs(title='East Coast')
p3 <- p3 + theme(plot.title=element_text(size=20, face="bold"))
p4 <- above4OU  %>%  ggplot(aes(x=PLACE, color=PLACE), show_guide=FALSE)+geom_bar(stat="bin")
p4 <- p4 + scale_y_continuous(limits=c(0,1250)) + theme(legend.position="none") + labs(x="State", y="Number of Level 4 and Above Earthquakes") + theme(plot.title=element_text(size=20, face="bold")) + labs(title='Mid-South')
require(grid)

p2

pushViewport(viewport(layout=grid.layout(1,2)))
print(p3,vp=viewport(layout.pos.row=1,layout.pos.col=1))
print(p4,vp=viewport(layout.pos.row=1,layout.pos.col=2))




