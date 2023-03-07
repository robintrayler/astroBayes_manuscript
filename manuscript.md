---
title: "Bayesian Integration of Astrochronology and Radioisotope Geochronology"
author:
  - Robin B. Trayler
  - Stephen R. Meyers
  - Mark D. Schmitz
bibliography: /Users/robintrayler/Zotero/ref_library.bib
csl: /Users/robintrayler/Zotero/styles/earth-and-planetary-science-letters.csl
mainfont: "Georgia"
fontsize: 12pt
geometry: margin=1.0in
tblPrefix: Table
figPrefix: Figure
secPrefix: Section
autoEqnLabels: true
link-citations: true
indent: true
header-includes:
    - \usepackage{lineno}
    - \linenumbers
    - \usepackage{setspace}
    - \doublespacing
---

<!-- pandoc -s -o manuscript.pdf --pdf-engine=xelatex --filter pandoc-crossref --citeproc --number-sections manuscript.md --> 


# Introduction

Astrochronology uses the geologic record of oscillations in earths climate ("Milankovitch cycles") to interpret the passage of time [@meyers2019; @hinnov2013; @laskar2020]. Some of these climate oscillations can be linked linked to astrologic processes with well understood periods [@laskar2020], including changes to the ellipticity of Earth's orbit (eccentricity; ~0.1 Ma, 0.405 Ma), axial tilt (obliquity ~0.041 Ma), and axial precession (precession; ~0.02 Ma). Together, these changes in Earth's orbit and rotation directly influence the climate which in turn is recorded in the rock record. Since the periods of different astrologic cycles are known, their manifestation in the rock record can be used as a metronome that provides a direct link between the passage of time and the geologic record. Since linking the rock record to time is a crucial step when investigating the timing, rate, and duration of past geologic, climatologic, and biologic processes, astrochronology has had a significant impact on the quantification of deep time [see reviews of  @meyers2019; and @hinnov2013]. 

Perhaps the biggest limitation of astrochronology is that, in the absence of independent constraints, astrochronology produces "floating" chronologies that lack absolute age information. Anchoring floating chronologies in time relies on  independently determining the age of a subset of stratigraphic positions using radioisotopic geochronology. The premier high-precision geochronometers, the ^40^Ar/^39^Ar and U-Pb methods enable the direct determination of age from single mineral crystals (e.g., sanidine, zircon) to better than 0.1% [@schmitz2013]. However, while astrochronologic records can be more-or-less continuous over large stratigraphic sections, radioisotopic geochronology requires the presence of datable material, usually volcanic ashes. Since these rocks usually occur in only a few horizons, chronologies developed using only radioisotopic dates have widely varying uncertainties, with precise, well-understood ages near the stratigraphic positions of the dates, and much larger uncertainties in stratigraphically distant areas [@blaauw2011; @parnell2011; @trachsel2017; @trayler2020a]. 

A common problem when constructing a chronology from a the rock record is how best to express time as a function of stratigraphic position. Astrochronology produces near-continuous floating chronologies, whereas radioisotopic geochronology can produce accurate and precise ages for a small subset of stratigraphic positions. Linking these two methods into an integrated model of age (i.e. age-depth modeling) is therefore an attractive prospect as combines the strengths and overcomes the limitations of both data sources. In this paper we present a method of integrating cyclostratigraphy and radioisotopic dates to develop high precision age-depth models. This joint inversion produces age-depth models with both the resolution of astrochronology and overall uncertainties closely linked to those of the radioisotopic dates. Furthermore, these chronologies are anchored in absolute time, making them ideal for correlating proxy records to other global records. 

# Background

## Astrochronology

<!-- Steve can write this --> 

## Radioisotope Geochronology

<!-- Mark can write this --> 

## Bayesian Modeling

Bayesian statistics aims to determine the most probable values of unknown parameters given data and prior information about those parameters. This formalized in Bayes equation where: 

