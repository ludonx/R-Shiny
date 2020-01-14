#dataTable_user
serverVisualisation_des_collections<-
  function(input, output, session,globalInformation){
    ## declaration de variable ----
    data <- reactiveValues(list_collection=data.frame())
    
    ## recuperation des données ---- 
    ## ** via le bouton reset ----
    dataFrameCollection<-eventReactive(input$ActionReset_vdc,{
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Récupération de la liste des collections", value = 0)
      
      data<-findAll(globalInformation$globalDatabase,globalInformation$collections)
      data$list_collection <- data
      progress$inc(1)
      return(data)
    })
    # observeEvent(input$ActionReset_vdc,{
    #   # Create a Progress object
    #   progress <- shiny::Progress$new()
    #   # Make sure it closes when we exit this reactive, even if there's an error
    #   on.exit(progress$close())
    #   progress$set(message = "Récupération de la liste des collections", value = 0)
    #   
    #   data<-findAll(globalInformation$globalDatabase,globalInformation$collections)
    #   data$list_collection <- data
    #   progress$inc(1)
    # })
    
    ## ** lors de la connection ----
    # dataFrameCollection<-reactive({
    #   # Create a Progress object
    #   progress <- shiny::Progress$new()
    #   # Make sure it closes when we exit this reactive, even if there's an error
    #   on.exit(progress$close())
    #   progress$set(message = "Récupération de la liste des collections", value = 0)
    #   
    #   data<-findAll(globalInformation$globalDatabase,globalInformation$collections)
    #   data$list_collection <- data
    #   progress$inc(1)
    #   return(data)
    # })
    
    #### affichage des données ----
    output$dataTable_collections_vdc<- DT::renderDataTable({
      #cat("\nnrow : ",nrow(data$list_collection))
      DT::datatable(dataFrameCollection(), 
                    filter = 'top',selection = 'single' # voir la doc dur DT:: table shiny
      ) 
    })
    
    #### affichage du resultat ----
    ## ** recap des resultat ----
    output$verbatim_res_vdc <- renderText({
      req(input$dataTable_collections_vdc_rows_selected)
      i <- input$dataTable_collections_vdc_rows_selected
      #data_selected <- data$list_collection[i,]
      data_selected <- dataFrameCollection()[i,]
      
      name <- paste0("\nname :",data_selected[1,"name"])
      col <- paste0("\nnumber of columns :",data_selected[1,"number_columns"])
      line <- paste0("\nnumber of lines :",data_selected[1,"number_lines"])
      size <- paste0("\nsize :",data_selected[1,"size"])
      type <- paste0("\ntype :",data_selected[1,"type"])
      
      return(paste0(name,col,line,size,type))
    })
    
    ## ** data frame des resultats 
    output$dataTable_collections_vue_vdc<- DT::renderDataTable({
      req(input$dataTable_collections_vdc_rows_selected)
      i <- input$dataTable_collections_vdc_rows_selected
      #data_selected <- data$list_collection[i,]
      data_selected <- dataFrameCollection()[i,]
      
      # cat("\nnrow : ",nrow(data$list_collection))
      # cat("\nnrow data_selected : ",nrow(data_selected))
      # cat("\nnames : ",length(names(data_selected)))
      data_to_display <- findLimit(databaseName =data_selected[1,"database"] ,collectionName =data_selected[1,"name"] ,limit = 50)
      DT::datatable(data_to_display,
                    filter = 'top',selection = 'single' # voir la doc dur DT:: table shiny
      )
    })
   
    ## delete collection ----
    observeEvent(input$ActionDelete_collections_vdc,{
      req(input$dataTable_collections_vdc_rows_selected)
      
      if(input$textInput_pwd_vdc=="123456789"){
        i <- input$dataTable_collections_vdc_rows_selected
        data_selected <- dataFrameCollection()[i,]
        
        db <- loadDataBase(globalInformation$globalDatabase,globalInformation$collections)
        db$remove(paste0('{"name" : "',data_selected[1,"name"],'"}'))
        
        db <- loadDataBase(globalInformation$globalDatabase,data_selected[1,"database"])
        db$drop()
        
      }
      
    })
   
   
    
    
  }