require("dplyr")
require("tidyr")
head(vocab)
#Generates the "Female" and "Male"columns from the "SEX" column
vocab %>% spread(SEX,EDUCATION) %>% tbl_df
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