# load libraries
library(plotly)
library(ggplot2)
library(stringr)
library(shinyWidgets)

source("scripts/build_bar.R")
source("scripts/build_line.R")
source("scripts/interactive_map.R")

bar_df <- read.csv("data/barchartdata.csv", stringsAsFactors = FALSE)
line_df <- read.csv("data/hate-crimes-2013-2018.csv", stringsAsFactors = FALSE)
map_df <- read.csv("data/new_mapdf.csv", stringsAsFactors = FALSE)
state_codes <- read.csv("./data/state_codes.csv", stringsAsFactors = FALSE)

joined_data <- left_join(map_df, state_codes, by = "State")

server <- function(input, output) {
  # chart one
  output$map <- renderPlotly({
    return(interactive_map(joined_data, input$mapvar))
  })

  # chart 2
  output$barplot <- renderPlotly({
    return(build_bar(bar_df, input$topic, input$bias))
  })

  # chart three
  output$linechart <- renderPlotly({
    return(build_line(line_df, input$category))
  })

  output$barcompare <- renderPlotly({
    return(build_compare(line_df, input$year1, input$year2))
  })
}
