tabItem_Sauvegarde<-
  tabItem(
    tabName = "Sauvegarde",
    h5("> Sauvegarde"),
    
    # sauvegarde de session ---------------------------------------------------------
    fluidRow(
      column(3,
             actionButton(inputId = paste0("ActionSave_session_Sauvegarde"),
                          label = "Sauvegarder la session",
                          icon("download"),
                          style="color: #fff; background-color: #3c936f; border-color: #3c936f"
             )
      )#end column
    ),
    br(),
    # Box Sauvegarde Génerale ---------------------------------------------------------
    box(
      title = "Sauvegarde Génerale",
      solidHeader = TRUE,
      
      sliderInput("sliderInput_save_session_time",
                  "Intervalle de sauvegarder des données (minutes) :",
                  min =1 ,
                  max =60*2 ,# 1heure * 2
                  value =5 ,
                  step =1 )
      
    ),
    # Box Sauvegarde Ma_console ---------------------------------------------------------
    box(
      title = 'Sauvegarde Module "Ma Console"',
      solidHeader = TRUE,
      
      sliderInput("sliderInput_save_session_time_Ma_console",
                  "Intervalle de sauvegarder des données (minutes) :",
                  min =1 ,
                  max =60*2 ,# 1heure * 2
                  value =5 ,
                  step =1 )
      
    ),
    
    # Box Sauvegarde Catalogue ---------------------------------------------------------
    box(
      title = 'Sauvegarde Module "Catalogue"',
      solidHeader = TRUE,
      
      sliderInput("sliderInput_save_session_time_Catalogue",
                  "Intervalle de sauvegarder des données (minutes) :",
                  min =1 ,
                  max =60*2 ,# 1heure * 2
                  value =60 ,
                  step =1 )
      
    )
    
  )#end tabItem

