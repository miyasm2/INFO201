library("plotly")

build_line <- function(data, category_var) {
  plot_ly(
    data = data,
    x = ~year,
    y = ~ get(category_var),
    type = "scatter",
    mode = "lines+markers"
  ) %>%
    layout(
      title = "Hate Crime Incidents by Year",
      yaxis = list(title = "Number of Crimes"),
      xaxis = list(title = "Year")
    )
}

build_compare <- function(data, year1, year2) {
  xval <- colnames(data)
  xval <- xval[-1]

  yval1 <- data %>%
    filter(year == year1) %>%
    select(-year)
  yval1 <- as.numeric(as.vector(yval1[1, ]))

  yval2 <- data %>%
    filter(year == year2) %>%
    select(-year)
  yval2 <- as.numeric(as.vector(yval2[1, ]))

  compare <- plot_ly(
    data,
    x = ~xval, y = ~yval1, type = "bar", name = year1
  ) %>%
    add_trace(
      y = ~yval2, name = year2
    ) %>%
    layout(
      title = paste0(
        "Hate Crime Incident Comparison: ", year1, " vs ",
        year2
      ),
      xaxis = list(
        title = "Incident Types"
      ),
      yaxis = list(title = "Number of Incidents"),
      barmode = "group"
    )
  return(compare)
}
