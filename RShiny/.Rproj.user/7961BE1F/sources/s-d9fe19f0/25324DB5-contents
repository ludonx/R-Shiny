library(jsonlite)


ajouter_un_catalogue<-
  function(JsonFileNameCollectionCatalog='ajouter_un_catalogue.json', path ='./R/PackageForAdmin/ManagingDataBase/',catalogProjectName="CatalogAnnotation_hs9.9_2" ){
    # on commence par récupérer les données du le fichier JSON qui contient
    # les informations sur les differente collection du catalogue
    cat("\n[ lecture des collection ]")
    listeCollectionCatalogue<-
      read_json(
        path=paste0(path,JsonFileNameCollectionCatalog),
        simplifyVector = TRUE
      )
    
    ## On ajout des données des collections dans la base de donnée
    cat("\n[ DEBUT -- Ajout dans MongoDB ]")
    ajouter_un_catalogue_mongodb(listeCollectionCatalogue)
    cat("\n[ FIN -- Ajout dans MongoDB ]")
    ## On rend les données des collections accessibles via l'application
    cat("\n[ Ajout dans shiny ]")
    ajouter_un_catalogue_shiny(
      listeCollectionCatalogue,
      catalogProjectName,
      catalogCollectionName='catalog',
      collectionOfcollectionName='collections')
    cat("\n[ FIN -- Ajout dans shiny ]")
        
  }

####################################################################################################
ajouter_un_catalogue_mongodb<-
  function(listeCollectionCatalogue){
    
    nbrCollection<-nrow(listeCollectionCatalogue)
    
    
    for(i in 1:nbrCollection){
      databaseName<-listeCollectionCatalogue[i,"database"]
      collectionName<-
        paste0(listeCollectionCatalogue[i,"def_collection"],
               listeCollectionCatalogue[i,"date"],
               listeCollectionCatalogue[i,"catalog"],
               listeCollectionCatalogue[i,"version"])
      
      path_to_collection<-paste0(listeCollectionCatalogue[i,"path"])
      
      # si les données sont stockées dans plusieur fichier mais avec un nom commun
      # exemple : ICGgenes_1_1000.json /  ICGgenes_1000_2000.json ...
      # dans ce cas on indique uniquement le nom commun : ICGgenes
      #common_json_file_name<-path_to_collection<-paste0(listeCollectionCatalogue[i,"common_json_file_name"])
      common_json_file_name <- paste0(listeCollectionCatalogue[i,"common_json_file_name"])
      
      ######################################################################################################
      
      cat("\n******************* [Début ajout collection : ",collectionName,"]")
      
      GenerateMyDataMultiAdmin(
        databaseName,
        collectionName,
        common_json_file_name,
        path_to_collection)
      
      cat("\n******************* [Fin ajout collection : ",collectionName,"]\n")
      ######################################################################################################
    }#end for
  }
################################################################################################################################
ajouter_un_catalogue_shiny<-
  function(listeCollectionCatalogue,catalogProjectName="CatalogAnnotation_hs9.9_2",catalogCollectionName='catalog',collectionOfcollectionName='collections'){
    
    cat("\n******************* [Récupération des données : ]")
    nbrCollection<-nrow(listeCollectionCatalogue)
    projetName <- ""
    catalogName <- ""
    databaseName <- ""
    v <- ""
    
    
    # contient la liste des collection du catalogue
    collections<-vector(mode="character",length = nbrCollection)
    for(i in 1:nbrCollection){
      if(listeCollectionCatalogue[i,"catalog"]!="")
        catalogName<-paste0(listeCollectionCatalogue[i,"catalog"],listeCollectionCatalogue[i,"version"])
    }
    for(i in 1:nbrCollection){
      databaseName<-listeCollectionCatalogue[i,"database"]
      
      collectionName<-
        paste0(listeCollectionCatalogue[i,"def_collection"],
               listeCollectionCatalogue[i,"date"],
               listeCollectionCatalogue[i,"catalog"],
               listeCollectionCatalogue[i,"version"])
      
      collections[i]<-collectionName
      
      
      ############# STATISTIQUE DE MA COLLECTION ######################
      cat("\n LES STATISTIQUES DE : ",collectionName)
      number_lines<-countAll(databaseName,collectionName)
      number_columns<-ncol(findLimit(databaseName,collectionName,10))
      size<-0
      type<-"def"
      v<-listeCollectionCatalogue[i,"version"]
      queryInsert<-
        paste0(
          '{"name" : "',collectionName,'",',
          '"number_lines" : ',number_lines,',',
          '"number_columns" : ',number_columns,',',
          '"size" : ',size,',',
          
          '"type" : "',type,'",',
          '"database" : "',databaseName,'",',
          '"catalog" : "',catalogName,'",',
          '"version" : "',v,'",',
          '"project" : "',catalogProjectName,'",',
          '"database" : "',databaseName,'"}'
        )
      db<-loadDataBase(databaseName,collectionOfcollectionName)
      db$remove(paste0('{"name" : "',collectionName,'"}'))
      db$insert(queryInsert)
      # Automatically disconnect when connection is removed
      # rm(db)
      # gc()
      

    }#end for
    cat("\n******************* [Insertion des données dans la collection ",collectionName," : ]")
    # on ajout les informations sur le nouveau catalogue
    # dans la collection catalog qui est liée a l'application 
    queryInsert<-
      paste0(
        '{"name" : "',catalogName,'",',
        '"database" : "',databaseName,'"}'
      )
    db<-loadDataBase(databaseName,catalogCollectionName)
    db$remove(paste0('{"name" : "',catalogName,'"}'))
    db$insert(queryInsert)
    # Automatically disconnect when connection is removed
    rm(db)
    gc()
    myUpdateQueryMongoSimple(databaseName,
                             catalogCollectionName,
                             myQueryUnique('name',catalogName),
                             myQueryPushChaine('collections',collections)
    )
    cat("\n******************* [Fin insertion des données dans la collection ",collectionName," : ]\n")
    
    
    
    
    return(collections)
  }
