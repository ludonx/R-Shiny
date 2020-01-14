tabItem_blast<-
  tabItem(
    tabName = "blast",
    fluidPage(
      fluidRow(
        actionButton(
          inputId ="load_blast" ,
          label = "Load Blast module"
        )
      ),#end blast
      fluidRow(
        radioButtons(
          inputId ="blast_search_blast" ,
          label =" Blast search" ,
          choices =names(blast_ICG),
          inline =T
        )
      ),#end  fluidRow
      fluidRow(
        column(3,
               textInput(
                 inputId = "evalue_blast",
                 label = "evalue"
               )
          ),#end column
        column(3,
               sliderInput(
                 inputId = "pid_blast",
                 label = "percent identity",
                 min = 0,
                 max = 100,
                 value = 50
               )
               
              ),#end column
        
        
        column(6,"")
      ),#end  fluidRow
      
      fluidRow(
        fileInput(
          inputId = "fasteFile_blast",
          label = "select fasta file",
          multiple = FALSE,
          accept = c(".fasta")
        ),#fileInput
        textAreaInput(
          inputId ="fata_file_blast" ,
          label ="fasta selected" 
        )
      ),#end  fluidRow
      
      fluidRow(
        textInput(
          inputId = "blast_output_file",
          label = "Enter the name of the output file :"
        )
      ),#end  fluidRow
      
      fluidRow(
        textAreaInput(
          inputId = "cmd_blast",
          label = "cmd"
        ),
        selectInput(
          inputId = "outfmt_blast",
          label = "outfmt",
          choices = c("0","6","7"),
          selected = "0"
        ),
        actionButton(
          inputId = "valider_blast",
          label = "blast !",
          icon = icon("play-circle")
        )
      ),#end fluidRow
      
      
      verbatimTextOutput(outputId ="res_blast")
      
    )
    
  )#end tabItem

