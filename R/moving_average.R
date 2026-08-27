# The input to this function should be a data frame containing stream chemistry data
moving_average <- function(df) {
  # Initialize a tibble to contain the results
  result <- tibble(
    sampleid = df$Sample_ID[1],
    window_start = seq(ymd("1988-01-05"), ymd("1994-12-31"), by = "63 days"),
    `NH4-N` = NA,
    Ca = NA,
    Mg = NA,
    K = NA,
    `NO3-N` = NA
  )

  # Fill in the iterator and sequence
  for (i in 1:nrow(result)) {
    # Create variables for the start and end of the current window
    w1 <- result$window_start[i]
    w2 <- result$window_start[i] + 63
    # Create a logical vector, called "in_window", that says which samples are inside the window
    # Hint: you'll compare sample dates to the start and end of the window
    in_window <- df$Sample_Date >= w1 & df$Sample_Date < w2

    # Use indexing to pull out the ion concentrations that fall inside the window
    nh4_window <- df$`NH4-N`[in_window]
    ca_window <- df$Ca[in_window]
    mg_window <- df$Mg[in_window]
    k_window <- df$K[in_window]
    no3_window <- df$`NO3-N`[in_window]
    # The line above gets potassium in the window. Get the rest of the ions too

    # Calculate the mean of each ion concentration and fill in the result
    result$`NH4-N`[i] <- mean(nh4_window, na.rm = TRUE)
    result$Ca[i] <- mean(ca_window, na.rm = TRUE)
    result$Mg[i] <- mean(mg_window, na.rm = TRUE)
    result$K[i] <- mean(k_window, na.rm = TRUE)
    result$`NO3-N`[i] <- mean(no3_window, na.rm = TRUE)
  }
  return(result)
  # Return the result
}
