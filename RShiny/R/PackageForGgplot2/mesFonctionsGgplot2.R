# library(reshape)
# library(gridExtra)
##Reproduce plotBarcode function with ggplot
plotBarcode.ggplot <- function(data, dataProjet="none",strat1="none",strat2="none")
{
  require(reshape2)
  cols <- c("white", "deepskyblue", "blue", "green3", "yellow", "orange", "red", "orangered2", "darkred")
  cols.val <- c(0, 1e-07, 4e-07, 1.6e-06, 6.4e-06, 2.56e-05, 0.0001024, 0.0004096, 0.0016384)
  data.melt <- as.data.frame(data)
  data.melt$gene <- as.character(rownames(data.melt))
  data.melt <- melt(data.melt)
  data.melt$gene <- factor(data.melt$gene, levels = as.character(rownames(data)))
  data.melt$variable <- factor(data.melt$variable, levels = colnames(data))
  mydata<-data.melt
  if(class(dataProjet)!="character"){
    mydata<-merge(data.melt,dataProjet,by.x = "variable", by.y = 0)
  }
  plot<-ggplot(mydata, aes(x=variable, y=gene, fill=value)) + 
    geom_tile() + 
    scale_fill_gradientn(colours = cols, values = cols.val, rescaler = function(x, ...) x) + 
    xlab("sample") + 
    theme_bw() + 
    theme(axis.text = element_blank(),
          legend.position = "none",
          axis.ticks = element_blank())
  
  if(class(dataProjet)!="character"){
    if(strat2!="none"){
      plot<-plot+facet_grid(mydata[strat1][,1]~mydata[strat2][,1])
    }else if(strat1!="none"){
      plot<-plot+facet_grid(.~mydata[strat1][,1])
    }else{
      plot
    }
  }
  
  return(plot)
}
#####################################################################################
#####################################################################################
myBarcodePlot1 <- function(data, dataProjet,strat1)
{
  require(reshape2)
  cols <- c("white", "deepskyblue", "blue", "green3", "yellow", "orange", "red", "orangered2", "darkred")
  cols.val <- c(0, 1e-07, 4e-07, 1.6e-06, 6.4e-06, 2.56e-05, 0.0001024, 0.0004096, 0.0016384)
  data.melt <- as.data.frame(data)
  data.melt$gene <- as.character(rownames(data.melt))
  data.melt <- melt(data.melt)
  data.melt$gene <- factor(data.melt$gene, levels = as.character(rownames(data)))
  data.melt$variable <- factor(data.melt$variable, levels = colnames(data))
  mydata<-data.melt
  
    mydata<-merge(data.melt,dataProjet,by.x = "variable", by.y = 0)
  
  plot<-ggplot(mydata, aes(x=variable, y=gene, fill=value)) + 
    geom_tile() + 
    scale_fill_gradientn(colours = cols, values = cols.val, rescaler = function(x, ...) x) + 
    xlab("sample") + 
    theme_bw() + 
    theme(axis.text = element_blank(),
          legend.position = "none",
          axis.ticks = element_blank())
  
  if(length(strat1)>1){
    
      plot<-plot+facet_grid(mydata[strat1[1]][,1]~mydata[strat1[2]][,1])
  }else if(length(strat1)==1){
      plot<-plot+facet_grid(.~mydata[strat1][,1])
  }else{
      plot
  }
  
  
  return(plot)
}
##################
####### merge

myMeltMerge <- function(dataMGS, dataProjet)
{
  data<-dataMGS
  data.melt <- as.data.frame(data)
  data.melt$gene <- as.character(rownames(data.melt))
  data.melt <- melt(data.melt)
  data.melt$gene <- factor(data.melt$gene, levels = as.character(rownames(data)))
  data.melt$variable <- factor(data.melt$variable, levels = colnames(data))
  mydata<-data.melt
  
  mydata<-merge(data.melt,dataProjet,by.x = "variable", by.y = 0)
  
  return(mydata)
}
##########
#### plot
myBarcodePlot <- function(mydata)
{
  
  require(reshape2)
  cols <- c("white", "deepskyblue", "blue", "green3", "yellow", "orange", "red", "orangered2", "darkred")
  cols.val <- c(0, 1e-07, 4e-07, 1.6e-06, 6.4e-06, 2.56e-05, 0.0001024, 0.0004096, 0.0016384)

  plot<-ggplot(mydata, aes(x=variable, y=gene, fill=value)) + 
    geom_tile() + 
    scale_fill_gradientn(colours = cols, values = cols.val, rescaler = function(x, ...) x) + 
    xlab("sample") + 
    
    theme_bw() + 
    theme(axis.text = element_blank(),
          legend.position = "none",
          axis.ticks = element_blank())
  
  
  return(plot)
}

