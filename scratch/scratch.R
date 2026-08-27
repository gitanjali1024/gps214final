library(tidyverse)

source("1_clean_data.R")
source("R/moving_average.R")


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

# Put the nutrients in the correct order
data_longer$Nutrient <- factor(
  data_longer$Nutrient,
  levels = c("K", "NO3-N", "Mg", "Ca", "NH4-N")
)


#Plot the data
ggplot(
  data = data_longer,
  mapping = aes(x = window_start, y = Concentration, linetype = sampleid)
) +
  geom_line() +
  facet_wrap(vars(Nutrient), scales = 'free_y', ncol = 1) +
  theme_bw() +
  labs(
    x = "Date",
    y = "Concentration",
    title = "Concentration in Bisley, PR Streams"
  ) +
  geom_vline(
    xintercept = ymd("1989-09-17"),
    linetype = "dashed",
    color = "darkgrey"
  )
