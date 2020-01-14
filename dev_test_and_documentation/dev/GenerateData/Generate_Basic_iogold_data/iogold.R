library(mongolite)
#library("rjson")#  rjson::fromJSON(js) may contain some bug
#library("RJSONIO") # sous forme de liste : affichage tableau
library("jsonlite")# pareil que rjson mais moin de bug: affichage matrice


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
#  ______ ______       _____                       _      _ 
#  |  _  \| ___ \     |_   _|                     | |    | |
#  | | | || |_/ /       | |    ___    __ _   ___  | |  __| |
#  | | | || ___ \       | |   / _ \  / _` | / _ \ | | / _` |
#  | |/ / | |_/ /  _   _| |_ | (_) || (_| || (_) || || (_| |
#  |___/  \____/  (_)  \___/  \___/  \__, | \___/ |_| \__,_|
#                                     __/ |                 
#                                    |___/                  

#########################################
# #db$insert     <- il faut de commenter le commande qui commence par
# db$insert      <-
chemin <- "/data/projects/iogold/data/microbiome/0.json.tables.ICGgenesMGS.MongoDB"
databaseName <- "iogold"


#  ___  ___ _____  _____  _                                                       
#  |  \/  ||  __ \/  ___|| |                                                      
#  | .  . || |  \/\ `--. | |_   __ _ __  __  ___   _ __    ___   _ __ ___   _   _ 
#  | |\/| || | __  `--. \| __| / _` |\ \/ / / _ \ | '_ \  / _ \ | '_ ` _ \ | | | |
#  | |  | || |_\ \/\__/ /| |_ | (_| | >  < | (_) || | | || (_) || | | | | || |_| |
#  \_|  |_/ \____/\____/  \__| \__,_|/_/\_\ \___/ |_| |_| \___/ |_| |_| |_| \__, |
#                                                                            __/ |
#                                                                           |___/ 
collectionName <- "MGStaxonomy" 
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

cheminCollection<-paste(chemin,"MGStaxonomy.json",sep='/')
if (!file.exists(cheminCollection)) {
  cat("!!!",collectionName,"!!! [not ok]\n\n")
}else{

  #db$insert(fromJSON(cheminCollection))
  cat("--",collectionName,"-- ",db$count(),"[ok]\n\n")
}
#  ___  ___            _         _                    _         __  _         _  _    _                    
#  |  \/  |           | |       | |                  | |       / _|(_)       (_)| |  (_)                   
#  | .  . |  ___    __| | _   _ | |  ___           __| |  ___ | |_  _  _ __   _ | |_  _   ___   _ __   ___ 
#  | |\/| | / _ \  / _` || | | || | / _ \         / _` | / _ \|  _|| || '_ \ | || __|| | / _ \ | '_ \ / __|
#  | |  | || (_) || (_| || |_| || ||  __/        | (_| ||  __/| |  | || | | || || |_ | || (_) || | | |\__ \
#  \_|  |_/ \___/  \__,_| \__,_||_| \___|         \__,_| \___||_|  |_||_| |_||_| \__||_| \___/ |_| |_||___/
#                                         ______                                                           
#                                        |______|                                                          
collectionName <- "module_definitions.json" 
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

cheminCollection<-paste(chemin,"module_definitions.json",sep='/')
if (!file.exists(cheminCollection)) {
  cat("!!!",collectionName,"!!! [not ok]\n\n")
}else{
  
  #db$insert(fromJSON(cheminCollection))
  cat("--",collectionName,"-- ",db$count(),"[ok]\n\n")
}

#   _                        _         __  _         _  _    _                    
#  | |                      | |       / _|(_)       (_)| |  (_)                   
#  | | __  ___            __| |  ___ | |_  _  _ __   _ | |_  _   ___   _ __   ___ 
#  | |/ / / _ \          / _` | / _ \|  _|| || '_ \ | || __|| | / _ \ | '_ \ / __|
#  |   < | (_) |        | (_| ||  __/| |  | || | | || || |_ | || (_) || | | |\__ \
#  |_|\_\ \___/          \__,_| \___||_|  |_||_| |_||_| \__||_| \___/ |_| |_||___/
#                ______                                                           
#               |______|                                                          

collectionName <- "ko_definition" 
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

cheminCollection<-paste(chemin,"ko.definitions.json",sep='/')
if (!file.exists(cheminCollection)) {
  cat("!!!",collectionName,"!!! [not ok]\n\n")
}else{
  
  #db$insert(fromJSON(cheminCollection))
  cat("--",collectionName,"-- ",db$count(),"[ok]\n\n")
}

