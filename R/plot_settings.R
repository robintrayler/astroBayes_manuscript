# plot settings
library(tidyverse)
library(viridis)
theme_custom <- theme_minimal() + 
  theme(axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        panel.border = element_rect(fill = NA, color = 'black'),
        panel.grid.minor = element_blank())

theme_set(theme_custom)