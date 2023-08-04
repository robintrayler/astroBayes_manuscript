library(astrochron)
tidy_eha <- function(data, win = 25, step = 1, fmax = 2) {
 
  eha <- astrochron::eha(data,
                        win = win,
                        step = step,
                        genplot = FALSE,
                        output = 3,
                        verbose = FALSE,
                        ydir = 1,
                        fmax = fmax,
                        pad = 10000)
  
  eha <- eha |> 
   pivot_longer(cols = 2:(ncol(eha)),
                names_to = 'depth',
                values_to = 'amplitude')
 
  eha$depth <- sub("X", "", eha$depth) |> as.numeric()
 
 return(eha)
}