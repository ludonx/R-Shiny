tabItem_Mes_requetes<-
  tabItem(
    tabName = "Mes_requetes",
    fluidPage(
      fluidRow(
        column(5,
               box(status = "primary",
                   
                   width = 12,
                   fluidPage(
                     actionButton(inputId = paste0("ActionActualiser_Mes_requetes"),
                                  label = "Actualiser",
                                  icon("spinner"),
                                  style="color: #fff; background-color: #3c936f; border-color: #3c936f"
                     ),
                     div(
                       style = "height:500px; overflow-y: scroll;overflow-x: scroll;",
                       dataTableOutput("data_frame_mes_requetes_Mes_requetes")
                     )
                     
                   )
               )#end box
        ),#end column
        column(7,
               box(status = "primary",
                   width = 12,
                   uiOutput("uiMessage_data_frame_mes_requetes_Mes_requetes")
                   
               ),#end box
               box(status = "success",
                   #solidHeader = TRUE,
                   #title = span( icon("exclamation-triangle"),paste0("")),
                   width = 12,
                   div(style = 'overflow-x: scroll',dataTableOutput("data_frame_ma_requete_Mes_requetes")),
                   br(),
                   fluidRow(
                     column(6,
                            actionButton(inputId = paste0("ActionPartager_ma_requete_Mes_requetes"),
                                         label = "Partager",
                                         icon("share"),
                                         style="color: #fff; background-color: #3c936f; border-color: #3c936f"
                            )
                     ),#end column
                     column(6,
                            actionButton(inputId = paste0("ActionExecuter_ma_requete_Mes_requetes"),
                                         label = "Executer",
                                         icon("play"),
                                         style="color: #fff; background-color: #a81f1f; border-color: #a81f1f"
                            )
                     )#end column
                   )#end fluidRow
                   
               )#end box
        )#end column
      ),#end fluidRow
      fluidRow(
        box(status = "primary",
            width = 12,
            uiOutput("uiselect_data_to_display_Mes_requetes"),
            div(style = 'overflow-x: scroll',dataTableOutput("data_frame_resultat_ma_requete_Mes_requetes"))
            
        )#end box
      )#end fluidRow
    )
    
    )#end tabItem