$$P(parameters | data) \propto P(data | parameters) \times P(parameters)$$ {#eq:bayes} 

The first term on the righthand side of @eq:bayes, known as the likelihood, is the conditional probability given a set of parameters values. The second term on the righthand side, known as the prior, represents the probability of previous knowledge or other constraints on the possible values of the parameters. The lefthand side of @eq:bayes is represents the posterior probability of the parameters. That is, how probable are the proposed parameters given a set of data. Bayes equation is often difficult or impossible to solve analytically and instead the posterior distribution is simulated using Markov Chain Monte Carlo methods (MCMC) to generate a random representative sample. Given a large enough sample size and adequate exploration of parameters space, this sample should have the same properties as the "true" posterior distribution [@gelman1996; @kruschke2015].

In our case our data consists of measurements of an astrochronologic record (*data*) (e.g., δ^18^O, XRF scans, core resistivity, etc), and a set of radioisotopic dates (*dates*) that share a common stratigraphic scale. Developing an age depth model from these records requires 1) a likelihood function that reflects the probability of both data types, 2) a common set of parameters to calculate the probability of, and 3) in the case of age-depth modeling, a model that reflects our best understanding of sediment accumulation. 

## Bayesian Age-Depth Modeling

Developing chronologies for rock records rely on models (age-depth models) that relate stratigraphic position to age. This is usually accomplished by fitting a curve to several dated horizons throughout a stratigraphic section which is then used to estimate the age and uncertainty at undated points [@blaauw2012]. A variety of Bayesian approaches have been proposed to fit age-depth models[@haslett2008; @blaauw2011; @bronkramsey2008; @schoene2019]. While these methods vary considerably in their mathematical framework, most they share two fundamental characteristics. First, they treat sediment accumulation as a stochastic process where accumulation rate is allowed to vary randomly and considerably throughout a stratigraphic section. Second, they rely on discrete point-estimates of absolute age, usually in the form of radioisotopic dates (e.g., ^40^Ar/^39^Ar, U-Pb, ^14^C), as their basis for chronology construction. This leads to chronologies with widely variable uncertainties [@trachsel2017; @telford2004; @devleeschouwer2014] that are largely a function of data density. That is model errors are lower in areas where there are more age determinations and higher in areas with less data, leading to "sausage" shaped uncertainties [@devleeschouwer2014]. Incorporating more chronologic information is the best way to improve model accuracy and reduce uncertainty [@blaauw2018], however, this is not always possible. While some records are amenable to almost continuous radioisotopic dating (e.g., ^14^C analysis of peat cores), dating most deep-time stratigraphic sections relies on the presence of volcanic ashes, which usually occur in only a few horizons. Since the density of radioisotopic ages is unlikely to change in most deep-time cases, incorporating other forms of chronologic information is crucial to improving age-depth models.

Incorporating astrochronology into age model construction is a promising method for reducing age-depth model uncertainties. 

[@harrigan2021] 
[@devleeschouwer2014]
[@meyers2012]
[@malinverno2010] 


# Methods

## Model Construction

