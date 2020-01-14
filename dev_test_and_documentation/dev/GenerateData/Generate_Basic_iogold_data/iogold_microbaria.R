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
#  ____________       _____                  _     _  ___  ____                _                _       
#  |  _  \ ___ \     |_   _|                | |   | | |  \/  (_)              | |              (_)      
#  | | | | |_/ /       | |  ___   __ _  ___ | | __| | | .  . |_  ___ _ __ ___ | |__   __ _ _ __ _  __ _ 
#  | | | | ___ \       | | / _ \ / _` |/ _ \| |/ _` | | |\/| | |/ __| '__/ _ \| '_ \ / _` | '__| |/ _` |
#  | |/ /| |_/ /  _   _| || (_) | (_| | (_) | | (_| | | |  | | | (__| | | (_) | |_) | (_| | |  | | (_| |
#  |___/ \____/  (_)  \___/\___/ \__, |\___/|_|\__,_| \_|  |_/_|\___|_|  \___/|_.__/ \__,_|_|  |_|\__,_|
#                                 __/ |                                                                 
#                                |___/                                                                  
#########################################
# #db$insert     <- il faut de commenter le commande qui commence par
# db$insert      <-
chemin <- "/data/projects/iogold/data/microbiome/2.json.tables.Microbaria"
databaseName <- "iogold"



#  ___  ____                _                _       _____                       _     ___  ___     _            _       _        
#  |  \/  (_)              | |              (_)     /  ___|                     | |    |  \/  |    | |          | |     | |       
#  | .  . |_  ___ _ __ ___ | |__   __ _ _ __ _  __ _\ `--.  __ _ _ __ ___  _ __ | | ___| .  . | ___| |_ __ _  __| | __ _| |_ __ _ 
#  | |\/| | |/ __| '__/ _ \| '_ \ / _` | '__| |/ _` |`--. \/ _` | '_ ` _ \| '_ \| |/ _ \ |\/| |/ _ \ __/ _` |/ _` |/ _` | __/ _` |
#  | |  | | | (__| | | (_) | |_) | (_| | |  | | (_| /\__/ / (_| | | | | | | |_) | |  __/ |  | |  __/ || (_| | (_| | (_| | || (_| |
#  \_|  |_/_|\___|_|  \___/|_.__/ \__,_|_|  |_|\__,_\____/ \__,_|_| |_| |_| .__/|_|\___\_|  |_/\___|\__\__,_|\__,_|\__,_|\__\__,_|
#                                                                         | |                                                     
#                                                                         |_|                                                     
collectionName <- "MicrobariaSampleMetadata" 
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

cheminCollection<-paste(chemin,"MicrobariaSampleMetadata.json",sep='/')
if (!file.exists(cheminCollection)) {
  cat("!!!",collectionName,"!!! [not ok]\n\n")
}else{
  
  #db$insert(fromJSON(cheminCollection))
  cat("--",collectionName,"-- ",db$count(),"[ok]\n\n")
}


#  ___  ____                _                _      ___  ________  _____       _                     _                      
#  |  \/  (_)              | |              (_)     |  \/  |  __ \/  ___|     | |                   | |                     
#  | .  . |_  ___ _ __ ___ | |__   __ _ _ __ _  __ _| .  . | |  \/\ `--.  __ _| |__  _   _ _ __   __| | __ _ _ __   ___ ___ 
#  | |\/| | |/ __| '__/ _ \| '_ \ / _` | '__| |/ _` | |\/| | | __  `--. \/ _` | '_ \| | | | '_ \ / _` |/ _` | '_ \ / __/ _ \
#  | |  | | | (__| | | (_) | |_) | (_| | |  | | (_| | |  | | |_\ \/\__/ / (_| | |_) | |_| | | | | (_| | (_| | | | | (_|  __/
#  \_|  |_/_|\___|_|  \___/|_.__/ \__,_|_|  |_|\__,_\_|  |_/\____/\____/ \__,_|_.__/ \__,_|_| |_|\__,_|\__,_|_| |_|\___\___|
#                                                                                                                           
#                                                                                                                           
collectionName <- "MicrobariaMGSabundance" 
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

cheminCollection<-paste(chemin,"MicrobariaMGSabundance.json",sep='/')
if (!file.exists(cheminCollection)) {
  cat("!!!",collectionName,"!!! [not ok]\n\n")
}else{
  
  #db$insert(fromJSON(cheminCollection))
  cat("--",collectionName,"-- ",db$count(),"[ok]\n\n")
}



#  ___  ____                _                _       _____                  ___  _                     _                      
#  |  \/  (_)              | |              (_)     |  __ \                / _ \| |                   | |                     
#  | .  . |_  ___ _ __ ___ | |__   __ _ _ __ _  __ _| |  \/ ___ _ __   ___/ /_\ \ |__  _   _ _ __   __| | __ _ _ __   ___ ___ 
#  | |\/| | |/ __| '__/ _ \| '_ \ / _` | '__| |/ _` | | __ / _ \ '_ \ / _ \  _  | '_ \| | | | '_ \ / _` |/ _` | '_ \ / __/ _ \
#  | |  | | | (__| | | (_) | |_) | (_| | |  | | (_| | |_\ \  __/ | | |  __/ | | | |_) | |_| | | | | (_| | (_| | | | | (_|  __/
#  \_|  |_/_|\___|_|  \___/|_.__/ \__,_|_|  |_|\__,_|\____/\___|_| |_|\___\_| |_/_.__/ \__,_|_| |_|\__,_|\__,_|_| |_|\___\___|
#                                                                                                                             
#                                                                                                                             
collectionName <- "MicrobariaGeneAbundance" 
# Connect to the database
db <- mongo(collection = collectionName,
            url = sprintf(
              "mongodb://%s:%s@%s/%s",
              options()$mongodb$username,
              options()$mongodb$password,
              options()$mongodb$host,
              databaseName)
)
#db$drop()  ATENTION!!! PREND PLUS DE 2h POUR LA RECONSTRUIR

cheminCollection<-paste(chemin,"MicrobariaGeneAbundance.json",sep='/')
if (!file.exists(cheminCollection)) {
  cat("!!!",collectionName,"!!! [not ok]\n\n")
}else{
  
  #db$insert(fromJSON(cheminCollection)) ATENTION!!! PREND PLUS DE 2h POUR LA RECONSTRUIRE
  cat("--",collectionName,"-- ",db$count(),"[ok]\n\n")
}
