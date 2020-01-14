
serverSelection_de_projets<-
  function(input, output, session,globalInformation){
    
    dataFrameCatalog<-reactive({
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Récupération des catalogues", value = 0)
      
      data<-findAll(globalInformation$globalDatabase,globalInformation$catalogCollections)
      
      progress$inc(1)
      return(data)
    })
    output$dataTable_catalog<- DT::renderDataTable({
      listCol<-c()
      # si le data frame contient des valeurs, on affiche uniquement les colonnes 1 et 2
      if(nrow(dataFrameCatalog())>0)listCol<-c("name","database")
      DT::datatable(dataFrameCatalog()[,listCol],
                    filter = 'top',selection = 'single' # voir la doc dur DT:: table shiny
      ) 
    })
    
    ############################################################################
    dataFrameProject<-eventReactive(input$dataTable_catalog_rows_selected,{
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Récupération des projets", value = 0)
      
      #data<-findAll(globalInformation$globalDatabase,globalInformation$projectsCollections)
      data<-
        getProjectUser(
          globalInformation$globalDatabase,
          globalInformation$usersCollections,
          globalInformation$projectsCollections,
          globalInformation$user$email,
          dataFrameCatalog()[input$dataTable_catalog_rows_selected,"name"]
          )
      
      progress$inc(1)
      return(data)
    })
    output$dataTable_project_Selection_de_projets<- DT::renderDataTable({
      
      # si le data frame contient des valeurs, on affiche uniquement les colonnes 1 et 2
      if(nrow(dataFrameProject())>0){
        listCol<-c()
        listCol<-c("name","database")
        DT::datatable(dataFrameProject()[,listCol],filter = 'top',selection = 'multiple')
      }
    })
    
    
    output$projects_selected_Selection_de_projets <- renderUI({
      s = input$dataTable_project_Selection_de_projets_rows_selected
      nbMax<-length(s)
      if(nbMax){
        projects_selected_list <- lapply(1:nbMax, function(i) {
          # Create a Progress object
          progress <- shiny::Progress$new()
          # Make sure it closes when we exit this reactive, even if there's an error
          on.exit(progress$close())
          progress$set(message = "Récupération des informations", value = 0)
          listeCollectionProjet<-unlist(dataFrameProject()[s[i],"collections"],use.names = TRUE)
          
          query<-myQueryConstraintN(
            list(
              #myConstraintUniqueIN("name",listeCollectionProjet),#@ ludo cette contrainte n'est pas obligatoire
              myConstraintUnique("project",dataFrameProject()[s[i],"name"])
            )
          )
          
          data<-findQuery(globalInformation$globalDatabase,
                          globalInformation$collections,
                          query#myQueryUniqueIN("name",listeCollectionProjet)
                          )
          
          progress$inc(1)
          box(status = "warning",width = 12,height = 350,
              solidHeader = TRUE,
              title = dataFrameProject()[s[i],"name"],
              DT::datatable(data,selection = "none")
          )#end box
        })
        
        # Convert the list to a tagList - this is necessary for the list of items
        # to display properly.
        do.call(tagList, projects_selected_list)
      }
      
    })
    
    observeEvent(input$ActionValider_projects,{
      s = input$dataTable_project_Selection_de_projets_rows_selected
      nbMax<-length(s)
      globalInformation$user$projectSelected<-dataFrameProject()[s[1:nbMax],"name"]
      #globalInformation$user$databaseProjectSelected<-dataFrameProject()[s[1:nbMax],"database"]
      #paste(cat(globalInformation$user$projectSelected,'--',length(globalInformation$user$projectSelected)))
        
      updateTabItems(session,inputId ="mainMenu" ,selected ="Les_MGS_projets" )
      
    })
    
    
  }