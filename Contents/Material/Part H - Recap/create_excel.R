library(mice)
library(nycflights13)

boys_ID <- boys |> mutate(ID = row_number())
boys_ID_1 <- boys_ID |> select(-gen, -phb, -tv) 
boys_ID_2 <- boys_ID |> select(gen, phb, tv, ID) |> na.omit()

openxlsx::write.xlsx(boys_ID, "Contents/Material/Part H - Recap/boys_ID.xlsx")
openxlsx::write.xlsx(boys_ID_1, "Contents/Material/Part H - Recap/boys_ID_1.xlsx")
openxlsx::write.xlsx(boys_ID_2, "Contents/Material/Part H - Recap/boys_ID_2.xlsx")

openxlsx::write.xlsx(planes, "Contents/Material/Part H - Recap/planes.xlsx")
openxlsx::write.xlsx(airlines, "Contents/Material/Part H - Recap/airlines.xlsx")
openxlsx::write.xlsx(flights |> select(-time_hour), "Contents/Material/Part H - Recap/flights.xlsx")

income <- read.table("Contents/Material/Part F - Summary stats/data/income.data", 
                     sep = ',', 
                     fill = F, 
                     strip.white = T) |> 
  as_tibble()

colnames(income) <- c('age', 'workclass', 'fnlwgt', 'education',
                      'education_num', 'marital_status', 'occupation',
                      'relationship', 'race', 'sex', 'capital_gain',
                      'capital_loss', 'hours_per_week', 'native_country',
                      'income')

openxlsx::write.xlsx(income, "Contents/Material/Part H - Recap/income.xlsx")

boys_ID_xlsx <- openxlsx::read.xlsx("Contents/Material/Part H - Recap/boys_ID.xlsx")
boys_ID_1_xlsx <- openxlsx::read.xlsx("Contents/Material/Part H - Recap/boys_ID_1.xlsx")
boys_ID_2_xlsx <- openxlsx::read.xlsx("Contents/Material/Part H - Recap/boys_ID_2.xlsx")

planes_xlsx <- openxlsx::read.xlsx("Contents/Material/Part H - Recap/planes.xlsx")
airlines_xlsx <- openxlsx::read.xlsx("Contents/Material/Part H - Recap/airlines.xlsx")
flights_xlsx <- openxlsx::read.xlsx("Contents/Material/Part H - Recap/flights.xlsx")

income_xlsx <- openxlsx::read.xlsx("Contents/Material/Part H - Recap/income.xlsx")
