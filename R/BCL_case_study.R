library(astroBayes)
library(viridis)
library(astrochron)
library(tidyverse)
theme_set(theme_bw())
source('./R/tidy_eha.R')

# load the data ---------------------------------------------------------------
# cyclostratigraphic data
cyclostrat <- read.csv(file = './data/BCL/cyclostratigraphic_record.csv') 

# two sets of geochronology
geochron_meyers <- read.csv(file = './data/BCL/meyers_radioisotopic_dates.csv') 
geochron_updated <- read.csv(file = './data/BCL/updated_radioisotopic_dates.csv') 

# layer boundary positions
layer_boundaries <- read.csv(file = './data/BCL/layer_boundaries.csv')

# target frequencies
target_frequency <- read.csv(file = './data/BCL/target_frequency.csv')

# C/T boundary position
new_positions = data.frame(id = 'CTB',
                           position = 7.315, # 4.855
                           thickness = 0)


# reinterpolate the cyclostrat data and remove mean and trends ----------------
cyclostrat_2.5 <- cyclostrat |> 
  select(position,
         value) |> 
  linterp(dt = 0.025, 
          genplot = FALSE) |> 
  demean(genplot = FALSE)  |> 
  detrend(genplot = FALSE)

# evolutive harmonic analysis -------------------------------------------------
eha_results <- tidy_eha(cyclostrat_2.5, 
                        win = 2, 
                        step = 0.05,
                        fmax = 6)

# plot the EHA ----------------------------------------------------------------
# swap the strat position to height for plotting
eha_results$depth <- 12.16944 - eha_results$depth

eha_results %>%
  ggplot(mapping = aes(x = freq,
                       y = depth,
                       fill = amplitude)) +
  geom_raster() +
  scale_fill_viridis(option = 'magma') +
  xlab('Frequency (cycles/m)') +
  ylab('Depth (m)') +
  # scale_y_reverse() +
  theme(legend.position = 'none') + 
  xlim(0, 6) +
  ylim(0, 12.5) + 
  geom_hline(yintercept = 6.6694,
             color = 'white',
             linetype = 'dashed') + 
  geom_hline(yintercept = 2.6694,
             color = 'white',
             linetype = 'dashed')

# run astro bayes -------------------------------------------------------------
meyers_model <- astro_bayes_model(geochron_data = geochron_meyers,
                                  target_frequency = target_frequency,
                                  layer_boundaries = layer_boundaries,
                                  cyclostrat_data = cyclostrat_2.5,
                                  method = 'malinverno',
                                  iterations = 500000,
                                  burn = 50000)
write_rds(meyers_model,
          file = './results/BCL_case_study/meyers_model.rds')
updated_model <- astro_bayes_model(geochron_data = geochron_updated,
                                   target_frequency = target_frequency,
                                   layer_boundaries = layer_boundaries,
                                   cyclostrat_data = cyclostrat_2.5,
                                   method = 'malinverno',
                                   iterations = 500000,
                                   burn = 50000)
write_rds(updated_model,
          file = './results/BCL_case_study/updated_model.rds')

# updated_model <- read_rds(file = './results/BCL_case_study/updated_model.rds')
# meyers_model <- read_rds(file = './results/BCL_case_study/meyers_model.rds')
# calculate the age of the Cenomanian-Turonian boundary -----------------------
meyers_predictions <- predict(age_model = meyers_model, 
                              new_positions = new_positions)

updated_predictions <- predict(age_model = updated_model, 
                               new_positions = new_positions)
# plot the results ------------------------------------------------------------
# swap the stratigraphic positions around for plotting
# age model CI
meyers_predictions$age_model$CI$position <- 
  12.16944 - meyers_predictions$age_model$CI$position
updated_predictions$age_model$CI$position <- 
  12.16944 - updated_predictions$age_model$CI$position

# geochron
meyers_predictions$age_model$geochron_data$position <- 
  12.16944 - meyers_predictions$age_model$geochron_data$position
updated_predictions$age_model$geochron_data$position <- 
  12.16944 - updated_predictions$age_model$geochron_data$position

# C/T boundary position 
meyers_predictions$CI$position <- 
  12.16944 - meyers_predictions$CI$position
updated_predictions$CI$position <- 
  12.16944 - updated_predictions$CI$position

plot(meyers_predictions) + 
  theme(axis.text = element_text(size = 12,
                                 color = 'black'),
        axis.title = element_text(size = 12,
                                  color = 'black'),
        panel.grid.minor = element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(size = 12),
        legend.position = c(0.3, 0.1)) + 
  xlab('Age (Ma)') + 
  ylab('Depth (m)') + 
  ylim(0, 12.5) + 
  xlim(92.5, 95) + 
  ylab('height (m)') 

plot(updated_predictions) + 
  theme(axis.text = element_text(size = 12,
                                 color = 'black'),
        axis.title = element_text(size = 12,
                                  color = 'black'),
        panel.grid.minor = element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(size = 12),
        legend.position = c(0.3, 0.1)) + 
  xlab('Age (Ma)') + 
  ylab('Depth (m)') + 
  ylim(0, 12.5) + 
  xlim(92.5, 95) + 
  ylab('height (m)')

# inspect the trace and density plots of the posterior ------------------------
# plot(meyers_model, type = 'trace')
# plot(meyers_model, type = 'sed_rate')
plot(meyers_model, type = 'periodogram')
# plot(meyers_model, type = 'cyclostrat')
# 
# plot(updated_model, type = 'trace')
# plot(updated_model, type = 'sed_rate')
plot(updated_model, type = 'periodogram')
# plot(updated_model, type = 'cyclostrat')

