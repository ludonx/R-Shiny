download_KEGG_modules_annotations <- function(link = 'https://www.genome.jp/kegg-bin/download_htext?htext=ko00002.keg&format=json&filedir=')
{
  
  datajson = tryCatch(rjson::fromJSON(file = link),
                      error = function(e)
                      {
                        tryCatch(fromJSON(file = sub("^https", "http", link)),
                                 error = function(e)
                                 {
                                   message("Error in downloading modules' annotations from KEGG:",
                                           "\nLink to download the json file containing the modules' annotation seems to be deprecated.",
                                           " Please try to find the right one and send it to the fuction as a value of 'link' argument.",
                                           "\nDo not hesitate to contact the maintainer of the package to aware him and stay tuned for updates !",
                                           "\nNote that the link was found on 'https://www.genome.jp/kegg-bin/get_htext?ko00002.keg', on 'Download json' page link.")
                                   opt.inner <- options(show.error.messages=FALSE)
                                   on.exit(options(opt.inner))
                                   stop("Without message")
                                 })
                      })
  
  datajson = datajson$children
  
  pattern = "^(M00[0-9]+)[ ]+([^\\[]+)"
  modules.annotation = list()
  for(i1 in 1:length(datajson))
  {
    md.type = datajson[[i1]]$name
    data1 = datajson[[i1]]$children
    for(i2 in 1:length(data1))
    {
      md.metabo1 = data1[[i2]]$name
      data2 = data1[[i2]]$children
      for(i3 in 1:length(data2))
      {
        md.metabo2 = data2[[i3]]$name
        data3 = data2[[i3]]$children
        strings = sapply(data3, function(x){x$name})
        matches = regmatches(strings, regexec(pattern, strings))
        
        matches = matrix(unlist(matches), ncol = 3, byrow = TRUE, dimnames = list(NULL, c("ToRemove", "md", "definition")))
        matches = matches[,2:3, drop = FALSE]
        
        # Some modules may have names that are not compatible with the first regex
        
        matches = cbind(
          matrix(c(md.type, md.metabo1, md.metabo2), nrow = nrow(matches), ncol = 3, byrow = TRUE,
                 dimnames = list(NULL, c("type", "subType1", "subType2"))),
          matches
        )
        
        modules.annotation[[length(modules.annotation)+1]] = matches
      }
    }
  }
  
  modules.annotation = do.call(rbind, modules.annotation)
  modules.annotation = data.frame(modules.annotation, stringsAsFactors = FALSE)
  modules.annotation = modules.annotation[order(modules.annotation$md),]
  
  #rownames(modules.annotation) = paste("md:",modules.annotation[,"md"], sep = "")
  rownames(modules.annotation) = modules.annotation[,"md"]
  modules.annotation = modules.annotation[,-which(colnames(modules.annotation)=="md")]
  
  return(modules.annotation)
  
}
