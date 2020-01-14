library(mongolite)
library("jsonlite")

pwd<-URLencode( "rT@g4CkYkaTRS=%8",reserved = TRUE)
options(mongodb = list(
  "host" = "gpu1.integromics.fr:27017",
  "username" = "shiny",
  "password" =pwd
))


loadDataBase <- 
  function(databaseName,collectionName)
  {
    dataDase <- mongo(collection = collectionName,
                      url = sprintf(
                        "mongodb://%s:%s@%s/%s",
                        options()$mongodb$username,
                        options()$mongodb$password,
                        options()$mongodb$host,
                        databaseName)
    )
    dataDase
  }

GenerateMyData<-
  function(databaseName,collectionName,jsonFileName,pathJsonFileName){
    
    db<-loadDataBase(databaseName,collectionName)
    #nbr<-db$count()
    #if(nbr>0){
     # msg<-paste(" cette collection existe deja et contient ",nbr," lignes")
      #print(msg)
    #}else{
      cheminCollection<-paste(pathJsonFileName,jsonFileName,sep='/')
      if (!file.exists(cheminCollection)) {
        cat("!!!la collection : ",collectionName,"n'exite pas au chemenin indiquer !!! [not ok]\n\n")
      }else{
        cat(cheminCollection)
        db$insert(fromJSON(cheminCollection)) 
        #cat("\n--",collectionName,"-- ",db$count(),"[ok]\n\n")
      }
    #}
    
  
  }

databaseName <- "iogold"
collectionName <- "MicrobariaGeneAbundance_row" 

#jsonFileName<-"MicrobariaGeneAbundance_1_1000000_renamed.json"# "MicrobariaGeneAbundance.json"
pathJsonFileName<-"/data/projects/iogold/data/microbiome/2.json.tables.Microbaria"

# jsonFileName<-"MicrobariaGeneAbundance_1000001:2000000.json"
# GenerateMyData(databaseName,collectionName,jsonFileName,pathJsonFileName)
jsonFileName<-"MicrobariaGeneAbundance_2000001:3000000.json"
GenerateMyData(databaseName,collectionName,jsonFileName,pathJsonFileName)
jsonFileName<-"MicrobariaGeneAbundance_3000001:4000000.json"
GenerateMyData(databaseName,collectionName,jsonFileName,pathJsonFileName)
jsonFileName<-"MicrobariaGeneAbundance_4000001:5000000.json"
GenerateMyData(databaseName,collectionName,jsonFileName,pathJsonFileName)
jsonFileName<-"MicrobariaGeneAbundance_5000001:6000000.json"
GenerateMyData(databaseName,collectionName,jsonFileName,pathJsonFileName)
jsonFileName<-"MicrobariaGeneAbundance_6000001:7000000.json"
GenerateMyData(databaseName,collectionName,jsonFileName,pathJsonFileName)
jsonFileName<-"MicrobariaGeneAbundance_7000001_end.json"
GenerateMyData(databaseName,collectionName,jsonFileName,pathJsonFileName)
