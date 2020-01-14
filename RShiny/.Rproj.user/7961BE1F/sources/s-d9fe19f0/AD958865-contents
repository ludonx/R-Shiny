
#########################################################################################
## server.R ## # server frontend
#########################################################################################
server <- function(input, output, session) {
  
  ################################################
  # cette structure de données contiendra les informations
  # essentielles au fonctionement générale de l'appication
  ################################################
  source(
    file.path(
      paste0(app$config$appDirectory,"/server"),
      "serverLesVariables.R"),
    local = TRUE)$value
  
  
  source(
    file.path(
      paste0(app$config$appDirectory,"/server"),
      "serverLesFonctions.R"),
    local = TRUE)$value
  
  
  ############################################################
  ####### pour éxécuter du code R ############################
  runcodeServer()
  
  
  
  lapply(app$modules$server, function(x){eval(parse(text = x))})
  
  #############################################################
  session$allowReconnect(TRUE)
  # options(shiny.launch.browser=TRUE)
  
  ################## CHARGEMENT DES FeedBack #######################
  source(
    file.path(
      paste0(app$config$appDirectory,"/server"),
      "serverUpdate_feedback.R"),
    local = TRUE)$value
  
 
  
}
