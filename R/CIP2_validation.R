# This script will generate 4000 validation models for the CIP2 data set using
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
index    <- rep(1:iterations, times = length(size) / iterations) # add iterations
# put it in a data frame
tests    <- data.frame(size = size, 
                       i    = index)

# set up for parallel processing ----------------------------------------------
numCores <- detectCores() - 2 # leave one core to run the computer
cl <- makeCluster(numCores)   # make a cluster running R in parallel

# load the testing data on each cluster ---------------------------------------
clusterEvalQ(cl = cl, {
  library(astroBayes)
  library(tidyverse)
  library(astrochron)
  # load required data
  cyclostrat <- read.csv(file = './data/CIP2/cyclostrat_data.csv') %>% 
    linterp(dt = 0.025, 
            genplot = FALSE)
  target_frequency  <- read.csv('./data/CIP2/target_frequency')
  true_data         <- read.csv(file = './data/CIP2/true_age.csv')
  layer_boundaries  <- read.csv(file = './data/CIP2/layer_boundaries.csv') 
}
)

##-----------------------------------------------------------------------------
## make a function for parallel processing
age_model <- function(i, 
                      size) {
  # make sure the hiatus is bracketed
  good <- FALSE
  bad  <- TRUE
  repeat{
    # generate some random geochronology --------------------
    index <- sample(seq_along(true_data$position), size = size)
    tmp   <- true_data[index, ]
    id    <- paste0('sample_', index) 
    
    # check to make sure the hiatus is bracketed
    # keep dates out of the hiatus
    bad <- any(between(tmp$position, 5.24, 6.26))
    
    good = any(between(tmp$position, 0, 5.24)) &
      any(between(tmp$position, 6.26, 10))
    
    if(good == TRUE) {
      if(bad == FALSE) {
        break()  
      }
    }
  }
  
  # make some random dates --------------------------------
  geochron_data <- data.frame(
    id = id,
    age = tmp$age,
    age_sd =  tmp$age * 0.015,
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
  
  model_folder <- paste0('./results/random_age_validation/CIP2_', 
                         size, 
                         '_ages/')
  model_name   <- paste0(size,'_age_model_', 
                         i, 
                         '.rds') 
  
  model |> 
    write_rds(file = paste0(model_folder, model_name))
  rm(model)
}
# run R in parallel ------------------------------------------------------------
start <- Sys.time()

clusterMap(cl = cl, 
           fun = age_model,
           size = tests$size, 
           i = tests$i)

stopCluster(cl)
end <- Sys.time()

print(end - start)