# plot EHA and periodogram of the meyers model for validation -----------------
meyers_eha <- data.frame(age = meyers_model$cyclostrat_CI[[1]]$median, 
                         value = meyers_model$cyclostrat_CI[[1]]$value) |> 
  linterp(genplot = FALSE,
          verbose = FALSE) |> 
  tidy_eha(win = 0.75,
           step = 0.025,
           fmax = 50) |> 
  ggplot(mapping = aes(x = freq,
                       y = depth,
                       fill = amplitude)) +
  geom_raster(show.legend = FALSE) +
  scale_fill_viridis(option = 'magma') +
  xlab('Frequency (cycles/m)') +
  ylab('Age (Ma)') +
  theme(legend.position = 'none') +
  geom_vline(data = target_frequency, 
             mapping = aes(xintercept = frequency,
                           color = orbital_cycle),
             size = 1,
             linetype = 'dotted') + 
  scale_color_brewer(palette = "Purples") + 
  xlim(0, 50) + 
  scale_y_continuous(breaks = c(93.0, 93.5, 94.0, 94.5),
                     limits = c(93.0, 94.25)) + 
  scale_y_reverse()

updated_eha <- data.frame(age = updated_model$cyclostrat_CI[[1]]$median, 
                          value = updated_model$cyclostrat_CI[[1]]$value) |> 
  linterp(genplot = FALSE,
          verbose = FALSE) |> 
  tidy_eha(win = 0.75,
           step = 0.025,
           fmax = 50) |> 
  ggplot(mapping = aes(x = freq,
                       y = depth,
                       fill = amplitude)) +
  geom_raster(show.legend = FALSE) +
  scale_fill_viridis(option = 'magma') +
  xlab('Frequency (cycles/m)') +
  ylab('Age (Ma)') +
  theme(legend.position = 'none',
        axis.title.y = element_blank(),
        axis.text.y = element_blank()) +
  geom_vline(data = target_frequency, 
             mapping = aes(xintercept = frequency,
                           color = orbital_cycle),
             size = 1,
             linetype = 'dotted') + 
  scale_color_brewer(palette = "Purples") + 
  xlim(0, 50) + 
  ylim(94.3, 93.0)

# periodogram 
meyers_pgram <- meyers_model$cyclostrat_CI[[1]] |>
  select(median,
         value) |>
  linterp(genplot = FALSE,
          verbose = FALSE) |>
  periodogram(genplot = FALSE,
              verbose = FALSE,
              background = 1,
              f0 = TRUE,
              output = 1,
              padfac = 10) |>
  ggplot(mapping = aes(x = Frequency,
                       y = Power)) +
  geom_line() +
  geom_line(mapping = aes(y = AR1_Fit),
            color = 2,
            linetype = 'solid') +
  geom_line(mapping = aes(y = AR1_95_power),
            color = 2,
            linetype = 'dashed') +
  theme_bw() +
  geom_vline(data = meyers_model$target_frequency,
             mapping = aes(xintercept = frequency),
             color = 'grey',
             linetype = 'dashed',
             size = 0.5) +
  xlab('Frequency (cycles/Ma)') +
  ylab('Spectral Power') +
  theme(panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank()) + 
  xlim(0, 50)

updated_pgram <- updated_model$cyclostrat_CI[[1]] |>
  select(median,
         value) |>
  linterp(genplot = FALSE,
          verbose = FALSE) |>
  periodogram(genplot = FALSE,
              verbose = FALSE,
              background = 1,
              f0 = TRUE,
              output = 1,
              padfac = 10) |>
  ggplot(mapping = aes(x = Frequency,
                       y = Power)) +
  geom_line() +
  geom_line(mapping = aes(y = AR1_Fit),
            color = 2,
            linetype = 'solid') +
  geom_line(mapping = aes(y = AR1_95_power),
            color = 2,
            linetype = 'dashed') +
  theme_bw() +
  geom_vline(data = meyers_model$target_frequency,
             mapping = aes(xintercept = frequency),
             color = 'grey',
             linetype = 'dashed',
             size = 0.5) +
  xlab('Frequency (cycles/Ma)') +
  ylab('Spectral Power') +
  theme(panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.y = element_blank()) + 
  xlim(0, 50)

cowplot::plot_grid(meyers_pgram, updated_pgram,
                   meyers_eha, updated_eha, 
                   nrow = 2,
                   ncol = 2,
                   aling = 'v',
                   rel_heights = c(1, 2, 1, 2))

# Calculate the hiatus duration for both models -----------------------------------------
meyers_dens <-  meyers_model$hiatus_durations[meyers_model$burn:meyers_model$iterations] |> 
  density()

updated_dens <-  updated_model$hiatus_durations[updated_model$burn:updated_model$iterations] |> 
  density()

ggplot() + 
  geom_density(
    mapping = aes(x = meyers_model$hiatus_durations[meyers_model$burn:meyers_model$iterations]),
    adjust = 1, 
    fill = 4,
    alpha = 0.75, 
    color = NA) + 
  geom_density(
    mapping = aes(x = updated_model$hiatus_durations[updated_model$burn:updated_model$iterations]),
    adjust = 1, 
    fill = NA,
    alpha = 0.75, 
    color = 1,
    linetype = 'dashed') +
  xlab('hiatus duration (Ma)')

updated_dens$x[which.max(updated_dens$y)]
meyers_dens$x[which.max(meyers_dens$y)]
