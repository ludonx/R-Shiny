tabItem_Connexion<-
  tabItem(
    tabName = "Connexion",
    
    fluidRow(
      useShinyjs(),  # Include shinyjs
      
      column(4,""),
      column(6,
             box(title = "Connexion ", status = "primary", solidHeader = TRUE,
                 
                 textInput(inputId ="email" ,
                           label ="Email",
                           value = app$config$default_user_email
                             # if(app$config$default_authentification) 
                             #   app$config$default_user_email
                             # else{ paste("")}
                           ),
                 
                 passwordInput(inputId ="pwd" ,
                               label ="Mot de passe",
                               value =app$config$default_user_pwd
                                 # if(app$config$default_authentification) 
                                 #   app$config$default_user_pwd
                                 # else{ paste("")}
                               ),
                 br(),
                 actionButton(inputId = "ActionLogin",
                              label = "Valider",
                              icon("paper-plane"), 
                              style="color: #fff; background-color: #337ab7; border-color: #2e6da4"
                 )
             )
             
      ),
      column(2,"")
    )
    
  )#end tabItem
