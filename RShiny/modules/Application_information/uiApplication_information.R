tabItem_Application_information<-
  tabItem(
    tabName = "Application_information",
    
    fluidRow(
      valueBoxOutput("infoUsers_Application_information"),
      valueBoxOutput("infoUsersConnected_Application_information"),
      valueBoxOutput("infoUsersConnectedAll_Application_information"),
      valueBoxOutput("infoProjects_Application_information"),
      valueBoxOutput("infoCatalogs_Application_information")
      
    ),#end fluidRow
    fluidRow(
      box(
        title = 
          list(
            fr="Information importante sur le fonctionement de l'application",
            en="Application information"
          )[app$config$language],
        
        status = "danger",
        solidHeader = TRUE,
        collapsible = TRUE,collapsed = T, width = 12,
        fluidRow(
          column(3,uiOutput("uiCheckbox_globalInformation_Application_information")),
          column(9,withSpinner(DT::dataTableOutput("dataTable_globalInformation_Application_information")))
        )
        
      ),
      box(
        title = "Information sur les utilisateurs connectés", status = "success", solidHeader = TRUE,
        collapsible = TRUE,collapsed = T, width = 12,
        fluidRow(
          column(3,uiOutput("uiCheckbox_Application_information_users_connecter")),
          column(9,withSpinner(DT::dataTableOutput("dataTable_Application_information_users_connecter")))
        )
        
      )
    )#end fluidRow
    
  )#end tabItem

