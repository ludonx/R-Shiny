serverMes_requetes<-
  function(input, output, session,globalInformation){
    ### on recupere la liste des requetes ---------------------------------------
    observeEvent(input$ActionActualiser_Mes_requetes,{
      dataFrameMesRequetes<-data.frame()
      pathUser<-globalInformation$user$path
      dir_Mes_requetes<-paste(pathUser,"Mes_requetes",sep="/")
      if(!dir.exists(dir_Mes_requetes)){
        dir.create(dir_Mes_requetes,recursive = T)
      }
      
      ### file_Mes_requetes_variables
      file_Mes_requetes_variables<-paste(dir_Mes_requetes,"Mes_requetes.rds",sep="/")
      if(file.exists(file_Mes_requetes_variables)){
        dataFrameMesRequetes<-readRDS(file=file_Mes_requetes_variables)
      }
      globalInformation$modules$Mes_requetes$dataFrameMesRequetes<-dataFrameMesRequetes
      
    })
    ####### data frame dataFrameMesRequetes
    output$data_frame_mes_requetes_Mes_requetes<-DT::renderDataTable({
      #globalInformation$modules$Mes_requetes$dataFrameMesRequetes_distinct<-globalInformation$modules$Mes_requetes$dataFrameMesRequetes
      if(nrow(globalInformation$modules$Mes_requetes$dataFrameMesRequetes)>0){
        # colNotTodisplay<-c("collection","requete","nbrElemRequete")
        # colTodisplay<-setdiff(colnames(globalInformation$user$dataFrameMesRequetes),colNotTodisplay)
        # 
        # #as.vector(unlist(strsplit(str,",")),mode="list")
        # 
        # rowTodisplay<-(globalInformation$user$dataFrameMesRequetes["user"]==globalInformation$user$email)
        # #globalInformation$user$dataFrameMesRequetes_distinct<-distinct(globalInformation$user$dataFrameMesRequetes[rowTodisplay,colTodisplay])
        # 
        # mySelectDf<-globalInformation$user$dataFrameMesRequetes_distinct[rowTodisplay,colTodisplay]
        # DT::datatable(mySelectDf,filter = 'top',selection = 'single',editable = TRUE)
        # 
        colNotTodisplay<-c("user","type", "name","description","nameDataFile") #c("collection","requete","nbrElemRequete")
        colTodisplay<-setdiff(colnames(globalInformation$modules$Mes_requetes$dataFrameMesRequetes),colNotTodisplay)
        
        #as.vector(unlist(strsplit(str,",")),mode="list")
        
        #rowTodisplay<-(globalInformation$modules$Catalogue$dataFrameMesRequetes["user"]==globalInformation$user$email)
        rowTodisplay<-!duplicated(globalInformation$modules$Mes_requetes$dataFrameMesRequetes[c("user","type","requete")])
        #globalInformation$user$dataFrameMesRequetes_distinct<-distinct(globalInformation$user$dataFrameMesRequetes[rowTodisplay,])
        
        #mySelectDf<-globalInformation$modules$Mes_requetes$dataFrameMesRequetes[rowTodisplay,]
        mySelectDf <- globalInformation$modules$Mes_requetes$dataFrameMesRequetes 
        # ou globalInformation$modules$Mes_requetes$dataFrameMesRequetes <- mySelectDf # non pas bon
        DT::datatable(mySelectDf,filter = 'top',selection = 'single',editable = TRUE)
      }
      
    })
    
    ####### set data
    observeEvent(input$data_frame_mes_requetes_Mes_requetes_rows_selected,{
      req(input$ActionActualiser_Mes_requetes)
      colNotTodisplay<-c("user","type", "name","description","nameDataFile")
      colTodisplay<-setdiff(colnames(globalInformation$modules$Mes_requetes$dataFrameMesRequetes),colNotTodisplay)
      
      rowSelected<-globalInformation$modules$Mes_requetes$dataFrameMesRequetes[input$data_frame_mes_requetes_Mes_requetes_rows_selected,"name"]
      #(globalInformation$modules$Mes_requetes$dataFrameMesRequetes["user"]==globalInformation$modules$Mes_requetes$email)&

      rowTodisplay<-((globalInformation$modules$Mes_requetes$dataFrameMesRequetes["name"]==rowSelected))
      globalInformation$modules$Mes_requetes$dataFrameRequeteMaRequete<-globalInformation$modules$Mes_requetes$dataFrameMesRequetes[rowTodisplay,colTodisplay]
   
      
      file_Catalogue_variables<-globalInformation$modules$Mes_requetes$dataFrameMesRequetes[input$data_frame_mes_requetes_Mes_requetes_rows_selected,"nameDataFile"]
      pathUser<-globalInformation$user$path
      file_Catalogue_variables<-paste(pathUser,file_Catalogue_variables,sep="/")
      #cat(file_Catalogue_variables,'---')
      var_catalogue<-readRDS(file=file_Catalogue_variables)
      globalInformation$modules$Mes_requetes$listSaveDataFrame<-var_catalogue$listSaveDataFrame
      
    })
    ####### data frame dataFrameMaRequeteSelected
    output$data_frame_ma_requete_Mes_requetes<-DT::renderDataTable({
      #req(input$data_frame_mes_requetes_Mes_requetes_rows_selected)
      
      mySelectDf<-globalInformation$modules$Mes_requetes$dataFrameRequeteMaRequete
      DT::datatable(mySelectDf,filter = 'top',selection = 'none',editable = TRUE)
    })
    #### Config pour gerer les modification du data frame

    proxy_data_frame_ma_requete_Mes_requetes = dataTableProxy('data_frame_ma_requete_Mes_requetes')

    observeEvent(input$data_frame_ma_requete_Mes_requetes_cell_edit, {
      info = input$data_frame_ma_requete_Mes_requetes_cell_edit
      #str(info)
      i = info$row
      j = info$col
      v = info$value
      globalInformation$modules$Mes_requetes$dataFrameRequeteMaRequete[i, j] <<- DT::coerceValue(v, globalInformation$modules$Mes_requetes$dataFrameRequeteMaRequete[i, j])
      replaceData(proxy_data_frame_ma_requete_Mes_requetes, globalInformation$modules$Mes_requetes$dataFrameRequeteMaRequete, resetPaging = FALSE)  # important
    })
    ###### bouton executer la requête selectionnée
    ############################## GENERER LE DATA FRAME COMPLET ######################### 
    ######################################################################################
    observeEvent(input$ActionExecuter_ma_requete_Mes_requetes,{
      req(input$data_frame_mes_requetes_Mes_requetes_rows_selected)
      
      myDataRequete<-globalInformation$modules$Mes_requetes$dataFrameRequeteMaRequete
      mydata<-data.frame()
      
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      #progress$set(message = paste0("requete sur l'ensemble les collections : ",collectionName), value = 0)
      progress$set(message = paste0("requête sur l'ensemble les collections : "), value = 0)
      nbr<-1 +nrow(myDataRequete)
      progress$inc(1/nbr)
      
      resultatQueries <- 
        executerQueriesDataFrame(globalInformation$globalDatabase,
                                 globalInformation$jointuresCollections,
                                 NULL,
                                 globalInformation$modules$Mes_requetes$dataFrameRequeteMaRequete)
      
 
      globalInformation$modules$Mes_requetes$listSaveDataFrame<-resultatQueries$listSaveDataFrame
      #dataFrameRequete<-resultatQueries$dataFrameRequete
     
      
      
    })
    
    ## uiselect_data_to_display_Mes_requetes ---------------------------------------------------------
    output$uiselect_data_to_display_Mes_requetes<-renderUI({
      choices<-names(globalInformation$modules$Mes_requetes$listSaveDataFrame)
      if(length(choices)<=0)choices=c()
      selectInput(inputId ="select_data_to_display_Mes_requetes" ,
                  label =paste0('Selectionner un data frame :') ,
                  choices = choices,
                  
                  multiple = F)
    })
    ###### data_frame_resultat_ma_requete_Mes_requetes
    output$data_frame_resultat_ma_requete_Mes_requetes<-DT::renderDataTable({
      req(input$select_data_to_display_Mes_requetes)
      
      mySelectDf<-globalInformation$modules$Mes_requetes$listSaveDataFrame[[input$select_data_to_display_Mes_requetes]]
      if(!is.null(mySelectDf)){
        DT::datatable(mySelectDf,filter = 'top',selection = 'none')
      }
      
    })
    
    
    
  }