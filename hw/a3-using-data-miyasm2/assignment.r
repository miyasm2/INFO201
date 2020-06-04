# Assignment 3: Using Data
# Before you get started:
# - Set your working directory to "source file location" using the Session menu
# - Run the following line of code to delete all variables in your workspace
#     (This will make it easier to test your script)
# used to clear env:rm(list = ls())

### Built in R Data ###########################################################

# In this section, you'll work with the variable `Titanic`, a data set which is
# built into the R environment.
# This data set actually loads in a format called a *table*
# See https://cran.r-project.org/web/packages/data.table/data.table.pdf
# Use the `is.data.frame()` function to test if it is a table.
t <- data("Titanic")
is.data.frame(t)

# Create a variable `titanic_df` by converting `Titanic` into a data frame;
# you can use the `data.frame()` function or `as.data.frame()`
# Hint: Be sure to **not** treat strings as factors!
titanic_df <- as.data.frame(Titanic, stringsAsFactors = FALSE)

# It's important to understand the _meaning_ of each column before analyzing it
# Using comments below, describe what information is stored in each column
# For categorical variables, list all possible values
# Class: Differnt societal classes, including,
# the 1st, 2nd, 3rd class.
# Lastly we will include the crew.
# Sex: This is what it is labled as,
# the person is either male or female.
# Age: The age of all the passangers,
# from the infants aboard to
# the oldest person of 74 years:
# Child or Adults
# Survived: This means that they got off the
# ship and survived until they were
# found and rescuded: yes or no]
# Freq: This shows the amount of people
# that apply to the category of class,
# sex, age and if they survived. For example,
# for a 1st class male child that did not
# survive there were 0 of them.

# Create a variable `children` that is a data frame containing only the rows
# from `titanic_df` with information about children on the Titanic
# Hints:
# - Filter rows using a vector of boolean values (like vector filtering)
# - See chapter 10.2.3
children <- titanic_df[titanic_df$Age == "Child", ]

# Create a variable `num_children` that is the total number of children.
# Hint: Remember the `sum()` function!
num_children <- sum(children$Freq)

# Create a variable `most_lost` that is the *row* from `titanic_df` with the
# largest absolute number of losses (people who did not survive)
# You can use multiple lines of code if you find that helpful
# to create this variable
# Hint: Filter for those who did not survive, then look for the row
filter <- titanic_df[titanic_df$Survived == "No", ]
most_lost <- filter[filter$Freq == max(filter$Freq), ]

# Define a function called `survival_rate()` that takes in two arguments which
# must be in *the following order*:
# - a ticket class (e.g., "1st", "2nd"), and
# - the dataframe itself (it's good practice to explicitly pass in data frames)
#
# This function should return a sentence that states the *survival rate*
# (# survived / # in group) of adult men and "women and children" in that
# ticketing class.
# It should read (for example):
# >"Of Crew class, 87% of women and children survived and 22% of men survived."
#
# This is a complicated function! We recommend the following approach:
# - Filter for all rows representing the given ticketing class and save the
#   new data frame to a variable
# - Using this data frame, filter for all rows representing Adult Males
# - Find the total number of men and total number of male survivors to
#   calculate the survival rate
# - Likewise, use the data frame to filter for all Children and Adult Females
# - Perform the above calculation for this group as well
#
# Other approaches are also acceptable, please comment to explain what you do!
survival_rate <- function(class, titanic_df) {
  filter_class <- titanic_df[titanic_df$Class == class, ]
  filter_surv <- filter_class[filter_class$Survived == "Yes", ]
  class_wom_child <- filter_class[filter_class$Age == "Child"
  | filter_class$Age == "Adult"
    & filter_class$Sex == "Female", ]
  filter_men <- filter_class[filter_class$Age == "Adult"
  & filter_class$Sex == "Male", ]
  surv_wom_child <- filter_surv[filter_surv$Age == "Child"
  | (filter_surv$Age == "Adult"
    & filter_surv$Sex == "Female"), ]
  surv_men <- filter_surv[(filter_surv$Age == "Adult"
  & filter_surv$Sex == "Male"), ]
  wom <- round(sum(surv_wom_child$Freq) /
    sum(class_wom_child$Freq) * 100)
  men <- round(sum(surv_men$Freq) /
    sum(filter_men$Freq) * 100)
  return(paste0(
    "Of ", class, " class ", round(wom),
    "% of women and children survived and ", round(men),
    "% of men survived."
  ))
}
# Create variables `first_survived`, `second_survived`, `third_survived` and
# `crew_survived` by passing each class and the `titanic_df` data frame
# to your `survival_rate` function
first_survived <- survival_rate("1st", titanic_df)
second_survived <- survival_rate("2nd", titanic_df)
third_survived <- survival_rate("3rd", titanic_df)
crew_survived <- survival_rate("Crew", titanic_df)
# What notable differences do you observe in the survival rates across classes?
# Note at least 2 observations.

