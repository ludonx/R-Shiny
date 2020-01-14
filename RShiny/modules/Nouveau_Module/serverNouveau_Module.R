serverNouveau_Module<-
  function(input, output, session,globalInformation){
    ### FlexBox.R  #Menu
    source(
      file.path(
        paste0(app$config$pathToModule,"Nouveau_Module"),
        "serverNouveau_Module_FlexBox.R"),
      local = TRUE)$value
  }