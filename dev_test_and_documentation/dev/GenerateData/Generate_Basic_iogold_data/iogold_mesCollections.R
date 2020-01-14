#   _____                       _         ______      _         ______                
#  /  __ \                     | |        |  _  \    | |        | ___ \               
#  | /  \/ ___  _ __  _ __     | |_ ___   | | | |__ _| |_ __ _  | |_/ / __ _ ___  ___ 
#  | |    / _ \| '_ \| '_ \    | __/ _ \  | | | / _` | __/ _` | | ___ \/ _` / __|/ _ \
#  | \__/\ (_) | | | | | | |_  | || (_) | | |/ / (_| | || (_| | | |_/ / (_| \__ \  __/
#   \____/\___/|_| |_|_| |_(_)  \__\___/  |___/ \__,_|\__\__,_| \____/ \__,_|___/\___|
#                                                                                     
#                                                                                     
##################################################################
# comme le mot de passe a des caractéres spéciaux, on utilise la fonction URLencore
pwd<-URLencode( "rT@g4CkYkaTRS=%8",reserved = TRUE)
options(mongodb = list(
  "host" = "gpu1.integromics.fr:27017",
  "username" = "shiny",
  "password" =pwd
))

# Connect to the database
# cette fonction permet de ce connecter à la base de données
# elle prend deux arguments, le nom de la base de données à laquelle on souaite se connecté
# et le nom de la collection 
# en effect avec mongo db on ne peux se connecté qu'a une seul collection à la fois
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


#  ____________    _                   _     _                       _____       _ _           _   _                 
#  |  _  \ ___ \  (_)                 | |   | |                     /  __ \     | | |         | | (_)                
#  | | | | |_/ /   _  ___   __ _  ___ | | __| |  _ __ ___   ___  ___| /  \/ ___ | | | ___  ___| |_ _  ___  _ __  ___ 
#  | | | | ___ \  | |/ _ \ / _` |/ _ \| |/ _` | | '_ ` _ \ / _ \/ __| |    / _ \| | |/ _ \/ __| __| |/ _ \| '_ \/ __|
#  | |/ /| |_/ /  | | (_) | (_| | (_) | | (_| | | | | | | |  __/\__ \ \__/\ (_) | | |  __/ (__| |_| | (_) | | | \__ \
#  |___/ \____(_) |_|\___/ \__, |\___/|_|\__,_| |_| |_| |_|\___||___/\____/\___/|_|_|\___|\___|\__|_|\___/|_| |_|___/
#                           __/ |           ______                                                                   
#                          |___/           |______|                                                                  


chemin <-"/home/ltekam/GIT_LAB_Ludo/iogoldg/RShiny/GenerateData"
databaseName <- "iogold"
collectionName <- "iogold_mesCollections"

db<-loadDataBase(databaseName,collectionName)
#db$drop()
cheminCollection<-paste(chemin,"iogold_mesCollections.json",sep='/')
if (!file.exists(cheminCollection)) {
  cat("!!!",collectionName,"!!! [not ok]\n\n")
}else{
  if(db$count() >0){
    print("cette collection existe déjà")
    #print(db$find())
  }else{
    db$insert(fromJSON(cheminCollection))
    cat("--",collectionName,"-- ",db$count(),"[ok]\n\n")
  }
}
