# This script will generate 4000 validation models for the TD1 data set using
# different numbers of randomly generated "dates" varying between 2 and 8 dates
# per model. 

# WARNING: This script is designed to run in parallel. It takes several days to 
# complete and will generate about 620 Gb of results files. I don't recommend
# running this on a personal laptop.

# load required libraries -----------------------------------------------------
library(parallel)
library(tidyverse)

# set up the models to test ---------------------------------------------------
iterations <- 1000 # test each set of parameters 1000 times
size     <- rep(c(2, 4, 6, 8), each = iterations) # vary between 2 - 8 ages
index    <- rep(1:iterations, times = length(size)/iterations) # add iterations
# put it in a data frame
tests    <- data.frame(size = size, 
                       i    = index)

# set up for parallel processing ----------------------------------------------
numCores <- detectCores() - 2 # leave one core to run the computer
cl <- makeCluster(numCores) # make a cluster running R in parallel

# load the testing data on each cluster ---------------------------------------
clusterEvalQ(cl = cl, {
  library(astroBayes)
  library(tidyverse)
  # load required data
  cyclostrat           <- read.csv(file = './data/data_A/cyclostratigraphic_record.csv')
  target_frequency     <- read.csv(file = './data/data_A/target_frequency.csv')
  true_data            <- read.csv(file = './data/data_A/true_age.csv')
  layer_boundaries     <- read.csv(file = './data/data_A/layer_boundaries.csv')
}
)

##-----------------------------------------------------------------------------
## make a function for parallel processing
age_model <- function(i, 
                      size) {
  # generate some random geochronology --------------------
  index <- sample(seq_along(true_data$position), size = size)
  tmp   <- true_data[index, ]
  id    <- paste0('sample_', index) 
  
  # make some random dates --------------------------------
  geochron_data <- data.frame(
    id = id, 
    age = tmp$age,
    age_sd =  tmp$age * 0.02,
    position = tmp$position,
    thickness = 0)
  
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
  
  model_folder <- paste0('./results/random_age_validation/TD1_', 
                         size, 
                         '_ages/')
  model_name   <- paste0(size,'_age_model_', 
                         i, 
                         '.rds') 
  
  model |> 
    write_rds(file = paste0(model_folder, model_name))
  rm(model)
 
} # end of function

# run R in parallel ------------------------------------------------------------
start <- Sys.time()

clusterMap(cl = cl, 
           fun = age_model,
           size = tests$size, 
           i = tests$i)

stopCluster(cl)
end <- Sys.time()

print(end - start)
