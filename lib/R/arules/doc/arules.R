###################################################
### chunk number 1: 
###################################################
options(width = 75)
### for sampling
set.seed <- 1234


###################################################
### chunk number 2: 
###################################################
library("arules")


###################################################
### chunk number 3: epub1
###################################################
data("Epub")
Epub


###################################################
### chunk number 4: epub2
###################################################
summary(Epub)


###################################################
### chunk number 5: 
###################################################
year <- strftime(as.POSIXlt(transactionInfo(Epub)[["TimeStamp"]]), "%Y")
table(year)


###################################################
### chunk number 6: 
###################################################
Epub2003 <- Epub[year == "2003"]
length(Epub2003)
image(Epub2003)


###################################################
### chunk number 7: epub
###################################################
print(image(Epub2003))


###################################################
### chunk number 8: 
###################################################
transactionInfo(Epub2003[size(Epub2003) > 20])


###################################################
### chunk number 9: 
###################################################
inspect(Epub2003[1:5])


###################################################
### chunk number 10: 
###################################################
as(Epub2003[1:5], "list")


###################################################
### chunk number 11: 
###################################################
EpubTidLists <- as(Epub, "tidLists")
EpubTidLists


###################################################
### chunk number 12: 
###################################################
as(EpubTidLists[1:3], "list") 


###################################################
### chunk number 13: data
###################################################
data("AdultUCI")
dim(AdultUCI)
AdultUCI[1:2,]


###################################################
### chunk number 14: 
###################################################
AdultUCI[["fnlwgt"]] <- NULL
AdultUCI[["education-num"]] <- NULL


###################################################
### chunk number 15: 
###################################################
AdultUCI[[ "age"]] <- ordered(cut(AdultUCI[[ "age"]], c(15,25,45,65,100)),
    labels = c("Young", "Middle-aged", "Senior", "Old"))

AdultUCI[[ "hours-per-week"]] <- ordered(cut(AdultUCI[[ "hours-per-week"]],
      c(0,25,40,60,168)),
    labels = c("Part-time", "Full-time", "Over-time", "Workaholic"))
			    
AdultUCI[[ "capital-gain"]] <- ordered(cut(AdultUCI[[ "capital-gain"]],
      c(-Inf,0,median(AdultUCI[[ "capital-gain"]][AdultUCI[[ "capital-gain"]]>0]),Inf)),
    labels = c("None", "Low", "High"))

AdultUCI[[ "capital-loss"]] <- ordered(cut(AdultUCI[[ "capital-loss"]],
      c(-Inf,0,
	median(AdultUCI[[ "capital-loss"]][AdultUCI[[ "capital-loss"]]>0]),Inf)),
    labels = c("none", "low", "high"))


###################################################
### chunk number 16: coerce
###################################################
Adult <- as(AdultUCI, "transactions")
Adult


###################################################
### chunk number 17: summary
###################################################
summary(Adult)


###################################################
### chunk number 18: itemFrequencyPlot eval=FALSE
###################################################
## itemFrequencyPlot(Adult, support = 0.1, cex.names=0.8)


###################################################
### chunk number 19: 
###################################################
itemFrequencyPlot(Adult, support = 0.1, cex.names=0.8)


###################################################
### chunk number 20: apriori
###################################################
rules <- apriori(Adult, 
                 parameter = list(support = 0.01, confidence = 0.6))
rules


###################################################
### chunk number 21: summary
###################################################
summary(rules)


###################################################
### chunk number 22: rules
###################################################
rulesIncomeSmall <- subset(rules, subset = rhs %in% "income=small" & lift > 1.2)
rulesIncomeLarge <- subset(rules, subset = rhs %in% "income=large" & lift > 1.2)


###################################################
### chunk number 23: subset
###################################################
inspect(head(SORT(rulesIncomeSmall, by = "confidence"), n = 3))
inspect(head(SORT(rulesIncomeLarge, by = "confidence"), n = 3))


###################################################
### chunk number 24: write_rules eval=FALSE
###################################################
## WRITE(rulesIncomeSmall, file = "data.csv", sep = ",", col.names = NA)


###################################################
### chunk number 25: pmml eval=FALSE
###################################################
## library("pmml")
## rules_pmml <- pmml(rulesIncomeSmall)
## saveXML(rules_pmml, file = "data.xml")


###################################################
### chunk number 26: 
###################################################
data("Adult")
fsets <- eclat(Adult, parameter = list(support = 0.05), 
	control = list(verbose=FALSE))


###################################################
### chunk number 27: 
###################################################
singleItems <- fsets[size(items(fsets)) == 1]

## Get the col numbers we have support for
singleSupport <- quality(singleItems)$support
names(singleSupport) <- unlist(LIST(items(singleItems),
	    decode = FALSE))
head(singleSupport, n = 5)


###################################################
### chunk number 28: 
###################################################
itemsetList <- LIST(items(fsets), decode = FALSE)

allConfidence <- quality(fsets)$support / 
    sapply(itemsetList, function(x) 
    max(singleSupport[as.character(x)]))

quality(fsets) <- cbind(quality(fsets), allConfidence)


###################################################
### chunk number 29: 
###################################################
summary(fsets)


###################################################
### chunk number 30: 
###################################################
fsetsEducation <- subset(fsets, subset = items %pin% "education")
inspect(SORT(fsetsEducation[size(fsetsEducation)>1], 
	by = "allConfidence")[1 : 3])


###################################################
### chunk number 31: 
###################################################
data("Adult")
Adult


###################################################
### chunk number 32: 
###################################################
supp <- 0.05
epsilon <- 0.1
c <- 0.1

n <- -2 * log(c)/ (supp * epsilon^2)
n


###################################################
### chunk number 33: 
###################################################
AdultSample <- sample(Adult, n, replace = TRUE)


###################################################
### chunk number 34: itemFrequencyPlot2 eval=FALSE
###################################################
## itemFrequencyPlot(AdultSample, population = Adult, support = supp,
##     cex.names = 0.7)


###################################################
### chunk number 35: 
###################################################
itemFrequencyPlot(AdultSample, population = Adult, support = supp,
    cex.names = 0.7)


###################################################
### chunk number 36: itemFrequencyPlot3 eval=FALSE
###################################################
## itemFrequencyPlot(AdultSample, population = Adult, 
##     support = supp, lift = TRUE, 
##     cex.names = 0.9)


###################################################
### chunk number 37: 
###################################################
itemFrequencyPlot(AdultSample, population = Adult, 
    support = supp, lift = TRUE, 
    cex.names = 0.9)


###################################################
### chunk number 38: 
###################################################
time <- system.time(itemsets <- eclat(Adult, 
    parameter = list(support = supp), control = list(verbose = FALSE)))
time

timeSample <- system.time(itemsetsSample <- eclat(AdultSample, 
    parameter = list(support = supp), control = list(verbose = FALSE)))
timeSample


###################################################
### chunk number 39: 
###################################################
# speed up
time[1] / timeSample[1]


###################################################
### chunk number 40: 
###################################################
itemsets
itemsetsSample


###################################################
### chunk number 41: 
###################################################
match <- match(itemsets, itemsetsSample, nomatch = 0)
## remove no matches
sum(match>0) / length(itemsets)


###################################################
### chunk number 42: 
###################################################
summary(quality(itemsets[which(!match)])$support)
summary(quality(itemsetsSample[-match])$support)


###################################################
### chunk number 43: 
###################################################
supportItemsets <- quality(itemsets[which(match > 0)])$support
supportSample <- quality(itemsetsSample[match])$support

accuracy <- 1 - abs(supportSample - supportItemsets) / supportItemsets

summary(accuracy)


