###################################################
### chunk number 1: 
###################################################
require(gWidgets)
options("guiToolkit"="RGtk2")


###################################################
### chunk number 2: 
###################################################
require(gWidgetsRGtk2)


###################################################
### chunk number 3: 
###################################################
  obj <- gbutton("Hello world", container = gwindow())


###################################################
### chunk number 4: 
###################################################
  obj <- glabel("Hello world", container = gwindow())  


###################################################
### chunk number 5: 
###################################################
  obj <- gedit("Hello world", container = gwindow())


###################################################
### chunk number 6: 
###################################################
  obj <- gtext("Hello world", container = gwindow())


###################################################
### chunk number 7: 
###################################################
  obj <- gradio(c("hello","world"), container=gwindow())


###################################################
### chunk number 8: 
###################################################
  obj <- gcombobox(c("hello","world"), container=gwindow())


###################################################
### chunk number 9: 
###################################################
  obj <- gcombobox(c("hello","world"), editable=TRUE, container=gwindow())


###################################################
### chunk number 10: 
###################################################
  obj <- gtable(c("hello","world"), container=gwindow())


###################################################
### chunk number 11: 
###################################################
  obj <- gcheckboxgroup(c("hello","world"), container=gwindow())


###################################################
### chunk number 12: 
###################################################
  obj <- gslider(from=0, to = 7734, by =100, value=0,
    container=gwindow())
  obj <- gspinbutton(from=0, to = 7734, by =100, value=0, 
   container=gwindow())


###################################################
### chunk number 13: 
###################################################
  win <- gwindow("Hello World, ad nauseum", visible=TRUE)
  group <- ggroup(horizontal = FALSE, container=win)
  obj <- gbutton("Hello...",container=group, 
    handler = function(h,...) gmessage("world"))
  obj <- glabel("Hello...", container =group, 
    handler = function(h,...) gmessage("world"))
  obj <- gcombobox(c("Hello","world"), container=group)
  obj <- gedit("Hello world", container=group)
  obj <- gtext("Hello world", container=group, font.attr=list(style="bold"))


###################################################
### chunk number 14: 
###################################################
confirmDialog <- function(message, handler=NULL)  {
  window <- gwindow("Confirm")
  group <- ggroup(container = window)
  gimage("info", dirname="stock", size="dialog", container=group)

  ## A group for the message and buttons
  inner.group <- ggroup(horizontal=FALSE, container = group)
  glabel(message, container=inner.group, expand=TRUE)

  ## A group to organize the buttons
  button.group <- ggroup(container = inner.group)
  ## Push buttons to right
  addSpring(button.group)
  gbutton("ok", handler=handler, container=button.group)
  gbutton("cancel", handler = function(h,...) dispose(window),
          container=button.group)
  
  return()
}


###################################################
### chunk number 15: 
###################################################
confirmDialog("This space for rent", handler = function(h,...) {
  print("what to do... [Change accordingly]")
  ## In this instance dispose finds its parent window and closes it
  dispose(h$obj)
})


###################################################
### chunk number 16: 
###################################################
w <- gwindow("Two widgets")
g <- ggroup(container = w)
widget1 <- gbutton("Click me to update the counter", container=g, 
                   handler = function(h,...) {
                     oldVal <- svalue(widget2)
                     svalue(widget2) <- as.numeric(oldVal) + 1
                   })
widget2 <- glabel(0, container=g)


###################################################
### chunk number 17: 
###################################################
fileChoose <- function(action="print", text = "Select a file...",
                       type="open", ...) {
  gfile(text=text, type=type, ..., action = action, handler =
        function(h,...) {
          do.call(h$action, list(h$file))
        })
}


###################################################
### chunk number 18: 
###################################################
lstObjects <- function(envir= .GlobalEnv, pattern) {
  objlist <- ls(envir=envir, pattern=pattern)
  objclass <- sapply(objlist, function(objName) {
    obj <- get(objName, envir=envir)
    class(obj)[1]
  })
  data.frame(Name = I(objlist), Class = I(objclass))
}


###################################################
### chunk number 19: 
###################################################
browseEnv1 <- function(envir = .GlobalEnv, pattern) {
  listOfObjects <- lstObjects(envir=envir, pattern)
  gtable(listOfObjects, container = gwindow("browseEnv1"))
}


