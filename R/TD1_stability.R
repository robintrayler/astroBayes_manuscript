# This script will generate 1000 validation models for the TD1 data set using
# the exact same data as inputs

# WARNING: This script is designed to run in parallel. It takes several days to 
# complete and will generate about 240 Gb of results files. I don't recommend
# running this on a personal laptop.

# load required libraries -----------------------------------------------------
library(parallel)
library(tidyverse)

# set up the models to test ---------------------------------------------------
iterations <- 1000 # test each set of parameters 1000 times
index    <- rep(1:iterations) # add iterations
# put it in a data frame
tests    <- data.frame(i = index)

# set up for parallel processing ----------------------------------------------
numCores <- detectCores() - 2 # leave one core to run the computer
cl <- makeCluster(numCores) # make a cluster running R in parallel

# load the testing data on each cluster ---------------------------------------
clusterEvalQ(cl = cl, {
  library(astroBayes)
  library(tidyverse)
  # load required data
  cyclostrat        <- read.csv(file = './data/TD1/cyclostratigraphic_record.csv')
  target_frequency  <- read.csv(file = './data/TD1/target_frequency.csv')
  true_data         <- read.csv(file = './data/TD1/true_age.csv')
  layer_boundaries  <- read.csv(file = './data/TD1/layer_boundaries.csv')
  geochron_data     <- read.csv(file = './data/TD1/radioisotopic_dates.csv')
}
)

##-----------------------------------------------------------------------------
## make a function for parallel processing
age_model <- function(i) {
  # generate some random geochronology --------------------
  # run the model -----------------------------------------
  model <- astro_bayes_model(
    geochron_data = geochron_data,
    cyclostrat_data = cyclostrat,
    target_frequency = target_frequency,
    layer_boundaries = layer_boundaries,
    iterations = 10000, 
    burn = 1000, 
    method = 'malinverno')
  
  # prep the model outputs --------------------------------
  f <- approxfun(x = true_data$position, 
                 y = true_data$age)
  true_age <- f(model$CI$position)
  
  # write the model CI to a csv --------------------------
  
  model_folder <- './results/stability_validation/TD1/'
  
  model_name   <- paste0('age_model_', i, '.rds') 
  
  model |> 
    write_rds(file = paste0(model_folder, model_name))
  rm(model)
} # end of function

# run R in parallel ------------------------------------------------------------
start <- Sys.time()

clusterMap(cl = cl, 
           fun = age_model,
           i = tests$i)

stopCluster(cl)
end <- Sys.time()

print(end - start)
