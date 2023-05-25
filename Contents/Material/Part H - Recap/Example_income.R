#### Install packages
# install.packages("openxlsx")

#Load packages
library(openxlsx)
library(dplyr)

#### Read income data
read.xlsx("data/income.xlsx") # this only prints the data
income <- read.xlsx("data/income.xlsx") # this puts the data in our environment

#### Inspect data
View(income)

head(income)
head(income, 10)
?head # help for head function
tail(income, 10)

# When we only want to use the glimpse function from dplyr,
# we do not need to load with library(dplyr) but instead:
dplyr::glimpse(income) 

str(income)

#### Inspect variables

names(income) # column/variable names
rownames(income) # row names

table(income$workclass) #frequency table
unique(income$workclass) #unique values of a variable

summary(income$age) #basic summary statistics for one variable
summary(income) #basic summary statistics for all variables

#### Data cleaning

# replace ? category in workclass with NA (missing)
income <- income |> 
  mutate(workclass_NA = case_when(workclass == "?" ~ NA,
                                  workclass != "?" ~ workclass))

# this doesn't work if we want to know the number of NA
summary(income$workclass_NA)
table(income$workclass_NA)

# this does work:
income |> 
  count(workclass_NA)

#### Data manipulation

# remove all under 26
filter_age <- income |> 
  filter(age > 25)

# Check if the minimum age is 26
summary(filter_age$age)

filter_age |> 
  summarize(min_age = min(age))

min(filter_age$age)

# filter age and education
filter_age_education <- income |> 
  filter(age > 25 & age < 61,
         education %in% c("Doctorate", 
                          "Masters", 
                          "Bachelors"))

# check filter
filter_age_education |> 
  count(education)

summary(filter_age_education$age)

