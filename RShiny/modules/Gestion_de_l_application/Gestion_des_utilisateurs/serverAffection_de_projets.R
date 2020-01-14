#dataTable_user
serverAffection_de_projets<-
  function(input, output, session,globalInformation){
    
    output$uiAffection_de_projets<-renderUI({
      fluidPage(
        
        fluidRow(
          box(
            title = "sélectionnez des utilisateurs et des projets",solidHeader = TRUE,
            width=12,#status="success",
            collapsible = TRUE,#collapsed = TRUE,
            fluidRow(
              box(
                title = "sélectionnez des utilisateurs", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                DT::dataTableOutput("dataTable_user")
              ),
              box(
                title = "sélectionnez des projets", status = "warning", solidHeader = TRUE,
                collapsible = TRUE,
                DT::dataTableOutput("dataTable_project")
              )
            )#end fluidPage
          )
          
        ),#end fluidPage
        
        # validation des projets selectionés
        fluidRow(
          box(
            title = "Utilisateur(s) et Projet(s) sélectionés", solidHeader = TRUE,#status = "success",
            collapsible = TRUE,#collapsed = TRUE,
            width = 12,
            fluidRow(
              column(6,uiOutput('users_selected')),
              column(6,uiOutput('projects_selected'))
            ),#end fluidRow
            fluidRow(
              
              column(6,uiOutput('infoAffecter') ),
              column(6,
                     actionButton(inputId = "ActionAffecter_user_to_project",
                                  label = "Affecter",
                                  icon("paper-plane"), 
                                  style="color: #fff; background-color: #b73263; border-color: #b7319c"
                     )
              )
              
              
            )#end fluidRow
            
          )#end box
        )#end fluidRow
        
        
      )#end fluidPage
    })
    ##############################################################################################################
        
    dataFrameProject<-reactive({
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Récupération des projets", value = 0)
      
      data<-findAll(globalInformation$globalDatabase,globalInformation$projectsCollections)
      
      progress$inc(1)
      return(data)
    })
    output$dataTable_project<- DT::renderDataTable({
      #listCol<-c()
      # si le data frame contient des valeurs, on affiche uniquement les colonnes 1 et 2
      #if(nrow(dataFrameProject())>0)listCol<-c("Name","dataBase")#c("name","database","catalog")
      DT::datatable(dataFrameProject()[,c("name","catalog","database")],#[,listCol], 
                    filter = 'top',selection = 'multiple' # voir la doc dur DT:: table shiny
      ) 
    })
   
   
    output$projects_selected <- renderUI({
      s = input$dataTable_project_rows_selected
      nbMax<-length(s)
      if(nbMax){
        projects_selected_list <- lapply(1:nbMax, function(i) {
          box(status = "warning",
              title = dataFrameProject()[s[i],"name"],
              HTML(
                paste(dataFrameProject()[s[i],"database"],
                      dataFrameProject()[s[i],"catalog"],
                      dataFrameProject()[s[i],"collections"],
                      #dataFrameProject()[s[i],"SampleMetadata"],
                      sep = '<br/>')
                )
              
          )#end box
        })
        
        # Convert the list to a tagList - this is necessary for the list of items
        # to display properly.
        do.call(tagList, projects_selected_list)
      }
     
      
     
    })
    
    ##########################################################################################
    dataFrameUser<-reactive({
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Récupération des projets", value = 0)
      
      data<-findAll(globalInformation$globalDatabase,globalInformation$usersCollections)
      
      progress$inc(1)
      return(data)
    })
    output$dataTable_user<- DT::renderDataTable({
      listCol<-c()
      # si le data frame contient des valeurs, on affiche uniquement les colonnes 1 et 2
      if(nrow(dataFrameUser())>0)listCol<-c("Name","email","profil")
      DT::datatable(dataFrameUser()[,listCol], 
                    filter = 'top',selection = 'multiple' # voir la doc dur DT:: table shiny
      ) 
    })
    
    output$users_selected <- renderUI({
      s = input$dataTable_user_rows_selected
      nbMax<-length(s)
      if(nbMax){
        users_selected_list <- lapply(1:nbMax, function(i) {
          box(status = "primary",
              title = paste(dataFrameUser()[s[i],"Last_name"]," ",dataFrameUser()[s[i],"First_name"]),
              HTML(
                paste(dataFrameUser()[s[i],"email"],
                      paste("Admin"," : ",dataFrameUser()[s[i],"profil"]),
                      dataFrameUser()[s[i],"Projects"],sep = '<br/>')
              )
              
          )#end box
        })
        
        # Convert the list to a tagList - this is necessary for the list of items
        # to display properly.
        do.call(tagList, users_selected_list)
      }
      
    })
    ##############################################################################################
    
    validerAffectation<-eventReactive(input$ActionAffecter_user_to_project,{
      req(input$dataTable_project_rows_selected)
      req(input$dataTable_user_rows_selected)
      
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Affectation des projets", value = 0)
      
      indiceProject = input$dataTable_project_rows_selected
      indiceUser = input$dataTable_user_rows_selected
      
      progress$inc(1/3)
      vectorUser<-vector(mode="character", length=length(indiceUser))
      for(j in 1:length(vectorUser)){
        vectorUser[j]<-dataFrameUser()[indiceUser[j],"email"]
      } 
      
      vectorProject<-vector(mode="character", length=length(indiceProject))
      for(j in 1:length(vectorProject)){
        vectorProject[j]<-dataFrameProject()[indiceProject[j],"name"]
      } 
      progress$inc(1/3)
      
      users<-myQueryUniqueIN('email',vectorUser)
      projects<-myQueryPushChaine('Projects',vectorProject)
      myUpdateQueryMongoSimple(globalInformation$globalDatabase,
                               globalInformation$usersCollections,
                               users,
                               projects
                               )
      progress$inc(1/3)
      #paste("Ajout Effectuer ",sep ='---' )
      #icon("thumbs-up")

    })
    
    output$infoAffecter<-renderUI({
      validerAffectation()
      
    })
    
    
}