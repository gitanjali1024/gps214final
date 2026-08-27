# Read in the data
bisley1 <- read_csv("../data/Bisley1.csv")
bisley2 <- read_csv("../data/Bisley2.csv")
bisley3 <- read_csv("../data/Bisley3.csv")
PRM <- read_csv("../data/PRM.csv")

# Filter the data to only include important columns
bisley_1 <- bisley1 |>
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`)
bisley_2 <- bisley2 |>
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`)
bisley_3 <- bisley3 |>
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`)
PRM_new <- PRM |>
  select(Sample_ID, Sample_Date, `NH4-N`, Ca, Mg, K, `NO3-N`)
