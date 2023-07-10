library(astroBayes)
library(viridis)
library(astrochron)
library(tidyverse)
theme_set(theme_bw())
source('./R/tidy_eha.R')

# load the data ---------------------------------------------------------------
cyclostrat <- read.csv(file = './data/BCL/cyclostratigraphic_record.csv') %>% 
  demean(genplot = FALSE) %>% 
  detrend(genplot = FALSE)

geochron   <- read.csv(file = './data/BCL/radioisotopic_dates.csv')
segment_edges <- read.csv(file = './data/BCL/segment_edges.csv')
tuning <- read.csv(file = './data/BCL/tuning_frequency.csv')

# prep the data ---------------------------------------------------------------
cyclostrat_2.5 <- cyclostrat |>  
  linterp(dt = 0.025,             # re interpolate to 0.025 m resolution
          genplot = FALSE) |>     # don't plot
  detrend(genplot = FALSE) |>     # remove a linear trend
  demean(genplot = FALSE)         # center at zero

# reorder the stratigraphic positions to depth --------------------------------
max_depth <- max(cyclostrat_2.5$position)
cyclostrat_2.5$position <- abs(cyclostrat_2.5$position - max_depth)
geochron$position       <- abs(geochron$position - max_depth)


# evolutive harmonic analysis -------------------------------------------------
eha_results <- tidy_eha(cyclostrat_2.5, 
                        win = 2, 
                        step = 0.05,
                        fmax = 6)

# plot it
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
  ylim(12.5, 0) + 
  geom_hline(yintercept = 5.5,
             color = 'white',
             linetype = 'dashed') + 
  geom_hline(yintercept = 8.5,
             color = 'white',
             linetype = 'dashed')

# run astro bayes -------------------------------------------------------------
model <- astro_bayes_model(geochron_data = geochron,
                           tuning_frequency = tuning,
                           segment_edges = segment_edges,
                           cyclostrat_data = cyclostrat_2.5,
                           method = 'malinverno',
                           iterations = 1000000,
                           burn = 10000)

# calculate the age of the Cenomanian-Turonian boundary -----------------------
new_positions = data.frame(id = 'CTB',
                           position = 7.315,
                           thickness = 0)

predictions <- predict(age_model = model, 
                       new_positions = new_positions)

# plot the results ------------------------------------------------------------
plot(predictions) + 
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
  guides(fill = guide_legend(ncol=2))

# inspect the trace and density plots of the posterior
plot(model, type = 'trace')
plot(model, type = 'sed_rate')
plot(model, type = 'periodogram')
plot(model, type = 'cyclostrat')

# 
eha_median <- data.frame(age = model$cyclostrat_CI[[1]]$median, 
                                value = model$cyclostrat_CI[[1]]$value) |> 
  linterp(genplot = FALSE,
          verbose = FALSE) |> 
  tidy_eha(win = 0.75,
           step = 0.025,
           fmax = 50)


eha_median %>%
  ggplot(mapping = aes(x = freq,
                       y = depth,
                       fill = amplitude)) +
  geom_raster(show.legend = FALSE) +
  scale_fill_viridis(option = 'magma') +
  xlab('Frequency (cycles/m)') +
  ylab('Age (Ma)') +
  theme(legend.position = 'bottom') +
  geom_vline(data = tuning, 
             mapping = aes(xintercept = frequency,
                           color = orbital_cycle),
             size = 1,
             linetype = 'dotted') + 
  scale_color_brewer(palette = "Purples") + 
  xlim(0, 50) + 
  scale_y_continuous(breaks = c(93.0, 93.5, 94.0, 94.5),
                     limits = c(93.0, 94.25))





model$cyclostrat_CI[[1]] |>
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
  geom_vline(data = model$tuning_frequency,
             mapping = aes(xintercept = frequency),
             color = 'grey',
             linetype = 'dashed',
             size = 0.5) +
  xlab('Frequency (cycles/Ma)') +
  ylab('Spectral Power') +
  ggtitle(LETTERS[1]) +
  theme(panel.grid = element_blank()) + 
  xlim(0, 50)

dens <-  model$hiatus_durations[model$burn:model$iterations] |> density()

ggplot(mapping = aes(x = model$hiatus_durations[model$burn:model$iterations])) + 
  geom_density(adjust = 1, fill = 4,
               alpha = 0.75, 
               color = NA) + 
  geom_vline(xintercept = dens$x[which.max(dens$y)]) + 
  geom_vline(xintercept = quantile(model$hiatus_durations[model$burn:model$iterations],
                                   prob = c(0.025, 0.5, 0.975)))
xlab('hiatus duration (Ma)')


