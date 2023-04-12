library(tidyverse)
source('./R/plot_settings.R')
library(cowplot)
library(viridis)
library(astroBayes)
# load required data ----------------------------------------------------------
CIP2 <- read_csv('./data/CIP2/cyclostrat_data.csv')
CIP2_true <- read_csv('./data/CIP2/true_age.csv')

# load some example models ----------------------------------------------------


# EHA plot --------------------------------------------------------------------
eha_results <- astrochron::eha(CIP2,
                               win = 2,
                               step = .1,
                               genplot = FALSE,
                               output = 3,
                               verbose = FALSE,
                               ydir = 1,
                               fmax = 10,
                               pad = 1000)

eha_results <- eha_results %>% pivot_longer(cols = 2:(ncol(eha_results)),
                                            names_to = 'depth',
                                            values_to = 'amplitude')

eha_results$depth <- sub("X", "", eha_results$depth) %>% as.numeric()

EHA_plot <- eha_results %>%
  ggplot(mapping = aes(x = freq,
                       y = depth,
                       fill = amplitude)) +
  geom_raster() +
  scale_fill_viridis(option = 'magma') +
  xlab('Frequency (cycles/m)') +
  ylab('Depth (m)') +
  theme(legend.position = 'none') + 
  ylim(10, 0) +
  xlim(0, 5) +
  theme(axis.text.y = element_blank(),
        axis.title.y = element_blank())




wiggles_CIP2 <- CIP2 |> 
  ggplot(mapping = aes(x = value, y = position)) + 
  geom_path() + 
  ylim(10, 0) +
  ylab('depth (m)')


sed_model_CIP2 <- CIP2_true |> 
  ggplot(mapping = aes(x = age, y = position)) + 
  geom_line(color = 'red',
            linetype = 'dashed') + 
  ylim(10, 0) + 
  theme(axis.text.y = element_blank(),
        axis.title.y = element_blank()) + 
  xlab('age (Ma)')

pdf(file = './figures/CIP2.pdf', 
    width = 7.5, 
    height = 3)
plot_grid(wiggles_CIP2, sed_model_CIP2, EHA_plot,
          rel_widths = c(1, 1, 1), 
          nrow = 1,
          labels = 'AUTO',
          label_x = 0.25,
          label_y = 0.97,
          align = 'hv') 
dev.off()
