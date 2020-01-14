

###### Link vers Mes requêtes
observeEvent(input$LinkMes_requetes_Nouveau_Module,{
  updateTabItems(session,inputId = "mainMenu",selected ="Mes_requetes" )
  
})
###### Link vers Catalogue
observeEvent(input$LinkCatalogue_Nouveau_Module,{
  updateTabItems(session,inputId = "mainMenu",selected ="Les_Genes" )
  
})
###### Link vers Ma_console
observeEvent(input$LinkMa_console_Nouveau_Module,{
  updateTabItems(session,inputId = "mainMenu",selected ="Ma_console" )
  
})