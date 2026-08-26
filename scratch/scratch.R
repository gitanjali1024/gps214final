library(tidyverse)



bisley1 <- read_csv("data/Bisley1.csv")
bisley2 <- read_csv("data/Bisley2.csv")
bisley3 <- read_csv("data/Bisley3.csv")
PRM <- read_csv("data/PRM.csv")

bisley_1 <- bisley1 |> 
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`)
bisley_2 <- bisley2 |> 
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`)
bisley_3 <- bisley3 |> 
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`)
PRM_new <- PRM |> 
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`)


data <- bind_rows(bisley_1, bisley_2, bisley_3, PRM_new)
data2 <- data |> 
mutate(Date = ymd(Sample_Date), Year = year(Date))

source("moving_average.R")


data_longer <- bisley_1 |> 
  pivot_longer(
cols = c(`NH4-N`, Ca, Mg, K, `NO3-N`),
names_to = "Nutrient",
values_to = "Concentration"
)

ggplot(
  data = data_longer,
  mapping = aes(x = window_start, y = Concentration, color = Nutrient)
) +
  geom_line()