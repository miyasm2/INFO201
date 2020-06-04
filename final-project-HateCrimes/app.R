# load the libraries used in files
library(shiny)
library(ggplot2)
library(plotly)

# link ui and server files
source("app_server.R")
source("app_ui.R")

# calling the shinyApp
shinyApp(ui = ui, server = server)