![Schematic of model parameters.](./figures/workflow.pdf){#fig:workflow width=100%}

Existing Bayesian age depth models (discussed above) model sedimentation as a relatively large number of piecewise linear segments. Sedimentation rate can vary substantially between segments, leading to the "sausage-shaped" uncertainty envelopes that characterize these models [@trachsel2017; @devleeschouwer2014; @parnell2011]. However, this mode of sedimentation is not ideal for the construction of astrochronologies, as fluctuations in sedimentation rate can be mapped to astrochronologic cycles even if they are unrelated. Instead a sedimentation model for astrologic tuning should minimize fine-scale fluctuations in sedimentation rate [@muller2002; @malinverno2010]. We therefore adopt a relatively simple sedimentation model with a few layers of consistent sedimentation rate. 

@malinverno2010 presented a simple sedimentation model appropriate for orbital tuning of sedimentary records and we use their framework as the basis for our joint inversion. The sedimentation model consists of two sets of parameters. The first is a vector of sedimentation rates (*r*), and stratigraphic boundary positions (*z*) that define regions of constant sedimentation (@fig:workflow A). For example, the model shown in @fig:workflow A has 11 parameters, five sedimentation rates (r~1~ to r~i~) and six layer boundaries (z~1~ to z~i~). This model formulation allows step changes in sedimentation rate at layer boundaries (*z*) but otherwise hold sedimentation rate (*r*) within each layer. 

Together *r* and *z* can also be transformed to create an age-depth model consisting of piecewise linear segments that form a floating age-depth model (@fig:workflow B). This floating model can be linked to absolute time by adding a constant age (*a*) to the floating model at every stratigraphic position.   This age (*a*) acts as an anchor to link the floating age model to absolute time. Optionally, sedimentary hiatuses can also be included in the model in a similar manner by adding the duration of the hiatus (*h*) to the all the points of the anchored blade below the stratigraphic position of the hiatus.


| parameter | explanation                                                      |
|:---------:|:-----------------------------------------------------------------|
|    *r*    | sedimentation rate (m/Ma)                                        |
|    *z*    | layer boundary positions (stratigraphic positions)               |
|    *a*    | anchoring age (Ma)                                               |
|    *D*    | depth (stratigraphic positions; transformation of *z*)           |
|    *T*    | age (Ma; transformation of *r* and *z*)                          |
|    *f*    | orbital tuning frequencies (cycles/Ma)                           |
|  *data*   | astrochronologic data (value vs stratigraphic position)          |
|  *dates*  | radioisotopic dates (Ma)                                         |

Table: explanation of model parameters. {#tbl:parameters}

## Probability Calculations

Together the vectors of sedimentation rates (*r*) and layer boundaries (*z*) and anchoring age (*a*) can be used to to calculate an anchored *age-depth model* which consists of a series of piecewise linear segments (@fig:workflow B). The slope (m/Ma) and length of these segments is controlled the sedimentation rates (*r*) and layer boundary positions (*z*), while the absolute age is controlled by the anchoring constant (*a*). The anchored age-depth model now consists of a vector of stratigraphic positions (*D*) and a corresponding vector of ages (*T*) that relate stratigraphic position to absolute age. The probability of this age-depth model can be assessed by calculating the probability of the segmentation rates (*r*) and anchoring constant (*a*) given an astrochronologic record (*data*) and a series of radioisotopic dates (*dates*). 

### Probability of a Astrologic Frequencies

We followed the approach of @malinverno2010 to calculate the probability of our data given a sedimentation rate and set of orbital frequencies (*f*).  

$$P(data |r, f) \propto exp[\frac{C_{data}(f)}{C_{background}(f)}]$$ {#eq:malinverno}

Where the data is the astrochronologic record, *r* is a sedimentation rate, and *f* is an orbital frequency, *C~data~* is the periodogram of the data, and *C~background~* is the red noise background. The probability in @eq:malinverno is calculated independently for each model layer (i.e., between adjacent *z*'s). The overall probability is therefore the joint probability of all individual layers. @eq:malinverno calculates the concentration of spectral power on orbital frequencies, where a given sedimentation rate is more probable if it causes peaks in spectral power that rise above the red noise background to "line up" with orbital frequencies.

<!-- There is currently no mention of the timeOpt probabilities. I'll ask Steve Meyers to write that as I get further along --> 

### Probability of Radioisotopic Dates

This anchored age-depth model consists of two paired vectors which that relate stratigraphic position (*D*) to absolute time (*T*). The stratigraphic positions of the dates {*d~1~* ... *d~j~*} and their corresponding ages [*t~1~* ... *t~j~*] are a subset of *D* and *T*, respectively. We therefore define the probability of the modeled age (*T*) at a depth (*D*), given a set of dates as: 

$$P(T | dates) = \prod_{j = 1}^{n} N(\mu_j, \sigma^{2}_{j})$$ {#eq:radio_prob}

Where *μ~j~* is the weighted mean age and *σ^2^~j~* is the variance of the j^th^ radioisotopic date at stratigraphic position *d~j~*. Notice that while *d* and *t* are continuous over the entire stratigraphic section, only the stratigraphic positions that contain radioisotopic dates influence the probability of the age model. In effect, this probability calculation reflects how well the age model "overlaps" the radioisotope dates, where modeled ages that are closer to the radioisotopic dates are more probable @fig:workflow B [@schoene2019]. 

### Overall Probability

The overall likelihood function of an anchored age-depth model is the joint probability of @eq:malinverno and @eq:radio_prob. We use a vague uniform prior where sedimentation rate may take any value between a specified minimum and maximum value. 

### Implementation

We implemented our model as an `R` package. We estimated the most probable values of sedimentation rate using a Metropolis-Hasting algorithm and an adaptive Markov Chain Monte Carlo (MCMC) [@haario2001]. 

## Testing and Validation

* Two data sets
    *  TD-1: Simple sedimentation model used to distort an eccentricity-tilt-precession time series to generate the astrochronologic data and generate a suite of radioisotopic date. <!-- This needs more information from Steve --> 
    *  CIP-2: Case study 2 from the Cyclostratigraphy Intercomparison project. [@sinnesael2019]

## Model Sensitivity and Validation

### Stability 

We assessed model stability buy generating 1000 individual age-depth models for both testing data sets using the same input data (synthetic cyclostratigraphic radioisotopic dates) and astrologic frequencies. Each simulation was run for 10,000 MCMC iterations with the initial 1,000 steps discarded to allow the model to converge.  

To assess model stability, we generated 1000 individual simulations for the TD-1 and CIP-2 data sets using the same input data (astrochronologic record and radioisotopic dates). Each simulation was run for 10,000 iterations with the initial 1,000 steps discarded to allow the model to stabilize.

### Sensitivity

We tested the sensitivity of our model to both the number and stratigraphic position of radioisotopic dates. For both our testing data sets we randomly generated a set of dates from the underlying true age model using Monte Carlo methods, which were then used as inputs alongside the synthetic astrochronologic record. We repeated this procedure 1,000 times using 2, 4, 6, and 8 dates for a total of 4,000 test models. For the CIP-2 data set we added an additional constraint to ensure that the hiatus was always bracketed by dates, with at least one date above and below the hiatus position. 

### Assessment

We calculated two metrics to assess model performance. First we calculated the proportion of the true underlying age model that fell within the 95% credible interval of our model. We assume a well performing model should contain the true age model in most cases. This method has been used to assess performance on existing Bayesian age-depth models [@parnell2011]. For example @haslett2008 showed that approximately 80-95% of model credible intervals contain the "true" age model. Second, we calculated the stability of median and 95% CI for sedimentation rate within each layer boundary (*z*). 

# Results

## Contained Proportion Table

| data set | number of dates | fraction contained |
|:--------:|:---------------:|:------------------:|
|   TD-1   |         2       |         0.98       |
|          |         4       |         0.99       |
|          |         6       |                    |
|          |         8       |                    |
|  CIP-2   |         2       |                    |
|          |         4       |                    |
|          |         6       |                    |
|          |         8       |                    |

Table: proportion of true sedimentation model contained within the 95% credible interval with an increasing number of dates. {#tbl:contained}

# Notes 
* Several bayesian models are available to fit age-depth models to radioisotope geochronology data including `OxCal` [@bronkramsey2008], `Bchron` [@haslett2008] `Bacon` [@blaauw2011], and `Chron.jl` [@schoene2019]. Each modeling framework takes a slightly different approach to model fitting but they each focus on fitting models to radioisotopic geochronology data alone. 

* `Bacon` models sedimentation accumulation as a series of discrete slices where the posterior distribution is of sedimentation rate. --> 

* the rate of accumulation is controlled by two prior distributions, a gamma distribution that represents prior constraints on sedimentation rate and a beta distribution that controls a sedimentation memory parameter, that is how rapidly sedimentation rate can change between slices. While the second parameter is more  -->

* `Bchron` uses a compound-Poisson-gamma distribution model to simulate sedimentation variability and fits a series piecewise-linear segments to the geochronology data. This process means that over the course of many MCMC model iterations sedimentation rate varies randomly throughout a stratigraphic section which may include near-hiatuses or period of near-infinite sedimentation rates. -->



\newpage

# References {.unnumbered}
:::{#refs}
:::