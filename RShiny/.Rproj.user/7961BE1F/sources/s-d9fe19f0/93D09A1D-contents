
# 1: on ajoute les données dans la base de données projet
globalDatabase<-'iogold'
projectDatabase<-'NX'
projectName<-"NX"

GenerateNewProjectWithGuide<-
  function(){
    cat('[DEBUT]')
    
    databaseName<-'iogold'
    projectCollection<-'iogold_projet'
    exist<-FALSE
    xdata<-""
    projectName<-""
    while(!(projectName=='Q') && !(exist==TRUE)){
      projectName <- readline(prompt="Entrer le nom du Projet (Q pour quitter): ")
      if(!(projectName=='Q')){
        xdata<-findQuery(databaseName,projectCollection,myQueryUnique("Name",projectName))
        if(nrow(xdata)>0){
          cat('Ce projet existe déjà !\n')
        }else{
          cat('[Valeur enregistrée] \n')
          exist<-TRUE
        }
      }
      
    }
    
    
    exist<-FALSE
    xdata<-""
    projectDataBase<-""
    while(!(projectDataBase=='Q') && !(exist==TRUE)){
      projectDataBase<-readline(prompt="Entrer le nom de la base de données où sera stocké les collection du projet (Q pour quitter): ")
      if(!(projectDataBase=='Q')){
        xdata<-findQuery(databaseName,projectCollection,myQueryUnique("dataBase",projectDataBase))
        if(nrow(xdata)>0){
          cat('Cette Base de données est déjà utilisée par un autre projet !\n')
        }else{
          cat('[Valeur enregistrée] \n')
          exist<-TRUE
        }
      }
      
    }
    cat('[Début de la génération des données du projet]')
    #################################################################################
    
    collectionSampleMetadata<-"SampleMetadata"
    collectionMGSabundance<-"MGSabundance"
    collectionGeneAbundance<-"GeneAbundance"
    
    cat('[Générons les données SampleMetadata]')
    ############################################################################
    # jsonFileName<-"MicrobariaGeneAbundance"
    # pathJsonFileName<-"/data/projects/iogold/data/microbiome/2.json.tables.Microbaria"
    
    jsonFileName<- readline(prompt="Entrer le nom du fichier ou le début de nom des fichiers json qui contiennent les données SampleMetadata : ")
    pathJsonFileName<-readline(prompt="Entrer le chemin vers ce(s) fichier(s) : ")
    
    GenerateMyDataMulti(projectDataBase,
                        collectionSampleMetadata,
                        jsonFileName,
                        pathJsonFileName)
    
    
    cat('[Générons les données MGSabundance]')
    ############################################################################
    # jsonFileName<-"MicrobariaSampleMetadata"
    # pathJsonFileName<-"/data/projects/iogold/data/microbiome/2.json.tables.Microbaria"
    
    jsonFileName<- readline(prompt="Entrer le nom du fichier ou le début de nom des fichiers json qui contiennent les données MGSabundance : ")
    pathJsonFileName<-readline(prompt="Entrer le chemin vers ce(s) fichier(s) : ")
    
    GenerateMyDataMulti(projectDataBase,
                        collectionMGSabundance,
                        jsonFileName,
                        pathJsonFileName)
    
    
    cat('[Générons les données GeneAbundance]')
    ############################################################################
    # jsonFileName<-"MicrobariaGeneAbundance"
    # pathJsonFileName<-"/data/projects/iogold/data/microbiome/2.json.tables.Microbaria/GeneAbundance_with_row"
    
    jsonFileName<- readline(prompt="Entrer le nom du fichier ou le début de nom des fichiers json qui contiennent les données GeneAbundance : ")
    pathJsonFileName<-readline(prompt="Entrer le chemin vers ce(s) fichier(s) : ")
    
    GenerateMyDataMulti(projectDataBase,
                        collectionGeneAbundance,
                        jsonFileName,
                        pathJsonFileName)
    
    
    cat('[Fin de la génération des données du projet]')
    ############################################################################
    # Maintenant que les données ont été rajouté, il faut générer les Abondance de gènes pour chaque MGS
    
    cat('[Générons les collection CAGXXXX]')
    Generate_CAGXXXXX(globalDatabase=databaseName,
                      projectDatabase=projectDataBase,
                      GeneAbundanceCollectionName=collectionGeneAbundance
    )
    
    
    
    ############################################################################
    # rajoutons maintenant le projet à la collection des projets
    
    cat("[Ajoutons le nouveau projet à la collection des projets pour qu'il soit visible dans l'application]")
    addProject(databaseName,
               collectionProject=projectCollection,
               NameProject=projectName,
               collectionGeneAbundance,
               collectionMGSabundance,
               collectionSampleMetadata,
               NameDataBaseProject=projectDataBase)
    
    cat('[FIN : le Projet a bien été rajouté ]')
    
  }