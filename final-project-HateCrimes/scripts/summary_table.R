# Summary Table
library(dplyr)
library(knitr)
library(tidyr)
library(leaflet)


get_summary_table <- function(dataset) {
  all_states <- select(
    hatecrime_2013, State, Race, Religion,
    Sexual.orientation, Ethnicity, Disability,
    Gender, Gender.Identity
  ) %>%
    filter(State == "Alabama" | State == "Alaska" | State == "Arizona"
    | State == "Arkansas" | State == "California"
    | State == "Colorado" | State == "Connecticut"
    | State == "DC" | State == "Delaware"
    | State == "Florida" | State == "Georgia"
    | State == "Idaho" | State == "Illinois"
    | State == "Indiana" | State == "Iowa"
    | State == "Kansas" | State == "Kentucky"
    | State == "Louisiana" | State == "Maine"
    | State == "Maryland" | State == "Massachusetts"
    | State == "Michigan" | State == "Minnesota"
    | State == "Mississippi" | State == "Missouri"
    | State == "Montana" | State == "Nebraska"
    | State == "Nevada" | State == "New_Hampshire"
    | State == "New_Jersey" | State == "New_Mexico"
    | State == "New_York" | State == "North_Carolina"
    | State == "North_Dakota" | State == "South_Dakota"
    | State == "Oklahoma" | State == "Ohio"
    | State == "Oregon" | State == "Pennsylvania"
    | State == "Rhode_Island" | State == "South_Carolina"
    | State == "Tennessee" | State == "Texas"
    | State == "Utah" | State == "Vermont"
    | State == "Virginia" | State == "Washington"
    | State == "West_Virginia" | State == "Wisconsin"
    | State == "Wyoming")

  state_summaries <- all_states %>%
    group_by(State) %>%
    summarise(
      total_crime = sum(Race) + sum(Religion) +
        sum(Sexual.orientation) + sum(Ethnicity) +
        sum(Disability) + sum(Gender, na.rm = T) +
        sum(Gender.Identity, na.rm = T)
    )

  # combines each State's information
  kable(state_summaries, col.names = c(
    "State", "Total Hate Crime"
  ))
}
