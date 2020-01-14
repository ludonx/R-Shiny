
### action buttons 
output$uiAction_compar_cag_Les_MGS_projets<-renderUI({
  req(input$dataTable_merge_Les_MGS_projets_All_rows_selected)
  
  box(status = "danger",width = 12,
      
      
      actionButton(inputId = paste0("Action_barcode_compar_cag_Les_MGS_projets"),
                   label = "Bar Code",
                   icon("barcode"),
                   style="color: #fff; background-color: #af8e24; border-color: #af9524"
      ),
      actionButton(inputId = paste0("Action_boxplot_compar_cag_Les_MGS_projets"),
                   label = "box plot",
                   icon("box"),
                   style="color: #fff; background-color: #aa5db7; border-color: #904f9b"
      )
  )#end box
  
})#end output$uiAction_compar_cag_Les_MGS_projets

### uiplot_barcode_compar_cag_Les_MGS_projets
output$uiplot_barcode_compar_cag_Les_MGS_projets<-renderUI({
  req(input$Action_barcode_compar_cag_Les_MGS_projets)
  req(input$dataTable_merge_Les_MGS_projets_All_rows_selected)
  
  
  box(status = "success",width = 12,
      solidHeader = TRUE,collapsible = TRUE,collapsed = F,
      title = paste0("Bar code "),
      uiOutput("ui_config_barcode_compar_cag_Les_MGS_projets"),
      plotOutput("plot_barcode_compar_cag_Les_MGS_projets") %>% withSpinner(color="#0dc5c1")
  )#end box
})

### ui_config_barcode_compar_cag_Les_MGS_projets
output$ui_config_barcode_compar_cag_Les_MGS_projets<-renderUI({
  req(input$Action_barcode_compar_cag_Les_MGS_projets)
  choix_free<-c('none','free','free_x','free_y')
  #-----------------------------------------------#
  nbrMax<-length(names(dataMeltMerge_newProj()))
  choixInt<-c()
  choixChar<-c()
  for(j in 1:nbrMax){
    if(class(dataMeltMerge_newProj()[,names(dataMeltMerge_newProj())[j]])=="character"){
      choixChar<-append(choixChar,names(dataMeltMerge_newProj())[j])
    }else{
      choixInt<-append(choixInt,names(dataMeltMerge_newProj())[j])

    }

  }
  fluidRow(
    column(5,
           selectInput(inputId =paste0("selectStratificationChar_barcode_compar_cag_Les_MGS_projets") ,label ="Stratification via des variables Discrètes " ,choices =choixChar ,multiple = T)
           
    ),
    column(4,
           selectInput(inputId =paste0("selectFree_barcode_compar_cag_Les_MGS_projets") ,label ='<< scales >>' ,
                       choices =choix_free ,selected =choix_free[1],multiple = F)
    ),
    
    column(3,"")
  )
})