###################################################
### chunk number 20: 
###################################################
browseEnv2 <- function(envir = .GlobalEnv, pattern, action="summary") {
  listOfObjects <- lstObjects(envir=envir, pattern)
  gtable(listOfObjects, container = gwindow("browseEnv2"),
         action = action, 
         handler = function(h,...) {
           print(do.call(h$action, list(get(svalue(h$obj)))))
         })
}


###################################################
### chunk number 21: 
###################################################
browseEnv3 <- function(envir = .GlobalEnv, pattern, action="summary") {
  listOfObjects <- lstObjects(envir=envir, pattern)
  gtable(listOfObjects, 
         container =gwindow("browseEnv3"),
         filter.column = 2,
         action = action, 
         handler = function(h,...) {
           print(do.call(h$action, list(get(svalue(h$obj)))))
         })
}


###################################################
### chunk number 22: setUp
###################################################
## set up
availDists <- c(Normal="rnorm", Exponential="rexp")
availKernels <- c("gaussian", "epanechnikov", "rectangular",
                  "triangular", "biweight", "cosine", "optcosine")


###################################################
### chunk number 23: updatePlot
###################################################
updatePlot <- function(h,...) {
  x <- do.call(availDists[svalue(distribution)],list(svalue(sampleSize)))
  plot(density(x, adjust = svalue(bandwidthAdjust), 
               kernel = svalue(kernel)),main="Density plot")
  rug(x)
}


###################################################
### chunk number 24: define.widgets
###################################################
distribution <- gradio(names(availDists), horizontal=FALSE, handler=updatePlot)
kernel <- gcombobox(availKernels, handler=updatePlot)
bandwidthAdjust <- gslider(from=0,to=2,by=.01, value=1, handler=updatePlot)
sampleSize <- gradio(c(50,100,200, 300), handler = updatePlot)


###################################################
### chunk number 25: layout
###################################################
## now layout
window <- gwindow("gWidgetsDensity")
BigGroup <- ggroup(cont=window)

group <- ggroup(horizontal=FALSE, container=BigGroup)
tmp <- gframe("Distribution", container=group)
add(tmp, distribution)

tmp <- gframe("Sample  size", container=group)
add(tmp,sampleSize)

tmp <- gframe("Kernel", container=group)
add(tmp,kernel)

tmp <- gframe("Bandwidth adjust", container=group)
add(tmp,bandwidthAdjust, expand=TRUE)


###################################################
### chunk number 26: gwtkdensity
###################################################
gwtkdensity <- function() {

  ## set up
  availDists <- c(Normal = "rnorm", Exponential="rexp")
  availKernels <- c("gaussian", "epanechnikov", "rectangular",
                    "triangular", "biweight", "cosine", "optcosine")
  
  
  updatePlot <- function(h,...) {
    x <- do.call(availDists[svalue(distribution)],list(svalue(sampleSize)))
    plot(density(x, adjust = svalue(bandwidthAdjust), kernel = svalue(kernel)))
    rug(x)
  }
  
  ##The widgets
  win <- gwindow("gwtkdensity")
  gp <- ggroup(horizontal=FALSE, cont=win)
  
  tmp <- gframe("Distribution", container=gp, expand=TRUE)
  distribution <- gradio(names(availDists), horizontal=FALSE,
                         cont=tmp, 
                         handler=updatePlot)
  
  
  tmp <- gframe("Sample  size", container=gp, expand=TRUE)
  sampleSize <- gradio(c(50,100,200, 300), cont=tmp,
                       handler =updatePlot)
  
  
  tmp <- gframe("Kernel", container=gp, expand=TRUE)
  kernel <- gcombobox(availKernels, cont=tmp,
                      handler=updatePlot)
  
  tmp <- gframe("Bandwidth adjust", container=gp, expand=TRUE)
  bandwidthAdjust <- gslider(from=0,to=2,by=.01, value=1,
                             cont=tmp, expand=TRUE,
                             handler=updatePlot)
  
}


###################################################
### chunk number 27: buddyList
###################################################
FROM <- "gWidgetsRGtk <gWidgetsRGtk@gmail.com>"
buddyList <- c("My Friend <myfriend@gmail.com>","My dog <mydog@gmail.com>")