#   _                   ___  ___            _         _                                              _         _    _                    
#  | |                  |  \/  |           | |       | |                                            (_)       | |  (_)                   
#  | | __  ___          | .  . |  ___    __| | _   _ | |  ___           __ _  ___  ___   ___    ___  _   __ _ | |_  _   ___   _ __   ___ 
#  | |/ / / _ \         | |\/| | / _ \  / _` || | | || | / _ \         / _` |/ __|/ __| / _ \  / __|| | / _` || __|| | / _ \ | '_ \ / __|
#  |   < | (_) |        | |  | || (_) || (_| || |_| || ||  __/        | (_| |\__ \\__ \| (_) || (__ | || (_| || |_ | || (_) || | | |\__ \
#  |_|\_\ \___/         \_|  |_/ \___/  \__,_| \__,_||_| \___|         \__,_||___/|___/ \___/  \___||_| \__,_| \__||_| \___/ |_| |_||___/
#                ______                                        ______                                                                    
#               |______|                                      |______|                                                                   


collectionName <- "ko_Module_associations" 
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

cheminCollection<-paste(chemin,"ko_Module_associations.json",sep='/')
if (!file.exists(cheminCollection)) {
  cat("!!!",collectionName,"!!! [not ok]\n\n")
}else{
  
  #db$insert(fromJSON(cheminCollection))
  cat("--",collectionName,"-- ",db$count(),"[ok]\n\n")
}

#   _                   ______         _    _                                                                    _         _    _                    
#  | |                  | ___ \       | |  | |                                                                  (_)       | |  (_)                   
#  | | __  ___          | |_/ /  __ _ | |_ | |__  __      __  __ _  _   _           __ _  ___  ___   ___    ___  _   __ _ | |_  _   ___   _ __   ___ 
#  | |/ / / _ \         |  __/  / _` || __|| '_ \ \ \ /\ / / / _` || | | |         / _` |/ __|/ __| / _ \  / __|| | / _` || __|| | / _ \ | '_ \ / __|
#  |   < | (_) |        | |    | (_| || |_ | | | | \ V  V / | (_| || |_| |        | (_| |\__ \\__ \| (_) || (__ | || (_| || |_ | || (_) || | | |\__ \
#  |_|\_\ \___/         \_|     \__,_| \__||_| |_|  \_/\_/   \__,_| \__, |         \__,_||___/|___/ \___/  \___||_| \__,_| \__||_| \___/ |_| |_||___/
#                ______                                              __/ | ______                                                                    
#               |______|                                            |___/ |______|                                                                   
collectionName <- "ko_Pathway_associations" 
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

cheminCollection<-paste(chemin,"ko_Pathway_associations.json",sep='/')
if (!file.exists(cheminCollection)) {
  cat("!!!",collectionName,"!!! [not ok]\n\n")
}else{
  
  #db$insert(fromJSON(cheminCollection))
  cat("--",collectionName,"-- ",db$count(),"[ok]\n\n")
}

#  ___  ___            _         _               ______         _    _                                                                    _         _    _                    
#  |  \/  |           | |       | |              | ___ \       | |  | |                                                                  (_)       | |  (_)                   
#  | .  . |  ___    __| | _   _ | |  ___         | |_/ /  __ _ | |_ | |__  __      __  __ _  _   _           __ _  ___  ___   ___    ___  _   __ _ | |_  _   ___   _ __   ___ 
#  | |\/| | / _ \  / _` || | | || | / _ \        |  __/  / _` || __|| '_ \ \ \ /\ / / / _` || | | |         / _` |/ __|/ __| / _ \  / __|| | / _` || __|| | / _ \ | '_ \ / __|
#  | |  | || (_) || (_| || |_| || ||  __/        | |    | (_| || |_ | | | | \ V  V / | (_| || |_| |        | (_| |\__ \\__ \| (_) || (__ | || (_| || |_ | || (_) || | | |\__ \
#  \_|  |_/ \___/  \__,_| \__,_||_| \___|        \_|     \__,_| \__||_| |_|  \_/\_/   \__,_| \__, |         \__,_||___/|___/ \___/  \___||_| \__,_| \__||_| \___/ |_| |_||___/
#                                         ______                                              __/ | ______                                                                    
#                                        |______|                                            |___/ |______|                                                                   
collectionName <- "Module_Pathway_associations" 
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

