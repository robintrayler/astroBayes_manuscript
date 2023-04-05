# load required libraries -----------------------------------------------------
library(tidyverse)
library(astroBayes)
library(viridis)
theme_set(theme_minimal())
# load all the data -----------------------------------------------------------
two_ages <- list.files('./results/random_age_validation/CIP2_2_ages',
                        full.names = TRUE, 
                        pattern = '*.rds')
four_ages <- list.files('./results/random_age_validation/CIP2_4_ages',
                       full.names = TRUE, 
                       pattern = '*.rds')
six_ages <- list.files('./results/random_age_validation/CIP2_6_ages',
                       full.names = TRUE, 
                       pattern = '*.rds')
eight_ages <- list.files('./results/random_age_validation/CIP2_8_ages',
                       full.names = TRUE, 
                       pattern = '*.rds')

file_list <- c(two_ages, four_ages, six_ages, eight_ages)


storage <- data.frame(median  = vector(length = length(file_list)),
                      CI_2.5  = vector(length = length(file_list)),
                      CI_97.5 = vector(length = length(file_list)),
                      delta   = vector(length = length(file_list)),
                      n_ages  = rep(c('2 ages','4 ages','6 ages','8 ages'), each = length(file_list)/4))


for(i in seq_along(file_list)) {
  model <- read_rds(file_list[i])
  
  hiatus_position <- model$segment_edges$position[model$segment_edges$hiatus]
  
  storage$median[i] <- model$hiatus_durations |> median()
  storage$CI_2.5[i] <- model$hiatus_durations |> quantile(prob = 0.025)
  storage$CI_97.5[i] <- model$hiatus_durations |> quantile(prob = 0.975)
  storage$delta[i] <- (model$geochron_data$position - hiatus_position) |> 
    abs() |> 
    min()
  
  
  
  rm(model)
}

storage <- storage |> 
  mutate(diff = median - 0.2025)


storage |> 
  filter(median != 0) |> 
  ggplot(mapping = aes(x = delta, 
                       y = median,
                       ymax = CI_97.5,
                       ymin = CI_2.5,
                       color = factor(n_ages))) + 
  geom_pointrange(alpha = 0.1, show.legend = FALSE) + 
  ylim(0, 0.4) + 
  facet_wrap(~n_ages) + 
  geom_hline(yintercept = 0.2025,
             linetype = 'dashed') + 
  xlab(expression(Delta*'hiatus-date (m)')) + 
  ylab('hiatus duration (Ma)') + 
  scale_color_viridis(option = 'plasma',
                      discrete = TRUE, 
                      end = 0.8)
