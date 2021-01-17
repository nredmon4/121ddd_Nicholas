##load packages
library(dplyr)
library(magrittr)
library(ggplot2)
library(pander)

##read in the COVID-19 dataset to the environment
covid.data <- read.csv("C:\\Users\\nicho\\OneDrive\\Desktop\\DDD-I21\\owid-covid-data.csv")

##check the names of columns and rows
colnames(covid.data)
rownames(covid.data)

##remove columns not of interest
covid.data.of.interest <- subset(covid.data, select = -c(handwashing_facilities,
                                                        male_smokers,
                                                        female_smokers,
                                                        diabetes_prevalence,
                                                        cardiovasc_death_rate,
                                                        stringency_index,
                                                        new_vaccinations_per_million,
                                                        total_vaccinations_per_hundred,
                                                        new_vaccinations,
                                                        total_vaccinations,
                                                        tests_units,
                                                        tests_per_case,
                                                        new_tests_smoothed_per_thousand,
                                                        new_tests_smoothed,
                                                        new_tests_per_thousand,
                                                        total_tests,
                                                        new_tests,
                                                        weekly_hosp_admissions_per_million,
                                                        weekly_hosp_admissions,
                                                        weekly_icu_admissions_per_million,
                                                        weekly_icu_admissions,
                                                        hosp_patients_per_million,
                                                        hosp_patients,
                                                        icu_patients_per_million,
                                                        icu_patients,
                                                        new_deaths_smoothed_per_million,
                                                        new_cases_smoothed_per_million,
                                                        new_deaths_smoothed,
                                                        new_cases_smoothed,
                                                        reproduction_rate,
                                                        total_tests_per_thousand,
                                                        positive_rate,
                                                        extreme_poverty))

##select countries to be used for analysis
selected.countries <- c("Afghanistan",
                        "Argentina", 
                        "Australia", 
                        "Brazil",
                        "China", 
                        "Mexico",
                        "Nigeria",
                        "South Africa",
                        "United States")

##combine the selected columns with the seletced countries to create the final dataframe
final.covid.data <- dplyr::filter(covid.data.of.interest, location %in% selected.countries)

##replace all NA values with 0 values
final.covid.data[is.na(final.covid.data)] = 0

##change character date to date
final.covid.data$date <- as.Date(final.covid.data$date)
class(final.covid.data$date)

pop.dens <- final.covid.data[c(317,668,1015,1331,1682,2054,2368,2703,3054),c(9,14)]
##create table comparing total cases per million to population density
pander(pop.dens,style = "rmarkdown")

pop.dens <- final.covid.data[c(317,668,1015,1331,1682,2054,2368,2703,3054),c(9,14)]

##create graph of above
ggplot(data = pop.dens, aes(x = population_density, y = total_cases_per_million)) + 
  geom_point()

med.Age <- final.covid.data[c(317,668,1015,1331,1682,2054,2368,2703,3054),c(11,15)]

ggplot(data = med.Age, aes(x = median_age, y = total_deaths_per_million)) +
  geom_point()

tracking <- final.covid.data[,c(3,4,9)]

ggplot(data = tracking, aes(x = date, y = total_cases_per_million, color = location))+
  geom_line()


big.chart <- final.covid.data[c(317,668,1015,1331,1682,2054,2368,2703,3054),c(3,5,7,21,20,18)]

pander(big.chart, style = "rmarkdown")
              