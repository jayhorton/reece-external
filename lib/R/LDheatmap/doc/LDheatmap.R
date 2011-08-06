###################################################
### chunk number 1: 
###################################################
options(width=60) #controls the number of characters on a line (to protect the margin area)


###################################################
### chunk number 2: 
###################################################
library(LDheatmap)
data("CEUData")


###################################################
### chunk number 3: Original
###################################################
MyHeatmap <- LDheatmap(CEUSNP, CEUDist, LDmeasure="r", 
			  title="Pairwise LD in r^2", add.map=TRUE, 
			  SNP.name=c("rs2283092", "rs6979287"), 
			  color=grey.colors(20), name="myLDgrob", 
			  add.key=TRUE)


###################################################
### chunk number 4:  eval=FALSE
###################################################
## grid.edit(gPath("myLDgrob", "heatMap", "title"), gp=gpar(cex=1.25, col="blue"))
## grid.edit(gPath("myLDgrob", "geneMap", "title"), gp=gpar(cex=0.8, col="orange"))
## grid.edit(gPath("myLDgrob", "Key", "title"), gp=gpar(cex=1.25, col="red"))


###################################################
### chunk number 5: 
###################################################
LD.grob1 <- editGrob(MyHeatmap$LDheatmapGrob, gPath("heatMap", "title"), 
		gp = gpar(cex=1.25, col="blue"))
LD.grob2 <- editGrob(LD.grob1, gPath("geneMap","title"), 
		gp = gpar(cex=0.8, col="orange"))
LD.grob3 <- editGrob(LD.grob2, gPath("Key","title"), 
		gp = gpar(cex=1.25, col="red"))


###################################################
### chunk number 6: Modified
###################################################
grid.newpage() 
grid.draw(LD.grob3) 


###################################################
### chunk number 7:  eval=FALSE
###################################################
## VP1<-viewport(x=0, y=0, width=0.5, height=1, just=c("left","bottom"), 
##                 name="vp1")
## pushViewport(VP1)
## LD1 <- LDheatmap(MyHeatmap, color=grey.colors(20), 
##    title="Pairwise LD in grey.colors(20)", SNP.name="rs6979572", 
##    name="ld1", newpage=FALSE)
## upViewport()
## VP2<-viewport(x=0.5, y=0, width=0.5, height=1, 
##                just=c("left","bottom"), name="vp2")
## pushViewport(VP2)
## LD2<-LDheatmap(MyHeatmap, color=heat.colors(20), 
## 	title="Pairwise LD in heat.colors(20)", 
##         SNP.name="rs6979572", name="ld2", newpage=FALSE)
## upViewport()


###################################################
### chunk number 8:  eval=FALSE
###################################################
## grid.edit(gPath("ld1", "heatMap", "heatmap"), gp=gpar(col="white", lwd=2))
## grid.edit(gPath("ld2", "geneMap", "title"), gp=gpar(col="blue"))


###################################################
### chunk number 9: multiple
###################################################
VP1<-viewport(x=0, y=0, width=0.5, height=1, just=c("left","bottom"), 
                name="vp1")
pushViewport(VP1)
LD1 <- LDheatmap(MyHeatmap, color=grey.colors(20), 
   title="Pairwise LD in grey.colors(20)", SNP.name="rs6979572", 
   name="ld1", newpage=FALSE)
upViewport()
VP2<-viewport(x=0.5, y=0, width=0.5, height=1, 
               just=c("left","bottom"), name="vp2")
pushViewport(VP2)
LD2<-LDheatmap(MyHeatmap, color=heat.colors(20), 
	title="Pairwise LD in heat.colors(20)", 
        SNP.name="rs6979572", name="ld2", newpage=FALSE)
upViewport()
grid.edit(gPath("ld1", "heatMap", "heatmap"), gp=gpar(col="white", lwd=2))
grid.edit(gPath("ld2", "geneMap", "title"), gp=gpar(col="blue"))


###################################################
### chunk number 10: 
###################################################
data("CHBJPTData")
pop<-factor(c(rep("chinese", 45), rep("japanese", 45)))


###################################################
### chunk number 11: lattice
###################################################
library(lattice)
print(xyplot(1:nrow(CHBJPTSNP)~1:nrow(CHBJPTSNP) | pop, type="n", 
scales=list(draw=F),xlab="",ylab="", 
panel=function(x,y,subscripts,...){
	LDheatmap(CHBJPTSNP[subscripts,], CHBJPTDist, newpage=FALSE)}))


###################################################
### chunk number 12:  eval=FALSE
###################################################
## data("CHBJPTData")


###################################################
### chunk number 13:  eval=FALSE
###################################################
## pop<-factor(c(rep("chinese", 45), rep("japanese", 45)))


###################################################
### chunk number 14:  eval=FALSE
###################################################
## library(lattice)
## xyplot(1:nrow(CHBJPTSNP)~1:nrow(CHBJPTSNP) | pop, type="n",
## scales=list(draw=FALSE), xlab="", ylab="", 
## panel=function(x,y,subscripts,...){
##  LDheatmap(CHBJPTSNP[subscripts,], CHBJPTDist, newpage=FALSE)})


