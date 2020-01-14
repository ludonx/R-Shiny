# listeModule<-dir(path = "~/GIT_LAB_test/iogoldg/RShiny/CopyOfShinyDashboard/mainDashboardPage/mainDashboardBody/")
# listeModule<-listeModule[grep("Nouvea",listeModule)]
# 

moduleSourceFile<-
  function(path,file){
    return(source(paste0(path,file)))
  }

moduleMenuItem<-
  function(text,tabName,icon="angle-double-right"){
    return(
      paste0(
        'menuItem(text="',text,'",tabName = "',tabName,'",icon = icon("',icon,'"))'
      )
    )
  }