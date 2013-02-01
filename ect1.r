# Calls vw to process the training input file and create a regression model named r_temp
# -c tells vw to create a cache file (basically a binary file to improve performance).
system("vw hockeyTrain.dat -f r_temp -c --passes 10000 --ect 10")
# Calls vw to predict using the test data. -t tells vw to create predictions using the
# r_temp model and '-p p_out2' tells vw to output predictions to file p_out2.
system("vw hockeyTest.dat -t -i r_temp -p p_out2")
# Read prediction file into R.
res1 <- read.csv(file = 'p_out2',header = F, sep =" ")
#res1$V2 <- as.numeric(substr(res1$V1,0,1))


res2 <- read.csv(file = 'hockeyTest.dat',header = F, sep= "|")
res2$V2 <- str_split(res2$V1," ")
x1 <- read.table(textConnection(as.character(res2$V1)), sep = " ")
head(x1)
x1$pred1 <- res1$V1

mapk(10,x1$V1,res1$V1)
qplot(x1$V1,x1$pred1, position = "jitter")

#head(res1)
#head(res2)
#summary(res1)
#summary(res2)

#colAUC(res1$V1, res2$x1.V1)
#table(res1$V1, x1$V1)

#qplot(x1$V1,x1$pred1, position = "jitter")
#mapk(5,x1$V1,res1$V1)
