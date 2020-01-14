# pour optimiser les requêtes on vas ajouté des index sur 
# les principaux attributs de des collections

AddIndex<-
  function(databaseName,collectionName,colonne){
    db<-loadDataBase(databaseName,collectionName)
    db$index(add = paste0('{"',colonne,'" : 1}'))
  }

databaseName<-'iogold'
collectionName<-'MGStaxonomy'
db<-loadDataBase(databaseName,collectionName)
db$index()



AddIndex(databaseName,'ICGgenes',colonne='KOs_embl_metacardis')
AddIndex(databaseName,'ko_definition',colonne='KOs_embl_metacardis')
AddIndex(databaseName,'MicrobariaMGSabundance',colonne='_row')
AddIndex(databaseName,'MGStaxonomy',colonne='_row')

