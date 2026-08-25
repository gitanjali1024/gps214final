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

bruh <- tibble(
  window_start = seq(ymd("1986-05-20"), ymd("1994-12-31"), by = "63 days"),
  `NH4-N` = NA,
  Ca = NA,
  Mg = NA,
  K = NA,
  `NO3-N` = NA
)

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
  pivot_longer(
cols = c(`NH4-N`, Ca, Mg, K, `NO3-N`),
names_to = "Nutrient",
values_to = "Concentration"
)

ggplot(
  data = data_longer,
  mapping = aes(x = Year, y = Concentration, color = Sample_ID)
) +
  geom_line() +
facet_wrap(~Nutrient)
