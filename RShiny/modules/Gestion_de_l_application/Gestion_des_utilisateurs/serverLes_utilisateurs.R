serverLes_utilisateurs<-
  function(input, output, session,globalInformation){
   
    output$uiLes_utilisateurs<-renderUI(
      fluidRow(
        column(5,div(style = 'overflow-x: scroll',dataTableOutput("dataTable_Les_utilisateurs"))),
       
        column(7,
               box(
                 title = "Suppression", status = "danger",width = 12,
                 #collapsible = TRUE,collapsed = F, 
                 fluidPage(
                   fluidRow(
                     div(style = 'overflow-x: scroll',DT::dataTableOutput('dataTable_Les_utilisateurs_selected'))
                   ),
                   br(),
                   fluidRow(
                     column(6,
                            actionButton(inputId = paste0("ActionSupprimerUtilisatuer"),
                                         label = "Supprimer",
                                         icon("user-minus"), 
                                         style="color: #fff; background-color: #b73263; border-color: #b7319c"
                            )),
                            column(6,htmlOutput(outputId = "ERROR_MGS_Supprimer_un_utilisateur"))
                    
                   )#end fluidRow
                  
                   
                 )#end fluidPage
                 
               )#end column
        ) #end box
        
      )#end fluidRow
    )#end output$uiLes_utilisateurs
    
    #####################################################################################
    ##### récupération des données
    dataFrameLesUtilisateurs<-reactive({
      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = "Récupération de la liste des utilisateurs", value = 0)
      progress$inc(1/2)
      dataFrameLesUtilisateurs<-
        findAll(
          globalInformation$globalDatabase,
          globalInformation$usersCollections
        )
      globalInformation$dataFrameLesUtilisateurs<-dataFrameLesUtilisateurs
      progress$inc(1/2)
      
      return(dataFrameLesUtilisateurs)
      
    })
    
    ##### data frame
    output$dataTable_Les_utilisateurs<- DT::renderDataTable({

      
        DT::datatable(globalInformation$dataFrameLesUtilisateurs,filter = 'top',selection = 'multiple') # vous pouvez changé single par multiple
      
    })
    
    
    
    #######################################################################################
    
    ############ Modification et Suppression
    ##### les utilisateur selectionée
    dataFrameLesUtilisateursSelected<-eventReactive(input$dataTable_Les_utilisateurs_rows_selected,{
      
      listeUser = input$dataTable_Les_utilisateurs_rows_selected
      dataFrameLesUtilisateursSelected<-data.frame()
      
      for(j in 1:length(listeUser)){
        dataFrameLesUtilisateursSelected<-
          rbind(dataFrameLesUtilisateursSelected,globalInformation$dataFrameLesUtilisateurs[listeUser[j],])
      } 
      return(dataFrameLesUtilisateursSelected)
    })
    ##### data frame résultat
    output$dataTable_Les_utilisateurs_selected<- DT::renderDataTable({

        DT::datatable(dataFrameLesUtilisateursSelected(),filter = 'top',selection = 'single') # vous pouvez changé single par multiple
      
    })
    
    ##### Suppression
    observeEvent(input$ActionSupprimerUtilisatuer,{
      req(input$dataTable_Les_utilisateurs_rows_selected)
      
      listeUser = input$dataTable_Les_utilisateurs_rows_selected
      vectorUser<-vector(mode="character", length=length(listeUser))
      
      for(j in 1:length(vectorUser)){
        #vectorUser[j]<-dataFrameLesUtilisateurs()[listeUser[j],"email"]
        
        ## ce teste est necessaire uniquement parceque j'ai modifier la structure de
        # la collection users. donc tt les utilisateru n'ont pas se parramettre 
        # @ludo à supprimer apres nettoyage de la collection users
        
        if(!is.na(globalInformation$dataFrameLesUtilisateurs[listeUser[j],"date_ajout"])){
          date_ajout<-globalInformation$dataFrameLesUtilisateurs[listeUser[j],"date_ajout"]
        }else{
          date_ajout<-"vide"
        }
        
        # Create a Progress object
        progress <- shiny::Progress$new()
        # Make sure it closes when we exit this reactive, even if there's an error
        on.exit(progress$close())
        progress$set(message = paste0("Suppression de ",globalInformation$dataFrameLesUtilisateurs[listeUser[j],"First_name"]), value = 0)
        progress$inc(1)

        ## faire la supression ici
        deleteUser(globalInformation$globalDatabase,
                   globalInformation$usersCollectionsDelete,
                   globalInformation$usersCollections,
                   globalInformation$dataFrameLesUtilisateurs[listeUser[j],"Name"],
                   globalInformation$dataFrameLesUtilisateurs[listeUser[j],"First_name"],
                   globalInformation$dataFrameLesUtilisateurs[listeUser[j],"Last_name"],
                   globalInformation$dataFrameLesUtilisateurs[listeUser[j],"Password"],
                   globalInformation$dataFrameLesUtilisateurs[listeUser[j],"email"],
                   globalInformation$dataFrameLesUtilisateurs[listeUser[j],"profil"],
                   date_ajout,
                   Projects="none")
        
        
        #progress$inc(1/2)
          
       
      }#end for
      output$ERROR_MGS_Supprimer_un_utilisateur<-renderText({
        paste("<font color=\"#36aa7a\"><b>", "Suppression effectuer !", "</b></font>")
      })
      
      dataFrameLesUtilisateurs<-
        findAll(
          globalInformation$globalDatabase,
          globalInformation$usersCollections
        )
      globalInformation$dataFrameLesUtilisateurs<-dataFrameLesUtilisateurs
      
    })
    
    #######################################################################################
    ##### Modification
    #######################################################################################
    ##### IHM
    #######################################################################################
    output$uiModifier_un_utilisateur<-renderUI({
      req(input$dataTable_Les_utilisateurs_rows_selected)
      
      listeUser = input$dataTable_Les_utilisateurs_rows_selected
      last_one <- length(listeUser)
      Last_name<-globalInformation$dataFrameLesUtilisateurs[listeUser[last_one],"Last_name"]
      First_name<-globalInformation$dataFrameLesUtilisateurs[listeUser[last_one],"First_name"]
      email<-globalInformation$dataFrameLesUtilisateurs[listeUser[last_one],"email"]
      profil<-globalInformation$dataFrameLesUtilisateurs[listeUser[last_one],"profil"]
      access_level <- globalInformation$dataFrameLesUtilisateurs[listeUser[last_one],"access_level"]
      
      
      fluidPage(
        fluidRow(
          column(5,""),
          column(7,
                 box(
                   title = "Modification", status = "success", width = 12,
                   fluidRow(
                     column(6,
                            textInput(inputId ="Modifier_un_utilisateur_Last_name" ,label ="Nom : ",value = Last_name  ),
                            textInput(inputId ="Modifier_un_utilisateur_First_name" ,label ="Prenom : " ,value = First_name ),
                            
                            textInput(inputId ="Modifier_un_utilisateur_email" ,label ="Email : ",value =  email )
                     ),
                     column(6,
                            textInput(inputId ="Modifier_un_utilisateur_pwd" ,label ="Nouveau mot de passe : ",value = paste0("!123@",Last_name)),

                            sliderInput(inputId= "Modifier_un_utilisateur_access_level", label = "Niveau d'accès", min=1, max=10, value=access_level),
                            selectInput(inputId ="Modifier_un_utilisateur_profil" ,label ="Profil : " ,choices = c("chercheur","administrateur"),selected =profil )
                            
                     )
                   ),#end fluidRow
                   br(),
                   fluidRow(
                     column(6,
                            actionButton(inputId = paste0("ActionModifierUtilisateur"),
                                         label = "Modifier",
                                         icon("user-edit"), 
                                         style="color: #fff; background-color: #3c936f; border-color: #36aa7a"
                            )
                     ),
                     column(6,htmlOutput(outputId = "ERROR_MGS_Modifier_un_utilisateur"))
                     
                   )#end fluidRow
                   
                  
                 )
                 
          )
          
        )#end fluidRow
        
      )#end fluidPage
      
    })#end output$uiModifier_un_utilisateur
    #######################################################################
    #### ActionButton
    #######################################################################################
    
    observeEvent(input$ActionModifierUtilisateur,{
      req(input$dataTable_Les_utilisateurs_rows_selected)
      
      listeUser = input$dataTable_Les_utilisateurs_rows_selected # @ludo à supprimer
      
      
      #dataFrameLesUtilisateursSelected()[listeUser[1],"email"]

      # Create a Progress object
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = paste0("Modification en cours ... "), value = 0)
      progress$inc(1/3,detail='test user ...')
      
      # testUser<-
      #   confirmeUser(
      #     globalInformation$globalDatabase,
      #     globalInformation$usersCollections,
      #     input$Modifier_un_utilisateur_Last_name,
      #     input$Modifier_un_utilisateur_First_name,
      #     input$Modifier_un_utilisateur_Last_name,
      #     input$Modifier_un_utilisateur_pwd,
      #     input$Modifier_un_utilisateur_pwd_confirmer,
      #     input$Modifier_un_utilisateur_email,
      #     input$Modifier_un_utilisateur_profil)
      
      testUser <- T
      progress$inc(1/3)
      if(testUser==T){

        listeUser = input$dataTable_Les_utilisateurs_rows_selected
        last_one <- length(listeUser)
        Last_name<-globalInformation$dataFrameLesUtilisateurs[listeUser[last_one],"Name"]
        ModifierUser(globalInformation$globalDatabase,
                   globalInformation$usersCollections,
                   Last_name,
                   input$Modifier_un_utilisateur_First_name,
                   input$Modifier_un_utilisateur_Last_name,
                   hashpw(input$Modifier_un_utilisateur_pwd, gensalt(16)),
                   
                   input$Modifier_un_utilisateur_email,
                   input$Modifier_un_utilisateur_profil,
                   input$Modifier_un_utilisateur_access_level
        )
        
        output$ERROR_MGS_Modifier_un_utilisateur<-renderText({
          paste("<font color=\"#36aa7a\"><b>", "Modification effectuer !", "</b></font>")
        })
        
        
        
        
        progress$inc(1/3,detail="Actualisation de la liste des utilisateurs")
        dataFrameLesUtilisateurs<-
          findAll(
            globalInformation$globalDatabase,
            globalInformation$usersCollections
          )
        globalInformation$dataFrameLesUtilisateurs<-dataFrameLesUtilisateurs
        
        
        
        
      }else{
        progress$inc(1/3)
        
        output$ERROR_MGS_Modifier_un_utilisateur<-renderText({
          paste("<font color=\"#a9355a\"><b>", testUser, "</b></font>")
        })
      }
      
      
    })
    
    ########################################
  }#end serverLes_utilisateurs