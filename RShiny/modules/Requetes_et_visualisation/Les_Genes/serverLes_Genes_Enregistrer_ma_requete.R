
############################### ENREGISTRE MA REQUETE ################################ 
######################################################################################


####### data frame
output$data_frame_ma_requete_Les_Genes<-DT::renderDataTable({
  mySelectDf<-globalInformation$modules$Catalogue$dataFrameRequete
  DT::datatable(mySelectDf,filter = 'top',selection = 'none',editable = TRUE)
})

####### sauvegarder ma requête
observeEvent(input$ActionSave_ma_requete_Les_Genes,{
  req(input$textinput_name_ma_requete_Les_Genes)
  req(input$textinput_type_ma_requete_Les_Genes)
  req(input$textinput_name_list_data_save_Les_Genes)
  
  # Create a Progress object
  progress <- shiny::Progress$new()
  # Make sure it closes when we exit this reactive, even if there's an error
  on.exit(progress$close())
  progress$set(message = "Sauvegarde de [Catalogue]", value = 0)
  progress$inc(1/2)
  
  
  fileName<-input$textinput_name_list_data_save_Les_Genes
  
  
  pathUser<-globalInformation$user$path
  dir_Catalogue<-paste(pathUser,"Catalogue",globalInformation$modules$Catalogue$CatalogSelected,sep="/")
  if(!dir.exists(dir_Catalogue)){
    dir.create(dir_Catalogue,recursive = T)
  }
  
  
  
  ### file_Catalogue_variables
  file_Catalogue_variables<-paste(dir_Catalogue,paste0(fileName,".rds"),sep="/")
  file_Catalogue_variables2<-paste("Catalogue",globalInformation$modules$Catalogue$CatalogSelected,paste0(fileName,".rds"),sep="/")
  if(file.exists(file_Catalogue_variables)){
    #file_Catalogue_variables<-paste(dir_Catalogue,paste0(fileName,"_new.rds"),sep="/")
    #file_Catalogue_variables2<-paste("Catalogue",globalInformation$modules$Catalogue$CatalogSelected,paste0(fileName,"_new.rds"),sep="/")
  }
  
  
  # sauvegarde des requêtes -----------------------------------------------------------------------------
  
  df<-globalInformation$modules$Catalogue$dataFrameRequete
  df$user<-globalInformation$user$email
  df$type<-input$textinput_type_ma_requete_Les_Genes
  df$name<-input$textinput_name_ma_requete_Les_Genes
  df$description<-input$textinput_description_ma_requete_Les_Genes
  df$nameDataFile <- file_Catalogue_variables2
  
  
  reorderCol<-append(c("user","type", "name","description","nameDataFile"),colnames(globalInformation$modules$Catalogue$dataFrameRequete))
  #cat(colnames(df))
  df<-df[reorderCol]
  
  globalInformation$modules$Catalogue$dataFrameMesRequetes<-rbind(globalInformation$modules$Catalogue$dataFrameMesRequetes,df)
  
 
  
  # sauvegarde sur disque -----------------------------------------------------------------------------
  
  
  globalInformation$modules$Catalogue$variables<-
    list(
      CatalogSelected=globalInformation$modules$Catalogue$CatalogSelected,
      defSelected=globalInformation$modules$Catalogue$defSelected,
      listSaveDataFrame=globalInformation$modules$Catalogue$listSaveDataFrame,
      dataFrameContrainte=globalInformation$modules$Catalogue$dataFrameContrainte,
      dataFrameRequete=globalInformation$modules$Catalogue$dataFrameRequete,
      dataFrameMesRequetes=globalInformation$modules$Catalogue$dataFrameMesRequetes,
      dataFrameCollectionData=globalInformation$modules$Catalogue$dataFrameCollectionData,
      dataFrameCollectionDataValider=globalInformation$modules$Catalogue$dataFrameCollectionDataValider
    )
  
  ## save in Mes_requetes -------------------------------------
  dir_Mes_requetes<-paste(pathUser,"Mes_requetes",sep="/")
  if(!dir.exists(dir_Mes_requetes)){
    dir.create(dir_Mes_requetes,recursive = T)
  }
  
  ### file_Mes_requetes_variables
  file_Mes_requetes_variables<-paste(dir_Mes_requetes,"Mes_requetes.rds",sep="/")
  if(file.exists(file_Mes_requetes_variables)){
    data_req<-readRDS(file =file_Mes_requetes_variables)
    testDataFrame<-requeteExiste(data_req, globalInformation$modules$Catalogue$dataFrameMesRequetes)
    cat(testDataFrame)
    if(testDataFrame == T)
    {
      output$uiERROR_ActionSave_ma_requete_Les_Genes <- 
      renderText({
        paste("<font color=\"#cf2141\"><b>", "Enregistrement Impossible !!, merci de modifier le nom de la requête ou le nom du fichier de sauvegarde", "</b></font>")
      })
      globalInformation$Console<-paste0(globalInformation$Console,"Enregistrement Impossible !!, merci de modifier le nom de la requête ou le nom du fichier de sauvegarde\n")
      
    }else
    {
      globalInformation$modules$Catalogue$dataFrameMesRequetes<-rbind(data_req,globalInformation$modules$Catalogue$dataFrameMesRequetes)
    
      saveRDS(globalInformation$modules$Catalogue$variables,file =file_Catalogue_variables)
      saveRDS(globalInformation$modules$Catalogue$dataFrameMesRequetes,file =file_Mes_requetes_variables)
      globalInformation$Console<-paste0(globalInformation$Console,"\n>> ",fileName,"_new.rds [OK] \n")
      
      output$uiERROR_ActionSave_ma_requete_Les_Genes <- renderText({
        paste("<font color=\"#36aa7a\"><b>", "Enregistrement effectuer !", "</b></font>")
      })
    }
  }else{
    saveRDS(globalInformation$modules$Catalogue$variables,file =file_Catalogue_variables)
    saveRDS(globalInformation$modules$Catalogue$dataFrameMesRequetes,file =file_Mes_requetes_variables)
    globalInformation$Console<-paste0(globalInformation$Console,"\n>> ",fileName,"_new.rds [OK] \n")
    
  }
  #cat('----',nrow(globalInformation$modules$Catalogue$dataFrameMesRequetes))
  
  #globalInformation$modules$Catalogue$time<-Sys.time()
  progress$inc(1/2)
}) 


#### Config pour gerer les modification du data frame

proxy_data_frame_ma_requete_Les_Genes = dataTableProxy('data_frame_ma_requete_Les_Genes')

observeEvent(input$data_frame_ma_requete_Les_Genes_cell_edit, {
  info = input$data_frame_ma_requete_Les_Genes_cell_edit
  #str(info)
  i = info$row
  j = info$col
  v = info$value
  globalInformation$modules$Catalogue$dataFrameRequete[i, j] <<- DT::coerceValue(v, globalInformation$modules$Catalogue$dataFrameRequete[i, j])
  replaceData(proxy_data_frame_ma_requete_Les_Genes, globalInformation$modules$Catalogue$dataFrameRequete, resetPaging = FALSE)  # important
})


