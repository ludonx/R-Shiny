tabItem_Gestion_des_projets<-
  tabItem(
    tabName = "Gestion_des_projets",
    
    fluidPage(
      fluidRow(
        column(4,
               box(
                 
                 status = "primary",
                 #solidHeader = TRUE,
                 collapsible = TRUE,collapsed = F, width = 12,
                 fileInput("JsonFile", "Importer une collection au format json",
                           multiple = FALSE,
                           accept = c(".json")),
                 textInput(
                   inputId ="text_collection_name_Gestion_des_projets" ,
                   label ="Nom de la collection dans MongoDB : " ),
                 textInput(
                   inputId ="test_projet_name_Gestion_des_projets" ,
                   label ="Nom du projet ou du catalogue lié à cette collection : " ),
                 textInput(
                   inputId ="text_database_name_Gestion_des_projets" ,
                   label ="Nom de la base de données où sera stocké cette collection dans MongoDB : " ),
                 actionButton(inputId = "ActionValider_ajout_collection",
                              label = "Valider",
                              icon("cloud-upload-alt"), 
                              style="color: #fff; background-color: #397745; border-color: #397745"
                 )
               ) #end box
               
               
               
        ),#end column
        column(8,
               box(
                 
                 status = "success",
                 #solidHeader = TRUE,
                 collapsible = TRUE,collapsed = F, width = 12,
                 DTOutput('data_frame_new_collection_Gestion_des_projets')
               ) #end box
               
        )#end column
      )
      
      
    )
    
    )#end tabItem