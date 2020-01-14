library(jsonlite)


ajouter_un_projet<-
  function(JsonFileNameCollectionprojet='ajouter_un_projet.json', path ='~/GIT_LAB_test/iogoldg/RShiny/ShinyDashboard/Tutoriels/'){
    # on commence par récupérer les données du le fichier JSON qui contient
    # les informations sur les differente collection du projet
    cat("\n[ lecture des collection ]")
    listeCollectionprojet<-
      read_json(
        path=paste0(path,JsonFileNameCollectionprojet),
        simplifyVector = TRUE
      )
    
    ## On ajout des données des collections dans la base de donnée
    cat("\n[ Ajout dans MongoDB ]")
    ajouter_un_projet_mongodb(listeCollectionprojet)
    
    ## On rend les données des collections accessibles via l'application
    cat("\n[ Ajout dans shiny ]")
    ajouter_un_projet_shiny(
      listeCollectionprojet,
      projetCollectionName='projects',
      collectionOfcollectionName='collections')
        
  }

####################################################################################################
ajouter_un_projet_mongodb<-
  function(listeCollectionprojet){
    
    nbrCollection<-nrow(listeCollectionprojet)
    
    
    
    for(i in 1:nbrCollection){
      databaseName<-listeCollectionprojet[i,"database"]
      collectionName<-
        paste0(listeCollectionprojet[i,"obs_collection"],
               listeCollectionprojet[i,"catalog"],
               listeCollectionprojet[i,"version"],
               listeCollectionprojet[i,"project"])
      
      path_to_collection<-paste0(listeCollectionprojet[i,"path"])
      
      # si les données sont stockées dans plusieur fichier mais avec un nom commun
      # exemple : ICGgenes_1_1000.json /  ICGgenes_1000_2000.json ...
      # dans ce cas on indique uniquement le nom commun : ICGgenes
      common_json_file_name<-paste0(listeCollectionprojet[i,"common_json_file_name"])
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
    return(T)
  }
################################################################################################################################
ajouter_un_projet_shiny<-
  function(listeCollectionprojet,projetCollectionName='projects',collectionOfcollectionName='collections'){
    
    cat("\n******************* [Récupération des données : ]")
    nbrCollection<-nrow(listeCollectionprojet)
    projectName <- ""
    catalogName <- ""
    databaseName <- ""
    v <- ""
    globaldatabase <- ""
    
    
    # contient la liste des collection du projet
    collections<-vector(mode="character",length = nbrCollection)
    
    
    if(nbrCollection>0)
    {
      for(i in 1:nbrCollection){
        if(listeCollectionprojet[i,"catalog"]!="")
          catalogName <- paste0(listeCollectionprojet[i,"catalog"],listeCollectionprojet[i,"version"])
        
      }
      for(i in 1:nbrCollection){
        globaldatabase <- listeCollectionprojet[i,"globaldatabase"]
        databaseName<-listeCollectionprojet[i,"database"]
        projectName <- listeCollectionprojet[i,"project"]
        
        collectionName<-
          paste0(listeCollectionprojet[i,"obs_collection"],
                 listeCollectionprojet[i,"catalog"],
                 listeCollectionprojet[i,"version"],
                 listeCollectionprojet[i,"project"])
        
        collections[i]<-collectionName
        
        
        ############# STATISTIQUE DE MA COLLECTION ######################
        cat("\n LES STATISTIQUES DE : ",collectionName)
        number_lines<-countAll(databaseName,collectionName)
        number_columns<-ncol(findLimit(databaseName,collectionName,10))
        size<-0
        type<-"obs"
        v<-listeCollectionprojet[i,"version"]
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
            '"project" : "',projectName,'",',
            '"database" : "',databaseName,'"}'
          )
        db<-loadDataBase(globaldatabase,collectionOfcollectionName)
        db$remove(paste0('{"name" : "',collectionName,'"}'))
        db$insert(queryInsert)
        # Automatically disconnect when connection is removed
        # rm(db)
        # gc()
        
        cat("\n******************* [Fin insertion des données dans la collection ",collectionName," : ]\n")
      }#end for
      cat("\n******************* [Insertion des données dans la collection ",collectionName," : ]")
      # on ajout les informations sur le nouveau projet
      # dans la collection projet qui est liée a l'application 
      # etape 1 on ajout le projet 
      
      queryInsert<-
        paste0(
          '{"name" : "',projectName,'",',
          '"catalog" : "',catalogName,'",',
          '"version" : "',v,'",',
          '"database" : "',databaseName,'"}'
        )
      db<-loadDataBase(globaldatabase,projetCollectionName)
      db$remove(paste0('{"name" : "',projectName,'"}'))
      db$insert(queryInsert)
      # Automatically disconnect when connection is removed
      # rm(db)
      # gc()
      # etape 2 on update le projet et on ajout le collection du projet sous forme de tableau
      myUpdateQueryMongoSimple(databaseName,
                               projetCollectionName,
                               myQueryUnique('name',projectName),
                               myQueryPushChaine('collections',collections)
      )
      cat("\n******************* [Fin insertion projet: ]\n")
      
    }#end if(nbrCollection>0)
    
    
    return(collections)
  }
