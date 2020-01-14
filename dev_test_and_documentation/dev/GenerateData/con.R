
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
