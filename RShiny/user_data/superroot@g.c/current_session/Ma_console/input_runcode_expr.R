my_config_df <- app$config_df[which((globalInformation$user$access_level >= app$config_df$priority) & (!is.na(app$config_df$menu))),]
my_config_df10 <- app$config_df[which((11 >= app$config_df$priority) & (!is.na(app$config_df$menu))),]
c<-class(globalInformation$user$access_level)
printy(my_config_df10,"mc")
printy(c,"mc")