# From the data we can see that the 1st class
# had the highest survival rate,which is to be expected.
# It was strange to see not only how high the 2nd class
# survival rate was but also the crew survival rate.
# Lastly the saddest result was the survival rate of
# the 3rd class was less than 50%.


# What notable differences do you observe in the survival rates between the
# women and children versus the men in each group?
# Note at least 2 observations.

# Unless I did the code wrong, it is strange to see
# that the children on the 3rd class have a higher frequency
# of survival than the 1st and 2nd class. As well as the adult
# men having a high survival rate due to the fact I believe
# they asked for woman and children first. Also that there is just
# no data on the crew children, indicating that none of  the crew
# memebers had children.


### Reading in Data ###########################################################

# In this section, you'll work with .csv data of life expectancy by country
# First, download the csv file of `Life Expectancy` data from GapMinder:
# https://www.gapminder.org/data/
# You should save the .csv file into your `data` directory
# Before getting started, explore the GapMinder website to better understand
# the *original* source of the data (e.g., who calculated these estimates)
# Place a brief summary of the each data source here (e.g., 1 - 2 sentences
# per data source)

# This data is from the gapminder website,
# where they are studying the life expectancy
# in years of the average number of years a
# newborn child would live if current would
# live if current moraltiy patterns were to stay the same.
# We then have a list of alphabatized
# countries, from the year 1800 to 2100.
# This data was compiled by Mattias Lindgren, who also assesed
# the fatal impacts of the biggest diaster in history
# and made a rough guesstimates showing in the charts
# as sudden dips in life expectancy. In summary, this data set
# is a global burden of disease study was used,
# along with UW health institutes. UN Forecasts were also
# considered,and natrual disaster analytics to form the data set.

# Using the `read.csv` function, read the life_expectancy_years.csv file into
# a variable called `life_exp`. Make sure not to read strings as factors
life_exp <- read.csv("data/life_expectancy_years.csv", stringsAsFactors = FALSE)
is.data.frame(life_exp)


# Write a function `get_col_mean()` that takes a column name and a data frame
# and returns the mean of that column. Make sure to properly handle NA values
# Hint: `mean()` takes in an argument called `na.rm`
get_col_mean <- function(col_name, life_exp) {
  return(mean(life_exp[, col_name], na.rm = TRUE))
}

# Create a list `col_means` that has the mean value of each column in the
# data frame (except the `Country` column). You should use your function above.
# Hint: Use an `*apply` function (lapply, sapply, etc.)
v <- colnames(life_exp[, -1])
col_means <- lapply(v, get_col_mean, life_exp)

# Create a variable `avg_diff` that is the difference in average country life
# expectancy between 1800 and 2018
avg_diff <- mean((life_exp$X2018 - life_exp$X1800), na.rm = TRUE)

# Create a column `life_exp$change` that is the change in life
# expectancy from 2000 to 2018. Increases in life expectancy should
# be *positive*
life_exp$change <- life_exp$X2018 - life_exp$X2000

