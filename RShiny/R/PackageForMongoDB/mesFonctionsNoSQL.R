#                   _____                          __                  _   _             
#                  |  _  |                        / _|                | | (_)            
#   _ __ ___  _   _| | | |_   _  ___ _ __ _   _  | |_ _   _ _ __   ___| |_ _  ___  _ __  
#  | '_ ` _ \| | | | | | | | | |/ _ \ '__| | | | |  _| | | | '_ \ / __| __| |/ _ \| '_ \ 
#  | | | | | | |_| \ \/' / |_| |  __/ |  | |_| | | | | |_| | | | | (__| |_| | (_) | | | |
#  |_| |_| |_|\__, |\_/\_\\__,_|\___|_|   \__, | |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|
#              __/ |                       __/ |                                         
#             |___/                       |___/                                          
##########################################################################################

#query = '{"Name" : "Mario"}',
#fields = '{"Name" : true, "_id" : false}',
#m$find('{ "val" : { "$regex" : "^a", "$options" : "i" }  }')


#   _____                        ______ _           _ 
#  |  _  |                       |  ___(_)         | |
#  | | | |_   _  ___ _ __ _   _  | |_   _ _ __   __| |
#  | | | | | | |/ _ \ '__| | | | |  _| | | '_ \ / _` |
#  \ \/' / |_| |  __/ |  | |_| | | |   | | | | | (_| |
#   \_/\_\\__,_|\___|_|   \__, | \_|   |_|_| |_|\__,_|
#                          __/ |                      
#                         |___/                       
############################################################
myQuery<-function(colonne,val){
  x<-paste0('{ "',colonne,'":',val,'}')
  return(x)
}
myQueryUnique<-function(colonne,val){
  x<-paste0('{ "',colonne,'":"',val,'"}')
  return(x)
}
myQueryUniqueOR<-function(c){
  query <- c[1]
 for(i in 1:length(c))
 {
   if(i>1){
     query<-paste0(query,',',c[i])
   }
 }
  queryFinal<-paste0('{ "$or": [',query,']}')
  return( queryFinal)
}
myQueryUniqueIN<-function(colonne,listvalue){
  query <- paste0('"',listvalue[1],'"')
  for(i in 1:length(listvalue))
  {
    if(i>1){
      query<-paste0(query,',"',listvalue[i],'"')
    }
  }
  queryFinal<-paste0('{ "',colonne,'" : { "$in" : [',query,']} }')
  return( queryFinal)
}
myQueryUniqueIN_integer<-function(colonne,listvalue){
  query <- paste0(listvalue[1])
  for(i in 1:length(listvalue))
  {
    if(i>1){
      query<-paste0(query,',',listvalue[i])
    }
  }
  queryFinal<-paste0('{ "',colonne,'" : { "$in" : [',query,']} }')
  return( queryFinal)
}

myQueryMinMax<-function(colonne,min,max){
  x<-paste0('{ "',colonne,'": {"$gte" :',min,', "$lte":',max,'}  }')
  return(x)
}
myQueryMinMax2<-function(c1,c2,min,max){
  debut<-'{ '
  x1<-paste0('"',c1,'":')
  x2<-paste0('"',c2,'":')
  #x<-paste0('{ "',colonne,'": {"$gte" :',min,', "$lte":',max,'}  }')
  condition<-paste0('{"$gte" :',min,', "$lte":',max,'}')
  fin<-'} '
  x<-paste0(debut,x1,condition,',',x2,condition,fin)
  return(x)
}
myQueryMinMaxN<-function(c,min,max){
  n<-length(unlist(c))
  #print(n)
  x<-list()
  debut<-'{ '
  fin<-'} '
  condition<-paste0('{"$gte" :',min,', "$lte":',max,'}')
  for(i in 1:n){
    x[i]<-paste0('"',c[i],'":')
  }
  query<-paste0(debut,x[1],condition)
  for(i in 1:n){
    if(i>1){
      query<-paste0(query,',',x[i],condition)
    }
  }
  query<-paste0(query,fin)
  return(query)
}
############################
myQueryChaine<-function(colonne,val){
  x<-paste0('{ "',colonne,'": { "$regex" : "',val,'", "$options" : "i" }  }')
  return(x)
}

