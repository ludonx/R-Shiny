

###### Link vers Mes requêtes
observeEvent(input$LinkMes_requetes_Les_Genes,{
  updateTabItems(session,inputId = "mainMenu",selected ="Mes_requetes" )
  
})

###### Link vers Ma_console
observeEvent(input$LinkMa_console_Les_Genes,{
  updateTabItems(session,inputId = "mainMenu",selected ="Ma_console" )
  
})