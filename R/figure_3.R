library(tidyverse)
source('./R/functions/plot_settings.R')
library(cowplot)
library(astroBayes)
library(modifiedBChron)
# load required data ----------------------------------------------------------
TD1_true <- read_csv('./data/TD1/true_age.csv')
CIP2_true <- read_csv('./data/CIP2/true_age.csv')

# define a function to plot the data ------------------------------------------
make_plot <- function(rds, 
                      xlim = c(0, 2.1), 
                      ylim = c(20, 0),
                      true_data = NA) {
  
  dates <- rds$geochron_data
  range <- -seq(min(rds$layer_boundaries$position), 
                max(rds$layer_boundaries$position), 
                length = 500)
  
  # generate a bchron model
  bmodel <- ageModel(ages = dates$age,
                     ageSds = dates$age_sd,
                     positions = -dates$position,
                     ids = dates$id,
                     predictPositions = range,
                     truncateUp = -1e10)
  
  # make the plot
  p <- plot(rds, 
            type = 'age_depth') + 
    theme_custom + 
    theme(legend.position = 'none') + 
    xlab('Age (Ma)') + 
    ylab('Depth (m)') + 
    geom_line(data = true_data,
              mapping = aes(x = age, 
                            y = position),
              inherit.aes = FALSE,
              color = 'red',
              linetype = 'dotted') + 
    xlim(xlim) +
    ylim(ylim) +
    theme(axis.title = element_text(size = 12),
          axis.text = element_text(size = 10))
  
  # add bchron reference lines
  CI <- bmodel$HDI |> 
    t() |> 
    as.data.frame() 
  
  CI$depth <- -bmodel$predictPositions
  
  p <- p + 
    geom_line(data = CI,
              aes(x = `50%`, y = depth),
              inherit.aes = FALSE,
              linetype = 'solid',
              color = 'grey75') + 
    geom_line(data = CI,
              aes(x = `2.5%`, y = depth),
              inherit.aes = FALSE,
              linetype = 'dashed',
              color = 'grey75') +  
    geom_line(data = CI,
              aes(x = `97.5%`, y = depth),
              inherit.aes = FALSE,
              linetype = 'dashed',
              color = 'grey75')
  
  
}
###############################################################################
# TD1 models ##################################################################
###############################################################################
# 2 ages ----------------------------------------------------------------------
TD1_2 <- make_plot(read_rds(file = './results/random_age_validation/TD1_2_ages/2_age_model_983.rds'), 
                   true_data = TD1_true)
TD1_4 <- make_plot(read_rds(file = './results/random_age_validation/TD1_4_ages/4_age_model_273.rds'), 
                   true_data = TD1_true)
TD1_6 <- make_plot(read_rds(file = './results/random_age_validation/TD1_6_ages/6_age_model_226.rds'), 
                   true_data = TD1_true)
TD1_8 <- make_plot(read_rds(file = './results/random_age_validation/TD1_8_ages/8_age_model_881.rds'), 
                   true_data = TD1_true)

###############################################################################
# CIP2 models #################################################################
###############################################################################
# 2 ages ----------------------------------------------------------------------
CIP_model_2 <- make_plot(read_rds(file = './results/random_age_validation/CIP2_2_ages/2_age_model_983.rds'), 
                         xlim = c(0.45, 1.6), 
                         ylim = c(10, -1.5),
                         true_data = CIP2_true)
CIP_model_4 <- make_plot(read_rds(file = './results/random_age_validation/CIP2_4_ages/4_age_model_944.rds'), 
                         xlim = c(0.45, 1.6), 
                         ylim = c(10, -1.5),
                         true_data = CIP2_true)
CIP_model_6 <- make_plot(read_rds(file = './results/random_age_validation/CIP2_6_ages/6_age_model_400.rds'), 
                         xlim = c(0.45, 1.6), 
                         ylim = c(10, -1.5),
                         true_data = CIP2_true)
CIP_model_8 <- make_plot(read_rds(file = './results/random_age_validation/CIP2_8_ages/8_age_model_210.rds'), 
                         xlim = c(0.45, 1.6), 
                         ylim = c(10, -1.5),
                         true_data = CIP2_true)

pdf(file = './figures/figure_3.pdf',
    width = 4.5,
    height = 8.5)
plot_grid(TD1_2, CIP_model_2,
          TD1_4, CIP_model_4,
          TD1_6, CIP_model_6,
          TD1_8, CIP_model_8,
          ncol = 2,
          align = 'hv',
          labels = c('A', 'E', 'B', 'F', 'C', 'G', 'D', 'H' ),
          label_x = 0.85,
          label_y = 0.97)
dev.off()