# Create a variable `most_improved` that is the *name* of the country
# with the largest gain in life expectancy. Make sure to filter NA values
# Hint: `max()` takes in an argument called `na.rm`
max_improve <- max(life_exp$change, na.rm = TRUE)
most_improved <- na.omit(life_exp$country[life_exp$change == max_improve])

# Create a variable `num_small_gain` that has the *number* of countries
# whose life expectance has improved less than 1 year between 2000 and 2018
# Make sure to filter NA values
# Hint: Lookup `is.na()`
num_small_gain <- length(life_exp[life_exp$change < 1
                                  & !is.na(life_exp$change), "country"])

# Write a function `country_change()` that takes in a country's name,
# two years as numbers (not strings), and the `life_exp` data frame
# Parameters should be written *in the above order*
# It should return the phrase:
# "Between YEAR1 and YEAR2, the life expectancy in COUNTRY went DIRECTION by
# SOME_YEARS years".
# Make sure to properly indictate the DIRECTION as "up" or "down"
# Hint: Use an if/else statement to help compute DIRECTION
country_change <- function(country, year_1, year_2, life_exp) {
  chosen_year_1 <- life_exp[
    life_exp$country == country,
    paste("X", year_1, sep = "")
  ]
  chosen_year_2 <- life_exp[
    life_exp$country == country,
    paste("X", year_2, sep = "")
  ]
  if (chosen_year_1 > chosen_year_2) {
    direction <- "down"
  } else {
    direction <- "up"
  }
  return(paste0(
    "Between ", year_1, " and ", year_2,
    " the life expectancy in ",
    country, " went ", direction, " by ",
    round(abs(chosen_year_2 - chosen_year_1), 1),
    " years."
  ))
}

# Using your `country_change()` function, create a variable `sweden_change`
# that is the change in life expectancy from 1960 to 1990 in Sweden
sweden_change <- country_change("Sweden", "1960", "1990", life_exp)

# Write a function `compare_change()` that takes in two country names and your
# `life_exp` data frame as parameters, and returns a sentence that describes
# their change in life expectancy from 2000 to 2018 (the `change` column)
# For example, if you passed the values "China", and "Bolivia" to you function,
# It would return this:
# "The country with the bigger change in life expectancy was China (gain=6.9),
#  whose life expectancy grew by 0.6 years more than Bolivia's (gain=6.3)."
# Make sure to round your numbers to one digit (though only after calculations)
# Hint: Use an if/else statement to paste the countries in the correct order
compare_change <- function(country_one, country_two) {
  country_one_change <- life_exp[
    life_exp$country == country_one,
    "change"
  ]
  country_two_change <- life_exp[
    life_exp$country == country_two,
    "change"
  ]
  if (country_one_change > country_two_change) {
    bigger_country <- country_one
    bigger_country_change <- round(country_one_change, 1)
    smaller_country <- country_two
    smaller_country_change <- round(country_two_change, 1)
  } else {
    bigger_country <- country_two
    bigger_country_change <- round(country_two_change, 1)
    smaller_country <- country_one
    smaller_country_change <- round(country_one_change, 1)
  }
  return(paste0(
    "The country with the bigger change in life expectancy was ",
    bigger_country, " (gain=", bigger_country_change, "), ",
    "whose life expectancy grew by ",
    bigger_country_change - smaller_country_change,
    " years more than ",
    smaller_country, "'s (gain=", smaller_country_change, ")."
  ))
}

# Using your `compare_change()` function, create a variable `usa_or_france`
# that describes who had a larger gain in life expectancy (the U.S. or France)
usa_or_france <- compare_change("United States", "France")

# Write your `life_exp` data.frame to a new .csv file to your
# data/ directory with the filename `life_exp_with_change.csv`.
# Make sure not to write row names.
write.csv(life_exp, "life_expectancy_with_change.cvs", row.names = FALSE)
