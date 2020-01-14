# 2: on ajoute les données dans la base de données projet
# il faut executer tous les fichier du dossier PackageMongoDB



GenerateNewProjectAdmin<-
  function(globalDatabase,projectDatabase,projectName,pathGeneAbundance,pathMGSabundance,pathSampleMetadata){
    
    cat('[DEBUT]')
    
    databaseName<-globalDatabase
    projectCollection<-'iogold_projet'
    userCollection<-'iogold_user'
    xdata<-""
    nbrEtape<-5
      
      
    
    cat('[Début de la génération des données du projet]')
    #################################################################################

    collectionSampleMetadata<-paste0(projectName,"SampleMetadata")
    collectionMGSabundance<-paste0(projectName,"MGSabundance")
    collectionGeneAbundance<-paste0(projectName,"GeneAbundance")
    
    cat('[étape 1/',nbrEtape,']\n')
    cat('[Générons les données SampleMetadata]\n')
    ############################################################################
    # jsonFileName<-"MicrobariaGeneAbundance"
    # pathJsonFileName<-"/data/projects/iogold/data/microbiome/2.json.tables.Microbaria"
    
    jsonFileName<-"SampleMetadata"
    pathJsonFileName<-pathSampleMetadata
    
    start_time<-Sys.time()
    GenerateMyDataMultiAdmin(projectDatabase,
                        collectionSampleMetadata,
                        jsonFileName,
                        pathJsonFileName)
    cat(Sys.time()-start_time,'\n')
    cat('[étape 2/',nbrEtape,']\n')
    cat('[Générons les données MGSabundance]\n')
    ############################################################################
    # jsonFileName<-"MicrobariaSampleMetadata"
    # pathJsonFileName<-"/data/projects/iogold/data/microbiome/2.json.tables.Microbaria"
    
    jsonFileName<- "MGSabundance"
    pathJsonFileName<-pathMGSabundance
    
    start_time<-Sys.time()
    GenerateMyDataMultiAdmin(projectDatabase,
                        collectionMGSabundance,
                        jsonFileName,
                        pathJsonFileName)
    cat(Sys.time()-start_time,'\n')
    
    cat('[étape 3/',nbrEtape,']\n')
    cat('[Générons les données GeneAbundance]\ n')
    ############################################################################
    # jsonFileName<-"MicrobariaGeneAbundance"
    # pathJsonFileName<-"/data/projects/iogold/data/microbiome/2.json.tables.Microbaria/GeneAbundance_with_row"
    
    jsonFileName<-"GeneAbundance"
    pathJsonFileName<-pathGeneAbundance
    
    start_time<-Sys.time()
    GenerateMyDataMultiAdmin(projectDatabase,
                        collectionGeneAbundance,
                        jsonFileName,
                        pathJsonFileName)
    
    cat(Sys.time()-start_time,'\n')
    cat('[Fin de la génération des données du projet]')
    
    cat("[Optimisation des requêtes sur la collction GeneAbundance : ajout d'un index]")
    start_time<-Sys.time()
    AddIndex(projectDatabase,collectionGeneAbundance,'_row')
    cat(Sys.time()-start_time,'\n')
    
    cat('[étape 4/',nbrEtape,']\n')
    cat('[Générons les collection CAGXXXX]')
    ############################################################################
    # Maintenant que les données ont été rajouté, il faut générer les Abondance de gènes pour chaque MGS
    start_time<-Sys.time()
    Generate_CAGXXXXX(globalDatabase=databaseName,
                      projectDatabase=projectDatabase,
                      GeneAbundanceCollectionName=collectionGeneAbundance
                      )
    cat(Sys.time()-start_time,'\n')
    
    
    cat('[étape 5/',nbrEtape,']\n')
    cat("[Ajoutons le nouveau projet à la collection des projets pour qu'il soit visible dans l'application]")
    ############################################################################
    # rajoutons maintenant le projet à la collection des projets
    
    start_time_f<-Sys.time()
    addProject(databaseName,
               collectionProject=projectCollection,
               NameProject=projectName,
               collectionGeneAbundance,
               collectionMGSabundance,
               collectionSampleMetadata,
               NameDataBaseProject=projectDatabase)
    cat(Sys.time()-start_time,'\n')
    
    
    cat("\n[On affecte le projet à l'administrateur")
    addProjectToUser(databaseName,
                     collectionProject=projectCollection,
                     collectionUser=userCollection,
                     userEmail='root@g.c',
                     projectDatabase)
    cat('[FIN : le Projet a bien été rajouté ]')
    
  }

