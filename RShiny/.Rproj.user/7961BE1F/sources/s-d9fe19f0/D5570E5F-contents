tabItem_Selection_de_projets<-
  tabItem(
    tabName = "Selection_de_projets",
    
    fluidPage(
       fluidRow(
          box(
            title = "sélectionnez un catalog", status = "primary", solidHeader = TRUE,
            collapsible = TRUE,width = 6,
            withSpinner(DT::dataTableOutput("dataTable_catalog"))
          ),
          box(
            title = "sélectionnez des projets", status = "warning", solidHeader = TRUE,
            collapsible = TRUE,width = 6,
            withSpinner(DT::dataTableOutput("dataTable_project_Selection_de_projets"))
          )
        ),#end fluidPage
        
        # validation des projets selectionés
        fluidRow(
          box(
            title = "Projet(s) sélectionés", solidHeader = TRUE,status = "success",
            collapsible = TRUE,
            width = 12,
            fluidRow(
              
              column(5,uiOutput('infoValidation') ),
              column(5,"" ),
              column(2,
                     actionButton(inputId = "ActionValider_projects",
                                  label = "Valider",
                                  icon("paper-plane"), 
                                  style="color: #fff; background-color: #337ab7; border-color: #2e6da4"
                     )
              )
              
              
            ),#end fluidRow
            fluidRow(column(12,uiOutput('projects_selected_Selection_de_projets')))
            
          )#end box
        )#end fluidRow

    )#end fluidPage
    
  )#end tabItem


