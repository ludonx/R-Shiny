serverGestion_des_projets<-
  function(input, output, session,globalInformation){
    
    observeEvent(input$ActionValider_ajout_collection,{
      req(input$JsonFile)
      req(input$text_collection_name_Gestion_des_projets)
      #req(input$test_projet_name_Gestion_des_projets)
      req(input$text_database_name_Gestion_des_projets)
      
      
      insertNewCollectionJson(input$text_database_name_Gestion_des_projets,input$text_collection_name_Gestion_des_projets)

    })
    
    output$tbl = renderDT({
      req(input$JsonFile)
      req(input$text_collection_name_Gestion_des_projets)
      #req(input$test_projet_name_Gestion_des_projets)
      req(input$text_database_name_Gestion_des_projets)
      findLimit(
        input$text_database_name_Gestion_des_projets,
        input$text_collection_name_Gestion_des_projets,
        100)
      
      # start_time_i<-Sys.time()
      # cat("\n limit = ",Sys.time()-start_time_i,'\n')
      # a
    })
  }