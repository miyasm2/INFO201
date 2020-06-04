# this function takes in a data set and returns a chart
# showing the number of hate crimes that occurred per quarter


library("dplyr")
library("tidyr")
library("plotly")

quarterly_crimes_chart <- function(dataset) {
  quarterly_crimes <- dataset %>%
    select(X1st.quarter, X2nd.quarter, X3rd.quarter, X4th.quarter) %>%
    summarise(
      "1st Quarter" = sum(X1st.quarter, na.rm = TRUE),
      "2nd Quarter" = sum(X2nd.quarter, na.rm = TRUE),
      "3rd Quarter" = sum(X3rd.quarter, na.rm = TRUE),
      "4th Quarter" = sum(X4th.quarter, na.rm = TRUE)
    ) %>%
    gather(quarter, num_crimes)

  chart <- plot_ly(
    data = quarterly_crimes,
    x = ~quarter,
    y = ~num_crimes,
    type = "scatter",
    mode = "lines+markers"
  ) %>%
    layout(
      title = "Hate crime occurences per quarter",
      yaxis = list(title = "Number of Crimes", range = c(1000, 1800)),
      xaxis = list(title = "Quarter")
    )

  return(chart)
}
