library(tidyverse)
source('./R/plot_settings.R')


dates <- tribble(~age, ~low, ~high, ~study,
        93.87, 93.87 - 0.15, 93.87 + 0.15, 'meyers this study',
        93.98,  93.98 - 0.1, 93.98 + 0.1, 'updated this study',
        93.90, 93.90 - 0.15, 93.90 + 0.15, 'meyers 2012',
        93.95, 93.95 - 0.05, 93.95 + 0.05, 'jones 2021',
        93.9, 93.9 - 0.2, 93.9 + 0.2, 'GTS2020',
        NA, 94.007, 94.616, 'renaut 2023')


dates |> 
  mutate(study = factor(study, levels = rev(c('meyers this study', 
                                              'updated this study',
                                              'meyers 2012', 'GTS2020', 
                                              'jones 2021', 'renaut 2023')))) |> 
  ggplot(mapping = aes(x = age, 
                       y = study,
                       color = study)) + 
  geom_point(show.legend = FALSE) + 
  geom_linerange(mapping = aes(xmin = low,
                               xmax = high),
                 show.legend = FALSE)

