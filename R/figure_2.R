library(tidyverse)
source('./R/functions/plot_settings.R')
source('./R/functions/tidy_eha.R')
library(cowplot)
library(viridis)
library(astroBayes)
# load required data ----------------------------------------------------------
CIP2 <- read_csv('./data/CIP2/cyclostrat_data.csv')
CIP2_true <- read_csv('./data/CIP2/true_age.csv')
TD1 <- read_csv(file = './data/TD1/cyclostratigraphic_record.csv')
TD1_true <- read_csv(file = './data/TD1/true_age.csv')

# EHA plots -------------------------------------------------------------------
# CIP2
CIP2_eha <- CIP2 |> 
  tidy_eha(win = 2, 
           step = 0.1,
           fmax = 10) |> 
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

# TD1
TD1_eha <- TD1 |> 
  tidy_eha(win = 3, 
           step = 0.1,
           fmax = 8) |> 
  ggplot(mapping = aes(x = freq,
                       y = depth,
                       fill = amplitude)) +
  geom_raster() +
  scale_fill_viridis(option = 'magma') +
  xlab('Frequency (cycles/m)') +
  ylab('Depth (m)') +
  theme(legend.position = 'none') + 
  ylim(20, 0)  +
  theme(axis.text.y = element_blank(),
        axis.title.y = element_blank())


# plot the raw data ---------------------------------------------------=-------
wiggles_CIP2 <- CIP2 |> 
  ggplot(mapping = aes(x = value, y = position)) + 
  geom_path() + 
  ylim(10, 0) +
  ylab('depth (m)')

wiggles_TD1 <- TD1 |> 
  ggplot(mapping = aes(x = value, y = position)) + 
  geom_path() + 
  ylim(20, 0) +
  ylab('depth (m)')

# sedimentation models --------------------------------------------------------
# CIP2
sed_model_CIP2 <- CIP2_true |> 
  ggplot(mapping = aes(x = age, y = position)) + 
  geom_line(color = 'red',
            linetype = 'dashed') + 
  ylim(10, 0) + 
  theme(axis.text.y = element_blank(),
        axis.title.y = element_blank()) + 
  xlab('age (Ma)')

# TD1
sed_model_TD1 <- TD1_true |> 
  ggplot(mapping = aes(x = age, y = position)) + 
  geom_line(color = 'red',
            linetype = 'dashed') + 
  ylim(20, 0) + 
  theme(axis.text.y = element_blank(),
        axis.title.y = element_blank()) + 
  xlab('age (Ma)')


pdf(file = './figures/figure_2.pdf', 
    width = 6.5, 
    height = 5)
plot_grid(wiggles_TD1, sed_model_TD1, TD1_eha,
  wiggles_CIP2, sed_model_CIP2, CIP2_eha,
          rel_widths = c(1, 1, 2), 
          nrow = 2,
          labels = 'AUTO',
          label_x = 0.25,
          label_y = 0.97,
          align = 'hv') 
dev.off()
