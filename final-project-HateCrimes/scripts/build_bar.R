library("ggplot2")
library("dplyr")
library("tidyr")
library("plotly")

bar_df <- read.csv("data/barchartdata.csv", stringsAsFactors = FALSE)

# formatting a new df to plot
build_bar <- function(data, topic, bias) {
  filtered_columns <- data %>% select("motivation", topic)

  if (bias == "Race") {
    filtered_rows <- filtered_columns %>% slice_(4, 5, 6, 7, 8, 9)
  } else if (bias == "Religion") {
    filtered_rows <- filtered_columns %>% slice_(11, 12, 13, 14, 15, 16, 17)
  } else if (bias == "Sexual Orientation") {
    filtered_rows <- filtered_columns %>% slice_(19, 20, 21, 22, 23)
  } else if (bias == "Ethnicity") {
    filtered_rows <- filtered_columns %>% slice_(25, 26)
  } else if (bias == "Disability") {
    filtered_rows <- filtered_columns %>% slice_(28, 29)
  } else if (bias == "Gender") {
    filtered_rows <- filtered_columns %>% slice_(31, 32)
  } else if (bias == "Gender Identity") {
    filtered_rows <- filtered_columns %>% slice_(34, 35)
  } else if (bias == "Total") {
    filtered_rows <- filtered_columns %>% slice_(
      3, 10, 18,
      24, 27, 30,
      33
    )
  }


  names(filtered_rows)[1] <- "xvals"
  names(filtered_rows)[2] <- "yvals"

  # bar chart of crime type vs. total of each type
  barplot <- plot_ly(
    filtered_rows,
    x = ~xvals,
    y = ~ as.numeric(yvals),
    type = "bar"
  ) %>%
    layout(
      title = paste0(
        "Hate Crime Breakdown based on: ",
        topic, " and ", bias
      ),
      yaxis = list(title = topic),
      xaxis = list(title = "Crime Categories")
    )
  return(barplot)
}
