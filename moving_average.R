bruh <- tibble(
  site = "Bisley1",
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
  nh4 <- bisley_1$`NH4-N`[bisley_1$Sample_Date >= w1 & bisley_1$Sample_Date < w2]
  ca <- bisley_1$Ca[bisley_1$Sample_Date >= w1 & bisley_1$Sample_Date < w2]
  mg <- bisley_1$Mg[bisley_1$Sample_Date >= w1 & bisley_1$Sample_Date < w2]
  k <- bisley_1$K[bisley_1$Sample_Date >= w1 & bisley_1$Sample_Date < w2]
  no3 <- bisley_1$`NO3-N`[bisley_1$Sample_Date >= w1 & bisley_1$Sample_Date < w2]


  bruh$`NH4-N`[i] = mean(nh4, na.rm = TRUE)
  bruh$Ca[i] = mean(ca, na.rm = TRUE)
  bruh$Mg[i] = mean(mg, na.rm = TRUE)
  bruh$K[i] = mean(k, na.rm = TRUE)
  bruh$`NO3-N`[i] = mean(no3, na.rm = TRUE)
}