
GenerateGeneAbundanceMGS<-
  function(projectDatabase,collectionGeneAbundace,vectorGenesNames){
    collectionGeneAbundaceMGS<-paste0(collectionGeneAbundace,'MGS')
    
    cat("\n[Récupération des Abondances de gènes avec MGS]\n")
    s<-Sys.time()
    GeneAbundanceMGS<-
      findQuery(projectDatabase,
                collectionGeneAbundace,
                myQueryUniqueIN('_row',vectorGenesNames)
      )
   
    cat(Sys.time()-s)
    cat("\n[je crée la nouvelle collection GeneAbundaceMGS]\n")

    s<-Sys.time()
    db<-loadDataBase(projectDatabase,collectionGeneAbundaceMGS)
    #db$drop() # s'assure que la collection est vide avant d'ajouter de nouveaux élément 
    db$insert(GeneAbundanceMGS)
    cat(Sys.time()-s)
  }

GenerateGeneAbundanceMGSadmin<-
  function(){
    globalDatabase<-'iogold'
    projectDatabase<-'iogold_microbaria'
    collectionGeneAbundace<-'myMicrobariaGeneAbundance'
    cat("[Récupération des GeneNames]\n")
    s<-Sys.time()
    myVectorGenesNames<-getVectorOfCollectionByField(globalDatabase,'ICGgenesMGS','GeneName')
    e<-Sys.time()
    
    
    e-s#Time difference of 3.670051 mins#Time difference of 3.637867 mins
    
    # > collectionGeneAbundaceMGS<-paste0(collectionGeneAbundace,'MGS')
    # > db<-loadDataBase(projectDatabase,collectionGeneAbundaceMGS)
    # > db$count()
    # [1] 9943
    collectionGeneAbundaceMGS<-paste0(collectionGeneAbundace,'MGS')
    db<-loadDataBase(projectDatabase,collectionGeneAbundaceMGS)
    db$drop() # s'assure que la collection est vide avant d'ajouter de nouveaux élément 
    
    # 2691408
    mydeb<-1
    myfin<-10000
    for(i in 1:269){
      
      cat('\n[part ',i,'] : ')
      cat('\ndeb =',mydeb,' fin = ',myfin)
      s<-Sys.time()
      GenerateGeneAbundanceMGS(projectDatabase='iogold_microbaria',
                               collectionGeneAbundace='myMicrobariaGeneAbundance',
                               myVectorGenesNames[mydeb:myfin])
      mydeb<-myfin+1
      myfin<-mydeb+10000
      
      e<-Sys.time()
      e-s
    }
    cat('\ndeb =',mydeb,' fin = ',myfin)
    cat("\n[Fin Ajout de l'index]\n")
    s<-Sys.time()
    AddIndex(projectDatabase,collectionGeneAbundaceMGS,'_row')
    e<-Sys.time()
    e-s
    ###################################
    
    myfin<-2691408
    #mydeb<-2690269
    cat('\n[part final ] : ')
    cat('\ndeb =',mydeb,' fin = ',myfin)
    s<-Sys.time()
    GenerateGeneAbundanceMGS(projectDatabase='iogold_microbaria',
                             collectionGeneAbundace='myMicrobariaGeneAbundance',
                             myVectorGenesNames[mydeb:myfin])
    
    
    e<-Sys.time()
    e-s
    cat("\n[Fin ]\n")
    
    
  }
