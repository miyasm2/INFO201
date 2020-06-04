library("ggplot2")
library("dplyr")
library("plotly")
library("stringr")

interactive_map <- function(data, map_var) {
  # specify some map projection/options
  g <- list(
    scope = "usa",
    projection = list(type = "albers usa"),
    showlakes = TRUE,
    lakecolor = toRGB("white")
  )


  # Plot
  map <- plot_geo(data, locationmode = "USA-states") %>%
    add_trace(
      z = data[, map_var], text = ~State, locations = ~code,
      color = data[, map_var], colors = "Purples"
    ) %>%
    colorbar(title = "Color Title") %>%
    layout(
      title = str_to_title(map_var),
      geo = g
    )
  return(map)
}