###################################################
### chunk number 28: Rmail
###################################################
Rmail <- function(draft = NULL, ...) {
  ## We use a global list to contain our widgets
  widgets <- list()
  
  
  ## Helper functions
  sendIt <- function(...) {
    tmp <- tempfile()
    
    cat("To:", svalue(widgets$to),"\n",file = tmp, append=TRUE)
    cat("From:", svalue(widgets$from),"\n", file=tmp, append=TRUE)
    cat("Subject:", svalue(widgets$subject),"\n", file=tmp, append=TRUE)
    cat("Date:", format(Sys.time(),"%d %b %Y %T %Z"),"\n", file=tmp, append=TRUE)
    cat("X-sender:", "R", file=tmp, append=TRUE)
    cat("\n\n", file=tmp, append=TRUE)
    cat(svalue(widgets$text), file=tmp, append=TRUE)
    cat("\n", file=tmp, append=TRUE)
    
    ## Use UNIX sendmail to send message
    system(paste("sendmail -t  <", tmp))
    ## Add To: to buddyList
    if(exists("buddyList"))
      assign("buddyList", unique(c(buddyList,svalue(widgets$to))), inherits=TRUE)
    
    ## Close window, delete file
    unlink(tmp)
    dispose(window)
  }
  
  ## Function to save a draft to the file draft.R
  saveDraft <- function(...) {
    draft <- list()
    sapply(c("to","from","subject","text"), function(i) 
           draft[[i]] <<- svalue(widgets[[i]])
           )
    dump("draft","draft.R")
    cat("Draft dumped to draft.R\n")
  }
  
  ## A simple dialog
  aboutMail <- function(...) gmessage("Sends a message")
  
  ## Make main window from top down
  
  window <- gwindow("Compose mail")
  group <- ggroup(horizontal=FALSE, spacing=0, container = window)
  ## Remove border
  svalue(group) <- 0
  
  actions <- list(save=gaction("Save", icon="save", handler=saveDraft),
                  send=gaction("Send", icon="connect", handler=sendIt),
                  quit=gaction("Quit", icon="quit", handler=function(...) dispose(window)),
                  about=gaction("About", icon="about", handler=aboutMail))
  
  ## Menubar is defined by the actions, but we nest under File menu
  menubarlist <- list(File=actions)
  gmenu(menubarlist, cont = window)
  
  ## Toolbar is also defined by the actions
  toolbarlist <-  actions[-4]
  gtoolbar(toolbarlist, cont=window)
  
  
  ## Put headers in a glayout() container
  tbl <- glayout(container = group)
  
  
  ## To: field. Looks for buddyList
  tbl[1,1] <- glabel("To:",container = tbl)
  tbl[1,2] <- (widgets$to <- gcombobox(c(), editable=TRUE, container=tbl))
  if(exists("buddyList")) widgets$to[] <- buddyList
  
  ## From: field. Click to edit value
  tbl[2,1] <- glabel("From:", container = tbl)
  tbl[2,2] <- (widgets$from <- glabel(FROM, editable=TRUE, container=tbl))
  
  ## Subject: field. Handler updates window title
  tbl[3,1] <- glabel("Subject:")
  tbl[3,2] <- (widgets$subject <- gedit("",container=tbl))
  addHandlerKeystroke(widgets$subject, handler = function(h,...)
                      svalue(window) <- paste("Compose mail:",svalue(h$obj),collapse=""))
  
  ## Add text box for message, but first some space
  addSpace(group, 5)
  widgets$text <- gtext("", container = group, expand=TRUE)


  ## Handle drafts. Either a list or a filename to source")
  ## The generic svalue() method makes setting values easy")
  if(!is.null(draft)) {
    if(is.character(draft))
      sys.source(draft,envir=environment()) # source into right enviro
    if(is.list(draft)) {
      sapply(c("to","from","subject","text"), function(i) {
        svalue(widgets[[i]]) <- draft[[i]]
      })
    }
  }

  ## That's it.

}



###################################################
### chunk number 29: comd
###################################################
  Rmail()


###################################################
### chunk number 30: expandgroup
###################################################
  ## expand group
  rightArrow <- system.file("images/1rightarrow.gif",package="gWidgets")
  downArrow <- system.file("images/1downarrow.gif",package="gWidgets")


  g <- ggroup(horizontal=FALSE,cont=T)
  
  g1 <- ggroup(horizontal=TRUE, cont=g)
  icon <- gimage(downArrow,cont=g1)
  label <- glabel("Expand group example", cont=g1)
  
  g2 <- ggroup(cont=g, expand=TRUE)
  
  expandGroup <- function() add(g,g2, expand=TRUE)
  hideGroup <- function() delete(g,g2)
  
  state <- TRUE                            # a global
  
  changeState <- function(h,...) {
    if(state) {
      hideGroup()
      svalue(icon) <- rightArrow
    }  else {
      expandGroup()
      svalue(icon) <- downArrow
    }
    state <<- !state
  }

