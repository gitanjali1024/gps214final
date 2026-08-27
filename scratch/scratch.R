library(tidyverse)
source("moving_average.R")

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


func1 <- moving_average(bisley_1)
func2 <- moving_average(bisley_2)
func3 <- moving_average(bisley_3)
func4 <- moving_average(PRM_new)

func_final <- bind_rows(func1, func2, func3, func4)


data_longer <- func_final |> 
  pivot_longer(
cols = c(`NH4-N`, Ca, Mg, K, `NO3-N`),
names_to = "Nutrient",
values_to = "Concentration"
)

ggplot(
  data = data_longer,
  mapping = aes(x = window_start, y = Concentration, color = sampleid)
) +
  geom_line() +
  facet_wrap(vars(Nutrient), scales = 'free_y', ncol = 1)