myQueryChaineNe<-function(colonne,val){
  x<-paste0('{ "',colonne,'":{"$not": { "$regex" : "',val,'", "$options" : "i" }  } }')
  return(x)
}
##########################
myQueryChaineN<-function(colonne,val){
  nval<-length(unlist(colonne))
  x<-list()
  debut<-'{ '
  fin<-'} '
  condition<-paste0('{ "$regex" : "',val,'", "$options" : "i" }')
  for(i in 1:nval){
    x[i]<-paste0('"',colonne[i],'":')
  }
  query<-paste0(debut,x[1],condition)
  for(i in 1:nval){
    if(i>1){
      query<-paste0(query,',',x[i],condition)
    }
  }
  query<-paste0(query,fin)
  return(query)
}
###################""
myQuery_Chaine_MinMaxN<-function(c,min,max,colonne,val){
  n<-length(unlist(c))
  nval<-length(unlist(colonne))
  #print(n)
  x<-list()
  debut<-'{ '
  fin<-'} '
  
  xval<-list()
  debut<-'{ '
  fin<-'} '
  condition<-paste0('{ "$regex" : "',val,'", "$options" : "i" }')
  for(i in 1:nval){
    xval[i]<-paste0('"',colonne[i],'":')
  }
  queryval<-paste0(debut,xval[1],condition)
  for(i in 1:nval){
    if(i>1){
      queryval<-paste0(queryval,',',xval[i],condition)
    }
  }
  
  #####
  condition<-paste0('{"$gte" :',min,', "$lte":',max,'}')
  for(i in 1:n){
    x[i]<-paste0('"',c[i],'":')
  }
  query<-paste0(x[1],condition)
  for(i in 1:n){
    if(i>1){
      query<-paste0(query,',',x[i],condition)
    }
  }
  queryval<-paste0(queryval,',',query,fin)
  return(queryval)
}
#myQuery_Chaine_MinMaxN('Age',20,30,'Name','m')

#   _____                         _____                 _             _       _   
#  |  _  |                       /  __ \               | |           (_)     | |  
#  | | | |_   _  ___ _ __ _   _  | /  \/ ___  _ __  ___| |_ _ __ __ _ _ _ __ | |_ 
#  | | | | | | |/ _ \ '__| | | | | |    / _ \| '_ \/ __| __| '__/ _` | | '_ \| __|
#  \ \/' / |_| |  __/ |  | |_| | | \__/\ (_) | | | \__ \ |_| | | (_| | | | | | |_ 
#   \_/\_\\__,_|\___|_|   \__, |  \____/\___/|_| |_|___/\__|_|  \__,_|_|_| |_|\__|
#                          __/ |                                                  
#                         |___/                                                   
#####################################################################################

myConstraintChaineN<-function(colonne,val){
  nval<-length(unlist(colonne))
  x<-list()
  debut<-''
  fin<-paste0(',"',colonne,'": { "$exists": true }')
  condition<-paste0('{ "$regex" : "',val,'", "$options" : "i" }')
  for(i in 1:nval){
    x[i]<-paste0('"',colonne[i],'":')
  }
  query<-paste0(debut,x[1],condition)
  for(i in 1:nval){
    if(i>1){
      query<-paste0(query,',',x[i],condition)
    }
  }
  query<-paste0(query,fin)
  return(query)
}
myConstraintUnique<-function(colonne,val){
  nval<-length(unlist(colonne))
  x<-list()
  debut<-''
  fin<-paste0(',"',colonne,'": { "$exists": true }')
  condition<-paste0('"',val,'"')
  for(i in 1:nval){
    x[i]<-paste0('"',colonne[i],'":')
  }
  query<-paste0(debut,x[1],condition)
  for(i in 1:nval){
    if(i>1){
      query<-paste0(query,',',x[i],condition)
    }
  }
  query<-paste0(query,fin)
  return(query)
}
myConstraintUniqueIN<-function(colonne,listvalue){
  query <- paste0('"',listvalue[1],'"')
  for(i in 1:length(listvalue))
  {
    if(i>1){
      query<-paste0(query,',"',listvalue[i],'"')
    }
  }
  queryFinal<-paste0('"',colonne,'" : { "$in" : [',query,']}')
  return( queryFinal)
}
myConstraintUniqueIN_integer<-function(colonne,listvalue){
  query <- paste0(listvalue[1])
  for(i in 1:length(listvalue))
  {
    if(i>1){
      query<-paste0(query,',',listvalue[i])
    }
  }
  queryFinal<-paste0('"',colonne,'" : { "$in" : [',query,']}')
  return( queryFinal)
}
myConstraintUnique_integer<-function(colonne,val){
  nval<-length(unlist(colonne))
  x<-list()
  debut<-''
  fin<-paste0(',"',colonne,'": { "$exists": true }')
  condition<-paste0('',val,'')
  for(i in 1:nval){
    x[i]<-paste0('"',colonne[i],'":')
  }
  query<-paste0(debut,x[1],condition)
  for(i in 1:nval){
    if(i>1){
      query<-paste0(query,',',x[i],condition)
    }
  }
  query<-paste0(query,fin)
  return(query)
}
myConstraintMinMaxN<-function(listeCol,min,max){
  n<-length(unlist(listeCol))
  x<-list()
  debut<-''
  fin<-''
  condition<-paste0('{"$gte" :',min,', "$lte":',max,'}')
  for(i in 1:n){
    x[i]<-paste0('"',listeCol[i],'":')
  }
  query<-paste0(debut,x[1],condition)
  for(i in 1:n){
    if(i>1){
      query<-paste0(query,',',x[i],condition)
    }
  }
  query<-paste0(query,fin)
  return(query)
}

