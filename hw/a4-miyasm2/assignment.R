# A4 Data Wrangling
# We provide this line to delete all variables in your workspace.
# This will make it easier to test your script.
# used to clear env:rm(list = ls())

# Loading and Exploring Data -------------------------------- (**29 points**)

# First, search online for a dplyr cheatsheet and put the link to one you
# like in the comments here (it's ok if the link makes the line too long):
# - <https://rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf>

# To begin, you'll need to download the Kickstarter Projects data from the
# Kaggle website: https://www.kaggle.com/kemical/kickstarter-projects
# Download the `ks-projects-201801.csv` file into a new folder called `data/`

# Load the `dplyr` package
# loading and installing: install.packages('dplyr')
library(dplyr)

# We provide this code to make sure your locale is in English so that
# files will be read correctly
Sys.setlocale("LC_ALL", "English")

# Load your data, making sure to not interpret strings as factors.
ks_project <- read.csv("data/ks-projects-201801.csv", stringsAsFactors = FALSE)
is.data.frame(ks_project)
ks_df <- as.data.frame(ks_project, stringsAsFactors = FALSE)
ks_df <- na.omit(ks_df)
View(ks_df)


# To start, write the code to get some basic information about the dataframe:
# - What are the column names?
# - How many rows is the data frame?
# - How many columns are in the data frame?
col_name <- colnames(ks_df)
n_row <- nrow(ks_df)
n_col <- ncol(ks_df)

# Use the `summary` function to get some summary information
summary(ks_df)

# Unfortunately, this doesn't give us a great set of insights. Let's write a
# few functions to try and do this better.
# First, let's write a function `get_col_info()` that takes as parameters a
# column name and a dataframe. If the values in the column are *numeric*,
# the function should return a list with the keys:
# - `min`: the minimum value of the column
# - `max`: the maximum value of the column
# - `mean`: the mean value of the column
# If the column is *not* numeric and there are fewer than 10 unique values in
# the column, you should return a list with the keys:
# - `n_values`: the number of unique values in the column
# - `unique_values`: a vector of each unique value in the column
# If the column is *not* numeric and there are 10 or *more* unique values in
# the column, you should return a list with the keys:
# - `n_values`: the number of unique values in the column
# - `sample_values`: a vector containing a random sample of 10 column values
# Hint: use `typeof()` to determine the column type
get_col_info <- function(ks_col, ks_df) {
  col_type <- typeof(ks_df[[ks_col]])
  col <- ks_df[[ks_col]]
  if (col_type == ("double") | col_type == "integer") {
    min_val <- min(col, na.rm = TRUE)
    max_val <- max(col, na.rm = TRUE)
    mean_val <- mean(col, na.rm = TRUE)
    min_out <- "The Minimum Value:"
    max_out <- "The Maximum Value:"
    mean_out <- "The Mean Value:"
    col_list <- list(
      min_out = min_val,
      max_out = max_val,
      mean_out = mean_val
    )
  } else {
    n_values <- length(unique(col, incomparables = FALSE))
    n_out <- "The Number of Unique Values in the Column:"
    if (n_values < 10) {
      unique_values <- unique(col, incomparables = FALSE)
      unique_out <- "Each Unique Value in the Column:"
      col_list <- list(
        n_out = n_values,
        unique_out = unique_values
      )
    } else {
      sample_values <- sample(unique(col, incomparables = FALSE),
        10,
        replace = FALSE, prob = NULL
      )
      sample_out <- "Random Sample of 10 Unique Values:"
      col_list <- list(
        n_out = n_values,
        sample_out = sample_values
      )
    }
  }
  col_list
}
# Demonstrate that your function works by passing a column name of your choice
# and the kickstarter data to your function. Store the result in a variable
# with a meaningful name
goal_info <- get_col_info("goal", ks_df)

# To take this one step further, write a function `get_summary_info()`,
# that takes in a data frame  and returns a *list* of information for each
# column (where the *keys* of the returned list are the column names, and the
# _values_ are the summary information returned by the `get_col_info()` function
# The suggested approach is to use the appropriate `*apply` method to
# do this, though you can write a loop
get_summary_info <- function(ks_df) {
  sapply(colnames(ks_df), get_col_info, USE.NAMES = TRUE, ks_df)
}
# Demonstrate that your function works by passing the kickstarter data
# into it and saving the result in a variable
test_summary <- get_summary_info(ks_df)

# Take note of 3 observations that you find interesting from this summary
# information (and/or questions that arise that want to investigate further)
# YOUR COMMENTS HERE
# LIKELY ON MULTIPLE LINES

# Asking questions of the data ----------------------------- (**29 points**)

