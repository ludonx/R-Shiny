tabItem_Gestion_des_utilisateurs<-
  tabItem(
    tabName = "Gestion_des_utilisateurs",
    fluidPage(
      tabBox(
        id = "tabID_Gestion_des_utilisateurs",width = 12,
        tabPanel(
          title = tagList(shiny::icon("clipboard-list"), "Les utilisateurs"),
          value="tabPanel_Les utilisateurs",
          uiOutput("uiLes_utilisateurs"),
          uiOutput("uiModifier_un_utilisateur")
        ),
        tabPanel(
          title = tagList(shiny::icon("user-plus"), "Ajouter un utilisateur"),
          value="tabPanel_Ajouter_un_utilisateur",
          uiOutput("uiAjouter_un_utilisateur")
        ),
        tabPanel(
          title = tagList(shiny::icon("user-tag"), "Affection de projets"),
          value="tabPanel_Affection_de_projets",
          uiOutput("uiAffection_de_projets")
        )
      )#end tabBox
    )#end fluidPage
   
  )#end tabItem