addHandlerClicked(icon, handler=changeState)
addHandlerClicked(label, handler=changeState)

gbutton("Hide by clicking arrow", cont=g2)
  


###################################################
### chunk number 31: 
###################################################
tag(g,"state") <- TRUE                            # a global
changeState <- function(h,...) {
  if(tag(g,"state")) {
    hideGroup()
    svalue(icon) <- rightArrow
  }  else {
    expandGroup()
    svalue(icon) <- downArrow
  }
  tag(g,"state") <- !tag(g,"state")
}


###################################################
### chunk number 32: 
###################################################
doPlot <-  function() {
  ## Set up main group
  mainGroup <- ggroup(container=gwindow("doPlot example"))
    
  ## The variable browser widget
  gvarbrowser(container = mainGroup)

  rightGroup <- ggroup(horizontal=FALSE, container=mainGroup)
    
  ## The graphics device
  ggraphics(container=rightGroup)
  entry <- gedit("drop item here to be plotted", container=rightGroup)
  adddroptarget(entry,handler = function(h,...) {
    do.call("plot",list(svalue(h$dropdata),main=id(h$dropdata)))
  })
}


###################################################
### chunk number 33: 
###################################################
 doPlot()


###################################################
### chunk number 34: 
###################################################
## Drag a column onto plot to have a boxplot drawn.
## Changing the column values will redraw the graph.

makeDynamicWidget <-  function() {
  
  win <- gwindow("Draw a boxplot")
  gd <- ggraphics(container = win)
  
  adddroptarget(gd, targetType="object", handler=function(h,...) {
    tag(gd,"data") <- h$dropdata
    plotWidget(gd)
    
    ## this makes the dynamic part:
    ## - we put a change handler of the column that we get the data from
    ## - we store the handler id, so that we can clean up the handler when this
    ##   window is closed
    
    ## The is.gdataframecolumn function checks if the drop value
    ##   comes from the data frame editor (gdf)
    if(gWidgetsRGtk2:::is.gdataframecolumn(h$dropdata)) {
      view.col <- h$dropdata
      
      ## Put change handler on column to update plotting widget
      ## (use lower case, to fix oversight)
      id <- addhandlerchanged(view.col, handler=function(h,...) plotWidget(gd))
      ## Save drop handler id so that it can be removed when
      ##   widget  is closed
      dropHandlers <- tag(gd,"dropHandlers")
      dropHandlers[[length(dropHandlers)+1]] <- 
        list(view.col = view.col,
             id = id
             )
      tag(gd,"dropHandlers") <- dropHandlers
    }
  })
  
  ## Remove drop handlers if widget is unrealized.
  addHandlerUnrealize(gd, handler = function(h,...) {
    dropHandlers <- tag(gd,"dropHandlers")
    if(length(dropHandlers) > 0) {
      for(i in 1:length(dropHandlers)) {
        removehandler(dropHandlers[[i]]$view.col,dropHandlers[[i]]$id)
      }
    }
  })
}


###################################################
### chunk number 35: 
###################################################
plotWidget <- function(widget) {
  data <- tag(widget, "data")
  theName <- id(data)
  values <- svalue(data)
  boxplot(values, xlab=theName, horizontal=TRUE, col=gray(.75))
}


###################################################
### chunk number 36: 
###################################################
gdf(mtcars, container=TRUE)
makeDynamicWidget()


###################################################
### chunk number 37: 
###################################################
win <- gwindow("Plot notebook")
group <- ggroup(horizontal = FALSE, container=win)
nb <- gnotebook(container = group, expand=TRUE)


###################################################
### chunk number 38: 
###################################################
tblist <- list(quit=gaction("Quit", icon="quit", handler=function(...) dispose(win)),
               separator=gseparator(),
               new=gaction("New", icon="new", handler=function(h,...) add(nb,ggraphics(),label="plot")),
               delete=gaction("Delete", icond="delete", handler=function(...) dispose(nb))
               )

gtoolbar(tblist, cont=group)


