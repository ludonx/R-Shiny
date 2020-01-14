tabPanel(
  title = tagList(shiny::icon("chart-line"), "Comparaisons de projets"),
  value="tabPanel_compar_cag_Les_MGS_projets",
  fluidRow(
    tabBox(
      #title = tagList(shiny::icon("chart-line"), "Visualisation"),
      # The id lets us use input$tabset1 on the server to find the current tab
      id = "tabBox_compar_cag_Les_MGS_projets_Barcode",width = 12,# height = "250px",
      tabPanel(
        title = "Statistique",
        value="tabPanel_compar_cag_Les_MGS_projets_Statistique",
        uiOutput("uitabPanel_compar_cag_Les_MGS_projets_Statistique")
        
      ),#end tabPanel
      tabPanel(
        title = tagList(shiny::icon("chart-pie"), "Statistique"),
        value="tabPanel_compar_cag_Les_MGS_projets_Barcode",
        fluidPage(
          fluidRow(
            
            # column(1,""),
            # column(3,
            #        actionButton(inputId = paste0("ActionComparLes_MGS_projets_All"),
            #                     label = "Comparer",
            #                     icon("paper-plane"), 
            #                     style="color: #fff; background-color: #337ab7; border-color: #2e6da4"
            #        )
            # )
            
            
          )
          
          
          
        )
        
      )#end tabPanel
      
      
    )#end tab box
  )#end fluidrow
)#end tabPanel