# This script will calculate the proportion of the true age model containd within
# the 95% credible interval of the the randomly generated TD1 and CIP2
# age-depth models.

# load required libraries -----------------------------------------------------
library(tidyverse)

# load the true age model and form an interpolation function

true_age <- read_csv(file = './data/TD1/true_age.csv')
f <- approxfun(x = true_age$position, 
               y = true_age$age)

# load all the data -----------------------------------------------------------
two_ages <- list.files('./results/outlier_analysis/TD1_2_ages/',
                       full.names = TRUE, 
                       pattern = '*.rds')
four_ages <- list.files('./results/outlier_analysis/TD1_4_ages/',
                        full.names = TRUE, 
                        pattern = '*.rds')
six_ages <- list.files('./results/outlier_analysis/TD1_6_ages/',
                       full.names = TRUE, 
                       pattern = '*.rds')
eight_ages <- list.files('./results/outlier_analysis/TD1_8_ages/',
                         full.names = TRUE, 
                         pattern = '*.rds')

file_list <- c(two_ages, four_ages, six_ages, eight_ages)

# allocate a data frame for storage
storage <- data.frame(contained = vector(length = length(file_list)),
                      n_ages  = rep(c('2 ages','4 ages','6 ages','8 ages')))

# loop throuhg all the models and extract the credible interval
for(i in 1:length(file_list)) {
  model <- read_rds(file = file_list[i])
  CI <- model$CI |> 
    mutate(true_age = f(position)) |> 
    filter(!is.na(true_age))
  # calculate the proportion contained
  storage$contained[i] <- sum(CI$true_age > CI$CI_2.5 & 
                                CI$true_age < CI$CI_97.5)/nrow(CI)
  
}

# calculate the average proportion contained.
TD1_contained <- storage |> 
  filter(contained != 0) |> 
  group_by(n_ages) |> 
  summarize(mean = mean(contained))

# repeat for the CIP2 data ----------------------------------------------------
# load the true age model and form an interpolation function

true_age <- read_csv(file = './data/CIP2/true_age.csv')
f <- approxfun(x = true_age$position, 
               y = true_age$age)

# load all the data -----------------------------------------------------------
two_ages <- list.files('./results/outlier_analysis/CIP2_2_ages/',
                       full.names = TRUE, 
                       pattern = '*.rds')
four_ages <- list.files('./results/outlier_analysis/CIP2_4_ages/',
                        full.names = TRUE, 
                        pattern = '*.rds')
six_ages <- list.files('./results/outlier_analysis/CIP2_6_ages/',
                       full.names = TRUE, 
                       pattern = '*.rds')
eight_ages <- list.files('./results/outlier_analysis/CIP2_8_ages/',
                         full.names = TRUE, 
                         pattern = '*.rds')

file_list <- c(two_ages, four_ages, six_ages, eight_ages)

# allocate a data frame for storage
storage <- data.frame(contained = vector(length = length(file_list)),
                      n_ages  = rep(c('2 ages','4 ages','6 ages','8 ages')))

# loop throuhg all the models and extract the credible interval
for(i in 1:length(file_list)) {
  model <- read_rds(file = file_list[i])
  CI <- model$CI |> 
    mutate(true_age = f(position)) |> 
    filter(!is.na(true_age))
  # calculate the proportion contained
  storage$contained[i] <- sum(CI$true_age > CI$CI_2.5 & 
                                CI$true_age < CI$CI_97.5)/nrow(CI)
  
}

# calculate the average proportion contained.
CIP2_contained <- storage |> 
  filter(contained != 0) |> 
  group_by(n_ages) |> 
  summarize(mean = mean(contained),
            sd = sd(contained))



