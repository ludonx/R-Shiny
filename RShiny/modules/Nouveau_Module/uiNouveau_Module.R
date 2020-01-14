tabItem_Nouveau_Module <-
  tabItem(
    tabName = "Nouveau_Module",
    h5("> Nouveau Module"),
    br(),
    fluidPage(
      paste0(">> Bonjour je suis un nouveau Module"),
      ### FlexBox.R  #Menu
      
      
      ### Mon code ici 
      fluidRow(
        column(6,"col1"
        ),#end column
        column(6,"col2"
        )#end column
      ),#end fluidRow
      
      source(
        file.path(
          paste0(app$config$pathToModule,"Nouveau_Module"),
          "uiNouveau_Module_FlexBox.R"),
        local = TRUE)$value
    )#end fluidPage
  )#end tabItem