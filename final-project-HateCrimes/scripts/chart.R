# Read the data set


# Load dplyr
library("dplyr")
library("ggplot2")

# Total Hate Crimes by State Function and graph
crimes_by_state_chart <- function(dataset) {
  hate_crimes_by_state <- dataset %>%
    mutate(hc_sum = rowSums(.[4:10])) %>%
    group_by(State) %>%
    summarize(hc_sum = n())
  scatter_plot <- ggplot(data = hate_crimes_by_state) +
    geom_point(mapping = aes(x = hc_sum, y = State)) +
    labs(
      title = "Hate Crimes per State",
      x = "Number of Hate Crimes",
      y = "State"
    )
  return(scatter_plot)
}
