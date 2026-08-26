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

<<<<<<< HEAD
data_longer <- values |> 
=======
for (i in 1:nrow(bruh)) {
  w1 <- bruh$window_start[i]
  w2 <- bruh$window_start[i] + 63

  # makes a vector
  nh4 <- data2$`NH4-N`[data2$Sample_Date >= w1 & data2$Sample_Date < w2]
  ca <- data2$Ca[data2$Sample_Date >= w1 & data2$Sample_Date < w2]
  mg <- data2$Mg[data2$Sample_Date >= w1 & data2$Sample_Date < w2]
  k <- data2$K[data2$Sample_Date >= w1 & data2$Sample_Date < w2]
  no3 <- data2$`NO3-N`[data2$Sample_Date >= w1 & data2$Sample_Date < w2]


  bruh$`NH4-N`[i] = mean(nh4, na.rm = TRUE)
  bruh$Ca[i] = mean(ca, na.rm = TRUE)
  bruh$Mg[i] = mean(mg, na.rm = TRUE)
  bruh$K[i] = mean(k, na.rm = TRUE)
  bruh$`NO3-N`[i] = mean(no3, na.rm = TRUE)
}



data_longerer <- bruh |> 
>>>>>>> de880e6bf1aea3cb654b60a6db2640cfd0a356ed
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
