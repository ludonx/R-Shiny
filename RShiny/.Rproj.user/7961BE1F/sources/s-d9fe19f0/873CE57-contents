tabItem_Ma_console<-
  tabItem(
    tabName = "Ma_console",
    fluidPage(
      #paste0(">> Bonjour je suis le module Ma_console"),
      ### FlexBox.R  #Menu
      
      fluidRow(
        column(6,
               #### mes variables
               box(status = "danger",width = 12,uiOutput("uiMessage_variable_ma_console")),
               
               #### ma console
               box(title = span( icon("laptop-code"),paste0(" Ma console : Permet Exécuter du code R")),
                   background = "navy",
                   #status = "danger",
                   solidHeader = T, collapsible = T, collapsed = F, width = 12,
                   runcodeUI(code="",type = "ace",height='350px')
               ),#end Box
               
               #### résultat variable type plot
               box(title = span( icon("chart-line"),paste0(" Plot : print_plot(x)")),
                   #background = "navy",
                   #status = "danger",
                   solidHeader = T, collapsible = T, collapsed = F, width = 12,
                   plotOutput("plot_result_Ma_console")
               )#end Box
        ),#end column
        column(6,
               #### résultat variable type text
               box(title = span( icon("pen-fancy"),paste0(" Text : print_text(x)")),
                   #background = "navy",
                   #status = "danger",
                   solidHeader = T, collapsible = T, collapsed = F, width = 12,
                   textAreaInput(inputId = "text_result_Ma_console",
                                 label = NULL,
                                 height = "200px")
               ),#end Box
               #### JS text_result_Ma_console
               tags$head(tags$style(HTML('#text_result_Ma_console{
                            background-color: #181918 ;color: #2d992d;
                            font-family: "Lucida Console";border: none;
                            }'))),
               #### résultat variable type dataFrame
               box(title = span( icon("table"),paste0(" DataFrame : print_dataframe(x)")),
                   #background = "navy",
                   #status = "danger",
                   solidHeader = T, collapsible = T, collapsed = F, width = 12,
                   div(style = 'overflow-x: scroll',dataTableOutput("data_frame_result_Ma_console"))
                   
               )#end Box
        )#end column
      ),#end fluidRow
      
      source(
        file.path(
          paste0(app$config$pathToModule,"Gestion_de_l_application/Ma_console"),
          "uiMa_console_FlexBox.R"),
        local = TRUE)$value
      
      
      # fixedPanel(
      #   draggable=T,
      #   bottom  = 90, right  = 10, width = "45%",
      #     box(title = span( icon("laptop-code"),paste0(" Console : Exécuté du code R")),
      #         background = "navy",#status = "danger",
      #         solidHeader = T, collapsible = T, collapsed = T, width = 12,
      #         runcodeUI(
      #           code = paste("globalInformation$Console<- ''",
      #                        "globalInformation$Console<-",
      #                        "paste0(globalInformation$Console,",
      #                        "'>>',",
      #                        " _MON_CODE_ICI_) ",sep='\n'),
      #           type = "ace",
      #           height='250px')
      #     )#end Box
      #   )#end fixedPanel
      
    )#end fluidPage
  )#end tabItem