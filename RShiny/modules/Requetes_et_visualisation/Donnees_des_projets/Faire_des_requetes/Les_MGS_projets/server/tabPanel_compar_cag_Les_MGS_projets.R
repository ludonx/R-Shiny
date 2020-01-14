observeEvent(input$ActionCompar_les_project_Les_MGS_projets,{
  updateTabItems(
    session,
    inputId ="tabBox_Les_MGS_projets" ,
    selected = "tabPanel_compar_cag_Les_MGS_projets"
    )
  
})

## ui statistique
output$uitabPanel_compar_cag_Les_MGS_projets_Statistique<-renderUI({
  req(input$ActionCompar_les_project_Les_MGS_projets)
  div(
    fluidRow(
      column(6,
             box(
               status = "success", width = 12,
               fluidRow(
                 column(8,
                        withSpinner(DT::dataTableOutput(paste0("dataTable_merge_Les_MGS_projets_All")))
                 ),
                 column(4,uiOutput("uiCheckbox_tabPanel_compar_cag_Les_MGS_projets"))
               )#end fluidRow
              )#end box
      ),#end column
      
      column(6,uiOutput("uiStatistique_tabPanel_compar_cag_Les_MGS_projets"))
    ),
    fluidRow(uiOutput("uiAction_compar_cag_Les_MGS_projets")),
    fluidRow(uiOutput("uiplot_barcode_compar_cag_Les_MGS_projets"))
  )
 
})
### get data
#mylisteCollection<-reactiveValues(listeCollection="")
dataFrameProjectMerge<-eventReactive(input$ActionCompar_les_project_Les_MGS_projets,{
  listeProjet<-globalInformation$user$projectSelected
  #listedatabaseProjet<-databaseProjectSelected
  
  dataFrameProjectMerge<-data.frame()
  dataProject2<-data.frame()
  
  listeDatabaseName<-c()
  listeCollection<-c()
  
  # Create a Progress object
  progress <- shiny::Progress$new()
  # Make sure it closes when we exit this reactive, even if there's an error
  on.exit(progress$close())
  progress$set(message = paste0("Récupération des données pour comparaison: "), value = 0)
  nbr<-length(listeProjet)+1
  for(n in 1:length(listeProjet)){
    
    progress$inc(1/nbr,detail = paste(listeProjet[n],"listeDatabaseName & listeCollection"))
    
    dataProject2<-
      findQuery(
        globalInformation$globalDatabase,
        globalInformation$projectsCollections,
        myQueryUnique("name",listeProjet[n]))
    
    
    x<-dataProject2[1,"database"]
    listeDatabaseName<-append(listeDatabaseName,x)
    listeCollection<-append(listeCollection,paste("obs_mgs",dataProject2[1,"catalog"],dataProject2[1,"name"],sep="_"))
    #mylisteCollection$listeCollection<-listeCollection
    
  }#end for
  progress$inc(1/nbr,detail = paste(listeProjet[n],"merge des projets"))
  
  dataFrameProjectMerge<-concatCollection(listeDatabaseName,listeCollection)
  
  dataFrameProjectMerge
  
})
### data frame
output$dataTable_merge_Les_MGS_projets_All<- DT::renderDataTable({
  listCol<-input$Checkbox_tabPanel_compar_cag_Les_MGS_projets
  if(length(listCol)>1)
    DT::datatable(dataFrameProjectMerge()[,listCol],filter = 'top',selection = 'single')#
})

#### checkbox
output$uiCheckbox_tabPanel_compar_cag_Les_MGS_projets<-renderUI({
  if(nrow(dataFrameProjectMerge())==0){
    box(
      title = "ERREUR !! ", status = "danger", solidHeader = TRUE,
      collapsible = TRUE,collapsed = F, width = 12,
      paste0("ERREUR lors de la fussion des abundances de mgs : ",
             " certaines observation son probablement ")
    )#end box
  }else{
    box(
      title = "Les observations", status = "primary", solidHeader = TRUE,
      collapsible = TRUE,collapsed = F, width = 12,
      checkboxGroupInput("Checkbox_tabPanel_compar_cag_Les_MGS_projets", 
                         " ",
                         names(dataFrameProjectMerge()),
                         selected =colnames(dataFrameProjectMerge())[1:2]
      )
    )#end box
  }
  
  
})
##############################################################################
##############################################################################
### ui statistique
output$uiStatistique_tabPanel_compar_cag_Les_MGS_projets<-renderUI({
  box(
    status = "success", width = 12,
    fluidRow(
    column(9,
           withSpinner(DT::dataTableOutput(paste0("dataTable_statistique_merge_Les_MGS_projets_All")))
           ),
    column(3,uiOutput("uiCheckbox_statistique_tabPanel_compar_cag_Les_MGS_projets"))
    ),
    fluidRow(
      box(
        status = "danger", width = 12,
        uiOutput("uiStatistique_nouveau_projet_tabPanel_compar_cag_Les_MGS_projets")
        )
      
    )
  )
  
})


### 
### get data
dataFrameProjectMergeStatistique<-eventReactive(input$ActionCompar_les_project_Les_MGS_projets,{
  #mylisteCollection$listeCollection
  dataFrameProjectMergeStatistique<-
    findQuery(
      globalInformation$globalDatabase,
      globalInformation$collections,
      myQueryUniqueIN("project",globalInformation$user$projectSelected)
    )
  dataFrameProjectMergeStatistique
  
})
### data frame
output$dataTable_statistique_merge_Les_MGS_projets_All<- DT::renderDataTable({
  listCol<-input$Checkbox_statistique_tabPanel_compar_cag_Les_MGS_projets
  if(length(listCol)>1)
    DT::datatable(dataFrameProjectMergeStatistique()[,listCol],filter = 'top',selection = 'single')#
})

#### checkbox
output$uiCheckbox_statistique_tabPanel_compar_cag_Les_MGS_projets<-renderUI({
  if(nrow(dataFrameProjectMergeStatistique())==0){
    box(
      title = "ERREUR !! ", status = "danger", solidHeader = TRUE,
      collapsible = TRUE,collapsed = F, width = 12,
      paste0("ERREUR lors de la fussion des abundances de mgs : ",
             " certaines observation son probablement ")
    )#end box
  }else{
    box(
      title = "Les variables ", status = "primary", solidHeader = TRUE,
      collapsible = TRUE,collapsed = F, width = 12,
      checkboxGroupInput("Checkbox_statistique_tabPanel_compar_cag_Les_MGS_projets", 
                         " ",
                         names(dataFrameProjectMergeStatistique()),
                         selected =colnames(dataFrameProjectMergeStatistique())[1:2]
      )
    )#end box
  }
  
  
})
output$uiStatistique_nouveau_projet_tabPanel_compar_cag_Les_MGS_projets<-renderText({
  paste("<font color=\"#7c4f9b\"><b>", "Les données du nouveau projets : ", "</b></font>")
})