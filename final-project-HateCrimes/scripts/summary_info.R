# Summary Info
library(dplyr)
library(knitr)
library(tidyr)
library(leaflet)

# summary information
get_summary_info <- function(dataset) {
  ret <- list()
  ret$race_crime <- summarize(dataset,
    race_crime = sum(Race)
  ) # 2872

  ret$religion_crime <- summarize(dataset,
    religion_crime = sum(Religion)
  ) # 1032

  ret$sex_ori_crime <- summarize(dataset,
    sex_ori_crime = sum(Sexual.orientation)
  ) # 1237

  ret$ethnic_crime <- summarize(dataset,
    ethnic_crime = sum(Ethnicity)
  ) # 655

  ret$disable_crime <- summarize(dataset,
    disable_crime = sum(Disability)
  ) # 83

  ret$gender_crime <- summarize(dataset,
    gender_crime = sum(Gender, na.rm = T)
  ) # 18

  ret$g_iden_crime <- summarize(dataset,
    g_iden_crime = sum(Gender.Identity, na.rm = T)
  ) # 31

  ret$all_crime <- summarize(dataset,
    all_crime = sum(Race) + sum(Religion) +
      sum(Sexual.orientation) + sum(Ethnicity) +
      sum(Disability) + sum(Gender, na.rm = T) +
      sum(Gender.Identity, na.rm = T)
  ) # 5928
  ret$state_most_impact <- dataset %>%
    group_by(State) %>%
    summarise(all_crime = sum(Race)) %>%
    filter(all_crime == max(all_crime)) %>%
    pull(State) # california

  ret$agency_most_impact <- dataset %>%
    group_by(Agency.type) %>%
    summarise(all_crime = sum(Race)) %>%
    filter(all_crime == max(all_crime)) %>%
    pull(Agency.type) # cities
  ret$length <- length(dataset)
  return(ret)
}
