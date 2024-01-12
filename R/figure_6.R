# load required packages ------------------------------------------------------
library(astroBayes) # modeling
library(ggplot2)    # plotting 
library(astrochron) # testing
library(viridis)    # colors 
library(colorednoise)
source('./R/functions/plot_settings.R')
source('./R/functions/tidy_eha.R')
# load the example data -------------------------------------------------------
# TD1 data set is built into astroBayes
dates              <- dates
layer_boundaries   <- layer_boundaries
target_frequencies <- target_frequencies
good_cycles        <- cyclostrat 

# replace cyclostrat data with some red noise
bad_cycles         <- cyclostrat 
bad_cycles$value   <- colorednoise::colored_noise(timesteps = 388, 
                                                  mean = 0, 
                                                  sd = 1, 
                                                  phi = 0.9)

# run astroBayes with the bad data --------------------------------------------
bad_model <- astro_bayes_model(geochron_data = dates,
                               cyclostrat_data = bad_cycles,
                               target_frequency = target_frequencies,
                               layer_boundaries = layer_boundaries)

wiggles_bad <- bad_cycles |> 
  ggplot(mapping = aes(x = value, y = position)) + 
  geom_path() + 
  ylim(20, 0) +
  ylab('Depth (m)')

# view the results
bad_plot <- plot(bad_model, type = 'age_depth') + 
  ylim(20, 0) + 
  theme(legend.position = 'none') + 
  xlab('Age (Ma)') + 
  ylab('Depth (m)')

bad_pgram <- plot(bad_model, type = 'periodogram')

bad_eha <- bad_cycles |> 
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
  theme(axis.text.y = element_blank(),
        axis.title.y = element_blank()) + 
  geom_hline(yintercept = layer_boundaries$position,
             color = 'white',
             linetype = 'dashed') + 
  ylim(20, 0)

pdf(file = 'figures/red_noise.pdf', 
    height = 3,
    width = 5)
cowplot::plot_grid(wiggles_bad, 
                   bad_plot, bad_eha, 
                   align = 'hv',
                   rel_widths = c(1,1, 2),
                   nrow = 1)
dev.off()
