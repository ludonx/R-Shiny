
tabItem_Couverture_des_modules<-
  tabItem(
    tabName = "Couverture_des_modules",
    fluidRow(
      column(3,
             box(
               title = "Configuration de la couverture", status = "warning", solidHeader = TRUE,
               collapsible = TRUE,collapsed = F, width = 12,
               uiOutput("uiConfig_Couverture_des_modules_niveau1"),
               uiOutput("uiConfig_Couverture_des_modules_niveau2"),
               uiOutput("uiConfig_Couverture_des_modules_niveau3"),
               
               
               actionButton(inputId = "ActionValider_Configuration_Couverture_des_modules",
                            label = "Valider",
                            icon("paper-plane"), 
                            style="color: #fff; background-color: #337ab7; border-color: #2e6da4"
               )
             ) #end box
      ),
      column(9,
             box(
               title = "Données Résultantes", status = "success", solidHeader = TRUE,
               collapsible = TRUE,collapsed = F, width = 12,
             fluidRow(
                 column(12,
                        tabBox(
                          #title = "First tabBox",
                          width = 12,
                          # The id lets us use input$tabset1 on the server to find the current tab
                          id = "tabset_uiDonnees_resultantes_Couverture_des_modules", 
                          tabPanel(title ="Données Résultantes " ,
                                   value = "Tab1_resultat_def_catalog_Les_Genes",
                                   icon = icon("list-alt"),
                                   uiOutput("uiTab1_Donnees_resultantes_Couverture_des_modules")
                          ),
                          tabPanel(title ="Plot pheatmap" ,
                                   value = "Tab2_plot_pheatmap_Couverture_des_modules",
                                   icon = icon("chart-bar"),
                                   uiOutput("uiTab2_plot_pheatmap_Couverture_des_modules")
                          ),
                          tabPanel(title ="Plot interactif " ,
                                   value = "Tab3_plot_interactive_Couverture_des_modules",
                                   icon = icon("linode"),
                                   uiOutput("uiTab3_plot_interactive_Couverture_des_modules")
                          )
                          
                        )#end tabBox
                 )#end column
                 
               )#end fluidRow
             )# end box
      )
    )#end fluidRow
    # fluidRow(
    #   box(
    #     title = "Visualisation des données", status = "success", solidHeader = TRUE,
    #     collapsible = TRUE,collapsed = T, width = 12,
    #     uiOutput("uiVisualisation_des_donnees_Couverture_des_modules")
    #   ) #end box
    # )#end fluidRow
    
    
  )#end tabItem

