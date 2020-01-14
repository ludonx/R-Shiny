#dataTable_user
serverGenes_Abundance<-
  function(input, output, session,globalInformation){
    ## uiselect_catalog_Genes_Abundance ----
    ### on recupere la liste des catalogues
    dataFrameCatalog<-reactive({
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Récupération de la liste des catalogues", value = 0)
      progress$inc(1/2)
      data<-findAll(globalInformation$globalDatabase,globalInformation$catalogCollections)
      
      progress$inc(1/2)
      return(data)
    })
    
    ### on selection un catalog
    output$uiselect_catalog_Genes_Abundance<-renderUI({
      choices="Pas de catalogue !!"
      if(nrow(dataFrameCatalog())>0)choices = dataFrameCatalog()[,"name"]
      
      selectInput(inputId ="select_catalog_Genes_Abundance" ,
                  label ="Sélectionner un catalogue : " ,
                  choices = choices,
                  selected =choices[1],
                  multiple = F)
    })
    
    
    ## Data Genes Abundance --------------------------------------------------------------------------
    ## ** uiselect_list_data_save_Genes_Abundance ----
    dataListDataSave<-reactive({
      ### file_Catalogue_variables
      pathUser<-globalInformation$user$path
      dir_Catalogue<-paste(pathUser,"Catalogue",input$select_catalog_Genes_Abundance,sep="/")
      return(dir(dir_Catalogue))
      
    })
    
    output$uiselect_list_data_save_Genes_Abundance<- renderUI({
      req(input$select_catalog_Genes_Abundance)
      choices="Pas de requêtes sauvegardé !!"
      if(length(dataListDataSave())>0) choices <- dataListDataSave()
      
      selectInput(inputId ="select_list_data_save_Genes_Abundance" ,
                  label ="Sélectionner une requête sauvegardé : " ,
                  choices = choices,
                  selected =choices[1],
                  multiple = F)
    })
    
    ## ** uiselect_dataframe_save_Genes_Abundance ----
    dataFrameSave<-reactive({
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Récupération des projets", value = 0)
      progress$inc(1/2)
      
      ### file_Catalogue_variables
      pathUser<-globalInformation$user$path
      dir_Catalogue<-paste(pathUser,"Catalogue",input$select_catalog_Genes_Abundance,sep="/")
      file_Catalogue_variables<-paste(dir_Catalogue,input$select_list_data_save_Genes_Abundance,sep="/")
      if(!file.exists(file_Catalogue_variables)){
        progress$inc(1/2)
        return(list())
      }
      
      
      
      liste_var <- readRDS(file =file_Catalogue_variables)
      if((!is.null(liste_var$CatalogSelected)) && liste_var$CatalogSelected==input$select_catalog_Genes_Abundance){
        progress$inc(1/2)
        return(liste_var$listSaveDataFrame)
      }else{
        progress$inc(1/2)
        return(list())
      }
      
    })
    
    output$uiselect_dataframe_save_Genes_Abundance<- renderUI({
      req(input$select_list_data_save_Genes_Abundance)
      choices="Pas de dataframe !!"
      if(length(dataFrameSave())>0) choices <- names(dataFrameSave())
      
      selectInput(inputId ="select_dataframe_save_Genes_Abundance" ,
                  label ="Sélectionner un data frame sauvegardé : " ,
                  choices = choices,
                  selected =choices[1],
                  multiple = F)
    })
    
    ## ** data_frame_save_Genes_Abundance ----
    output$data_frame_save_Genes_Abundance <- DT::renderDataTable({
      req(input$select_dataframe_save_Genes_Abundance)
      if(!is.null(dataFrameSave()[[input$select_dataframe_save_Genes_Abundance]])){
        DT::datatable(dataFrameSave()[[input$select_dataframe_save_Genes_Abundance]],filter = 'top',selection = 'none')
      }
      
    })
    
    ## Data SampleMetadata ------------------------------------------------------------------------------
    ## ** uiselect_list_data_save_Samplemetadata_Genes_Abundance ----
    dataListDataSave_Samplemetadata<-reactive({
      ### file_Catalogue_variables
      pathUser<-globalInformation$user$path
      dir_Catalogue<-paste(pathUser,"Catalogue",input$select_catalog_Genes_Abundance,sep="/")
      return(dir(dir_Catalogue))
      
    })
    
    output$uiselect_list_data_save_Samplemetadata_Genes_Abundance<- renderUI({
      req(input$select_catalog_Genes_Abundance)
      choices="Pas de requêtes sauvegardé !!"
      if(length(dataListDataSave_Samplemetadata())>0) choices <- dataListDataSave_Samplemetadata()
      
      selectInput(inputId ="select_list_data_save_Samplemetadata_Genes_Abundance" ,
                  label ="Sélectionner une requête sauvegardé : " ,
                  choices = choices,
                  selected =choices[1],
                  multiple = F)
    })
    
    ## ** uiselect_dataframe_save_Samplemetadata_Genes_Abundance ----
    dataFrameSave_Samplemetadata<-reactive({
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Récupération des projets", value = 0)
      progress$inc(1/2)
      
      ### file_Catalogue_variables
      pathUser<-globalInformation$user$path
      dir_Catalogue<-paste(pathUser,"Catalogue",input$select_catalog_Genes_Abundance,sep="/")
      file_Catalogue_variables<-paste(dir_Catalogue,input$select_list_data_save_Samplemetadata_Genes_Abundance,sep="/")
      if(!file.exists(file_Catalogue_variables)){
        progress$inc(1/2)
        return(list())
      }
      
      
      
      liste_var <- readRDS(file =file_Catalogue_variables)
      if((!is.null(liste_var$CatalogSelected)) && liste_var$CatalogSelected==input$select_catalog_Genes_Abundance){
        progress$inc(1/2)
        return(liste_var$listSaveDataFrame)
      }else{
        progress$inc(1/2)
        return(list())
      }
      
    })
    
    output$uiselect_dataframe_save_Samplemetadata_Genes_Abundance<- renderUI({
      req(input$select_list_data_save_Samplemetadata_Genes_Abundance)
      choices="Pas de dataframe !!"
      if(length(dataFrameSave_Samplemetadata())>0) choices <- names(dataFrameSave_Samplemetadata())
      
      selectInput(inputId ="select_dataframe_save_Samplemetadata_Genes_Abundance" ,
                  label ="Sélectionner un data frame sauvegardé : " ,
                  choices = choices,
                  selected =choices[1],
                  multiple = F)
    })
    
    ## ** data_frame_save_Samplemetadata_Genes_Abundance ----
    output$data_frame_save_Samplemetadata_Genes_Abundance <- DT::renderDataTable({
      req(input$select_dataframe_save_Samplemetadata_Genes_Abundance)
      if(!is.null(dataFrameSave_Samplemetadata()[[input$select_dataframe_save_Samplemetadata_Genes_Abundance]])){
        DT::datatable(dataFrameSave_Samplemetadata()[[input$select_dataframe_save_Samplemetadata_Genes_Abundance]],filter = 'top',selection = 'none')
      }
      
    })
    
    
    
    ## data_frame_resultat_Genes_Abundance ----
    dataFrameJointure<-eventReactive(input$ActionSave_joint_data_Genes_Abundance,{
      
      dataFrameJointure<-data.frame()
      
      dataGeneAbundance<-dataFrameSave()[[input$select_dataframe_save_Genes_Abundance]]
      currente_colnames<-colnames(dataGeneAbundance)
      rownamesToMatch<-row.names(dataFrameSave_Samplemetadata()[[input$select_dataframe_save_Samplemetadata_Genes_Abundance]])
      
      colnamesToMatch<-intersect(currente_colnames,rownamesToMatch)
      
      if(length(colnamesToMatch)>0)
      {
        dataFrameJointure<-dataGeneAbundance[,colnamesToMatch]
        ## on sauvegarde les données
        pathUser<-globalInformation$user$path
        dir_Genes_Abundance<-paste(pathUser,"Genes_Abundance",sep="/")
        if(!dir.exists(dir_Genes_Abundance)){
          dir.create(dir_Genes_Abundance,recursive = T)
        }
        
        
        globalInformation$modules$Genes_Abundance$variables<-list(
          globalInformation$modules$Genes_Abundance$datajointure
        )
        ### file_Genes_Abundance_variables
        file_Genes_Abundance_variables<-paste(dir_Genes_Abundance,"list_Genes_Abundance_variables.rds",sep="/")
        saveRDS(globalInformation$modules$Genes_Abundance$variables,file =file_Genes_Abundance_variables)
        
        file_Genes_Abundance_datajointure <- paste(dir_Genes_Abundance,paste0(input$textinput_joint_data_Patient_analyses,".rds"),sep="/")
        saveRDS(globalInformation$modules$Genes_Abundance$datajointure,file =file_Genes_Abundance_datajointure)
      }else{
        updateTextInput(session,
                        inputId = "textinput_joint_data_Genes_Abundance",
                        value = "Incorrect Match :(")
      }

      return(dataFrameJointure)
    })
    
    output$data_frame_resultat_Genes_Abundance <- DT::renderDataTable({
      #req(input$)
      DT::datatable(dataFrameJointure(),filter = 'top',selection = 'none')
    })
    
   
    
  }#end 

