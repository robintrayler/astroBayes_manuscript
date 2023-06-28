# load required libraries -----------------------------------------------------
library(tidyverse)
library(cowplot)
library(viridis)

source('./R/plot_settings.R')
# load all the data -----------------------------------------------------------
validation_data <- list.files('./results/stability_validation/TD1/',
                       full.names = TRUE, 
                       pattern = '*.rds') |> 
  sample(size = 50)



sed_rate <- list()

for(i in seq_along(validation_data)) {
  model <- read_rds(validation_data[i])
  
  sed_rate[[i]] <- model$sed_rate |> 
    as.data.frame() |> 
    set_names(nm = paste0('layer ', 1:ncol(model$sed_rate))) |> 
    add_column(iteration = 1:nrow(model$sed_rate)) |> 
    add_column(model = i) |> 
    pivot_longer(cols = 1:ncol(model$sed_rate),
                 names_to = 'layer', 
                 values_to = 'sed_rate')
  
}

pdf(width = 4, 
    height = 4,
    file = './figures/final figures/supplemental_figures/TD1_trace.pdf')
sed_rate <- sed_rate |> 
  reduce(rbind)

sed_rate |> 
  ggplot(mapping = aes(x = iteration, 
                       y = sed_rate,
                       color = model)) +
  facet_wrap(~layer) + 
  geom_line(alpha = 0.1, show.legend = FALSE) + 
  scale_color_viridis(option = 'plasma', end = 0.9) + 
  geom_vline(xintercept = 1000,
             linetype = 'dashed') + 
  theme_custom +
  ylab('sedimentation rate (m/Ma)')
dev.off()  


pdf(width = 4, 
    height = 4,
    file = './figures/final figures/supplemental_figures/TD1_density.pdf')

sed_rate |> 
  ggplot(mapping = aes(x = sed_rate, 
                       color = model,
                       group = model)) +
  facet_wrap(~layer, 
             scales = 'free_y') + 
  geom_density(alpha = 0.01, 
               show.legend = FALSE,
               fill = NA,
               adjust = 1.5) + 
  scale_color_viridis(option = 'plasma', end = 0.9) + 
  theme_custom +
  theme(axis.text.y = element_blank()) + 
  xlab('sedimentation rate (m/Ma)')
dev.off()  
