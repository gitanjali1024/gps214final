library(tidyverse)
source("R/moving_average.R")

# Read in the data
bisley1 <- read_csv("data/Bisley1.csv")
bisley2 <- read_csv("data/Bisley2.csv")
bisley3 <- read_csv("data/Bisley3.csv")
PRM <- read_csv("data/PRM.csv")

# Filter the data to only include important columns
bisley_1 <- bisley1 |>
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`)
bisley_2 <- bisley2 |>
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`)
bisley_3 <- bisley3 |>
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`)
PRM_new <- PRM |>
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`)

# Call the moving average function
func_bis1 <- moving_average(bisley_1)
func_bis2 <- moving_average(bisley_2)
func_bis3 <- moving_average(bisley_3)
func_bis4 <- moving_average(PRM_new)

# Combine into one data frame
data_combined <- bind_rows(func_bis1, func_bis2, func_bis3, func_bis4)

# Pivot longer
data_longer <- data_combined |>
  pivot_longer(
    cols = c(`NH4-N`, Ca, Mg, K, `NO3-N`),
    names_to = "Nutrient",
    values_to = "Concentration"
  )

write_csv(data_longer, "output/output.csv")