##################################################################################

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
      cat("\n** les fichiers Json : '",jsonFileName,"' n'exite pas au chemin indiqué **\n")
      return(FALSE)
    }else{
      cat("\n** fichiers Json Trouvés : ",nbrFile,"***\n")
      for(i in 1:nbrFile)
      {
        cat(files[i],"\n")
        
      }
      
      db<-loadDataBase(databaseName,collectionName)
      cat("** Supprimons la collecion si elle existe déjà ... \n")
      db$drop()
      cat("*** Ajoutons des éléments ...\n")
      start_time<-Sys.time()
      for(i in 1:nbrFile)
      {
        start_time_f<-Sys.time()
        cat("\nAjout des données du fichier: '",files[i],"'")
        cheminCollection<-paste(pathJsonFileName,files[i],sep='/')
        db$insert(fromJSON(cheminCollection)) 
        
        cat(Sys.time()-start_time_f,'\n')
      }
      
      cat(Sys.time()-start_time,'\n')
      cat("\n[Fin : ajout des données OK] \n")
      
    }
  }


#############################################################################
Generate_CAGXXXXX<-
  function(globalDatabase,projectDatabase,GeneAbundanceCollectionName){
    # @ludo a modifié :
    # l'utilisation de la collection ICGgenesMGS serait plus rapide
    ICGgenesCollectionName<-"ICGgenes"
    
    # on récupére la collection qui lie les MGS au GeneIDs [CAGXXXX; [id1,id2,......,]]
    cat("\n[Début CAG]")
    cat("on récupére la collection qui lie les MGS au GeneIDs [CAGXXXX; [id1,id2,......,]]")
    start_time<-Sys.time()
    result<-findAll(globalDatabase  ,collectionName ='CAG')
    maxlength<-nrow(result)
    cat(Sys.time()-start_time,'\n')
    
    for(i in 1:maxlength){
      # on récupére une ligne 
      start_time<-Sys.time()
      MGS_name<-result[i,1]
      MGS_GeneIDs<-result[i,2]
      vectorGeneIDs<-unlist(MGS_GeneIDs, use.names=FALSE)
      
      # on récupére les GeneNames correspondant au GeneIDs
      # car sur la collection GeneAbundance, les cles sont les GeneNames
      cat("\n[on récupére les GeneNames correspondant au GeneIDs]\n")
      start_time_i<-Sys.time()
      Gene<-findQuery(globalDatabase,ICGgenesCollectionName,
                      myQueryUniqueIN_integer('GeneID',vectorGeneIDs))
      MGS_GeneName<-Gene["GeneName"]
      # on la converti en un vecteur ( ce data frame à une seul colonnes)
      vectorGeneNames<-vector(mode="character", length=nrow(MGS_GeneName))
      for(j in 1:length(vectorGeneNames)){
        vectorGeneNames[j]<-MGS_GeneName[j,1]
      } 
      cat(Sys.time()-start_time_i,'\n')
      
      cat('[Je me connecte a la collection des GeneAbundance et je récupére les abondances de gènes]\n')
      start_time_i<-Sys.time()
      # je me connecte a la collection des GeneAbundance et je récupére 
      # les abondance des génes qui on leur gènes names contenu dans vectorGeneNames
      GeneAbundance<-
        findQuery(projectDatabase,
                  GeneAbundanceCollectionName,
                  myQueryUniqueIN('_row',vectorGeneNames)
        )
      cat(Sys.time()-start_time_i,'\n')
      
      cat("[je crée la nouvelle collection CAGXXXX qui contiendra ces abondances de gènes]\n")
      start_time_i<-Sys.time()
      # je crée la nouvelle collection CAGXXXX qui contiendra ces abundances de gènes
      db<-loadDataBase(projectDatabase,MGS_name)
      db$drop() # s'assure que la collection est vide avant d'ajouter de nouveaux élément 
      db$insert(GeneAbundance)
      cat(Sys.time()-start_time_i,'\n')
      
      cat(MGS_name,'[',i,'/',maxlength,'] [',Sys.time()-start_time,']\n')
    }
    cat("\n[Fin CAG]")
    
  }
