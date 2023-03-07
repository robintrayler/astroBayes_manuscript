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
cl <- makeCluster(numCores) # make a cluster running R in parallel

# load the testing data on each cluster ---------------------------------------
clusterEvalQ(cl = cl, {
  library(astroBayes)
  library(tidyverse)
  library(astrochron)
  # load required data
  cyclostrat <- read.csv(file = './data/CIP2/cyclostrat_data.csv') %>% 
    linterp(dt = 0.025, 
            genplot = FALSE)
  tuning_frequency  <- read.csv('./data/CIP2/tuning_frequency.csv')
  true_data         <- read.csv(file = './data/CIP2/true_age.csv')
  segment_edges <-
    data.frame(position = c(0, 3, 5.75, 10),
               thickness = c(0, 0.5, 0.5, 0),
               hiatus_boundary = c(FALSE, FALSE, TRUE, FALSE),
               sed_min = c(7.5, 7.5, 10, 5),
               sed_max = c(15, 17.5, 20, 20))
  }
)

##-----------------------------------------------------------------------------
## make a function for parallel processing
age_model <- function(i, 
                      size) {
  # make sure the hiatus is bracketed
  good <- FALSE
  while(good == FALSE) {
    # generate some random geochronology --------------------
    index <- sample(seq_along(true_data$position), size = size)
    tmp   <- true_data[index, ]
    id    <- paste0('sample_', index) 
    
    # check to make sure the hiatus is bracketed
    good = any(tmp$position > 6.26) &
      any(tmp$position < 5.24)
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
    tuning_frequency = tuning_frequency,
    segment_edges = segment_edges,
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
                         '.csv') 
  
  model$CI |> 
    add_column(model_no = paste0('model_', i)) |> 
    add_column(true_age = true_age) |> 
    write_csv(file = paste0(model_folder, model_name))
} # end of function

# run R in paralel ------------------------------------------------------------
start <- Sys.time()

clusterMap(cl = cl, 
           fun = age_model,
           size = tests$size, 
           i = tests$i)

stopCluster(cl)
end <- Sys.time()

print(end - start)
