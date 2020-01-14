# étape 1
#charger l'objet CAG (list mgs avec gene ids)
load("/data/db/biobank/catalogue/hs_9.9/hs_9.9_3463_cleaned_CAG_sup50_freeze1.rda")

# étape 2
# on converti la list CAG en data frame ou chaque colonne represente les GeneID d'un MGS
# et le nom de la colonne represente le MGS

# # étape 2a
# pour rendre la conversion facile, tous les MGS doivent avoir le même nombre d'élément
# on rajoute donc des valeur null

## Example data
l <- CAG
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
db<-loadDataBase('iogold','CAG')
# on s'assure quelle est bien vide 
db$drop()

# étape 4
# on rajoute chaque colonne du data frame à la collection CAG
# remarque, avant de rajouter une colonne, il faudra supprimer les valeur NA

library("tidyverse") # use for %>% filter(!is.na(CAG00004 ))

maxlength<-ncol(dfCAG)
for(j in 1:maxlength){
  # on suppime les NA sur la colonne i
  #j<-5
  df_no_NA<-dfCAG %>% filter(!is.na(dfCAG[j] ))
  
  # on met les ids dans une liste
  myGeneIDs<-list()
  for(i in 1:length(df_no_NA[,j])){
    #on converti les id en integer car il sont en factor
    ID<-as.integer(as.character(df_no_NA[i,j]))
    myGeneIDs<-append(myGeneIDs,ID)
  } 
  
  # on crée la chaine qui contient les ids
  n<-length(myGeneIDs)
  inter<-paste0(myGeneIDs[1])
  for(i in 1:n){
    if(i>1)inter<-paste0(inter,',',myGeneIDs[i])
  }
  # tableau d'ID qui sera rajouter dans Mongo
  tabIDs<-paste0('[',inter,']') 
  # nom du MGS correspondant au tableau
  mgs<-colnames(dfCAG[j])
  
  MGS_data<-paste0('{ "MGS": "',mgs,'", "GeneIDs": ',tabIDs,' }')

  
  # on insert les données : MGS et GenesIDs
  db$insert(MGS_data)
  
  # on indique que la colonne MGS est un index, ce qui augmentera 
  # la vitesse d'execution des requête qui seront effectué plutard
  if(j==1){
    db$index(add = '{"MGS" : 1}')
    cat("***index***")
  }
  cat('[',j,'/',maxlength,']\n')
  
}