#### merge des CAG
dataFrameCAGmerge<-eventReactive(input$Action_barcode_compar_cag_Les_MGS_projets,{
  listeProjet<-globalInformation$user$projectSelected
  #listedatabaseProjet<-databaseProjectSelected
  dat<-dataFrameProjectMerge()[input$dataTable_merge_Les_MGS_projets_All_rows_selected,]
  cagName<-row.names(dat)
  dataFrameCAGmerge<-data.frame()
  dataProject2<-data.frame()
  
  listeDatabaseName<-c()
  listeCollection<-c()
  
  # Create a Progress object
  progress <- shiny::Progress$new()
  # Make sure it closes when we exit this reactive, even if there's an error
  on.exit(progress$close())
  progress$set(message = paste0("Récupération des données et merge : des ",cagName), value = 0)
  nbr<-length(listeProjet)+1
  for(n in 1:length(listeProjet)){
    
    progress$inc(1/nbr,detail = paste(listeProjet[n]," : listeDatabaseName"))
    
    dataProject2<-
      findQuery(
        globalInformation$globalDatabase,
        globalInformation$projectsCollections,
        myQueryUnique("name",listeProjet[n]))
    
    
    x<-dataProject2[1,"database"]
    listeDatabaseName<-append(listeDatabaseName,x)
    listeCollection<-append(listeCollection,cagName)
    #cat(cagName)

  }#end for
progress$inc(1/nbr,detail = paste(listeProjet[n],"merge des CAG"))
  
  dataFrameCAGmerge<-concatCollection(listeDatabaseName,listeCollection)
  
  dataFrameCAGmerge
})
#### commun colonne project
communColSamplemetadata<-eventReactive(input$Action_barcode_compar_cag_Les_MGS_projets,{
  listeProjet<-globalInformation$user$projectSelected
  
  communColSamplemetadata<-list()
  dataProject2<-data.frame()
  # Create a Progress object
  progress <- shiny::Progress$new()
  # Make sure it closes when we exit this reactive, even if there's an error
  on.exit(progress$close())
  progress$set(message = paste0("Récupération des colonnes communes à chaque projet: "), value = 0)
  nbr<-length(listeProjet)*2
  for(n in 1:length(listeProjet)){
    #local({
    progress$inc(1/nbr,detail = paste(listeProjet[n],"dataSampleMetaC"))
    
    dataProject2<-
      findQuery(
        globalInformation$globalDatabase,
        globalInformation$projectsCollections,
        myQueryUnique("name",listeProjet[n]))
    
    progress$inc(1/nbr,detail = paste(listeProjet[n],"intersect"))
    #dataCompar<-rbind(dataCompar,dataProject2)
    x<-dataProject2[1,"database"]
    
    
    dataSampleMetaC<-findLimit(
      x,
      paste("obs_samplemetadata",dataProject2[1,"version"],dataProject2[1,"name"],sep="_"),
      15
    )
    if(n==1){
      communColSamplemetadata<-colnames(dataSampleMetaC)
    }else{
      communColSamplemetadata<-intersect(communColSamplemetadata,colnames(dataSampleMetaC))
    }
    
    
    
    
    
  }#end for
  return(communColSamplemetadata)
})
#### rbind des projet
dataFrameSamplemetadata<-eventReactive(input$Action_barcode_compar_cag_Les_MGS_projets,{
  listeProjet<-globalInformation$user$projectSelected
  #listedatabaseProjet<-databaseProjectSelected
  dat<-dataFrameProjectMerge()[input$dataTable_merge_Les_MGS_projets_All_rows_selected,]
  cagName<-row.names(dat)
  dataFrameSamplemetadata<-data.frame()
  dataProject2<-data.frame()
  
  communColSamplemetadata<-list()
  
  # Create a Progress object
  progress <- shiny::Progress$new()
  # Make sure it closes when we exit this reactive, even if there's an error
  on.exit(progress$close())
  progress$set(message = paste0("Récupération des données et merge : des ",cagName), value = 0)
  nbr<-length(listeProjet)+1
  for(n in 1:length(listeProjet)){
    
    progress$inc(1/nbr,detail = paste(listeProjet[n]," : listeDatabaseName $ rbind"))
    
    dataProject2<-
      findQuery(
        globalInformation$globalDatabase,
        globalInformation$projectsCollections,
        myQueryUnique("name",listeProjet[n]))
    
    
    x<-dataProject2[1,"database"]
    
    proj<-findAll(x,paste("obs_samplemetadata",dataProject2[1,"version"],dataProject2[1,"name"],sep="_"))
    proj$projet<-listeProjet[n]
    if(n==1){
      communColSamplemetadata<-colnames(proj)
      dataFrameSamplemetadata<-proj
    }else{
      communColSamplemetadata<-intersect(communColSamplemetadata,colnames(proj))
      dataFrameSamplemetadata<-
        rbind(
          dataFrameSamplemetadata[,communColSamplemetadata],
          proj[,communColSamplemetadata]
        )
    }
    
  }#end for
  progress$inc(1/nbr,detail = paste(listeProjet[n],"merge des CAG"))
  
  
  dataFrameSamplemetadata
})


####### données pour le plot : 
#### 
##############
####### étape 1: je merge des data
dataMeltMerge_newProj<-reactive({
  
  progress <- shiny::Progress$new()
  # Make sure it closes when we exit this reactive, even if there's an error
  on.exit(progress$close())
  progress$set(message = paste0("Merge des data CAG et projet : "), value = 0)
  nbr<-2
  progress$inc(1/nbr)
  mydata<-myMeltMerge(dataFrameCAGmerge(),dataFrameSamplemetadata())
  
  progress$inc(1/nbr)
  return(mydata)
})
##############
####### étape 2: je defini le plot
plot_newProj<-reactive({
  progress <- shiny::Progress$new()
  # Make sure it closes when we exit this reactive, even if there's an error
  on.exit(progress$close())
  progress$set(message = paste0("Initialisation du bare code : "), value = 0)
  nbr<-2
  progress$inc(1/nbr)
  
  plot<-myBarcodePlot(dataMeltMerge_newProj())
  progress$inc(1/nbr)
  return(plot)
})


### uiplot_barcode_compar_cag_Les_MGS_projets
output$plot_barcode_compar_cag_Les_MGS_projets<-renderPlot({
  
  # Create a Progress object
  progress <- shiny::Progress$new()
  # Make sure it closes when we exit this reactive, even if there's an error
  on.exit(progress$close())
  progress$set(message = paste0("Aplication de la nouvelle configuration: "), value = 0)
  nbr<-3
  progress$inc(1/nbr)
  
  
  
  strat1<-input$selectStratificationChar_barcode_compar_cag_Les_MGS_projets
  strat<-c()
  if(length(strat1)>1){
    strat1<-input$selectStratificationChar_barcode_compar_cag_Les_MGS_projets[1]
    strat2<-input$selectStratificationChar_barcode_compar_cag_Les_MGS_projets[2]
    strat<-append(strat,strat1)
    strat<-append(strat,strat2)
  }else if(length(strat1)==1){
    strat1<-input$selectStratificationChar_barcode_compar_cag_Les_MGS_projets[1]
    strat<-append(strat,strat1)
  }
  progress$inc(1/nbr)
  
  plot<-myPlotStrat(dataMeltMerge_newProj(),plot_newProj(),strat,input$selectFree_barcode_compar_cag_Les_MGS_projets)
  
  
  progress$inc(1/nbr)
  #myBarcodePlot1(cag,proj,c("Time"))
  
  return(plot)
})