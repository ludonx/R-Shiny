tabItem_test_Blast<-
  tabItem(
    tabName = "test_Blast",
    
    fluidPage(
      fluidRow(
        column(2,""),#end column
        column(8,
               box(
                 title = NULL, 
                 status = "primary", 
                 #solidHeader = TRUE,
                 collapsible = TRUE,
                 collapsed = F, 
                 width = 12,
                 fluidPage(
                   fileInput(
                     inputId = "fasteFile",
                     label = "Importer une collection au format json",
                     multiple = FALSE,
                     accept = c(".fasta")
                     ),#fileInput
                   textAreaInput(
                     inputId ="fata_file_test_Blast" ,
                     label ="fasta selected" 
                   ),
                   textAreaInput(
                     inputId ="Blast_cmd_test_Blast" ,
                     label ="Blast result" 
                   ),
                   actionButton(inputId = paste0("ActionValider_Blast_cmd_test_Blast"),
                                label = "Blast",
                                icon("play"),
                                style="color: #fff; background-color: #bd2626; border-color: #bd2626"
                   )
                 )#end fluidPage
                 
               )#end box
               ),#end column
        column(2,"")#end column
      ),#end fluidRow
      fluidRow(
        verbatimTextOutput(
          outputId = "Blast_result_test_Blast"
        ),
        textAreaInput(
          inputId ="Blast_result_text_test_Blast" ,
          label ="Blast result" 
        )
        
      )#end fluidRow
    )#end fluidPage
    
    
  )#end tabItem

