# This script calculates the reproducability of the median and 95% credible interval
# across all model validation runs for the CIP2 and TD1 testing data sets
# it will read in each individual model .rds, extract the credible interval and 
# calculate the 2 sigma uncertanity across all models.

# load required libraries -----------------------------------------------------
library(tidyverse)

# load TD1 validation data -----------------------------------------------------
file_list <- list.files('./results/stability_validation/TD1/',
                        full.names = TRUE, 
                        pattern = '*.rds')
# preallocate storage
CI <- list()

# loop through the validation models ----------------------
for(i in seq_along(file_list)) {
  # read in the model
  model <- read_rds(file_list[i])
  # calculate the number of sed rates
  # store the CI
  CI[[i]] <- model$CI |> 
    add_column(file_name = basename(tools::file_path_sans_ext(file_list[i])))
  # remove model before next iteration
  rm(model)
}

# collapse into a data.frame
CI <- CI |> 
  reduce(rbind)

# pivot wider
median <- CI |> 
  select(median, position, file_name) |> 
  pivot_wider(names_from = file_name,
              values_from  = median) |> 
  select(-position)

CI97.5 <- CI |> 
  select(CI_97.5, position, file_name) |> 
  pivot_wider(names_from = file_name,
              values_from  = CI_97.5) |> 
  select(-position)

CI2.5 <- CI |> 
  select(CI_2.5, position, file_name) |> 
  pivot_wider(names_from = file_name,
              values_from  = CI_2.5) |> 
  select(-position)

# calculate the standard deviation of the median
TD1_median <- apply(median, 1, sd) |> 
  sd()*2

TD1_97.5 <- apply(CI97.5, 1, sd) |> 
  sd()*2

TD1_2.5 <- apply(CI2.5, 1, sd) |> 
  sd()*2

# load CIP2 validation data -----------------------------------------------------
file_list <- list.files('./results/stability_validation/CIP2/',
                        full.names = TRUE, 
                        pattern = '*.rds')
# preallocate storage
CI <- list()

# loop through the validation models ----------------------
for(i in seq_along(file_list)) {
  # read in the model
  model <- read_rds(file_list[i])
  # calculate the number of sed rates
  # store the CI
  CI[[i]] <- model$CI |> 
    add_column(file_name = basename(tools::file_path_sans_ext(file_list[i])))
  # remove model before next iteration
  rm(model)
}

# collapse into a data.frame
CI <- CI |> 
  reduce(rbind)

# pivot wider
median <- CI |> 
  select(median, position, file_name) |> 
  pivot_wider(names_from = file_name,
              values_from  = median) |> 
  select(-position)

CI97.5 <- CI |> 
  select(CI_97.5, position, file_name) |> 
  pivot_wider(names_from = file_name,
              values_from  = CI_97.5) |> 
  select(-position)

CI2.5 <- CI |> 
  select(CI_2.5, position, file_name) |> 
  pivot_wider(names_from = file_name,
              values_from  = CI_2.5) |> 
  select(-position)

# calculate the standard deviation of the median
CIP2_median <- apply(median, 1, sd) |> 
  sd()*2

CIP2_97.5 <- apply(CI97.5, 1, sd) |> 
  sd()*2

CIP2_2.5 <- apply(CI2.5, 1, sd) |> 
  sd()*2

# put it all in a data.frame
data.frame(data_set = c('TD1', 'CIP2'),
           CI_2.5 = c(TD1_2.5, CIP2_2.5),
           median = c(TD1_median, CIP2_median),
           CI_97.5 = c(TD1_97.5, CIP2_97.5)) |> 
  mutate_if(is.numeric, round, 3)


