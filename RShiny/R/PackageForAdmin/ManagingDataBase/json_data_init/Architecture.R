
# changeCollectionName('iogold_microbaria','myMicrobariaGeneAbundanceMGS','obs_genes_mgs_cat_hs9.9_v1_Microbaria')
# changeCollectionName('iogold_microbaria','myMicrobariaGeneAbundance','obs_genes_cat_hs9.9_v1_Microbaria')
# changeCollectionName('iogold_microbaria','myMicrobariaMGSabundance','obs_mgs_cat_hs9.9_v1_Microbaria')
# changeCollectionName('iogold_microbaria','myMicrobariaSampleMetadata','obs_samplemetadata_v1_Microbaria')

# 
# 
# collections<-findAll('iogold','collections')
# 
# changeCollectionName('iogold_microbaria','obs_genes_mgs_cat_hs9.9_v1_myMicrobaria','obs_genes_mgs_cat_hs9.9_v1_Microbaria')
# changeCollectionName('iogold_microbaria','obs_genes_cat_hs9.9_v1_myMicrobaria','obs_genes_cat_hs9.9_v1_Microbaria')
# changeCollectionName('iogold_microbaria','obs_mgs_cat_hs9.9_v1_myMicrobaria','obs_mgs_cat_hs9.9_v1_Microbaria')
# changeCollectionName('iogold_microbaria','obs_samplemetadata_v1_myMicrobaria','obs_samplemetadata_v1_Microbaria')
# # 
# # changeCollectionName('iogold','MicrobariaMGSabundance','obs_mgs_cat_hs9.9_v1_Microbaria')
# # 
# # GenerateMyDataMultiAdmin('iogold','collections','collections3.json','~/GIT_LAB_test/iogoldg/RShiny/MongoDB/')
# 
# listCollectionByName('iogold','CAG',F)
# changeCollectionName('iogold','iogold_user','users')
# changeCollectionName('iogold','MicrobariaGeneAbundance','obs_genes_cat_hs9.9_v1_MicrobariaCopy')
# 
# changeCollectionName('iogold','ICGgenes','def_genes_cat_hs9.9_v1')
# changeCollectionName('iogold','NoMGSgenes','obs_nomgsgenes_cat_hs9.9_v1_Microbaria')
# changeCollectionName('iogold','MGStaxonomy','def_mgstaxonomy_cat_hs9.9_v1')
# changeCollectionName('iogold','ICGgenesMGS','def_genesmgs_cat_hs9.9_v1')
# changeCollectionName('iogold','CAG','def_cag_cat_hs9.9_v1')
# 
# changeCollectionName('iogold','ko_definition','def_ko_definition_KEGGdb_5_19')
# changeCollectionName('iogold','Module_Pathway_associations','def_module_pathway_associations_KEGGdb_5_19')
# 
# changeCollectionName('iogold','ko_Pathway_associations','def_ko_pathway_associations_KEGGdb_5_19')
# changeCollectionName('iogold','module_definitions','def_module_definitions_KEGGdb_5_19')
# changeCollectionName('iogold','ko_Module_associations','def_ko_Module_associations_KEGGdb_5_19')
# 
# 
# changeCollectionName('iogold','obs_genes_cat_hs9.9_v1_Microbaria','obs_mgs_cat_hs9.9_v1_MicrobariaCopy')
# changeCollectionName('iogold','obs_mgs_cat_hs9.9_v1_MicrobariaCopy','abc')
# changeCollectionName('iogold','obs_genes_cat_hs9.9_v1_MicrobariaCopy','obs_mgs_cat_hs9.9_v1_MicrobariaCopy')
# 
# changeCollectionName('iogold','abc','obs_genes_cat_hs9.9_v1_MicrobariaCopy')
# changeCollectionName('iogold','obs_mgs_cat_hs9.9_v1_Microbaria','obs_mgs_cat_hs9.9_v1_Microbaria')
# changeCollectionName('iogold','obs_samplemetadata_v1_Microbaria_Copy','obs_samplemetadata_v1_MicrobariaCopy')
# 
# changeCollectionName('iogold','obs_nomgsgenes_cat_hs9.9_v1_Microbaria','def_nomgsgenes_cat_hs9.9_v1_Microbaria')
# 
# 

