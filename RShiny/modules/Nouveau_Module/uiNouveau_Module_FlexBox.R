fluidRow(
  ##################### CONSOLE Nouveau_Module ############################
  ####################################################### 
  fixedPanel(
    bottom  = 5, right = 10, width = "45%",
    box(title = span( icon("file-code"),paste0(" Retour d'information (Feedback)")),
        background = "navy",
        solidHeader = T,collapsible = T,collapsed = T,
        width = 12,
        textAreaInput(inputId = "Console_Nouveau_Module",
                      label = NULL,
                      height = '300px'
                      )
        
    )#end Box
  ),#end fixedPanel
  tags$head(tags$style(HTML('#Console_Nouveau_Module{
                            background-color: #181918 ;color: #2d992d;
                            font-family: "Lucida Console";border: none;
                            }'))),
  
  ##################### MENU ############################
  ####################################################### 
  
  fixedPanel(
    draggable=T,
    top  = 500, right  = 10, width = "15%",
    box(title = span( icon("bars"),paste0(" Raccourci Menu")), 
        solidHeader = T, collapsible = T, collapsed = F, width = 12,
        
        actionLink(inputId ="LinkMes_requetes_Nouveau_Module" ,label ="* Mes requêtes" ),
        br(),
        actionLink(inputId ="LinkCatalogue_Nouveau_Module" ,label ="* Catalogues" ),
        br(),
        actionLink(inputId ="LinkMa_console_Nouveau_Module" ,label ="* Ma console" ),
        br()
        # br(),
        # actionLink(inputId ="LinkCatalogue_Ma_console" ,label ="* Catalogues" )
    )#end Box
  )#end fixedPanel
  
  )#end fluidRow