myQueryConstraintN<-function(listContraint){
  n<-length(unlist(listContraint))
  debut<-'{ '
  fin<-'}'
  inter<-','
  query<-""
  if(n>0){
    query<-paste0(listContraint[1])
    for(i in 1:n){
      if(i>1){
        query<-paste0(query,',',listContraint[i])
      }
    }
  }
  
  query<-paste0(debut,query,fin)
  return(query)
}
myQueryConstraintN_OR<-function(listContraint){
  
  n<-length(unlist(listContraint))
  debut<-'{ "$or": ['
  fin<-'] }'
  inter<-','
  query<-""
  if(n>0){
    query<-paste0('{',listContraint[1],'}')
    for(i in 1:n){
      if(i>1){
        query<-paste0(query,', {',listContraint[i],' }')
      }
    }
  }
  
  query<-paste0(debut,query,fin)
  return(query)
}
#   _____                          ___                                   _   _             
#  |  _  |                        / _ \                                 | | (_)            
#  | | | |_   _  ___ _ __ _   _  / /_\ \ __ _  __ _ _ __ ___  __ _  __ _| |_ _  ___  _ __  
#  | | | | | | |/ _ \ '__| | | | |  _  |/ _` |/ _` | '__/ _ \/ _` |/ _` | __| |/ _ \| '_ \ 
#  \ \/' / |_| |  __/ |  | |_| | | | | | (_| | (_| | | |  __/ (_| | (_| | |_| | (_) | | | |
#   \_/\_\\__,_|\___|_|   \__, | \_| |_/\__, |\__, |_|  \___|\__, |\__,_|\__|_|\___/|_| |_|
#                          __/ |         __/ | __/ |          __/ |                        
#                         |___/         |___/ |___/          |___/                                              
#################################################################

myQueryAggregation<-function(CollectionPrincipale,CollectionEtranger,clesP,clesE,match){
  query<-paste0('[{"$limit" : 3},
                {
                "$lookup": {
                "from": "',CollectionEtranger,'",
                "localField": "',clesP,'",    
                "foreignField": "',clesE,'",  
                "as": "datagene"
                }
                },
                { "$unwind": { "path": "$datagene" }  },
                {"$match" : { "_row" : "',match,'" } }
                ]')
  return(query)
}
myQueryAggregationLimit<-function(CollectionPrincipale,CollectionEtranger,clesP,clesE,limit){
  query<-paste0('[{"$limit" : ',limit,'},
                {
                "$lookup": {
                "from": "',CollectionEtranger,'",
                "localField": "',clesP,'",    
                "foreignField": "',clesE,'",  
                "as": "datagene"
                }
                },
                { "$unwind": { "path": "$datagene" }  }
                ]')
  return(query)
}
#myQueryAggregation("","ICGgenesMGS","_row","MGS","CAG00002")
#{ $or: [ { <expression1> }, { <expression2> }, ... , { <expressionN> } ] }
#a<-x$find(query = '{ "$or" : [ {"Name":"Test"},{"Name":"root"} ] }')

