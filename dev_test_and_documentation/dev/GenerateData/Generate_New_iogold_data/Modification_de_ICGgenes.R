
databaseName<-'iogold'
collectionName<-'ICGgenes'

updateMGSofICGgenes<-
  function(){
    databaseName<-'iogold'
    collectionName<-'ICGgenes'
    
    db<-loadDataBase(databaseName,collectionName)
    db$index(add = '{"MGS" : 1}')
    
    
    cles<-'{"MGS": { "$exists":  true}}'
    updateVal<-'{"$set":{"MGS": 1}}'
    db$update(cles,updateVal,multiple = TRUE)
    
    cles<-'{"MGS": { "$exists":  false}}'
    updateVal<-'{"$set":{"MGS": 0}}'
    db$update(cles,updateVal,multiple = TRUE)
    
  }


res<-findQueryLimit(databaseName,collectionName,'{}',3)




# GenerateMyData(databaseName,collectionName,'test.json',
#                "/home/ltekam/GIT_LAB_Fin/iogoldg/RShiny/GenerateData/Generate_New_iogold_data/")



