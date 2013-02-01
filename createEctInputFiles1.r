library(caTools)
library(arm)
library(ggplot2)
library(Metrics)


# Read in training data.
train <- read.csv(file = '2010-11.csv', header = T)
# Remove rows without rank.
train <- train[!is.na(train$Rk),]
# Assigns factor variable based on which 20% of overall rank player occupies.
train$cutter1 <- cut(train$Rk, 10, labels = F)
# Optional binary variable for manual OVA / OAA classification.
train$cutter2 <- ifelse(train$cutter1 == 1, 1, 0)
# Scales player age variable.
train$age2 <- (as.numeric(as.character(train$Age)) - mean(as.numeric(as.character(train$Age))) 
               / sd(as.numeric(as.character(train$Age))))
train$age2 <- round(as.numeric(as.character(train$age2)),5)
# Scales games played variable.
train$GP2 <- (as.numeric(as.character(train$GP)) - mean(as.numeric(as.character(train$GP))) 
              / sd(as.numeric(as.character(train$GP))))
train$GP2 <- round(as.numeric(as.character(train$GP2)),5)
# Scales penalty minutes variable.
train$PIM2 <- (as.numeric(as.character(train$PIM)) - mean(as.numeric(as.character(train$PIM))) 
               / sd(as.numeric(as.character(train$PIM))))
train$PIM2 <- round(as.numeric(as.character(train$PIM2)),5)

# Same as above but for test set.
test <- read.csv(file = '2011-12.csv', header = T)
test <- test[!is.na(test$Rk),]
test$cutter1 <- cut(test$Rk, 10, labels = F)
test$cutter2 <- ifelse(test$cutter1 == 1, 1, 0)

test$age2 <- (as.numeric(as.character(test$Age)) - mean(as.numeric(as.character(test$Age))) 
              / sd(as.numeric(as.character(test$Age))))
test$age2 <- round(as.numeric(as.character(test$age2)),5)
test$GP2 <- (as.numeric(as.character(test$GP)) - mean(as.numeric(as.character(test$GP))) 
             / sd(as.numeric(as.character(test$GP))))
test$GP2 <- round(as.numeric(as.character(test$GP2)),5)
test$PIM2 <- (as.numeric(as.character(test$PIM)) - mean(as.numeric(as.character(test$PIM))) 
              / sd(as.numeric(as.character(test$PIM))))
test$PIM2 <- round(as.numeric(as.character(test$PIM2)),5)


#head(train)
#head(test)

cnn(train)
# Creates variable holding column names of variables to include.
varList1 <- colnames(train)[c(23,24,11,25,13:17)]

# Converts all variables to characters.
for(i in varList1){
  train[,i] <- as.character(train[,i])
  print(i);flush.console()
}

# Actually creates output.
score  <- train$cutter1
train3 <- train[, varList1]
cols   <- colnames(train3)
res <- apply(train3, 1, function(x) {
  idx  <- x != 0
  nms  <- cols[idx]
  vals <- x[idx]
  paste(nms, vals, sep=":", collapse=" ")
})

# Combines y-var, rowId and x-vars.
out <- paste(score," ex",train$Rk,"| ", as.vector(res)," ",train$Tm," ", train$Pos, sep ="")
print(out)
# Writes actual text file.
write(out, file = 'hockeyTrain.dat')

#####
# Same as above but for test set.
for(i in varList1){
  test[,i] <- as.character(test[,i])
  print(i);flush.console()
}


score  <- test$cutter1
test3 <- test[, varList1]
cols   <- colnames(test3)
res <- apply(test3, 1, function(x) {
  idx  <- x != 0
  nms  <- cols[idx]
  vals <- x[idx]
  paste(nms, vals, sep=":", collapse=" ")
})

out <- paste(score," ex",test$Rk,"| ", as.vector(res)," ",test$Tm," ", test$Pos, sep ="")
print(out)

write(out, file = 'hockeyTest.dat')

#####










