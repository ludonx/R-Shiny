globalDatabase<-'iogold'
projectDatabase<-'iogold'
GeneAbundanceCollectionName<-"MicrobariaGeneAbundance"
# comment récupérer les GenesIDs d'un gene particulier
Generate_CAGXXXXX<-
  function(globalDatabase,projectDatabase,GeneAbundanceCollectionName){
    ICGgenesCollectionName<-"ICGgenes"
    # on récupére la collection qui lie les MGS au GeneIDs [CAGXXXX; [id1,id2,......,]]
    
    result<-findAll(globalDatabase  ,collectionName ='CAG')
    maxlength<-nrow(result)
    
    for(i in 1:maxlength){
      # on récupére une ligne 
      MGS_name<-result[i,1]
      MGS_GeneIDs<-result[i,2]
      vectorGeneIDs<-unlist(MGS_GeneIDs, use.names=FALSE)
      
      # on récupére les GeneNames correspondant au GeneIDs
      # car sur la collection GeneAbundance, les cles sont les GeneNames
      Gene<-findQuery(globalDatabase,ICGgenesCollectionName,
                      myQueryUniqueIN_integer('GeneID',vectorGeneIDs))
      MGS_GeneName<-Gene["GeneName"]
      # on la converti en un vecteur ( ce data frame à une seul colonnes)
      vectorGeneNames<-c()
      for(j in 1:nrow(MGS_GeneName)){
        vectorGeneNames<-append(vectorGeneNames,MGS_GeneName[i,j])
      } 
      
      # je me connecte a la collection des GeneAbundance et je récupére 
      # les abondance des génes qui on leur gènes names contenu dans vectorGeneNames
      GeneAbundance<-
        findQuery(projectDatabase,
                  GeneAbundanceCollectionName,
                  myQueryUniqueIN('_row',vectorGeneNames)
        )
      
      # je crée la nouvelle collection CAGXXXX qui contiendra ces abundances de gènes
      db<-loadDataBase(projectDatabase,MGS_name)
      db$drop() # s'assure que la collection est vide avant d'ajouter de nouveaux élément 
      db$insert(GeneAbundance)
      
      cat(MGS_name,'[',i,'/',maxlength,']\n')
    }
    
  }

