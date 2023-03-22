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
  cyclostrat        <- read.csv(file = './data/data_A/cyclostratigraphic_record.csv')
  tuning_frequency  <- read.csv(file = './data/data_A/tuning_frequency.csv')
  true_data         <- read.csv(file = './data/data_A/true_age.csv')
  segment_edges     <- read.csv(file = './data/data_A/segment_edges.csv')
  geochron_data     <- read.csv(file = './data/data_A/radioisotopic_dates.csv')
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
    tuning_frequency = tuning_frequency,
    segment_edges = segment_edges,
    iterations = 10000, 
    burn = 1000, 
    method = 'malinverno')
  
  # prep the model outputs --------------------------------
  f <- approxfun(x = true_data$position, y = true_data$age)
  true_age <- f(model$CI$position)
  
  # write the model CI to a csv --------------------------
  
  model_folder <- paste0('./results/stability_validation/TD1/')
  
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