###################################################
### chunk number 39: 
###################################################
  ## function to find offspring
  offspring <- function(path, user.data=NULL) {
    if(length(path) > 0) 
      directory <- paste(getwd(),"/",paste(path,sep="/", collapse=""),sep="",collapse="")
    else
      directory <- getwd()
    tmp <- file.info(dir(path=directory))
    files <- data.frame(Name=rownames(tmp), isdir=tmp[,2], size=as.integer(tmp[,1]))
    return(files)
  }


###################################################
### chunk number 40: 
###################################################
hasOffspring <- function(children,user.data=NULL, ...) {
  return(children$isdir)
}


###################################################
### chunk number 41: 
###################################################
icon.FUN <- function(children,user.data=NULL, ...) {
  x <- rep("file",length= nrow(children))
  x[children$isdir] <- "directory"
  return(x)
}


###################################################
### chunk number 42: 
###################################################
  gtree(offspring, hasOffspring, icon.FUN = icon.FUN,
        container=gwindow(getwd()))


###################################################
### chunk number 43: 
###################################################
gtree(offspring,  icon.FUN = icon.FUN,
      container=gwindow(getwd()))


###################################################
### chunk number 44: 
###################################################
w <- gwindow("Click on button to change")
g <- ggroup(cont = w)                   # abbreviate container
glabel("Hello ", cont=g)
world <- gbutton("world", cont=g)
lst <- list()
lst$world$handler <- function(h,...) svalue(world) <- "world"
lst$continent$handler <- function(h,...) svalue(world) <- "continent"
lst$country$handler <- function(h,...) svalue(world) <- "country"
lst$state$handler <- function(h,...) svalue(world) <- "state"
addPopupmenu(world, lst)


###################################################
### chunk number 45: t-test-ex
###################################################
## layout a collection of widgets to generate a t.test

## widgets to gather the variable(s)
varList <- list(type="fieldset",
                columns = 2,
                label = "Variable(s)",
                label.pos = "top",
                label.font = c(weight="bold"),
                children = list(
                  list(name = "x",
                       label = "x",
                       type = "gedit",
                       text = ""),
                  list(name = "y",
                       label = "y",
                       type = "gedit",
                       text = "",
                       depends.on = "x",
                       depends.FUN = function(value) nchar(value) > 0,
                       depends.signal = "addHandlerBlur"
                       )
                       )
                )
## list for alternative
altList <- list(type = "fieldset",
                label = "Hypotheses",
                columns = 2, 
                children = list(
                  list(name = "mu",
                       type = "gedit",                            
                       label = "Ho: mu=",
                       text = "0",
                       coerce.with = as.numeric),
                  list(name = "alternative",
                       type="gcombobox",
                       label = "HA: ",
                       items = c("two.sided","less","greater")
                       )
                  )
                )
## now make t-test list
tTest <- list(type = "ggroup",
              horizontal = FALSE,
              children = list(
                varList,
                altList,
                list(type = "fieldset",
                     label = "two sample test",
                     columns = 2,
                     depends.on = "y",
                     depends.FUN = function(value) nchar(value) > 0,
                     depends.signal = "addHandlerBlur",                     
                     children = list(
                       list(name = "paired",
                            label = "paired samples",
                            type = "gcombobox",
                            items = c(FALSE, TRUE)
                            ),
                       list(name = "var.equal",
                            label = "assume equal var",
                            type = "gcombobox",
                            items = c(FALSE, TRUE)
                            )
                       )
                     ),
                list(type = "fieldset",
                     columns = 1,
                     children = list(
                       list(name = "conf.level",
                            label = "confidence level",
                            type = "gedit",
                            text = "0.95",
                            coerce.with = as.numeric)
                       )
                     )
                )
              )


###################################################
### chunk number 46:  eval=FALSE
###################################################
## ## Code to call the layout
## w <- gwindow("t.test")
## g <- ggroup(horizontal = FALSE, cont = w)
## fl <- gformlayout(tTest, cont = g, expand=TRUE)
## bg <- ggroup(cont = g)
## addSpring(bg)
## b <- gbutton("run t.test", cont = bg)
## addHandlerChanged(b, function(h,...) {
##   out <- svalue(fl)
##   out$x <- svalue(out$x) # turn text into numbers
##   if(out$y == "") {
##     out$y <- out$paired <- NULL 
##   } else {
##    out$y <- svalue(out$y)
##   }
##   ## easy, not pretty
##   print(do.call("t.test",out))
## })
## 


