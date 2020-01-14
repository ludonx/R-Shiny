
# flags <- c(
#   #"https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/au.svg",
#   "https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/fr.svg",
#   "https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/gb.svg",
#   #"https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/us.svg"
# )

countries <- c("Fr", "En")
flags <- c(
  "fr.png",
  "en.png"
)

tabItem_Reglage<-
  tabItem(tabName = "Reglage",
          h5("> Réglage"),
          #br(),
          
          fluidRow(
            box(
              status = "primary",
             
              pickerInput(
                inputId ="pickerInputt_langue" ,
                label =
                  list(
                    fr="langues",
                    en="languages"
                  )["en"],
                choices =countries ,
                
                choicesOpt = list(content =  
                                    mapply(countries, flags, FUN = function(country, flagUrl) {
                                      HTML(paste(
                                        tags$img(src=flagUrl, width=20, height=15)
                                        #,country
                                      ))
                                    }, SIMPLIFY = FALSE, USE.NAMES = FALSE)
                                  
                          ),
                selected = "En",
                width ='50%'
                ),#end pickerInput
                
              
              br(),
              actionButton(inputId = paste0("ActionDeconnexion"),
                 label = "Deconnexion",
                 icon("walking"),
                 style="color: #fff; background-color: #b73263; border-color: #b7319c"
              )
            )
            
          )
          
  )
