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
dat <- Employment
datArg <- quote(Employment)
## persistent variables
spec <- list()
plotCalls <- list()
plotNum <- 0


###################################################
### chunk number 2:  eval=FALSE
###################################################
##   spec <- list()
##   latticist(Employment, spec = spec)


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
  spec$defaultPlot <- "parallel"


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
  spec$groups <- "EmploymentStatus"


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
  spec <- list(xvar = "LayoffCause",
               yvar = "EmploymentLength")


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
  eval(plotCalls[[plotNum]])


###################################################
### chunk number 14: 
###################################################
  spec$groups <- "EmploymentStatus"


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
  eval(plotCalls[[plotNum]])


###################################################
### chunk number 17: 
###################################################
  spec <- list(xvar = "EmploymentStatus",
               yvar = "EmploymentLength",
               cond = "LayoffCause")


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
  eval(plotCalls[[plotNum]])


###################################################
### chunk number 20: 
###################################################
  spec$doSeparateStrata <- FALSE


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
  eval(plotCalls[[plotNum]])


###################################################
### chunk number 23: 
###################################################
  writePlotCallsAppendix(plotCalls)