###################################################
### chunk number 47: 
###################################################
lst <- list()
lst$title <- "t.test()"
lst$help <- "t.test"
lst$variableTypes <- "univariate"
lst$action <- list(beginning="t.test(",ending=")")
lst$arguments$hypotheses$mu <- 
  list(type = "gedit",text=0,coerce.with=as.numeric)
lst$arguments$hypotheses$alternative <- 
  list(type="gradio", items=c("'two.sided'","'less'","'greater'")
       )


###################################################
### chunk number 48: 
###################################################
ggenericwidget(lst, container=gwindow("One sample t test"))


###################################################
### chunk number 49: 
###################################################
  our.t.test <- stats:::t.test.default
  ggenericwidget("our.t.test", container=gwindow("t-test"))


###################################################
### chunk number 50: 
###################################################
args(our.t.test)


###################################################
### chunk number 51: 
###################################################
## A constructor to automagically make a GUI for a function
gfunction <- function(f, window = gwindow(title=fName), ...) {

  ## Get the function and its name
  if(is.character(f)) {
    fName <- f
    f <- get(f)
  } else if(is.function(f)) {
    fName <- deparse(substitute(f))
  }
    
  ## Use formals() to define the widget
  lst <- formals(f)

  
  
  ## Hack to figure out variable type
  type <- NULL
  if(names(lst)[1] == "x" && names(lst)[2] == "y") {
    type <- "bivariate"
  } else if(names(lst)[1] == "x") {
    type <- "univariate"
  } else if(names(lst)[1] == "formula") {
    type <- "model"
  } else {
    type + NULL
  }
  

  ##  Layout
  
  w <- gwindow("create dialog")
  g <- ggroup(horizontal = TRUE, cont=w)
  ## Arrange widgets with an output area
  ## Put widgets into a layout container
  tbl <- glayout(container=g)
  gseparator(horizontal=FALSE, container=g)
  outputArea <- gtext(container=g, expand=TRUE)
  

  ## Make widgets for arguments from formals()
  widgets <- sapply(lst, getWidget, cont=tbl)

  ## Layout widgets
  for( i in 1:length(widgets)) {
    tbl[i,1] <- names(lst)[i]
    tbl[i,2] <- widgets[[i]]
  }


  ## Add update handler to each widget when changed
  sapply(widgets, function(obj) {
    try(addHandlerChanged(obj, function(h,...) update()), silent=TRUE)
  })

  ## Add drop target to each widget
  sapply(widgets, function(obj)
         try(adddroptarget(obj,
                           handler=function(h,...) {
                             svalue(h$obj) <- h$dropdata
                             update()
                           }),
             silent=TRUE))
  


  ## In case this doesn't get exported
  svalue.default <- function(obj, ...) obj
  
  ## Function used to weed out 'NULL' values to widgets
  isNULL <- function(x) 
    ifelse(class(x) == "character" && length(x) ==1 && x == "NULL",
           TRUE, FALSE)
  
  ## Function called when a widget is changed
  ## 2nd and 3rd lines trim out non-entries
  update <- function(...) {
    is.empty <- function(x) return(is.na(x) || is.null(x) || x == "" )
    outList <- lapply(widgets,svalue)
    outList <- outList[!sapply(outList,is.empty)]
    outList <- outList[!sapply(outList,isNULL)]
    outList[[1]] <- svalue(outList[[1]])
    if(type == "bivariate")
      outList[[2]] <- svalue(outList[[2]])
    
    out <- capture.output(do.call(fName,outList))
    
    dispose(outputArea)
    if(length(out)>0)
      add(outputArea, out)
  }
  invisible(NULL)
}


###################################################
### chunk number 52: 
###################################################
getWidget <- function(x, cont=cont) {
  switch(class(x),
         "numeric" = gedit(x, coerce.with=as.numeric, cont=cont),
         "character" = gcombobox(x, active=1, cont=cont),
         "logical" = gcombobox(c(TRUE,FALSE), active = 1 + (x == FALSE), cont=cont),
         "name" = gedit("", cont=cont),
         "NULL" = gedit("NULL", cont=cont),
         "call" = getWidget(eval(x), cont=cont), # recurse
         gedit("", cont=cont)                     # default
    )
}


###################################################
### chunk number 53: 
###################################################
our.t.test <- stats:::t.test.default
gfunction(our.t.test)


