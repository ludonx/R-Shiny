tabItem_Accueil<-
  tabItem(
    tabName = "Accueil",
    
    fluidPage(
      # tags$img(src='context.png'),
      # tags$img(src='objectif.png'),
      
      verbatimTextOutput(outputId = "recap_projet_Accueil")
    )
    
  )#end tabItem

