#dataTable_user
serverAjouter_un_utilisateur<-
  function(input, output, session,globalInformation){
    output$uiAjouter_un_utilisateur<-renderUI({
      fluidPage(
        fluidRow(
          column(6,
                 box(
                   title = "Formulaire d'ajout", status = "primary", width = 12,
                   textInput(inputId ="Ajouter_un_utilisateur_Last_name" ,label ="Nom : "  ),
                   textInput(inputId ="Ajouter_un_utilisateur_First_name" ,label ="Prenom : "  ),
                   
                   textInput(inputId ="Ajouter_un_utilisateur_email" ,label ="Email : "  ),
                   
                   passwordInput(inputId ="Ajouter_un_utilisateur_pwd" ,label ="Mot de passe : "),
                   passwordInput(inputId ="Ajouter_un_utilisateur_pwd_confirmer" ,label ="Confirmer le mot de passe : "),
                   
                   sliderInput(inputId= "Ajouter_un_utilisateur_access_level", label = "Niveau d'accès", min=1, max=10, value=5),
                   selectInput(inputId ="Ajouter_un_utilisateur_profil" ,label ="Profil : " ,choices = c("chercheur","administrateur")),

                   uiOutput("uiAjouter_un_utilisateur_Projects")
                   
                   
                 )
                 
          )
         
        ),#end fluidRow
        fluidRow(
          column(2,""),
          column(2,
                 actionButton(inputId = paste0("ActionAjouter_un_utilisateur"),
                              label = "Ajouter",
                              icon("user-plus"), 
                              style="color: #fff; background-color: #3c936f; border-color: #36aa7a"
                 )
          ),#end column
          column(8,htmlOutput(outputId = "ERROR_MGS_Ajouter_un_utilisateur"))
          
        )#end fluidRow
      )#end fluidPage
    
    })#end output$uiAjouter_un_utilisateur
    
    ## uiAjouter_un_utilisateur_Projects ---- 
    output$uiAjouter_un_utilisateur_Projects<-renderUI({
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = paste0(" Récupération des projets... "), value = 0)
      progress$inc(1/2)
      data<-findAll(globalInformation$globalDatabase,globalInformation$projectsCollections)
      progress$inc(1/2)
      listProjet<-data[,"name"]
      selectInput(
        inputId ="Ajouter_un_utilisateur_Projects" ,
        label ="Projects : " ,
        choices = listProjet)
      

    })
    ## ActionAjouter_un_utilisateur ----
    observeEvent(input$ActionAjouter_un_utilisateur,{
      req(input$Ajouter_un_utilisateur_Last_name)
      req(input$Ajouter_un_utilisateur_First_name)
      req(input$Ajouter_un_utilisateur_email)
      req(input$Ajouter_un_utilisateur_pwd)
      req(input$Ajouter_un_utilisateur_pwd_confirmer)
      req(input$Ajouter_un_utilisateur_profil)
      req(input$Ajouter_un_utilisateur_Projects)
      req(input$Ajouter_un_utilisateur_access_level)
      
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = paste0("Ajout en cours ... "), value = 0)
      progress$inc(1/3,detail='test user ...')
      
      testUser<-
        confirmeUser(
          globalInformation$globalDatabase,
          globalInformation$usersCollections,
          input$Ajouter_un_utilisateur_Last_name,
          input$Ajouter_un_utilisateur_First_name,
          input$Ajouter_un_utilisateur_Last_name,
          input$Ajouter_un_utilisateur_pwd,
          input$Ajouter_un_utilisateur_pwd_confirmer,
          input$Ajouter_un_utilisateur_email,
          input$Ajouter_un_utilisateur_profil
          )
      progress$inc(1/3,detail='Ajout en cours ...')
      if(testUser==T){
        addNewUser(globalInformation$globalDatabase,
                   globalInformation$usersCollections,
                   input$Ajouter_un_utilisateur_Last_name,
                   input$Ajouter_un_utilisateur_First_name,
                   input$Ajouter_un_utilisateur_Last_name,
                   hashpw(input$Ajouter_un_utilisateur_pwd, gensalt(16)),
                   input$Ajouter_un_utilisateur_email,
                   input$Ajouter_un_utilisateur_profil,
                   input$Ajouter_un_utilisateur_Projects,
                   input$Ajouter_un_utilisateur_access_level)
        progress$inc(1/3,detail='actualisation de la liste des utilisateur en cours ...')
        
        dataFrameLesUtilisateurs<-
          findAll(
            globalInformation$globalDatabase,
            globalInformation$usersCollections
          )
        globalInformation$dataFrameLesUtilisateurs<-dataFrameLesUtilisateurs
        
        output$ERROR_MGS_Ajouter_un_utilisateur<-renderText({
          paste("<font color=\"#36aa7a\"><b>", "Ajout effectuer !", "</b></font>")
        })
        
      }else{
        progress$inc(1/3)
        output$ERROR_MGS_Ajouter_un_utilisateur<-renderText({
          paste("<font color=\"#a9355a\"><b>", testUser, "</b></font>")
        })
      }
        
      
      
      
      
    })
  }#end serverAjouter_un_utilisateur