# Write the appropriate dplyr code to answer each one of the following questions
# Make sure to return (only) the desired value of interest (e.g., use `pull()`)
# Store the result of each question in a variable with a clear + expressive name
# If there are multiple observations that meet each condition, the results
# can be in a vector. Make sure to *handle NA values* throughout!
# You should answer each question using a single statement with multiple pipe
# operations!
# Note: For questions about goals and pledged, use the usd_pledged_real
# and the usd_goal_real columns, since they standardize the currancy.

# What was the name of the project(s) with the highest goal?
highest_goal_projects <- ks_df %>%
  filter(goal == max(goal)) %>%
  select(name) %>%
  pull(name)

# What was the category of the project(s) with the lowest goal?
lowest_goal_categories <- ks_df %>%
  filter(goal == min(goal)) %>%
  select(category) %>%
  pull(category)

# How many projects had a deadline in 2018?
# Hint: start by googling "r get year from date" and then look up more about
# different functions you find
deadline_2018 <- ks_df %>%
  filter(between(
    as.Date(deadline), as.Date("2018-1-1"),
    as.Date("2018-12-31")
  )) %>%
  nrow()

# What proportion of projects weren't marked successful (e.g., failed or live)?
# Your result can be a decimal
unsuccessful_projects <- ks_df %>%
  filter(state == "failed" | state == "canceled") %>%
  nrow() / nrow(ks_df)

# What was the amount pledged for the project with the most backers?
most_backers <- ks_df %>%
  filter(backers == max(backers)) %>%
  select(usd_pledged_real) %>%
  pull(usd_pledged_real)

# Of all of the projects that *failed*, what was the name of the project with
# the highest amount of money pledged?
failed_with_highest_pled <- ks_df %>%
  filter(state == "failed") %>%
  filter(usd_pledged_real == max(usd_pledged_real)) %>%
  pull(name)

# How much total money was pledged to projects that weren't marked successful?
total_failed_projects <- ks_df %>%
  filter(state == "failed" | state == "canceled") %>%
  pull(usd_pledged_real) %>%
  sum()

# Performing analysis by *grouped* observations ----------------- (31 Points)

# Which category had the most money pledged (total)?
richest_category <- ks_df %>%
  group_by(category) %>%
  summarize(usd_pledged_real = max(usd_pledged_real)) %>%
  filter(usd_pledged_real == max(usd_pledged_real)) %>%
  pull(category)

# Which country had the most backers?
most_backers_country <- ks_df %>%
  group_by(country) %>%
  summarize(backers = sum(backers)) %>%
  filter(backers == max(backers)) %>%
  pull(country)

# Which year had the most money pledged (hint: you may have to create a new
# column)?
# Note: To answer this question you can choose to get the year from either
# deadline or launched dates.
most_money_pledge <- ks_df %>%
  mutate(year = substr(ks_df$deadline, 1, 4)) %>%
  group_by(year) %>%
  summarize(usd_pledged_real = sum(usd_pledged_real)) %>%
  filter(usd_pledged_real == max(usd_pledged_real)) %>%
  pull(year)

# Write one sentance below on why you chose deadline or launched dates to
# get the year from:
# I chose the deadline because, it did not have the time, like the launch
# group did. I was not sure, if the time was going to effect the code.

# What were the top 3 main categories in 2018 (as ranked by number of backers)?
ranked_backers <- ks_df %>%
  mutate(year = substr(ks_df$deadline, 1, 4)) %>%
  filter(year == "2018") %>%
  group_by(main_category) %>%
  summarize(total_backers = sum(backers, na.rm = TRUE)) %>%
  arrange(-total_backers) %>%
  pull(main_category)

top3_main_cat <- ranked_backers[1:3]

# What was the most common day of the week on which to launch a project?
# (return the name of the day, e.g. "Sunday", "Monday"....)
most_common_day <- ks_df %>%
  mutate(days = weekdays(as.Date(launched, "%Y-%m-%d")), na.rm = TRUE) %>%
  group_by(days) %>%
  mutate(count = n(), na.rm = T) %>%
  ungroup() %>%
  filter(count == max(count, na.rm = T)) %>%
  summarise(days = max(days, na.rm = T)) %>%
  pull(days)


# What was the least successful day on which to launch a project? In other
# words, which day had the lowest success rate (lowest proportion of projects
# that were marked successful )? This might require creative problem solving...
# Hint: Try googling "r summarize with condition in dplyr"
least_successful_launching_day <- ks_df %>%
  mutate(days = weekdays(as.Date(
    deadline, "%Y-%m-%d"
  )), na.rm = TRUE) %>%
  group_by(days) %>%
  mutate(total_num_state = n(), na.rm = TRUE) %>%
  group_by(days, state) %>%
  filter(state != "successful") %>%
  mutate(count_unsuccessful = n()) %>%
  mutate(percent = (count_unsuccessful / total_num_state)) %>%
  ungroup() %>%
  filter(percent == min(percent, na.rm = TRUE)) %>%
  summarise(days = min(days, na.rm = T)) %>%
  select(days) %>%
  pull(days)
