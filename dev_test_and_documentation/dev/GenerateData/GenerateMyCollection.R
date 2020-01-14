# library(mongolite)
# library(jsonlite)
# 
# changePath<-
#   function(pathFileFromProject,FileToSource){
#     
#     files<-dir(path=paste0(getwd(),'/',pathFileFromProject) ,pattern =FileToSource ,ignore.case = T)
#     
#     if(length(files)==1){
#       cat("Source ok :  ")
#       cat(files)
#       cat("\n***********************\n")
#       return(TRUE)
#     }else{
#       cat("\n ** Please change the current working directory ** \n")
#       cat("\n You are current project path is : ",getwd(),"\n")
#       newPath <- readline(prompt="Enter new path to the project (case sensitive)(Q to exit) : ")
#       if(newPath=='Q') return (FALSE)
#       setwd(newPath)
#       changePath(pathFileFromProject,FileToSource)
#     }
#     
#   }
# 
# 
# changePath(pathFileFromProject='PackageForMongoDB',FileToSource='connexionNoSQL.R')
# source('PackageForMongoDB/mongoDbSimpleQuery.R') # on charge les fonction de connexion à mongo



choiceMenu<-
  function(){
    
    cat("*** Que voulez vous faire ? ***\n")
    cat("a . Vider la collection et mettre de nouveaux éléments ?\n")
    cat("b . Ajouter les nouveaux éléments à la suite (concaténation) ?\n")
    cat("c . quitter ?\n")
    mychoice<-"x"
    listeOfChoice <- list('a','b','c')
    while(!any(listeOfChoice==mychoice)){
      mychoice <- readline(prompt="Que choisissez vous (a , b ou c) : ")
    }
    return(mychoice)
  }

GenerateMyData<-
  function(databaseName,collectionName,jsonFileName,pathJsonFileName){
    
    cheminCollection<-paste(pathJsonFileName,jsonFileName,sep='/')
    if (!file.exists(cheminCollection)) {
      cat("** le fichier Json : '",jsonFileName,"' n'exite pas au chemin indiqué **\n")
      return(FALSE)
    }else{
      cat("** fichier Json : '",jsonFileName,"' Trouvé ***\n")
      
      db<-loadDataBase(databaseName,collectionName)
      cat("** Vérifions si la collection '",collectionName,"' existe ... \n")
      nbrElem<-db$count()
      if(nbrElem<=0){
        cat("****** La collection n'existe pas \n")
        cat("*** Ajoutons des éléments ...\n")
        db$insert(fromJSON(cheminCollection))
        cat("[Nombre d'élément ajouté :",db$count()," \n")
      }else{
        cat("****** Cette collection existe déjà et contient ",nbrElem," éléments \n")
        mychoice<-choiceMenu()
        
        if(mychoice=='a'){
          mychoice <- readline(prompt="êtes vous sur ?(o/n) : ")
          if(mychoice=='o'){
            cat("*** Vidons la collection ...")
            db$drop()
            cat("*** Ajoutons des éléments ...")
            db$insert(fromJSON(cheminCollection))
            cat("[Nombre d'élément ajouté :",db$count()," \n")
          }else{
            GenerateMyData(databaseName,collectionName,jsonFileName,pathJsonFileName)
          }
        }else if(mychoice=='b'){
          db$insert(fromJSON(cheminCollection))
          cat("[Nombre d'élément totaux :",db$count()," \n")
        }else if(mychoice=='c'){
          cat("*** Nombre d'élément de la collection : ",db$count())
          return(FALSE)
        }
        
      }
      return(TRUE)
    }
  }

