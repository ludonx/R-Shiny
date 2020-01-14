tabItem_Patient_analyses<-
  tabItem(
    tabName = "Patient_analyses",
    h5("> Patient_analyses"),
    fluidPage(
      fluidRow(
        ## requête ----
        column(6,
               box(status = "primary",
                   width = 12,
                   uiOutput("uiselect_catalog_Patient_analyses"),
                   uiOutput("uiselect_projet_Patient_analyses"),
                   fluidRow(
                     column(6,uiOutput("uiselect_list_data_save_Patient_analyses")),
                     column(6, uiOutput("uiselect_dataframe_save_Patient_analyses"))
                   ),#end fluid row
                  
                   uiOutput("uiselect_obs_projet_Patient_analyses"),
                   fluidRow(
                     column(6,
                     textInput(inputId ="textinput_joint_data_Patient_analyses" ,
                               label ="Nom du data frame " ,
                               value ="jointure" )
                     ),#end column
                     column(6,
                     actionButton(inputId = paste0("ActionSave_joint_data_Patient_analyses"),
                                  label = "Exécuter",
                                  icon("play"),
                                  style="color: #fff; background-color: #3c936f; border-color: #3c936f"
                     )
                     )#end column
                   )#end fluid row
                   )
               ),#end column
        ## affichage du data frame ----
        column(6,
               box(status = "primary",
                   width = 12,
                   div(style = 'overflow-x: scroll',dataTableOutput("data_frame_save_Patient_analyses"))),
               box(status = "success",
                   width = 12,
                   div(style = 'overflow-x: scroll',dataTableOutput("data_frame_resultat_Patient_analyses")))
        )#end column
      )
    )
    
  )#end tabItem

