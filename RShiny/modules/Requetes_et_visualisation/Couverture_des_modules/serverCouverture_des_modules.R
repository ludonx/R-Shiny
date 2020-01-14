serverCouverture_des_modules<-
  function(input, output, session,globalInformation){
    ### information importante sur la collection module definition
    moduleDefinition<-reactiveValues(
      name="def_module_definitions_KEGGdb_5_19",
      type1="type",
      type2="subType1",
      type3="subType2"
    )#@ludo
    
    ######### Récupération des données de couverture
    ######### on le fait une fois, ensuite il faudra simplement jouer avec les colonnes selectionnées
    ########### mise en place des interfaces
    #############################################################################################
    dataFrameCouverture<-reactive({
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Récupération des données de couverture", value = 0)
      progress$inc(1/2)
      #data<-findAll(globalInformation$globalDatabase,globalInformation$projectsCollections)
      mydataFrameCouverture<-
        findAll(
          globalInformation$globalDatabase,
          globalInformation$moduleCoverageCollections
        )
      progress$inc(1/2)
      
      return(mydataFrameCouverture)
      
    }) 
    
    #### résultats
    output$uiTab1_Donnees_resultantes_Couverture_des_modules<-renderUI({
      fluidRow(
        column(3,
               box(
                 status = "danger", width = 12,
                 textOutput("text_nombre_module")
               ),
               box(
                 title = "Les variables", status = "primary", solidHeader = TRUE,
                 collapsible = TRUE,collapsed = F, width = 12,
                 uiOutput("uiCheckbox_Donnees_resultantes_Couverture_des_modules")
               ) #end box
        ),#end column
        column(9,withSpinner(DT::dataTableOutput('dataTable_Donnees_resultantes_Couverture_des_modules')))
      )#end fluidRow
    })
    output$text_nombre_module<-renderText(paste0("Nombre de module : ",nrow(dataFrameModuleDefinition())))
    
    #### visualisation
    ### pheatmap
    output$uiTab2_plot_pheatmap_Couverture_des_modules<-renderUI({
      plotOutput("plot_pheatmap_Couverture_des_modules") %>% withSpinner(color="#0dc5c1")
    })
    output$uiTab3_plot_interactive_Couverture_des_modules<-renderUI({
      plotlyOutput("plot_interactive_Couverture_des_modules") %>% withSpinner(color="#0dc5c1")
    })
    
    
    
    ########### bouton valider
    #############################################################################################
    dataFrameCouvertureValider<-eventReactive(input$ActionValider_Configuration_Couverture_des_modules,{
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Récupération des données des colonnes spécifier", value = 0)
      progress$inc(1/2)
      #data<-findAll(globalInformation$globalDatabase,globalInformation$projectsCollections)
      listColModuleDefinition<-row.names(dataFrameModuleDefinition()) 
      listColCouverture<-colnames(dataFrameCouverture())
      
      listCol<-intersect(listColModuleDefinition,listColCouverture) 
      # car il y a des colonnes qui ne sont pas representé dans le dataFrameCouverture
      mydataFrameCouverture<-dataFrameCouverture()[,listCol]
       
      progress$inc(1/2)

      return(mydataFrameCouverture)
      
    }) 
    
    ########### configuration
    #############################################################################################
    ### recuperation des données
    dataFrameModuleDefinition<-eventReactive(input$ActionValider_Configuration_Couverture_des_modules,{
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Récupération des id des modules", value = 0)
      progress$inc(1/2)
      #data<-findAll(globalInformation$globalDatabase,globalInformation$projectsCollections)
      #######################
      listContraint<-list()
      if(!is.null(input$select_Config_Couverture_des_modules_niveau1)){
        c1<-myConstraintUniqueIN(moduleDefinition$type1,input$select_Config_Couverture_des_modules_niveau1)
        listContraint<-append(listContraint,c1)
      }
      if(!is.null(input$select_Config_Couverture_des_modules_niveau2)){
        c2<-myConstraintUniqueIN(moduleDefinition$type2,input$select_Config_Couverture_des_modules_niveau2)

        listContraint<-append(listContraint,c2)
      }
      if(!is.null(input$select_Config_Couverture_des_modules_niveau3)){
        c3<-myConstraintUniqueIN(moduleDefinition$type3,input$select_Config_Couverture_des_modules_niveau3)

        listContraint<-append(listContraint,c3)
      }
      #####################

      if(length(listContraint)>0){
        myQueryString<-myQueryConstraintN(listContraint)
      }else{
        myQueryString<-'{}'
      }


      mydataFrameModuleDefinition<-
        findQuery(
          globalInformation$globalDatabase,
          moduleDefinition$name,
          myQueryString
        )
      progress$inc(1/2)

      return(mydataFrameModuleDefinition)

    })
    ##### data condition type 1
    dataFrameModuleDefinitionType1<-reactive({
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Récupération des données du module : type", value = 0)
      progress$inc(1/2)
      #data<-findAll(globalInformation$globalDatabase,globalInformation$projectsCollections)
      #######################
      mydataFrameModuleDefinition<-
        findAll(
          globalInformation$globalDatabase,
          moduleDefinition$name
        )
      progress$inc(1/2)
      
      return(mydataFrameModuleDefinition)
      
    })
    ##### data condition type 2
    dataFrameModuleDefinitionType2<-reactive({
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Récupération des définition", value = 0)
      progress$inc(1/2)
      #######################
      listContraint<-list()
      c1<-myConstraintUniqueIN(moduleDefinition$type1,input$select_Config_Couverture_des_modules_niveau1)
      listContraint<-append(listContraint,c1)
      
      ###################
      
      myQueryString<-myQueryConstraintN(listContraint)

      mydataFrameModuleDefinition<-
        findQuery(
          globalInformation$globalDatabase,
          moduleDefinition$name,
          myQueryString
        )
      progress$inc(1/2)
      
      
      return(mydataFrameModuleDefinition)
      
    })
    ##### data condition type 3
    dataFrameModuleDefinitionType3<-reactive({
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Récupération des définition", value = 0)
      progress$inc(1/2)
      #######################
      listContraint<-list()
      c1<-myConstraintUniqueIN(moduleDefinition$type1,input$select_Config_Couverture_des_modules_niveau1)
      listContraint<-append(listContraint,c1)
      c2<-myConstraintUniqueIN(moduleDefinition$type2,input$select_Config_Couverture_des_modules_niveau2)
      listContraint<-append(listContraint,c2)
      ###################
      
      myQueryString<-myQueryConstraintN(listContraint)
      
      mydataFrameModuleDefinition<-
        findQuery(
          globalInformation$globalDatabase,
          moduleDefinition$name,
          myQueryString
        )
      progress$inc(1/2)
      
      
      return(mydataFrameModuleDefinition)
      
    })
    ##### configuration
    ##type 1
    output$uiConfig_Couverture_des_modules_niveau1<-renderUI({
        selectInput(
          inputId ='select_Config_Couverture_des_modules_niveau1' ,
          label ="Selectioné une valeur" ,
          choices =dataFrameModuleDefinitionType1()[,moduleDefinition$type1],
          multiple = T
        )
    })
    ##type 2
    output$uiConfig_Couverture_des_modules_niveau2<-renderUI({
      #######################################################
      req(input$select_Config_Couverture_des_modules_niveau1)

      selectInput(
        inputId ='select_Config_Couverture_des_modules_niveau2' ,
        label ="Selectioné une valeur" ,
        choices =dataFrameModuleDefinitionType2()[,moduleDefinition$type2],
        multiple = T
      )
        
    })
    ##type 3
    output$uiConfig_Couverture_des_modules_niveau3<-renderUI({
      #######################################################
      req(input$select_Config_Couverture_des_modules_niveau1)
      req(input$select_Config_Couverture_des_modules_niveau2)
      #######################################################
      
      selectInput(
        inputId ='select_Config_Couverture_des_modules_niveau3' ,
        label ="Selectioné une valeur" ,
        choices =dataFrameModuleDefinitionType3()[,moduleDefinition$type3],
        multiple = T
      )
    
    })
    
    
    ########### résultat
    #############################################################################################
    ####### data frame
    output$dataTable_Donnees_resultantes_Couverture_des_modules<- DT::renderDataTable({
      req(input$Checkbox_Donnees_resultantes_Couverture_des_modules)
      
      listCol<-input$Checkbox_Donnees_resultantes_Couverture_des_modules
      if(length(listCol)>1)
        DT::datatable(dataFrameCouvertureValider()[,listCol],filter = 'top',selection = 'none') # vous pouvez changé single par multiple
      
    })
    
    ####### checkbox
    output$uiCheckbox_Donnees_resultantes_Couverture_des_modules <-renderUI({
      div(
        checkboxGroupInput("Checkbox_Donnees_resultantes_Couverture_des_modules", 
                           " ",
                           names(dataFrameCouvertureValider()),
                           selected =colnames(dataFrameCouvertureValider())[1:2]
        )
      )
      
      
    })
    
    
    ########### plot des couvertures
    #############################################################################################
    ## pheatmap
    output$plot_pheatmap_Couverture_des_modules<-renderPlot({
      #pheatmap(as.matrix(dataFrameCouvertureValider()))
      pheatmap(as.matrix(dataFrameCouvertureValider()),color = colorRampPalette(rev(brewer.pal(n = 7, name ="Set3")))(100))
    })

    # ###
    output$plot_interactive_Couverture_des_modules<-renderPlotly({
      mydata<-dataFrameCouverture()
      mydata<-as.matrix(mydata)
      # plot_ly(x=colnames(as.matrix(dataFrameCouverture())), y=rownames(as.matrix(dataFrameCouverture())), z=as.matrix(dataFrameCouverture()), type="heatmap",
      #         colorbar=list(title="Coverage"),
      #         colorscale=list(c(0,"rgb(224, 224, 224)"),
      #                         c(1, "rgb(255,0,0)"))
      # )%>%
      #   layout(xaxis=list(showticklabels = FALSE), yaxis=list(showticklabels = FALSE))

      plot_ly(x=colnames(as.matrix(dataFrameCouvertureValider())), y=rownames(as.matrix(dataFrameCouvertureValider())), z=as.matrix(dataFrameCouvertureValider()), type="heatmap",
              colorbar=list(title="Coverage"),
              colorscale=list(c(0,"rgb(224, 224, 224)"),
                              c(1, "rgb(255,0,0)"))
      )%>%
        layout(xaxis=list(showticklabels = FALSE), yaxis=list(showticklabels = FALSE))

    })


    
  }
  