# myUpdateQueryMongoSimple('iogold','def_ko_definition_KEGGdb_5_19','{}',myQueryRenameField("V1","koIDs"))
# myUpdateQueryMongoSimple('iogold','def_ko_definition_KEGGdb_5_19','{}',myQueryRenameField("V2","definition"))
# 
# myUpdateQueryMongoSimple('iogold','def_ko_Module_associations_KEGGdb_5_19','{}',myQueryRenameField("V1","moduleIDs"))
# myUpdateQueryMongoSimple('iogold','def_ko_Module_associations_KEGGdb_5_19','{}',myQueryRenameField("V2","koIDs"))
# 
# myUpdateQueryMongoSimple('iogold','def_module_pathway_associations_KEGGdb_5_19','{}',myQueryRenameField("V1","mapIDs"))
# myUpdateQueryMongoSimple('iogold','def_module_pathway_associations_KEGGdb_5_19','{}',myQueryRenameField("V2","moduleIDs"))
# 
# #myUpdateQueryMongoSimple('iogold','def_ko_pathway_associations_KEGGdb_5_19','{}',myQueryRenameField("V1","mapkoIDs"))
# myUpdateQueryMongoSimple('iogold','def_ko_pathway_associations_KEGGdb_5_19','{}',myQueryRenameField("V2","koIDs"))

# myUpdateQueryMongoSimple('iogold','def_pathway_definitions_KEGGdb_5_19','{}',myQueryRenameField("V1","mapIDs"))
# myUpdateQueryMongoSimple('iogold','def_pathway_definitions_KEGGdb_5_19','{}',myQueryRenameField("V2","definition"))



databaseName<-'iogold'
collectionJointure<-"jointures"
### (1)
M00001<-findQuery(databaseName,
          "def_ko_Module_associations_KEGGdb_5_19",
          myQueryChaine("moduleIDs","M00001"))

listeKoIds<-M00001$koIDs

### (2)
key<-
  getCollectionKeyMongo(databaseName,
                        collectionJointure,
                        "def_genes_cat_hs9.9_v1",
                        "def_ko_definition_KEGGdb_5_19",
                        "cat_hs9.9_v1")
K00844<-findQuery(databaseName,
                  "def_genes_cat_hs9.9_v1",
                  myQueryUniqueIN(key,listeKoIds[1:5]))

listGeneIDs<-K00844$GeneID

### (3)
key2<-
  getCollectionKeyMongo(databaseName,
                        collectionJointure,
                        "def_genes_cat_hs9.9_v1",
                        "def_cag_cat_hs9.9_v1",
                        "cat_hs9.9_v1")
#key2<-"GeneIDs"
CAG000X<-findQuery(databaseName,
                  "def_cag_cat_hs9.9_v1",
                  myQueryUniqueIN_integer(key2,listGeneIDs[1:5]))
# listGeneIDs2<-c(7215742,6360494)
# cagf<-findQueryLimit('iogold','def_cag_cat_hs9.9_v1',myQueryUniqueIN_integer("GeneIDs",listGeneIDs2),3)

