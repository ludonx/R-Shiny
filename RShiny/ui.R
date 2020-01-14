
#
## ui.R ##
ui <- function(req)
{
  
  # Put them together into a dashboardPage
  # permet de modifier la langue de datatable
  # French.json = en français
  # Chinise.json = en chinois
  options(
    DT.options =
      list(
        pageLength = 5,
        #language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/French.json')
        language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/English.json')
      )
  )
  #useShinyjs()
  
  
  # structure de notre application
  # ici on utilise une structure type shinydashboard
  # les variables mainDashboardHeader,mainDashboardSidebar et mainDashboardHeader
  # sont definie chacun dans un dossier
  dashboardPage(
    header = dashboardHeader(title = tags$img(src='IntegrOmics.png', title = "INTERGROMICS",height = '40', width = '160')), # ou simplement img
    sidebar = dashboardSidebar(sidebarMenuOutput("sidebarMenuOutput")), # voir serverConnexion
    body = dashboardBody(useShinyjs(),do.call(tabItems, app$modules$ui)), # end dashbordBody
    title = paste0("INTEGROMICS"),
    skin = "black"
  ) # end dashbordPage
}

