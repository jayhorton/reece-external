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
library(MASS)
dat <- Aids2
datArg <- quote(Aids2)
## persistent variables
spec <- list()
plotCalls <- list()
plotNum <- 0


###################################################
### chunk number 2:  eval=FALSE
###################################################
##   spec <- list()
##   latticist(Aids2, spec = spec)


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
  spec$xvar <- "T.categ"


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
  spec$groups <- "status"
  spec$subset <- "T.categ != 'hs'"


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
  spec <- list(yvar = "T.categ", xvar = "status")


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
  spec <- list(yvar = "T.categ", xvar = "age")


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
  spec <- list(yvar = "jitter(age)", xvar = "diag",
               zvar = "death", doSegments = TRUE)


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
  spec$groups <- "diag"


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
  spec$cond <- "T.categ"


###################################################
### chunk number 24: 
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### chunk number 25: 
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### chunk number 26: 
###################################################
  spec <- list(xvar = "age", yvar = "(death - diag)",
               subset = "status == 'D'", doHexbin = TRUE)


###################################################
### chunk number 27: 
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### chunk number 28: 
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### chunk number 29: 
###################################################
  spec <- modifyList(spec, list(cond = "T.categ",
                                x.relation = "free",
                                doLines = FALSE))


###################################################
### chunk number 30: 
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### chunk number 31: 
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### chunk number 32: 
###################################################
  writePlotCallsAppendix(plotCalls)