getDataFrame<-
  function(){
    databaseName<-'iogold'
    collectionJointure<-"jointures"
    ### (1)
    cat('1 - \n')
    M00001<-findQuery(databaseName,
                      "def_ko_Module_associations_KEGGdb_5_19",
                      myQueryChaine("moduleIDs","M00001"))
    
    listeKoIds<-M00001$koIDs
    
    ### les keys
    key<-
      getCollectionKeyMongo(databaseName,
                            collectionJointure,
                            "def_genes_cat_hs9.9_v1",
                            "def_ko_definition_KEGGdb_5_19",
                            "cat_hs9.9_v1")
    key2<-
      getCollectionKeyMongo(databaseName,
                            collectionJointure,
                            "def_genes_cat_hs9.9_v1",
                            "def_cag_cat_hs9.9_v1",
                            "cat_hs9.9_v1")
    ### le df initial
    
    mycag<-findAll(databaseName,'def_cag_cat_hs9.9_v1')
    mydata<-mycag
    row.names(mydata)<-mydata$MGS
    mydata$GeneIDs<-NULL
    
    ### construction du df
    for(i in 1:length(listeKoIds)){
    
    #for(i in 1:2){
      max<-length(listeKoIds)
      cat('2 - ::',listeKoIds[i],':: ',i,'/ ',max,'\n')
      ### (2)
      i<-1
      K0<-findQuery(databaseName,
                        "def_genes_cat_hs9.9_v1",
                        myQueryUnique(key,listeKoIds[i]))
      # K02<-findQuery(databaseName,
      #                "def_genes_cat_hs9.9_v1",
      #                myQueryConstraintN(
      #                  list(
      #                    myConstraintUnique(key,listeKoIds[i]),
      #                    myConstraintMinMaxN("MGS",1,1)
      #                  )
      #                ))
      
      listGeneIDs<-K0$GeneID
      
      ### (3)
      cat('3 - ::',i,'\n')
      CAG000X<-findQuery(databaseName,
                         "def_cag_cat_hs9.9_v1",
                         myQueryUniqueIN_integer(key2,listGeneIDs[1]))
      
      listCAG000X<-CAG000X$MGS
      
      ### on compte le nombre le mgs 
      nbrByCag<-table(listCAG000X)
      
      ### on met les valeur dans le df
      for(j in 1:length(nbrByCag)){
        cat('3 bis - ::',listeKoIds[i],' :: ',names(nbrByCag)[j],'\n')
        mydata[row.names(mydata) %in% names(nbrByCag)[j],listeKoIds[i]]<-nbrByCag[j]
        
      }
      
      
    }
    mydata[is.na(mydata)] <- 0
    
    mydata$MGS<-NULL
    return(mydata)
  }
d<-Sys.time()
mydfin4<-getDataFrame()
Sys.time()-d

vectorGeneIDs<-unlist(MGS_GeneIDs, use.names=FALSE)
d<-Sys.time()
if(listGeneIDs[1] %in% unlist(mycag[1,"GeneIDs"], use.names=FALSE)){
  cat(mycag$MGS[1])
}
Sys.time()-d


d<-Sys.time()
CAG000X<-findQuery(databaseName,
                   "def_cag_cat_hs9.9_v1",
                   myQueryUniqueIN_integer(key2,listGeneIDs[1]))
cat(CAG000X$MGS)
Sys.time()-d





mydata[row.names(mydata) %in% c("CAG00001","CAG00008"),] # ok
mydata[c("CAG00001","CAG00008") %in% row.names(mydata),]


db2<-loadDataBase('iogold','def_cag_cat_hs9.9_v1')

query<-
  paste0('[{ "$match": {',myConstraintUnique_integer("GeneIDs",listGeneIDs[1]),',',myConstraintUnique_integer("GeneIDs",listGeneIDs[2]),'} },',
         '{"$group":{"_id":"$MGS", "count": {"$sum":1}}}]')
query<-
  paste0('[{ "$match": ',myQueryUniqueIN_integer("GeneIDs",listGeneIDs[1:2]),' },',
         '{"$group":{"_id":"$MGS", "count": {"$sum":1}}},',
         '{ "$project": { "_id": 0 } }',']')


stats <- db2$aggregate(
  query,
  options = '{"allowDiskUse":true}'
  #,iterate = TRUE
)
#names(stats) <- c("MGS", "count", "average")
# print(stats)
# stats$json(10)

getDataFrameCouvertureMGSbyK0<-
  function(data_frame_CAG,listeKoIds,key_gene_ko="KOs_embl_metacardis"){
    databaseName<-'iogold'
    
    ### les keys
    key<-"KOs_embl_metacardis"
    
    
    mycag<-data_frame_CAG
    ## set names of mycag$GeneIDs with mycag$MGS
    ## in this case, every GeneID of a data_frame_CAG row will have the name of the MGS of the row
    names(mycag$GeneIDs)<-mycag$MGS
    
    ### le df initial
    mydata<-mycag
    ## set row.name with CAGXXX value
    row.names(mydata)<-mycag$MGS
    ## set col.name with K00XXX value
    #for(i in 1:length(listeKoIds)){mydata[,listeKoIds[i]]<-0}
    
    ## suppression de la colonnes GeneIDs
    mydata$GeneIDs<-NULL
    
    
    ### construction du df
    lapply(listeKoIds,function(K0x){
      cat(K0x)
      d<-Sys.time()
      K0<-findQuery(databaseName,
                    "def_genes_cat_hs9.9_v1",
                    myQueryUnique(key,K0x))
      
      ## on compte le nombre de gene par CAG 
      ## (c'est la longueur de l'intercection entre la liste des geneid du ko et la liste des geneid du cag  )
      listGeneIDs<-K0$GeneID
      tabMGSK0<-sapply(mycag$GeneIDs, function(x) length(intersect(x, listGeneIDs)))
      
      ## on stoque le resultat dans la colonne ko qui correspond
      ## la longuer de tabMGSK0 == nbr ligne mydata
      mydata[,K0x]<-tabMGSK0
      
      cat(" -- ",Sys.time()-d,"\n")
    })
    
    ## suppression de la colonnes MGS
    mydata$MGS<-NULL
    return(mydata)
  }






