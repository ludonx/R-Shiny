# ------------------------------------------------------------------------#
# Functions dedicated to printing in the message console (the black one) ----
# ------------------------------------------------------------------------#


print_text<-
  function(text="texte vide ..."){
    paste0(globalInformation$modules$Ma_console$text,"\n",text)
    globalInformation$modules$Ma_console$text<-text
  }


print_plot<-
  function(plot){
    if(("ggplot" %in% class(plot)) || ("plot" %in% class(plot) )){
    globalInformation$modules$Ma_console$plot<-plot
    }
  }


print_dataFrame<-
  function(dataframe){
    if(class(dataframe)=="data.frame"){
      globalInformation$modules$Ma_console$dataFrame<-dataframe
    }
  }

# **  PRINTY_TEXT ----
#' @param obj: a text, dataframe or plot
#' @param stdout:  the name of the output to be used (mc: my console module, log: console log)
printy_text <- function(obj = "", stdout = "log")
{
  if(!is.null(globalInformation$modules$Ma_console) & !is.null(globalInformation$Console))
  {
    if(stdout == "mc")
    {
      txt <- paste(globalInformation$modules$Ma_console$text,paste(obj, collapse = "\t"), sep="\n")
      globalInformation$modules$Ma_console$text <- txt
    }
    if(stdout == "log")
    {
      txt <- paste(globalInformation$Console, paste(obj, collapse = "\t"), sep="\n")
      globalInformation$Console <- txt
    }else
    {
      warning(paste0("printy_text: the stdout ",stdout," does not exist!")) 
    }
  }
  if(stdout != "log" & stdout == "mc")
  {
   warning("printy_text: object Ma_console should exist") 
  }
}

# **  PRINTY_DF ----
#' @param obj: a text, dataframe or plot
#' @param stdout:  the name of the output to be used (mc: my console module, log: console log)
printy_df <- function(obj = NULL, stdout = "mc"){
  if(!is.null(globalInformation$modules$Ma_console) & !is.null(globalInformation$Console))
  {
    if(stdout == "mc")
    {
      globalInformation$modules$Ma_console$dataFrame <- obj
    }
    if(stdout == "log")
    {
      # globalInformation$Console <- paste(paste(apply(obj,1, paste, collapse = "\t")), collapse = "\n")
      txt <- paste(globalInformation$Console, str(obj), sep="\n")
      globalInformation$Console <- txt
    }
    if(stdout != "log" & stdout == "mc")
    {
      warning(paste0("printy_df: the stdout ",stdout," does not exist!")) 
    }
  }else
  {
    warning("printy_text: object Ma_console should exist") 
  }
}

# **  PRINTY_PLOT ----
#' @param obj: a text, dataframe or plot
#' @param stdout:  the name of the output to be used (mc: my console module, log: console log)
printy_plot <- function(obj = NULL, stdout = "mc")
{
  if(!is.null(globalInformation$modules$Ma_console))
  {
    if(stdout == "mc")
    {
      globalInformation$modules$Ma_console$plot <- obj
    }
    else
    {
      warning(paste0("printy_df: the stdout ",stdout," does not exist!")) 
    }
  }else
  {
    warning("printy_text: object Ma_console should exist") 
  }
}

# **  PRINTY ----
#' @param obj: a text, dataframe or plot
#' @param stdout:  the name of the console to be sent
printy <-  function(obj = NULL, stdout = "log")
{
  if(is.null(obj))
  {
    warning("printy: object should exist")
  }
  
  if(is.null(globalInformation))
  {
    warning("printy: object should exist")
    # next
  }
  correct.format <- FALSE
  
  # TEXT
  if(is.vector(obj))
  {
    printy_text(obj = obj, stdout = stdout)
    correct.format <- TRUE
  }
  
  # 2D DF OR MATRIX
  # if(!is.vector(obj) & !is.list(obj) & is.ggplot(obj))
  if(is.matrix(obj) | is.data.frame(obj))
  {
    printy_df(obj = obj, stdout = stdout)
    correct.format <- TRUE
  }
  
  if(is.ggplot(obj))
  {
    printy_plot(obj = obj, stdout = stdout)
    correct.format <- TRUE
  }
  
  if(!correct.format)
  {
    warning("printy: object can not fit the standards")
  }
}


# Clean function ----
clean_text <- function(){globalInformation$modules$Ma_console$text<-""}
clean_plot <- function(){globalInformation$modules$Ma_console$plot<-""}
clean_dataframe <- function(){globalInformation$modules$Ma_console$dataFrame<-data.frame()}

# ------------------------------------------------------------------------#
# Functions dedicated to save module variable ----
# ------------------------------------------------------------------------#


# ** SAVE_MA_CONSOLE ----

### i use reactive because function does not work


