

###### Link vers Mes requêtes
observeEvent(input$LinkMes_requetes_Ma_console,{
  updateTabItems(session,inputId = "mainMenu",selected ="Mes_requetes" )
  
})

###### Link vers Catalogue
observeEvent(input$LinkCatalogue_Ma_console,{
  updateTabItems(session,inputId = "mainMenu",selected ="Les_Genes" )
  
})