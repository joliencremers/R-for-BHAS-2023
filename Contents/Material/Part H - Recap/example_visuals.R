## Load packages
library(tidyverse) ## This includes ggplot2 and dplyr
library(mice)
library(openxlsx)
library(ggplot2) ## If you cannot install tidyverse
library(dplyr) ## If you cannot install tidyverse
getwd()

##Create a folder for the R-project

##Save the script in the folder

##Create an R-project

##Read the boys data
boys <- read.xlsx("data/boys_ID.xlsx")

#Remeber to specify the path, if the data is not stored in the wd

##Create a scatterplot (points) between `age` and `bmi` in the `boys` data set.
boys |> 
  ggplot() +
  geom_point(aes(x=age, y=bmi))

#Why do we see a warning? Let us check
sum(is.na(boys$age))
sum(is.na(boys$bmi))

#We can turn it around
boys |> 
  ggplot() +
  geom_point(aes(x=bmi, y=age))

#Try with categorical? Different types of plots may be better
boys |> 
  ggplot() +
  geom_point(aes(x=reg, y=age)) # Not the way to plot categorical variable

# Boxplot
boys |> 
  ggplot() +
  geom_boxplot(aes(x=reg, y=bmi))

###Add title and labels to the x and y axis
boys |> 
  ggplot() +
  geom_boxplot(aes(x=reg, y=bmi)) +
  ggtitle("Boxplot of BMI in Regions") +
  xlab("Region") +
  ylab("BMI")

###Color the lines based on the region the boys are from
boys |> 
  ggplot() +
  geom_point(aes(x=bmi, y=age, color=reg)) # Color based on regions

#Or just red
boys |> 
  ggplot() +
  geom_point(aes(x=bmi, y=age), color="red") # With red color

#Also possible to add size, shape etc. 
#But do not include too many dimensions

###export the plot
ggsave(file="plot_eks.jpeg", width=10, height=8, dpi=300, units="cm")
ggsave(file="plot_eks.png", width=10, height=8, dpi=300, units="cm")

##Histogram with reg
boys |> 
  filter(!is.na(reg)) |> # To exclude NA
  ggplot() +
  geom_bar(aes(x=reg))

#Fill (not color) - We need two categorical variables
boys <- boys |> 
  mutate(age_cat=case_when(age<13 ~ "Child",
                           age>=13 & age<18 ~ "Teenager",
                           age>=18 ~ "Adult"))

boys |> 
  filter(!is.na(reg)) |> # To exclude NA
  ggplot() +
  geom_bar(aes(x=reg, fill=age_cat))

#Side by side bars
boys |> 
  filter(!is.na(reg)) |> # To exclude NA
  ggplot() +
  geom_bar(aes(x=reg, fill=age_cat), position="dodge")

# dev.off() - use this to clear the plots

#Facets (bmi, age, reg)
ggplot(data = boys) + 
  geom_point(mapping = aes(x = bmi, y = age)) + 
  facet_wrap(~ reg, nrow = 2)

#A note about factors: Factors help us to control the order of the categories

#The graph gallery