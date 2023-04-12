library(tidyverse)
source('./R/plot_settings.R')
library(cowplot)
library(astroBayes)

# load required data ----------------------------------------------------------
TD1_true <- read_csv('./data/TD1/true_age.csv')
CIP2_true <- read_csv('./data/CIP2/true_age.csv')


###############################################################################
# TD1 models ##################################################################
###############################################################################
# 2 ages ----------------------------------------------------------------------
TD1_2 <- read_rds(file = './results/random_age_validation/TD1_2_ages/2_age_model_983.rds')
TD_model_2_plot <- plot(TD1_2, type = 'age_depth') + 
  theme_custom + 
  theme(legend.position = 'none') + 
  xlab('Age (Ma)') + 
  ylab('Depth (m)') + 
  geom_line(data = TD1_true,
            mapping = aes(x = age, 
                          y = position),
            inherit.aes = FALSE,
            color = 'red',
            linetype = 'dashed') + 
  xlim(0, 2.05) + 
  ylim(20, 0) + 
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank())

# 4 ages ----------------------------------------------------------------------
TD1_4 <- read_rds(file = './results/random_age_validation/TD1_4_ages/4_age_model_273.rds')
TD_model_4_plot <- plot(TD1_4, type = 'age_depth') + 
  theme_custom + 
  theme(legend.position = 'none') + 
  xlab('Age (Ma)') + 
  ylab('Depth (m)') + 
  geom_line(data = TD1_true,
            mapping = aes(x = age, 
                          y = position),
            inherit.aes = FALSE,
            color = 'red',
            linetype = 'dashed') + 
  xlim(0, 2.05) + 
  ylim(20, 0) + 
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank())

# 6 ages ----------------------------------------------------------------------
TD1_6 <- read_rds(file = './results/random_age_validation/TD1_6_ages/6_age_model_226.rds')
TD_model_6_plot <- plot(TD1_6, type = 'age_depth') + 
  theme_custom + 
  theme(legend.position = 'none') + 
  xlab('Age (Ma)') + 
  ylab('Depth (m)') + 
  geom_line(data = TD1_true,
            mapping = aes(x = age, 
                          y = position),
            inherit.aes = FALSE,
            color = 'red',
            linetype = 'dashed') + 
  xlim(0, 2.05) + 
  ylim(20, 0) + 
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank())

# 8 ages ----------------------------------------------------------------------
TD1_8 <- read_rds(file = './results/random_age_validation/TD1_8_ages/8_age_model_881.rds')
TD_model_8_plot <- plot(TD1_8, type = 'age_depth') + 
  theme_custom + 
  theme(legend.position = 'none') + 
  xlab('Age (Ma)') + 
  ylab('Depth (m)') + 
  geom_line(data = TD1_true,
            mapping = aes(x = age, 
                          y = position),
            inherit.aes = FALSE,
            color = 'red',
            linetype = 'dashed') + 
  xlim(0, 2.05) + 
  ylim(20, 0) 

###############################################################################
# CIP2 models #################################################################
###############################################################################
# 2 ages ----------------------------------------------------------------------
CIP_model_2 <- read_rds(file = './results/random_age_validation/CIP2_2_ages/2_age_model_983.rds')
CIP_model_2_plot <- plot(CIP_model_2, type = 'age_depth') + 
  theme_custom + 
  theme(legend.position = 'none') + 
  xlab('Age (Ma)') + 
  ylab('Depth (m)') + 
  geom_line(data = CIP2_true,
            mapping = aes(x = age, 
                          y = position),
            inherit.aes = FALSE,
            color = 'red',
            linetype = 'dashed') + 
  xlim(0.45, 1.55) +
  ylim(10, -1.5) + 
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.title.y = element_blank())

# 4 ages ----------------------------------------------------------------------
CIP_model_4 <- read_rds(file = './results/random_age_validation/CIP2_4_ages/4_age_model_944.rds')
CIP_model_4_plot <- plot(CIP_model_4, type = 'age_depth') + 
  theme_custom + 
  theme(legend.position = 'none') + 
  xlab('Age (Ma)') + 
  ylab('Depth (m)') + 
  geom_line(data = CIP2_true,
            mapping = aes(x = age, 
                          y = position),
            inherit.aes = FALSE,
            color = 'red',
            linetype = 'dashed') + 
  xlim(0.45, 1.55) +
  ylim(10, -1.5) + 
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.title.y = element_blank())

# 6 ages ----------------------------------------------------------------------
CIP_model_6 <- read_rds(file = './results/random_age_validation/CIP2_6_ages/6_age_model_400.rds')
CIP_model_6_plot <- plot(CIP_model_6, type = 'age_depth') + 
  theme_custom + 
  theme(legend.position = 'none') + 
  xlab('Age (Ma)') + 
  ylab('Depth (m)') + 
  geom_line(data = CIP2_true,
            mapping = aes(x = age, 
                          y = position),
            inherit.aes = FALSE,
            color = 'red',
            linetype = 'dashed') + 
  xlim(0.45, 1.55) +
  ylim(10, -1.5) + 
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.title.y = element_blank())

# 8 ages ----------------------------------------------------------------------
CIP_model_8 <- read_rds(file = './results/random_age_validation/CIP2_8_ages/8_age_model_210.rds')
CIP_model_8_plot <- plot(CIP_model_8, type = 'age_depth') + 
  theme_custom + 
  theme(legend.position = 'none') + 
  xlab('Age (Ma)') + 
  ylab('Depth (m)') + 
  geom_line(data = CIP2_true,
            mapping = aes(x = age, 
                          y = position),
            inherit.aes = FALSE,
            color = 'red',
            linetype = 'dashed') + 
  xlim(0.45, 1.55) +
  ylim(10, -1.5) + 
  theme(axis.title.y = element_blank())



pdf(file = './figures/random_models.pdf',
    width = 4.5,
    height = 8.5)
plot_grid(TD_model_2_plot, CIP_model_2_plot,
          TD_model_4_plot, CIP_model_4_plot,
          TD_model_6_plot, CIP_model_4_plot,
          TD_model_8_plot, CIP_model_8_plot,
  ncol = 2,
  align = 'hv',
  labels = c('A', 'E', 'B', 'F', 'C', 'G', 'D', 'H' ),
  label_x = 0.85,
  label_y = 0.97)
dev.off()