cheminCollection<-paste(chemin,"Module_Pathway_associations.json",sep='/')
if (!file.exists(cheminCollection)) {
  cat("!!!",collectionName,"!!! [not ok]\n\n")
}else{
  
  #db$insert(fromJSON(cheminCollection))
  cat("--",collectionName,"-- ",db$count(),"[ok]\n\n")
}


#   _____  _____  _____                                ___  ___ _____  _____ 
#  |_   _|/  __ \|  __ \                               |  \/  ||  __ \/  ___|
#    | |  | /  \/| |  \/  __ _   ___  _ __    ___  ___ | .  . || |  \/\ `--. 
#    | |  | |    | | __  / _` | / _ \| '_ \  / _ \/ __|| |\/| || | __  `--. \
#   _| |_ | \__/\| |_\ \| (_| ||  __/| | | ||  __/\__ \| |  | || |_\ \/\__/ /
#   \___/  \____/ \____/ \__, | \___||_| |_| \___||___/\_|  |_/ \____/\____/ 
#                         __/ |                                              
#                        |___/                                               

collectionName <- "ICGgenes"
#collectionName <- "ICGgenesMGS"
# Connect to the database
db <- mongo(collection = collectionName,
            url = sprintf(
              "mongodb://%s:%s@%s/%s",
              options()$mongodb$username,
              options()$mongodb$password,
              options()$mongodb$host,
              databaseName)
)
#db$drop()  ATTENTION !!!! il faut [20-25]minutes pour reconstruir cette collection

fichiers<-dir(chemin,pattern = "CAG")
n <-length(fichiers)
cat("[DEBUT import IGCgenes]\n")
for(i in 1:n)
{
  cheminCollection<-paste(chemin,fichiers[i],sep='/')
  #db$insert(fromJSON(cheminCollection))  ATTENTION !!!! il faut [20-25]minutes pour reconstruir cette collection
  if((i%%500)==0)cat(i," yep\n")#cat("--ICGgenesMGS ::",fichiers[i],"[",i,"..]-- ",db$count(),"[ok]\n\n")
  
}
cat("--ICGgenesMGS ::",fichiers[n],"[",n,"]-- ",db$count(),"[ok]\n\n")
cat("[FIN import IGCgenes]\n")
# i<-1
# db$insert(fromJSON(cheminCollection)) 
# #db$insert(fromJSON("/data/projects/iogold/data/microbiome/0.json.tables.ICGgenesMGS.MongoDB/CAG00001.json"))
# cat("--ICGgenesMGS ::",fichiers[i],"[",i,"]-- ",db$count(),"[ok]\n\n")


#   _   _        ___  ___ _____  _____                           
#  | \ | |       |  \/  ||  __ \/  ___|                          
#  |  \| |  ___  | .  . || |  \/\ `--.   __ _   ___  _ __    ___ 
#  | . ` | / _ \ | |\/| || | __  `--. \ / _` | / _ \| '_ \  / _ \
#  | |\  || (_) || |  | || |_\ \/\__/ /| (_| ||  __/| | | ||  __/
#  \_| \_/ \___/ \_|  |_/ \____/\____/  \__, | \___||_| |_| \___|
#                                        __/ |                   
#                                       |___/                    
#collectionName <- "ICGgenes"
#collectionName <- "NoMGSgenes" 
# Connect to the database
db <- mongo(collection = collectionName,
            url = sprintf(
              "mongodb://%s:%s@%s/%s",
              options()$mongodb$username,
              options()$mongodb$password,
              options()$mongodb$host,
              databaseName)
)
#db$drop() ATTENTION !!!! il faut [20-25]minutes pour reconstruir cette collection 

fichiers<-dir(chemin,pattern = "NoMGSgenes")
n <-length(fichiers)
cat("[DEBUT import NoMGSgenes]\n")
for(i in 1:n)
{
  cheminCollection<-paste(chemin,fichiers[i],sep='/')
  #db$insert(fromJSON(cheminCollection)) ATTENTION !!!! il faut [20-25]minutes pour reconstruir cette collection
  cat(i," yep\n")#cat("--",fichiers[i],"[",i,"]-- ",db$count(),"[ok]\n\n")
}
cat("--",fichiers[n],"[",n,"]-- ",db$count(),"[ok]\n\n")
cat("[FIN import NoMGSgenes]\n")

nbrgenes<-db$count()
