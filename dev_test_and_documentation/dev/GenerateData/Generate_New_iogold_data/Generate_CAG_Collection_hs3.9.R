# étape 1
#charger l'objet GU_7381_conn (list mgs avec gene names)
load("/data/projects/iogold/data/microbiome/3.mgsList_3.9catalog/list_GU_7381_sup3_ordered_connectivity.RData") #MGS>50 genes (3481 MGSs) ##18 extra MGSs not in CAG object

# étape 2
# on converti la list CAG en data frame ou chaque colonne represente les GeneID d'un MGS
# et le nom de la colonne represente le MGS

# # étape 2a
# pour rendre la conversion facile, tous les MGS doivent avoir le même nombre d'élément
# on rajoute donc des valeur null

## Example data
l <- GU_7381_conn
## Compute maximum length
max.length <- max(sapply(l, length))
## Add NA values to list elements
l <- lapply(l, function(v) { c(v, rep(NA, max.length-length(v)))})
newCAG<-l

# # étape 2b
# on convertie la nouvelle liste en data frame
dfCAG <- as.data.frame(newCAG)


# étape 3
# creation de la collection CAG dans la base de données iogold
db<-loadDataBase('iogold','def_cag_cat_hs3.9_v1')
# on s'assure quelle est bien vide 
db$drop()

# étape 4
# on rajoute chaque colonne du data frame à la collection CAG
# remarque, avant de rajouter une colonne, il faudra supprimer les valeur NA

library("tidyverse") # use for %>% filter(!is.na(CAG00004 ))

maxlength<-ncol(dfCAG)
#for(j in 1:maxlength){7381 
for(j in 2108:maxlength){
  d<-Sys.time()
  # on suppime les NA sur la colonne i
  #j<-5
  df_no_NA<-dfCAG %>% filter(!is.na(dfCAG[j] ))
  
  # on met les ids dans une liste
  myGeneNames<-list()
  for(i in 1:length(df_no_NA[,j])){
    #on converti les id en character car il sont en factor
    ID<-as.character(df_no_NA[i,j])
    myGeneNames<-append(myGeneNames,ID)
  } 
  
  # on crée la chaine qui contient les GeneNames
  n<-length(myGeneNames)
  inter<-paste0('"',myGeneNames[1],'"')
  for(i in 1:n){
    if(i>1)inter<-paste0(inter,',"',myGeneNames[i],'"')
  }
  # tableau d'ID qui sera rajouter dans Mongo
  tabIDs<-paste0('[',inter,']') 
  # nom du MGS correspondant au tableau
  mgs<-colnames(dfCAG[j])
  
  MGS_data<-paste0('{ "MGS": "',mgs,'", "GeneNames": ',tabIDs,' }')

  
  # on insert les données : MGS et GenesIDs
  db$insert(MGS_data)
  
  # on indique que la colonne MGS est un index, ce qui augmentera 
  # la vitesse d'execution des requête qui seront effectué plutard
  if(j==1){
    db$index(add = '{"MGS" : 1}')
    cat("***index***")
  }
  cat('[',j,'/',maxlength,'] --',Sys.time()-d,'\n')
  
}