myQueryAggregationListMatch<-function(CollectionPrincipale,CollectionEtranger,clesP,clesE,match){
mymatch<-paste0('{"$match" : {"',clesP,'" : "',match,'" } }')
# ATTENTION :: LIMITE =3 !!!!!!!!!!!!
query<-paste0('[{"$limit" : 3}, 
                {
                "$lookup": {
                "from": "',CollectionEtranger,'",
                "localField": "',clesP,'",    
                "foreignField": "',clesE,'",  
                "as": "datagene"
                }
                },
                { "$unwind": { "path": "$datagene" }  },
                ',mymatch,'
                ]')
  return(query)
}

myQueryAggregationListMatchN<-function(CollectionPrincipale,CollectionEtranger,clesP,clesE,match){

  condition<-paste0('{"',clesP,'" : "',match[1],'" }')
  for(i in 1:length(match)){
    if(i>1){
      condition<-paste0(condition,' , 
                        ',  '{"',clesP,'" : "',match[i],'" }')
    }
    
  }  
  
  
  mymatch<-paste0('{"$match" :
                      { "$or" : 
                        [ 
                            ',condition,' 
                        ] 
                      } 
                   }')
 

  query<-paste0('[
                {
                "$lookup": {
                "from": "',CollectionEtranger,'",
                "localField": "',clesP,'",    
                "foreignField": "',clesE,'",  
                "as": "datagene"
                }
                },
                { "$unwind": { "path": "$datagene" }  },
                ',mymatch,'
                ]')
  return(query)
}
#resN<-b$aggregate(myQueryAggregationListMatchN("","ICGgenesMGS","_row","MGS",list("CAG00001","CAG00002")))

# condition2<-paste0('{"',clesP,'" : "',match[1],'" }',' ,','
#                           {"',clesP,'" : "',match[2],'" } ')

# print((condition))
# 
# mymatch2<-paste0('{"$match" :
#                     { "$or" : 
#                       [ 
#                           {"',clesP,'" : "',match[1],'" } ,
#                           {"',clesP,'" : "',match[2],'" } 
#                       ] 
#                     } 
#                  }')
# 
# print(mymatch2)
# print(mymatch)



#   _____       _ _           _   _             
#  /  __ \     | | |         | | (_)            
#  | /  \/ ___ | | | ___  ___| |_ _  ___  _ __  
#  | |    / _ \| | |/ _ \/ __| __| |/ _ \| '_ \ 
#  | \__/\ (_) | | |  __/ (__| |_| | (_) | | | |
#   \____/\___/|_|_|\___|\___|\__|_|\___/|_| |_|
#                                               
#                                               

getCollectionKey<-
  function(collection_1,collection_2){
    #!!!!!!!!!!!!!!!!!!!!
    
    # ATENTION !!!!! IL FAUT VERIFIER LES COLLECTION SONT BIEN DANS LA MATRICE
    
    # les colonnes corresponde au cles primaire des collection 1 
    # matrice[collection 1,collection 2] cles de la collection 2 qui permet de joindre la collection 1
    # matrice[collection 2,collection 1] cles de la collection 1 qui permet de joindre la collection 2
    # ces deux cles n'ont pas forcement le meme nom 
    # exemple : matrice["MGStaxonomy", "ICGgenesMGS"] = MGS
    #           matrice[ "ICGgenesMGS","MGStaxonomy"] = _row
    #           matrice[ "MGStaxonomy","MGStaxonomy"] = X
    
    
    collection_key = matrix( 
     
      
         c("_row", "_row","_row","_row","5","6","7","8","9","10","_row","12",
           
           "MGS", "GeneID","GeneID","GeneID","5","KOs_embl_metacardis","KOs_embl_metacardis","KOs_embl_metacardis","9","GeneName","11","12",
           "MGS", "GeneID","GeneID","GeneID","5","KOs_embl_metacardis","KOs_embl_metacardis","KOs_embl_metacardis","9","GeneName","11","12",
           "X", "GeneID","GeneID","GeneID","5","KOs_embl_metacardis","KOs_embl_metacardis","KOs_embl_metacardis","9","GeneName","11","12",
           
           "X", "X","X","X","V1","6","7","8","9","10","11","12",
           
           "X", "V1","V1","V1","X","V1","V1","V1","X","X","X","X",
           
           "X", "V2","V2","V2","V1","V2","V1","V2","9","10","11","12",
           "X", "V2","V2","V2","X","V2","V2","V1","9","10","11","12",
           
           "X", "X","X","X","V2","X","V2","V1","9","10","11","12",
           
           "X", "_row","_row","_row","5","6","7","8","9","X","11","12",
           "_row", "_row","_row","_row","5","6","7","8","9","10","_row","12",
           "1", "2","3","4","5","6","7","8","9","_row","_row","_row"
           ), 
         nrow=12, 
         ncol=12,
         dimnames = 
           list(
             c("MGStaxonomy", 
               "ICGgenes", 
               "ICGgenesMGS", 
               "NoMGSgenes",
               "module_definitions",
               "ko_definition" ,
               "ko_Module_associations",  
               "ko_Pathway_associations" ,
               "Module_Pathway_associations", 
               "MicrobariaGeneAbundance",
               "MicrobariaMGSabundance", 
               "MicrobariaSampleMetadata"
               ),
             c("MGStaxonomy", "ICGgenes", "ICGgenesMGS", "NoMGSgenes",
               "module_definitions", "ko_definition" , "ko_Module_associations",  "ko_Pathway_associations" ,
               "Module_Pathway_associations",
               "MicrobariaGeneAbundance", "MicrobariaMGSabundance", "MicrobariaSampleMetadata"
               )
             )
    )
    
    return(collection_key[collection_1,collection_2])
  }



# mes_collection_key<-
#   data.frame(
#   Name=character(), 
#   Key=character(),
#   stringsAsFactors=FALSE)
# rbind(mes_collection_key,c(MGStaxonomy)
#       c(date(),
#         information_ICGgenesMGS$query,
#         information_ICGgenesMGS$nbr_elem,
#         user_connected@id,
#         information_ICGgenesMGS$Nom),stringsAsFactors=FALSE) # ajout d'une ligne 
# 

#   _____             _            _   _             
#  |_   _|           | |          | | (_)            
#    | |_ __ __ _  __| |_   _  ___| |_ _  ___  _ __  
#    | | '__/ _` |/ _` | | | |/ __| __| |/ _ \| '_ \ 
#    | | | | (_| | (_| | |_| | (__| |_| | (_) | | | |
#    \_/_|  \__,_|\__,_|\__,_|\___|\__|_|\___/|_| |_|
#                                                    
#                                                    
myQueryChaineN_Traduction<-function(colonne,val){
  query_traduction<-paste0(colonne," ~= '",val,"'")
  return(query_traduction)
}

myQueryMinMaxN_Traduction<-function(colonne,min,max){
  query_traduction<-paste0(colonne," = [ ",min," - ",max," ]")
  return(query_traduction)
}

myConstraintChaineN_traduction<-function(colonne,val,collectionName){
  query_traduction<-paste0("Afficher tous les lignes de la collection ",collectionName)
  query_traduction<-paste0(query_traduction,"donc la colonne '",colonne,"'  contient la chaine '",val,"'")
  return(query_traduction)
}

myConstraintMinMaxN_traduction<-function(c,min,max,collectionName){
  query_traduction<-paste("Afficher tous les lignes de la collection ",collectionName)
  query_traduction<-paste(query_traduction," donc la colonne '",c,"'  a sa valeur dans l'interval [ ",min," , ",max," ]")
  return(query_traduction)
}


myQueryPushChaine<-
  function(colonne,listvalue){
    tab <- paste0('"',listvalue[1],'"')
    for(i in 1:length(listvalue))
    {
      if(i>1){
        tab<-paste0(tab,',"',listvalue[i],'"')
      }
    }
    query<-paste0('[',tab,']') 
    queryFinal<-paste0('{ "$push": { "',colonne,'" : {"$each":[',query,'] } } }')
    return( queryFinal)
  }

myQuerySetChaine<-
  function(colonne,val){
    queryFinal<-paste0('{ "$set": { "',colonne,'" : "',val,'" } }')
    return( queryFinal)
  }

myQueryRenameField<-
  function(colonne,val){
    queryFinal<-paste0('{ "$rename": { "',colonne,'" : "',val,'" } }')
    return( queryFinal)
  }