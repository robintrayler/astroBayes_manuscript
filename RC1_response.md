# RC1: 'Comment on gchron-2023-22', Maarten Blaauw, 27 Sep 2023

This manuscript proposes to combine proxy data of orbital forcing with radiometric dates in order to produce integrated age-depth models from cores. It builds a piece-wise linear model with constrained accumulation rates and the possibility of hiatuses, and treats the response to the orbital forcing as a constant offset 'a' in years for each section. The method is tested using synthetic and real-world data, and shows huge enhancements in precision compared to dates-only age-models (but see below).

Generally the method is described well and placed in the wider context through an interesting review of existing methods. However, I would like to see some more detail on how the parameters are estimated, how the priors are set and how these settings affect the age-depth models (robustness analysis).

Section 3.2.3, what limits are put on the accumulation rate, and why are you using a uniform distribution? Why not use a more informative prior on accumulation rate, such as a gamma with a specified mean and shape (the latter can be put at very permissive values, e.g., 1.1)? This would then also diminish the likelihood of cycles that require extreme accumulation rates (i.e., the harmonic analysis of Fig. 2c/f would show darker colours for less realistic accumulation rates). Are there limits on the hiatus size as well, and is the prior also uniform or rather gamma as suggested by Fig. 7?

The difference in modeled precision between `BChron` and astroBayes is huge, especially in the case where a core has only few radiometric dates. That said, how robust is the assumption of linear accumulation over long time-scales (e.g., the long section of Fig. 3b)? Although this is discussed, I still find it hard to believe that a geological sedimentation process really was exactly linear over large amounts of time - if this assumption is not met, then the reconstructed precision will be illusionary high.

The proposed method uses a limited number of sections of linear accumulation, e.g. <10. Does increasing this to say 50 or 100 shorter linear sections affect the age-depth models by much (e.g., in terms of smoothness and reconstructed uncertainties)? Could you explain a bit more how the 'elbows' (z) between the sections are chosen and how they can be made to vary over depth? This model reminds me of Bpeat (Blaauw and Christen 2005 Applied Statistics 54, 805-816), which modeled accumulation using a handful of linear sections and where the depths of the 'elbows' were part of the parameters to be estimated (this also included hiatuses and outliers).

What about a potential alternative model, also with set boundaries between the different known sections of nearly but not entirely linear accumulation (e.g., a bit like Bacon but with a very high and strong prior memory on accumulation rate, so a very low variability of accumulation rate over a section, but still some possibility of deviation from an entirely straight line), and with very permissive/wide prior accumulation rates for each of these sections so rates can jump from one z to the next?

Some more information on the MCMC settings and decisions could be helpful, e.g. in Supplementary Information. Perhaps also provide a short tutorial, much like on the helpful GitHub pages but using the examples of the manuscript and with more information as to what steps are taken and why.

Table 2: The estimates are given as 7 digits, which implies that the length of each of the periods is known to the month (!). Should the values not be rounded to a more realistic precision, and if so, what would that precision be (millennial I'd say)? Are there any estimates of the size and shape of the uncertainties related to the period/frequency estimates of the different orbital cycles? Does it matter for the harmonic analysis where in time each of the cycles of Table 2 starts?

> Section 3.2.2, was no outlier analysis done?

## Details

> Line 13, 49, spatial-temporal? How does is the spatial component involved? Do you rather mean vertical, depth-scale resolution? Spatial could be interpreted as 'horizontal' resolution, as in, how representative is a core of wider spatial events. How would one define high temporal resolution? Rather, mention that this is at, e.g., 10^5-6 yr resolution.

> 15, high-precision, quantify

> 94, again high-precision - this seems an unnecessary qualifier here as no-one would aim for low precision

> 270, what MCMC thinning was used?

> 299, The test was done using simulated sections of constant accumulation, so that the model closely follows the simulated truth is no surprise.

> 430, to evaluate