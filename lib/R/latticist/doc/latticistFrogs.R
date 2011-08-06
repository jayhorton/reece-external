###################################################
### chunk number 1: preliminaries
###################################################
library(latticist)
ltheme <- custom.theme.2()
ltheme$strip.background$col <- grey(7:1 / 8)
ltheme$strip.shingle$col <- grey(6:0 / 8)
lattice.options(default.theme = ltheme)
ps.options(pointsize = 12)
options(width = 45, continue = " ")
source("common.R")
## set up data object
library(DAAG)
## coerce numeric 0/1 to factor (happens in latticist())
frogs$pres.abs <- factor(frogs$pres.abs)
dat <- frogs
datArg <- quote(frogs)
## persistent variables
spec <- list()
plotCalls <- list()
plotNum <- 0


###################################################
### chunk number 2:  eval=FALSE
###################################################
##   spec <- list()
##   latticist(frogs, spec = spec)


###################################################
### chunk number 3: 
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### chunk number 4: 
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### chunk number 5: 
###################################################
  spec <- list(varSubset = c("altitude", "distance",  "NoOfPools",
           "NoOfSites", "avrain", "meanmin", "meanmax"),
               defaultPlot = "splom")


###################################################
### chunk number 6: 
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### chunk number 7: 
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### chunk number 8: 
###################################################
  spec$groups <- "altitude"
  spec$defaultPlot <- "parallel"


###################################################
### chunk number 9: 
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### chunk number 10: 
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### chunk number 11: 
###################################################
  spec$yvar <- "northing"
  spec$xvar <- "easting"


###################################################
### chunk number 12: 
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### chunk number 13: 
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### chunk number 14: 
###################################################
  spec$aspect <- "iso"
  spec$doLines <- FALSE


###################################################
### chunk number 15: 
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### chunk number 16: 
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### chunk number 17: 
###################################################
  spec$groups <- "pres.abs"


###################################################
### chunk number 18: 
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### chunk number 19: 
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### chunk number 20: 
###################################################
  spec$zvar <- "altitude"


###################################################
### chunk number 21: 
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### chunk number 22: 
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### chunk number 23: 
###################################################
  writePlotCallsAppendix(plotCalls)


