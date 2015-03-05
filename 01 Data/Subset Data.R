require("dplyr")
#Displays first six rows
head(quake)
#Displays last six rows
tail(quake)
#Converts data to tbl class. tbl's are easier to examine than data frames. R displays only the data that fits on screen
tbl_df(quake)
#Information dense summary of tbl data.
glimpse(quake)
#Produces a summary data for each column of the dataframe
summary(quake)
# Compactly displays the internal structure of the dataframe
str(quake)

