# ui
# library loaded
library(ggplot2)
library(plotly)
library(shiny)


# main page content(brief intro and overview)
main <- fluidPage(
  h1("INFO 201 - Hate Crimes in 2013: Overview"),
  tags$div(
    id = "header",
    h2("Introduction")
  ),
  tags$p("We are interested in hate crimes because of the rising
  rate of hate crimes against Asian Americans due to COVID-19.
  Throughout history, it has become clear that due to certain
  tragic events, racial, religious, ethnic, and sexually diverse
  groups (among others) who seem closely related to those events
  are subjected to hate crimes. For example, after the bombing of
  Pearl Harbor, Japanese Americans suffered ridicule and hate crimes
  for years after the war had ended. As a group, we have picked one
  year-- 2013-- and we have found a database that goes over hate
  crimes that occurred within that year in detail. Detailing what
  state it was in as well as what type of crime was it
  (race, religion, ect.) in addition to the specific location
  and date."),
  a("Click here to see where we found our data source.",
    href = "https://www.fbi.gov/investigate/civil-rights/hate-crimes"
  ),
  tags$img(
    src =
      "https://shop.hrc.org/media/catalog/product/cache/b96c8ebdd70d2c86125e47f452c01479/h/r/hrc13194_2.jpg"
  ),
  tags$div(
    id = "header",
    h2("Overview - Questions we hope to answer")
  ),
  tags$p("Looking at the motivation behind the hate crimes, which states
         had the highest rates and how did they compare with other states?"),
  tags$p("Which bias motivations, and sub-bais motivations of hate crimes
         were most common in 2013?"),
  tags$p("How has the frequency of hate crimes changed in the years
         following 2013?")
)

########################################
########################################
# interactive tab 1: interactive map
tab_1_options <- sidebarPanel(
  # first widget
  selectInput("mapvar",
    label = tags$div(id = "widget", h3("Types of Motivation: ")),
    choices = list(
      "Total" = "Total",
      "Race" = "Race",
      "Religion" = "Religion",
      "Sexual Orientation" = "Sexual.Orientation",
      "Ethnicity" = "Ethnicity",
      "Disability" = "Disability",
      "Gender" = "Gender",
      "Gender Identity" = "Gender.Identity"
    )
  )
)


# the main tab on the page
tab_1_main <- mainPanel(
  plotlyOutput("map"),
  tags$p("This map allows you to view the different motivations for hate
         crimes by state as well as the total number of hate crimes per state.
         The different types of motivations shown are race, religion, sexual
         orientation, ethnicity, disability, gender, and gender identity.
         The map set up allows for an easy overview of the concentration of
         crimes across the nation relativity to certain locations and regions.
         ")
)

# combining them together
tab_1 <- sidebarLayout(
  tab_1_options,
  tab_1_main
)
########################################
########################################
# interactive tab 2: bar chart
tab_2_content <- sidebarPanel(
  # first widget
  radioButtons("topic",
    label = tags$div(id = "widget", h3("Is it: ")),
    choices = list(
      "Incidents" = "Incidents",
      "Offense" = "Offenses",
      "Victims" = "Victims",
      "Known Offenders" = "Known.Offender"
    )
  ),
  # second widget
  selectInput("bias",
    label = tags$div(id = "widget", h3("Bias Motivation: ")),
    choices = list(
      "Total" = "Total",
      "Race" = "Race",
      "Religion" = "Religion",
      "Sexual Orientation" = "Sexual Orientation",
      "Ethnicity" = "Ethnicity",
      "Disability" = "Disability",
      "Gender" = "Gender",
      "Gender Identity" = "Gender Identity"
    )
  )
)

# main tab on the page
tab_2_main <- mainPanel(
  plotlyOutput(
    outputId = "barplot"
  ),
  tags$p("This bar chart shows the break down of the different
         bias motivations that are targets of hate crimes based
         off of number of incidents, offenses, victims, and
         known offenders.")
)

# combining two bars together
tab_2 <- sidebarLayout(
  tab_2_content,
  tab_2_main
)

########################################
########################################
# interactive tab three for line graph
tab_3_content <- sidebarPanel(
  radioButtons(
    inputId = "category",
    label = tags$div(id = "widget", h3("Select Incident Category:")),
    choices = list(
      "Total Incidents" = "total_incidents", "Single-Bias Incidents"
      = "single_bias", "Race/Ethnicity" = "race_ethnicity",
      "Religion" = "religion", "Sexual Orientation" =
        "sexual_orientation", "Disability" = "disability", "Gender" =
        "gender", "Gender Identity" = "gender_identity", "Multiple-Bias
                 Incidents" = "multiple_bias"
    ),
    selected = "total_incidents"
  ),
  tags$div(id = "widget", h3("Incident Comparisons Between Two Years")),
  selectInput(
    inputId = "year1",
    label = h4("Year 1"),
    choices = list(
      "2013" = 2013, "2014" = 2014, "2015" = 2015, "2016"
      = 2016, "2017" = 2017, "2018" = 2018
    ),
    selected = "2013"
  ),
  selectInput(
    inputId = "year2",
    label = h4("Year 2"),
    choices = list(
      "2013" = 2013, "2014" = 2014, "2015" = 2015, "2016"
      = 2016, "2017" = 2017, "2018" = 2018
    ),
    selected = "2018"
  )
)

# main tab on the page
tab_3_main <- mainPanel(
  plotlyOutput(
    outputId = "linechart"
  ),
  tags$p("This line graph shows the changes in the United States' national hate
         crime incident rates between the years 2013 to 2018. It also displays
         changes in hate crime rates of different motivation categories such as
         race/ethnicity, religion, sexual orientation, disability, gender, and
         gender identity."),
  plotlyOutput(
    outputId = "barcompare"
  ),
  tags$p("This comparative bar chart shows the difference in hate crime
  incident rates between two different years.")
)


# combining them together
tab_3 <- sidebarLayout(
  tab_3_content,
  tab_3_main
)


########################################
########################################
# conclusion tab
conclusion_tab <- mainPanel(
  tags$div(h1("Conclusion")),
  tags$div(
    id = "header",
    h2("Interactive Map")
  ),
  tags$p("From our interactive map we see that
  California seems to have the highest amount of hate crimes regardless of
  the types of motivation. While this may be due to the population size of
  California, there were two motivations that California was not the highest,
  and that was disability bias and gender bias. Overall,
  when looking at Gender-related
  hate crimes, we see the least distribution.
  For this type of motivation, cases
  were concentrated in a handful of states without much of a gradient
  amongst the nation overall as signified by the dominating white
  color on the map. As for the most recorded number of crimes, Race
  seemed to be the motivation for most of the states.
  When looking at the number
  of recorded Race-related hate crimes across all states,
  we see a varied distribution
  with almost all states recording at least one case of
         Race-related hate crimes."),
  tags$div(
    id = "header",
    h2("Bar Chart: Breakdown")
  ),
  tags$p("The first thing to take note of in the bar chart breakdown
         is that the largest bias motivation is race, more than double
         any of the other biases. Within the subcategories of race bias,
         we see unsurprisingly that anti-black or African Americans
         more than double any other subcategory of race. Something to
         note within the race subcategory is that the second most targeted
         group is anti-white. In the subcategory of religion, we see that
         there were a lot of anti-jewish hate crimes during the year 2013.
         In terms of sexual orientation, anti-gay had a high rate of hate
         crimes against them. There seemed to be an even amount of hate
         crimes in the ethnicity bias motivation, but both subcategories
         are very high. Something surprising to learn was the fact there
         were hate crimes against people with disabilities, and even more
         surprising, many of the hate crimes were anti-mental. Within the
         subcategories of gender bias, we see that anti-female is targeted
         more than anti-male. Lastly, in the gender identity subcategory,
         the group most targeted during the year of 2013 was anti-transgender.
         From these breakdowns, we see which specific groups are being
         targeted and can take note and analyze this data for future
         reference."),
  tags$div(
    id = "header",
    h2("Yearly Hate Crime Rates")
  ),
  tags$p("From our charts about the changes in hate crime inicdent rates
  between 2013 to 2018, we see that the total hate crime incidents
         tend to increase each year, with the largest jump between two
         consecutive years being an increase of 1054 cases between 2016 to
         2017. In regards to incident comparisons between any two years, the
         greatest change in total incidents, single bias incidents, and
         incidents targeting race and religion occured between 2014 and 2017.
         The greatest change in multiple bias inidents and incidents targeting
         gender and gender identity occured between 2013 and 2018. The greatest
         change in incidents targeting sexual orientation occured between 2013
         and 2014 while the greatest change in incidents targeting disability
         occured between 2016 and 2018."),
  tags$div(
    id = "header",
    h2("Takeaways")
  ),
  tags$p("We started off looking to see which states had the
  highest amount of hate
         crimes for all of the different types of motivations.
         Overall California
         had the highest amount of hate crimes in 2013.
         When we broke it into the
         different motivations, California also had the
         highest amount of hate crimes
         for race, sexual orientation, ethnicity, and
         gender identity in 2013. New York
         had the highest hate crimes with religion
         motivation that year, totaling at 294
         incidents, and with gender motivation,
         totaling at 6. Lastly, Ohio had the most
         hate crimes based off of a disability
         motivation with 24 incidents. We noticed
         that the states with higher populations,
         such as California and New York,
         consistently had more hate crimes while
         states with lower populations such
         as Wyoming and Idaho consistently had less
         hate crimes. We noticed a higher
         distribution of Race-related hate crimes
         across the nation as opposed to
         Gender-related crimes which were concentrated
         in a few states without much
         distribution overall."),
  tags$p("We then wanted to see which bias motivations
  and sub bias motivations were
         the most common in 2013. Race by far had the
         most incidents that year with
         a total of 2,871. Sexual orientation was the
         next highest with 1,233 incidents.
         For the subcategories, anti-black had the most
         racially biased hate crime
         incidents and anti-Jewish had the most hate
         crimes based off of religion.
         For gender, there were more hate crimes directed
         at females than males and
         for disability, more hate crimes incidents were
         based off of anti-mental
         than anti-physical. It didn't come as a surprise
         that race had the
         highest amounts of incidents that year, especially
         anti-Black hate
         crimes. With everything all of the protests going
         on in our country
         right now, hopefully that number can go down soon."),
  tags$p("Lastly we wanted to see how the spread of hate
  crimes looked across
         the U.S. based on different types of motivation
         bias. In almost every
         type of motivation bias, hate crimes have increased
         in the past couple
         of years leading up to 2018. The only decrease in
         hate crimes we saw
         from 2017-2018 was gor race/ethnicity and religion.
         However, hate
         crimes in general have increased a lot since 2013.
         It was interesting
         to see that sexual orientation hate crimes in 2013
         were higher than they
         are now then took a huge drop in 2014.
         However ever since 2014, they have
         been climbing again and again."),
  tags$p("Overall, we found that hate crimes were a prevalent
  issue in 2013 and
         an even more prevalent issue by 2018. States with
         high-populated areas
         like New York and California accounted for many
         of the hate crimes.
         Race/ethnicity, religion, and sexual orientation
         were the primary bias
         motivations behind hate crimes.")
)

########################################
########################################
# overall structure
ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
    tags$style(setBackgroundColor("white"), HTML("
        .tabs-above > .nav > li[class=active] > a {
           background-color: #000;
           color: #FFF;
        }")),
    tabPanel(tags$div(id = "tab", h3("Introduction")), main),
    tabPanel(tags$div(id = "tab", h3("Interactive Map")), tab_1),
    tabPanel(tags$div(id = "tab", h3("Breakdown of Categories")), tab_2),
    tabPanel(tags$div(id = "tab", h3("Yearly Hate Crime Rates")), tab_3),
    tabPanel(tags$div(id = "tab", h3("Conclusion")), conclusion_tab)
  )
)
