fluidRow(
  ##################### CONSOLE Ma_console ############################
  ####################################################### 
  #absolutePanel(
  #fixedPanel(
  #  bottom  = 5, right = 5, width = "100%",
    box(title = span( icon("file-code"),paste0(" Retour d'information (Feedback)")),
        background = "navy",
        solidHeader = T,collapsible = T,collapsed = T,
        width = 12,
        textAreaInput("Console_Ma_console",
                      NULL,
                      height = '300px')
        
    ),#end Box
  #),#end fixedPanel
  tags$head(tags$style(HTML('#Console_Ma_console{
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
        
        actionLink(inputId ="LinkMes_requetes_Ma_console" ,label ="* Mes requêtes" ),
        br(),
        actionLink(inputId ="LinkCatalogue_Ma_console" ,label ="* Catalogues" )
        # br(),
        # actionLink(inputId ="LinkCatalogue_Ma_console" ,label ="* Catalogues" )
    )#end Box
  )#end fixedPanel
  
)#end fluidRow