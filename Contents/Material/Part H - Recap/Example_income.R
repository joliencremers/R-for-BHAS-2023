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

## filter

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

## grouping and summarize

# group by marital status and count amount of individuals per group
unique(income$marital_status) # check the unique categories of marital status

income |> 
  group_by(marital_status) |>
  summarise(amount = n())

income |> 
  count(marital_status)

# group by marital status and compute some summary statistics
table_marital <- income |> 
  group_by(marital_status) |>
  summarise(amount = n(),
            amount_of_females = sum(sex == "Female"),
            lowest_age = min(age),
            mean_age = mean(age),
            sd_age = sd(age))

# write table to Excel
write.xlsx(table_marital, "output/table_marital.xlsx")

# with filter for age
income |> 
  filter(age > 25) |> 
  group_by(marital_status) |>
  summarise(amount = n(),
            amount_of_females = sum(sex == "Female"),
            lowest_age = min(age),
            mean_age = mean(age),
            sd_age = sd(age))


# compute amount of males and females
sum(income$sex == "Female") # compute the amount of females
sum(income$sex != "Female") # compute the amount of males
sum(income$sex == "Male") # compute the amount of males
income |> 
  count(sex)

# So what does this do?
# It groups the data by marital status and workclass
# Then computes the amount of individuals in each group
# Then computes the proportion of bachelors (rounded to 2 decimals) in each group
# Ungroups the data
# Renames the workclass variable to sector

data_new <- income |> 
  group_by(marital_status, workclass) |>
  summarise(amount = n(),
            bachelors_proportion = round(mean(education == "Bachelors"), 2)) |> 
  ungroup() |> 
  rename(sector = workclass)

