library(tidyverse)

bisley1 <- read_csv("data/Bisley1.csv")
bisley2 <- read_csv("data/Bisley2.csv")
bisley3 <- read_csv("data/Bisley3.csv")
PRM <- read_csv("data/PRM.csv")

bisley_1 <- bisley1 |> 
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`) |> 
  filter(year(Sample_Date) >= 1988 & year(Sample_Date) <= 1994) |> 
  mutate(window = 0) |> 
  add_row(window = 1:7) |> 
  mutate(window = rep(1:47, each = 9))

bisley_2 <- bisley2 |> 
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`) |> 
  filter(year(Sample_Date) >= 1988 & year(Sample_Date) <= 1994) |> 
  mutate(window = 0) |> 
  add_row(window = 1:2) |> 
  mutate(window = rep(1:46, each = 9))

bisley_3 <- bisley3 |> 
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`) |> 
  filter(year(Sample_Date)>=1988 & year(Sample_Date)<=1994) |> 
  mutate(window = 0) |> 
  add_row(window = 1:4) |> 
  mutate(window = rep(1:46, each = 9))

PRM_new <- PRM |> 
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`) |> 
  filter(year(Sample_Date)>=1988 & year(Sample_Date)<=1994) |> 
  mutate(window = 0) |> 
  mutate(window = rep(1:32, each = 9))


data <- bind_rows(bisley_1, bisley_2, bisley_3, PRM_new)
data2 <- data |> 
mutate(Date = ymd(Sample_Date), Year = year(Date))

values <- data2 |> 
  group_by(Sample_ID, window) |> 
  summarise_all(mean, na.rm = TRUE)

data_longer <- values |> 
  pivot_longer(
cols = c(`NH4-N`, Ca, Mg, K, `NO3-N`),
names_to = "Nutrient",
values_to = "Concentration"
)

ggplot(
  data = data_longer,
  mapping = aes(x = window, y = Concentration, color = Sample_ID)
) +
  geom_line() +
  facet_wrap(~Nutrient)
