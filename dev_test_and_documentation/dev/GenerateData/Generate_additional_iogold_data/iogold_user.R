library(mongolite)
library("jsonlite")


#########################################################################
##         NE PAS FAIRE DE MODIFICATION OU D'EXECUTION                 ##
##              SANS L'AUTORISATION  DE L'ADMIN                        ##
#########################################################################


pwd<-URLencode( "rT@g4CkYkaTRS=%8",reserved = TRUE)
options(mongodb = list(
  "host" = "gpu1.integromics.fr:27017",
  "username" = "shiny",
  "password" =pwd
))


#  ______ ______       _____                       _      _          _   _                  
#  |  _  \| ___ \     |_   _|                     | |    | |        | | | |                 
#  | | | || |_/ /       | |    ___    __ _   ___  | |  __| |        | | | | ___   ___  _ __ 
#  | | | || ___ \       | |   / _ \  / _` | / _ \ | | / _` |        | | | |/ __| / _ \| '__|
#  | |/ / | |_/ /  _   _| |_ | (_) || (_| || (_) || || (_| |        | |_| |\__ \|  __/| |   
#  |___/  \____/  (_)  \___/  \___/  \__, | \___/ |_| \__,_|         \___/ |___/ \___||_|   
#                                     __/ |                  ______                         
#                                    |___/                  |______|                                       

chemin <-"/home/ltekam/GIT_LAB/iogoldg/RShiny/GenerateData"
databaseName <- "iogold"

collectionName <- "iogold_user"
# Connect to the database
db <- mongo(collection = collectionName,
            url = sprintf(
              "mongodb://%s:%s@%s/%s",
              options()$mongodb$username,
              options()$mongodb$password,
              options()$mongodb$host,
              databaseName)
)
#db$drop()

cheminCollection<-paste(chemin,"iogold_user.json",sep='/')
if (!file.exists(cheminCollection)) {
  cat("!!!",collectionName,"!!! [not ok]\n\n")
}else{
  
  #db$insert(fromJSON(cheminCollection))
  cat("--",collectionName,"-- ",db$count(),"[ok]\n\n")
}
print(db$find())


#fichier<-dir(ch,pattern = "ut.json")
#db$insert(fromJSON(paste(ch,fichier[1],sep='/')))
#  ______ ______       _____                       _      _         ______                 _        _   
#  |  _  \| ___ \     |_   _|                     | |    | |        | ___ \               (_)      | |  
#  | | | || |_/ /       | |    ___    __ _   ___  | |  __| |        | |_/ / _ __   ___     _   ___ | |_ 
#  | | | || ___ \       | |   / _ \  / _` | / _ \ | | / _` |        |  __/ | '__| / _ \   | | / _ \| __|
#  | |/ / | |_/ /  _   _| |_ | (_) || (_| || (_) || || (_| |        | |    | |   | (_) |  | ||  __/| |_ 
#  |___/  \____/  (_)  \___/  \___/  \__, | \___/ |_| \__,_|        \_|    |_|    \___/   | | \___| \__|
#                                     __/ |                  ______                      _/ |           
#                                    |___/                  |______|                    |__/            
collectionName <- "iogold_projet"
# Connect to the database
db <- mongo(collection = collectionName,
            url = sprintf(
              "mongodb://%s:%s@%s/%s",
              options()$mongodb$username,
              options()$mongodb$password,
              options()$mongodb$host,
              databaseName)
)
#db$drop()

cheminCollection<-paste(chemin,"iogold_projet.json",sep='/')
if (!file.exists(cheminCollection)) {
  cat("!!!",collectionName,"!!! [not ok]\n\n")
}else{
  
  #db$insert(fromJSON(cheminCollection))
  cat("\n--",collectionName,"-- ",db$count(),"[ok]\n\n")
}

print(db$find())
