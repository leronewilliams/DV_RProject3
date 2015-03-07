require("dplyr")
require("tidyr")
require("jsonlite")
head(vocab)
#Generates the "Female" and "Male"columns from the "SEX" column

names(Above4OU);
names(Above4cali);
names(Recentca);
names(Recentou);

justMAG <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT ca.MAG, ca.PLACE, ou.MAG, ou.PLACE FROM CLEANRECENTCA ca OUTER JOIN CLEANEDRECENTOU ou ON (ca.MAG = ou.MAG)"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_law229', PASS='orcl_law229', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
justMAG
justCA <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT MAG, PLACE FROM CLEANEDRECENTCAL "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_law229', PASS='orcl_law229', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
justOU <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT MAG, PLACE FROM RECENTOU "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_law229', PASS='orcl_law229', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
justCA
justOU

recentOUaverage <- justOU   %>% group_by(PLACE) %>% summarize(Average_Magnitude = mean(MAG))
recentCAaverage <- justCA  %>% group_by(PLACE) %>% summarize(Average_Magnitude = mean(MAG))
recentOUaverage
recentCAaverage

?ggplot
p2 <- recentCAaverage  %>%  ggplot(aes(x=PLACE, y=Average_Magnitude, color=PLACE))+geom_bar()
p2
p2 <- recentCAaverage  %>%  ggplot(aes(x=PLACE, y=Average_Magnitude, color=PLACE))+geom_point()
p2
p2 <- ggplot(r, aes(x=x, y=n, size=legend, color=legend)) + geom_line()

above4CA <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT MAG, PLACE FROM CLEANABOVE4CALI "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_law229', PASS='orcl_law229', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
above4CA
above4OU <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT MAG, PLACE FROM CLEANEDABOVE4OU "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_law229', PASS='orcl_law229', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
above4OU

p3 <- above4CA  %>%  ggplot(aes(x=PLACE, color=PLACE))+geom_bar(stat="bin")
p3 <- p3 + scale_y_continuous(limits=c(0,1250)) + theme(legend.position="none") + labs(x="State", y="Number of Earthquakes") + theme(plot.title=element_text(size=20, face="bold")) + labs(title='East Coast')
p3 <- p3 + theme(plot.title=element_text(size=20, face="bold"))
p4 <- above4OU  %>%  ggplot(aes(x=PLACE, color=PLACE), show_guide=FALSE)+geom_bar(stat="bin")
p4 <- p4 + scale_y_continuous(limits=c(0,1250)) + theme(legend.position="none") + labs(x="State", y="Number of Earthquakes") + theme(plot.title=element_text(size=20, face="bold")) + labs(title='Mid-South')
require(grid)
pushViewport(viewport(layout=grid.layout(1,2)))
print(p3,vp=viewport(layout.pos.row=1,layout.pos.col=1))
print(p4,vp=viewport(layout.pos.row=1,layout.pos.col=2))


#Average Vocab per Education
vocab %>% group_by(SEX) %>% summarize(Average_Education = mean(EDUCATION)) %>% tbl_df
#Average Vocab per Sex
vocab %>% group_by(SEX) %>% summarize(Average_Vocabulary = mean(VOCABULARY)) %>% tbl_df
#Standard Deviation Vocab per Sex
vocab %>% group_by(SEX) %>% summarize(Standard_Deviation_Vocabulary = sd(VOCABULARY)) %>% tbl_df
#Average Vocabs per Education
avgPerEduc <- vocab %>% group_by(EDUCATION) %>% summarize(Average_Vocabulary_per_Education = mean(VOCABULARY))
print(avgPerEduc, n=21)
#Top Vocabulary
vocab %>% arrange(desc(VOCABULARY)) %>% tbl_df
#Top 3 Vocab per Sex
vocab %>% group_by(SEX) %>% arrange(desc(VOCABULARY)) %>% slice(1:10) %>% tbl_df




