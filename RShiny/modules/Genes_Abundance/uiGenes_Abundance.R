tabItem_Genes_Abundance<-
  tabItem(
    tabName = "Genes_Abundance",
    h5("> Genes Abundance"),
    fluidPage(
      fluidRow(
        # requête ----
        column(6,
               box(status = "primary",
                     width = 12,
                     uiOutput("uiselect_catalog_Genes_Abundance"),
                     fluidRow(
                       column(6,uiOutput("uiselect_list_data_save_Genes_Abundance")),
                       column(6, uiOutput("uiselect_dataframe_save_Genes_Abundance"))
                     ),#end fluid row
                     fluidRow(
                       column(6,uiOutput("uiselect_list_data_save_Samplemetadata_Genes_Abundance")),
                       column(6, uiOutput("uiselect_dataframe_save_Samplemetadata_Genes_Abundance"))
                     ),#end fluid row
  
                     fluidRow(
                       column(6,
                       textInput(inputId ="textinput_joint_data_Genes_Abundance" ,
                                 label ="Nom du data frame " ,
                                 value ="data_" )
                       ),#end column
                       column(6,
                       actionButton(inputId = paste0("ActionSave_joint_data_Genes_Abundance"),
                                    label = "Match colnames",
                                    icon("play"),
                                    style="color: #fff; background-color: #3c936f; border-color: #3c936f"
                       )
                       )#end column
                     )#end fluid row
                   ),#end box
               box(status = "success",
                   width = 12,
                   div(style = 'overflow-x: scroll',dataTableOutput("data_frame_resultat_Genes_Abundance"))
                   )#end box
               ),#end column
        ## affichage du data frame ----
        column(6,#style = "height:500px; overflow-y: scroll;overflow-x: scroll;",
               box(status = "primary",
                   width = 12,
                   div(style = "height:500px; overflow-y: scroll;overflow-x: scroll;",dataTableOutput("data_frame_save_Genes_Abundance"))),
               box(status = "primary",
                   width = 12,
                   div(style = 'overflow-x: scroll',dataTableOutput("data_frame_save_Samplemetadata_Genes_Abundance")))
               
        )#end column
      )#end fluidRow
    )#end fluidPage
    
  )#end tabItem