###################
##### stratification
myPlotStrat <- function(mydata,plot,strat1,free="none")
{
 
  #TimeOrder<-c("T0","M1","M3","M12")
  TimeOrder<-c("M12","M3","M1","T0")
  mydata[,"Time"]<-factor(mydata[,"Time"],levels=TimeOrder)
  
  if(length(strat1)>1){
    mydata<-mydata[order(mydata[,strat1[1]]),]
    
    nbrcol<-length(unique(mydata[,strat1[1]])) * length(unique(mydata[,strat1[2]]))
    if(free=="none"){
      #plot<-plot+facet_grid(mydata[strat1[1]][,1]~mydata[strat1[2]][,1])
      plot<- plot+facet_wrap(mydata[strat1[1]][,1]~mydata[strat1[2]][,1],ncol = nbrcol)
    }else{
      #plot<-plot+facet_grid(mydata[strat1[1]][,1]~mydata[strat1[2]][,1],scales = free)
      plot<-plot+facet_wrap(mydata[strat1[1]][,1]~mydata[strat1[2]][,1],ncol = nbrcol,scales = free)
    }
    
  }else if(length(strat1)==1){
    mydata<-mydata[order(mydata[,strat1[1]]),]
    
    if(free=="none"){
      plot<-plot+facet_grid(.~mydata[strat1][,1])
    }else{
      plot<-plot+facet_grid(.~mydata[strat1][,1],scales = free)
    }
    
  }else{
    plot
  }
  
  
  return(plot)
}
################################################################################
myBarcodePlotStep <- function(data, dataProjet,strat1,free="none")
{
  
  mydata<-myMeltMerge(data,dataProjet)
  
  plot<-myBarcodePlot(mydata)
  plot<-myPlotStrat(mydata,plot,strat1,free)
  return(plot)
}



myBoxPlot<-
  function(data, xcolName,ycolName,avecPoint=FALSE,avecLegende=FALSE){
    xdata<-data[xcolName][,1]
    ydata<-data[ycolName][,1]
    
    titre<-paste0("Box Plot of ",xcolName,"\n by ",ycolName)

    p <- ggplot(data, aes(x=xdata, y=ydata, fill=xdata)) 
    p<-p+ggtitle(titre) +  xlab(xcolName) + ylab(ycolName) +labs(fill = xcolName)
    
    p <- p + geom_boxplot()
    #p <- p + geom_boxplot(position = position_jitter(width=.05), outlier.shape = NA)
    p <- p + scale_x_discrete(breaks=xdata)
    p <- p +theme_bw()+theme(axis.text.x = element_text(angle = 90, vjust = 0.5))
    if(avecPoint==TRUE){
      p <- p + geom_jitter(position = position_jitter(.05))
      #p <- p + geom_jitter(position = position_jitter(width = .2))
      #p <- p + geom_point()
    }
    if(avecLegende==FALSE){
      p<-p+theme(legend.position = "none") 
    }
    
    

    
    
    return(p)
  }
myPointPlot<-
  function(data, xcolName,ycolName,avecLegende=FALSE){
    xdata<-data[xcolName][,1]
    ydata<-data[ycolName][,1]
    
    titre<-paste0("Box Plot of ",xcolName,"\n by ",ycolName)
    
    p <- ggplot(data, aes(x=xdata, y=ydata, fill=xdata)) 
    #p <- p + geom_boxplot()
    p <- p + geom_jitter(position = position_jitter(width = .2))
    p <- p + scale_x_discrete(breaks=xdata)
    p <- p + theme(axis.text.x = element_text(angle = 90, vjust = 0.5))
   
    if(avecLegende==FALSE){
      p<-p+theme_bw()+theme(legend.position = "none") 
    }
    
    p<-p+ggtitle(titre) +  xlab(xcolName) + ylab(ycolName) +labs(fill = xcolName)
    
    
    
    return(p)
  }


