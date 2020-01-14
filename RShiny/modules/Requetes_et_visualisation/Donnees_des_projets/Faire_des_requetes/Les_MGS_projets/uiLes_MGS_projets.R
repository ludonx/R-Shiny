
tabItem_Les_MGS_projets<-
  tabItem(
    tabName = "Les_MGS_projets",
    fluidRow(
    tabBox(
      #title = tagList(shiny::icon("chart-line"), "Visualisation"),
      # The id lets us use input$tabset1 on the server to find the current tab
      id = "tabBox_Les_MGS_projets",width = 12,# height = "250px",
      tabPanel(
        title = tagList(shiny::icon("chart-line"), "Mes Plots"),
        value="tabPanel_select_cag_Les_MGS_projets",
        
        
      fluidRow(
        box(
          title = "Information sur les projets selectionées", solidHeader = TRUE,#status = "primary", 
          collapsible = TRUE,collapsed = TRUE,
          width = 12, 
          uiOutput("uiprojectSelected_Les_MGS_projets")
        )
      ),#end fluidRow
      ####################################################################################################
      fluidRow(
        box(
          title = "Information sur les projets selectionées", solidHeader = TRUE,#status = "primary", 
          collapsible = TRUE, width = 12, 
          uiOutput("uiMyAbundance_Les_MGS_projets"),
          fluidRow(
            #textOutput("texte"),
            column(4,""),
            column(3,
                   actionButton(inputId = paste0("ActionCompar_les_project_Les_MGS_projets"),
                                label = "Comparer les Projets",
                                icon("paper-plane"), 
                                style="color: #fff; background-color: #337ab7; border-color: #2e6da4"
                   )
            )
            
            
          )
        )
      ),#end fluidRow
      fluidRow(
        tabBox(
          #title = tagList(shiny::icon("chart-line"), "Visualisation"),
          # The id lets us use input$tabset1 on the server to find the current tab
          id = "uiPlotComparaison_Les_MGS_projets",width = 12,# height = "250px",
          tabPanel(
            title = tagList(shiny::icon("chart-line"), "Mes Plots"),
            value="tabPanel_uiBoxplotBarcode_Les_MGS_projets",
            uiOutput("uiBoxplotBarcode_Les_MGS_projets")
          ),#end tabPanel
          tabPanel(
            title = tagList(shiny::icon("chart-pie"), "Comparaison de projets (BoxPLot) "),
            value="tabPanel_plot",
            fluidPage(
              fluidRow(
                #textOutput("texte"),
                column(1,""),
                column(3,
                       actionButton(inputId = paste0("ActionComparLes_MGS_projets_All"),
                                    label = "Comparer",
                                    icon("paper-plane"), 
                                    style="color: #fff; background-color: #337ab7; border-color: #2e6da4"
                       )
                )
                
                
              ),
              fluidRow(
               
                uiOutput("uiConfig_Les_MGS_projets_All"),
                uiOutput("uiplotOutput_Les_MGS_projets_All")
                
              )
              
              
            )
            
          ),#end tabPanel
          tabPanel(
            title = tagList(shiny::icon("barcode"), "Comparaison de projets (Bare code)"),
            value="tabPanel_plot_bare_code",
            fluidPage(
              fluidRow(
                #textOutput("texte"),
                column(1,""),
                column(3,
                       actionButton(inputId = paste0("ActionCompar_Barecode_Les_MGS_projets_All"),
                                    label = "Comparer",
                                    icon("paper-plane"), 
                                    style="color: #fff; background-color: #337ab7; border-color: #2e6da4"
                       )
                )
                
                
              ),
              fluidRow(
                
                uiOutput("uiConfig_Barecode_Les_MGS_projets_All"),
                uiOutput("uiplotOutput_Barecode_Les_MGS_projets_All")
                
                
              )
              
              
            )
            
          ),#end tabPanel
          tabPanel(
            title = "table des données",
            value="tabPanel_data_frame",
            withSpinner(DT::dataTableOutput(paste0("dataTable_Les_MGS_projets_All")))
          ),
          tabPanel(
            title = "table des données (Bare Code)",
            value="tabPanel_Barecode_data_frame",
            withSpinner(DT::dataTableOutput(paste0("dataTable_Barecode_Les_MGS_projets_All")))
          )
          
        )#end tab box
      )#end fluidRow
      
    ),#end tabPanel
    ##############################################################################################
    ##############################################################################################
    source(
      file.path(
        paste0(app$config$pathToModule,"Requetes_et_visualisation/Donnees_des_projets/Faire_des_requetes/Les_MGS_projets/ui"),
        "tabPanel_compar_cag_Les_MGS_projets.R"),
      local = TRUE)$value
    
    )#end tabBox
    )#end fluidRow
    
  )#end tabItem