GenerateMyDataMulti<-
  function(databaseName,collectionName,jsonFileName,pathJsonFileName){
    
    cheminCollection<-paste(pathJsonFileName,jsonFileName,sep='/')
    
    files<-dir(path=pathJsonFileName,pattern =jsonFileName ,ignore.case = T)
    nbrFile<-length(files)
    jsonFile<-c()
    for(i in 1:nbrFile)
    {
      if(endsWith(files[i],".json")==TRUE)
        jsonFile<-append(jsonFile,files[i])
      
    }
    files<-jsonFile
    nbrFile<-length(files)
    if (nbrFile<=0) {
      cat("** les fichiers Json : '",jsonFileName,"' n'exite pas au chemin indiqué **\n")
      return(FALSE)
    }else{
      cat("** fichiers Json Trouvés : ",nbrFile,"***\n")
      for(i in 1:nbrFile)
      {
        cat(files[i],"\n")
        
      }
      
      db<-loadDataBase(databaseName,collectionName)
      cat("** Vérifions si la collecion existe ... \n")
      nbrElem<-db$count()
      if(nbrElem<=0){
        cat("****** La collection n'existe pas \n")
        cat("*** Ajoutons des éléments ...\n")
        for(i in 1:nbrFile)
        {
          cat("Ajout des données du fichier: '",files[i],"'")
          cheminCollection<-paste(pathJsonFileName,files[i],sep='/')
          db$insert(fromJSON(cheminCollection)) 
          
        }
        cat("[Nombre d'élément ajouté :",db$count()," \n")
      }else{
        cat("****** Cette collection existe déjà et contient ",nbrElem," éléments \n")
        mychoice<-choiceMenu()
        
        if(mychoice=='a'){
          mychoice <- readline(prompt="êtes vous sur ?(o/n) : ")
          if(mychoice=='o'){
            cat("*** Vidons la collection ...")
            db$drop()
            cat("*** Ajoutons des éléments ...")
            for(i in 1:nbrFile)
            {
              cat("Ajout des données du fichier: '",files[i],"'")
              cheminCollection<-paste(pathJsonFileName,files[i],sep='/')
              db$insert(fromJSON(cheminCollection)) 
              
            }
            cat("[Nombre d'élément ajouté :",db$count()," \n")
          }else{
            GenerateMyDataMulti(databaseName,collectionName,jsonFileName,pathJsonFileName)
          }
        }else if(mychoice=='b'){
          mychoice <- readline(prompt="êtes vous sur ?(o/n) : ")
          if(mychoice=='o'){
            cat("*** Ajoutons des éléments ...")
            for(i in 1:nbrFile)
            {
              cat("Ajout des données du fichier: '",files[i],"'")
              cheminCollection<-paste(pathJsonFileName,files[i],sep='/')
              db$insert(fromJSON(cheminCollection)) 
              
            }
            cat("[Nombre d'élément totaux :",db$count()," \n")
          }else{
            GenerateMyDataMulti(databaseName,collectionName,jsonFileName,pathJsonFileName)
          }
          
        }else if(mychoice=='c'){
          cat("*** Aucune modification effectuée : ")
          return(FALSE)
        }
        
      }
      return(TRUE)
    }
  }

GenerateMyDataMultiAdmin<-
  function(databaseName,collectionName,jsonFileName,pathJsonFileName){
    
    cheminCollection<-paste(pathJsonFileName,jsonFileName,sep='/')
    
    files<-dir(path=pathJsonFileName,pattern =jsonFileName ,ignore.case = T)
    nbrFile<-length(files)
    jsonFile<-c()
    for(i in 1:nbrFile)
    {
      if(endsWith(files[i],".json")==TRUE)
        jsonFile<-append(jsonFile,files[i])
      
    }
    files<-jsonFile
    nbrFile<-length(files)
    if (nbrFile<=0) {
      cat("** les fichiers Json : '",jsonFileName,"' n'exite pas au chemin indiqué **\n")
      return(FALSE)
    }else{
      cat("** fichiers Json Trouvés : ",nbrFile,"***\n")
      for(i in 1:nbrFile)
      {
        cat(files[i],"\n")
        
      }
      
      db<-loadDataBase(databaseName,collectionName)
      cat("** Supprimons la collecion si elle existe déjà ... \n")
      db$drop()
      cat("*** Ajoutons des éléments ...\n")
      for(i in 1:nbrFile)
      {
        cat("Ajout des données du fichier: '",files[i],"'")
        cheminCollection<-paste(pathJsonFileName,files[i],sep='/')
        db$insert(fromJSON(cheminCollection)) 
        
      }
      cat("[Fin : ajout des données OK] \n")
    
    }
  }

testGenerateMyCollection <-
  function(){
    databaseName <- "iogold"
    collectionName <- "iogold_projet"
    pathJsonFileName<-"~/GIT_LAB_Fin/iogoldg/RShiny/GenerateData/"
    jsonFileName<-"iogold_projet.json"
    #GenerateMyData(databaseName,collectionName,jsonFileName,pathJsonFileName)
    
    databaseName <- "iogold"
    collectionName <- "MicrobariaGeneAbundance_row"
    jsonFileName<-"MicrobariaGeneAbundance"
    pathJsonFileName<-"/data/projects/iogold/data/microbiome/2.json.tables.Microbaria"
    GenerateMyDataMulti(databaseName,collectionName,jsonFileName,pathJsonFileName)

    #jsonFileName<-"MicrobariaGeneAbundance_1_1000000_renamed.json"# "MicrobariaGeneAbundance.json"
    #pathJsonFileName<-"/data/projects/iogold/data/microbiome/2.json.tables.Microbaria"
    
  }


