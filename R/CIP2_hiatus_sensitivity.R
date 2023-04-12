# load required libraries -----------------------------------------------------
library(tidyverse)
library(cowplot)

source('./R/plot_settings.R')
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

hiatus_2 <-  storage |> 
  filter(n_ages == '2 ages') |> 
  filter(median !=0) |> 
  ggplot(mapping = aes(x = delta, 
                       y = median,
                       ymax = CI_97.5,
                       ymin = CI_2.5)) + 
  geom_point(alpha = 0.1,
             size = 0.5) + 
  geom_linerange(alpha = 0.05, 
                 show.legend = FALSE) + 
  ylim(0, 0.4) + 
  geom_hline(yintercept = 0.2025,
                            linetype = 'dashed',
                            color = 'red',
                            linewidth = 1) + 
  xlab(expression(Delta*'hiatus-date (m)')) + 
  ylab('hiatus duration (Ma)') + 
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank())

hiatus_4 <-  storage |> 
  filter(n_ages == '4 ages') |> 
  filter(median !=0) |> 
  ggplot(mapping = aes(x = delta, 
                       y = median,
                       ymax = CI_97.5,
                       ymin = CI_2.5)) + 
  geom_point(alpha = 0.1,
             size = 0.5) + 
  geom_linerange(alpha = 0.05, 
                 show.legend = FALSE) + 
  ylim(0, 0.4) + 
  geom_hline(yintercept = 0.2025,
             linetype = 'dashed',
             color = 'red',
             linewidth = 1) + 
  xlab(expression(Delta*'hiatus-date (m)')) + 
  ylab('hiatus duration (Ma)') + 
  theme(axis.title.x = element_blank(), 
        axis.title.y = element_blank(),
        axis.text = element_blank())

hiatus_6 <-  storage |> 
  filter(n_ages == '6 ages') |> 
  filter(median !=0) |> 
  ggplot(mapping = aes(x = delta, 
                       y = median,
                       ymax = CI_97.5,
                       ymin = CI_2.5)) + 
  geom_point(alpha = 0.1,
             size = 0.5) + 
  geom_linerange(alpha = 0.05, 
                 show.legend = FALSE) + 
  ylim(0, 0.4) + 
  geom_hline(yintercept = 0.2025,
             linetype = 'dashed',
             color = 'red',
             linewidth = 1) + 
  xlab(expression(Delta*'hiatus-date (m)')) + 
  ylab('hiatus duration (Ma)')

hiatus_8 <-  storage |> 
  filter(n_ages == '8 ages') |> 
  filter(median !=0) |> 
  ggplot(mapping = aes(x = delta, 
                       y = median,
                       ymax = CI_97.5,
                       ymin = CI_2.5)) + 
  geom_point(alpha = 0.1,
             size = 0.5) + 
  geom_linerange(alpha = 0.05, 
                 show.legend = FALSE) + 
  ylim(0, 0.4) + 
  geom_hline(yintercept = 0.2025,
             linetype = 'dashed',
             color = 'red',
             linewidth = 1) + 
  xlab(expression(Delta*'hiatus-date (m)')) + 
  ylab('hiatus duration (Ma)') + 
  theme(axis.text.y = element_blank(),
        axis.title.y = element_blank())
  




pdf(file = './figures/hiatus_duration.pdf',
    width = 4,
    height = 4)
plot_grid(hiatus_2, hiatus_4, hiatus_6, hiatus_8,
          align = 'hv',
          labels = 'AUTO',
          label_x = 0.22,
          label_y = 0.99)
dev.off()