myBarPlot<-
  function(data, xcolName,ycolName,avecPoint=FALSE,avecLegende=FALSE){
    xdata<-data[xcolName][,1]
    ydata<-data[ycolName][,1]
    titre<-paste0("Bar Plot of ",xcolName,"\n by ",ycolName)
    
    p <- ggplot(data, aes(x=xdata, y=ydata, fill=xdata)) 
    p <- p +geom_bar(stat="identity")
    p <- p + scale_x_discrete(breaks=xdata) 
    p <- p + theme(axis.text.x = element_text(angle = 90, vjust = 0.5))
    p<-p+ggtitle(titre) +  xlab(xcolName) + ylab(ycolName) +labs(fill = xcolName)
    if(avecLegende==FALSE){
      p<-p+theme(legend.position = "none") 
    }
    
    return(p)
  }

myLinePlot<-
  function(data, xcolName,ycolName,avecLine=TRUE,avecLegende=FALSE){
    xdata<-data[xcolName][,1]
    ydata<-data[ycolName][,1]
    titre<-paste0("Line Plot of ",xcolName,"\n by ",ycolName)
    
    p <- ggplot(data, aes(x=xdata, y=ydata, fill=xdata)) 
    p <- p +geom_point(size=1)
    p <- p + scale_x_discrete(breaks=xdata) 
    p <- p + theme(axis.text.x = element_text(angle = 90, vjust = 0.5))
    
    p<-p+ggtitle(titre) +  xlab(xcolName) + ylab(ycolName) +labs(fill = xcolName)
    
    if(avecLine==TRUE){
      p<-p+geom_line()
    }
    if(avecLegende==FALSE){
      p<-p+theme(legend.position = "none") 
    }
    return(p)
  }




#grid.arrange(a,b, ncol=1, nrow = 2)

myDataNbr<-
  function(data,xcolName,ycolName,decroissant=FALSE){
    tab<-data.frame(
      x=character(),
      nombreGene=numeric(),
      stringsAsFactors=FALSE
    )
    
    cmp<-0
    xdata<-data[xcolName][,xcolName]
    ydata<-data[ycolName][,ycolName]
    
    for(ix in 1:nrow(data)){
      if(xdata[ix] %in% tab[1][,1]){
      }else{
        cmp<-0
        for(iy in 1:nrow(data)){
          if(xdata[ix]==xdata[iy]) cmp<-cmp+1
        }
        tab<- rbind(tab,c(xdata[ix],cmp),stringsAsFactors=FALSE)
      }
      
      names(tab)[1]<-xcolName
      names(tab)[2]<-"nombreGene"
    }
    tab[xcolName][,1] <- 
      factor(tab[xcolName][,1],
             levels = tab[xcolName][,1][order(tab$nombreGene,decreasing=decroissant)])
    return (tab)
  }

############################################################################################

myCommunCatalogPlot<-
  function(data){
    # ###### ceci est equivalent a data$xcolName
    # xcolName<-""
    # ycolName<-""
    # xdata<-data[xcolName][,1]
    # ydata<-data[ycolName][,1]
    # #########################################
    # 
    # titre<-paste0("Plot de  ",xcolName,"\n by ",ycolName)
    # 
    # p <- ggplot(data, aes(x=xdata, y=ydata, fill=xdata)) 
    # #p <- p + geom_boxplot()
    # p <- p + geom_jitter(position = position_jitter(width = .2))
    # p <- p + scale_x_discrete(breaks=xdata)
    # p <- p + theme(axis.text.x = element_text(angle = 90, vjust = 0.5))
    # 
    # 
    # p<-p+theme_bw()+theme(legend.position = "none") 
    # 
    # 
    # p<-p+ggtitle(titre) +  xlab(xcolName) + ylab(ycolName) +labs(fill = xcolName)
    # 
    # return(p)
  }
