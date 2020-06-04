library("plotly")
library("dplyr")
library("tidyr")

# formatting a new df to plot
total_crimes_categories <- function(df) {
  hate_crimes_totals <- df %>%
    select(
      Race, Religion,
      Ethnicity, Sexual.orientation,
      Disability, Gender,
      Gender.Identity
    ) %>%
    summarise(
      Race = sum(Race, na.rm = TRUE),
      Sexual.orientation = sum(Sexual.orientation, na.rm = TRUE),
      Ethnicity = sum(Ethnicity, na.rm = TRUE),
      Disability = sum(Disability, na.rm = TRUE),
      Gender = sum(Gender, na.rm = TRUE),
      Gender.Identity = sum(Gender.Identity, na.rm = TRUE)
    ) %>%
    gather(crime_type, total)
  # bar chart of crime type vs. total of each type
  plot <- plot_ly(
    data = hate_crimes_totals, x = ~crime_type,
    y = ~total, type = "bar", color = "rgba(255, 0, 0)"
  ) %>%
    layout(
      title = "Hate Crime Categories and Frequency",
      xaxis = list(title = "Crime Categories")
    )
  return(plot)
}