getDataFrameCouvertureMGSbyK0<-
  function(data_frame_CAG,listeKoIds,key_gene_ko="KOs_embl_metacardis"){
    databaseName<-'iogold'
    
    ### les keys
    key<-"KOs_embl_metacardis"
    
    
    mycag<-data_frame_CAG
    ## set names of mycag$GeneIDs with mycag$MGS
    ## in this case, every GeneID of a data_frame_CAG row will have the name of the MGS of the row
    names(mycag$GeneIDs)<-mycag$MGS
    
    ### le df initial
    mydata<-mycag
    ## set row.name with CAGXXX value
    row.names(mydata)<-mycag$MGS
    ## set col.name with K00XXX value
    #for(i in 1:length(listeKoIds)){mydata[,listeKoIds[i]]<-0}
    
    ## suppression de la colonnes GeneIDs
    mydata$GeneIDs<-NULL
    
    max<-length(listeKoIds)
    ### construction du df
    db<-loadDataBase('iogold','def_genes_cat_hs9.9_v1')
    for(i in 1:length(listeKoIds)){
      # pour chaque ko, on récupére la liste des genes
      cat(i,"/",max," :: ",listeKoIds[i])
      d<-Sys.time()
      # K0<-findQuery(databaseName,
      #               "def_genes_cat_hs9.9_v1",
      #               myQueryUnique(key,listeKoIds[i]))
      # 
      K0<-db$find(query =myQueryUnique(key,listeKoIds[i]),fields = '{"KOs_embl_metacardis" : true}' ) # ~5fois plus rapide en precisant le fields
      
      ## on compte le nombre de gene par CAG 
      ## (c'est la longueur de l'intercection entre la liste des geneid du ko et la liste des geneid du cag  )
      listGeneIDs<-K0$GeneID
      tabMGSK0<-sapply(mycag$GeneIDs, function(x) length(intersect(x, listGeneIDs)))
      
      ## on stoque le resultat dans la colonne ko qui correspond
      ## la longuer de tabMGSK0 == nbr ligne mydata
      mydata[,listeKoIds[i]]<-tabMGSK0
      
      cat(" -- ",Sys.time()-d,"\n")
      
    }#end for
    rm(db)
    gc()
    ## suppression de la colonnes MGS
    mydata$MGS<-NULL
    return(mydata)
  }

data_frame_CAG<-findAll('iogold','def_cag_cat_hs9.9_v1')
listeKoIds<-findAll('iogold','def_ko_definition_KEGGdb_5_19')
listeKoIds<-listeKoIds$koIDs

d<-Sys.time()
mydata_couverture2<-getDataFrameCouvertureMGSbyK0(data_frame_CAG,listeKoIds) #Time difference of 4.38086 hours
cat(" FIN -- ",Sys.time()-d,"\n")
Sys.time()-d

d<-Sys.time()
mydata_couverture<-getDataFrameCouvertureMGSbyK0(data_frame_CAG,listeKoIds) #Time difference of 4.38086 hours
cat(" FIN -- ",Sys.time()-d,"\n")
Sys.time()-d

db<-loadDataBase('iogold','GeneAbundancebyKoIDs')

AddIndex('iogold','def_genes_cat_hs3.9_v1',"GeneID")
AddIndex('iogold','def_genes_cat_hs3.9_v1',"GeneName")

AddIndex('iogold','def_mgstaxonomy_cat_hs3.9_v1',"_row")
AddIndex('iogold','def_cag_cat_hs3.9_v1',"MGS")
AddIndex('iogold','def_cag_cat_hs3.9_v1',"GeneNames")



