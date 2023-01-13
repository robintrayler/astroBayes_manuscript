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

Linking the rock record to absolute time is essential to understanding the timing, rate, and interactions of and among geologic, climatologic, and biologic processes over the course of earth history. Developing chronologies for rock records rely on models (age-depth models) that relate stratigraphic position to age. This is usually accomplished by fitting a curve to several dated horizons throughout a stratigraphic section which is then used to estimate the age and uncertainty at undated points [@blaauw2012]. A variety of Bayesian approaches have been proposed to fit age-depth models[@haslett2008; @blaauw2011; @bronkramsey2008; @schoene2019]. While these methods vary considerably in their mathematical framework, most they share two fundamental characteristics. First, they treat sediment accumulation as a stochastic process where accumulation rate is allowed to vary randomly and considerably throughout a stratigraphic section. Second, they rely on discrete point-estimates of absolute age, usually in the form of radioisotopic dates (e.g., ^40^Ar/^39^Ar, U-Pb, ^14^C), as their basis for chronology construction. This leads to chronologies with widely variable uncertainties [@trachsel2017; @telford2004] that are largely a function of data density. That is model errors are lower in areas where there are more age determinations and higher in areas with less data, leading to "sausage" shaped uncertainties [@devleeschouwer2014]. Incorporating more chronologic information is the best way to improve model accuracy and reduce uncertainty [@blaauw2018], however, this is not always possible. While some records are amenable to almost continuous radioisotopic dating (e.g., ^14^C analysis of peat cores), dating most deep-time stratigraphic sections relies on the presence of volcanic ashes, which usually occur in only a few horizons. Since the density of radioisotopic ages is unlikely to change in most deep-time cases, incorporating other forms of chronologic information is crucial to improving age-depth models. 

<!-- need more informaiton on the desirable properties of both data sources  --> 

Astrochronology links oscillations in climate (as recorded in the rock record) to the quasiperiodic changes in earths orbit [@laskar2020]. These climate rhythms are known as “Milankovitch cycles” and are related to the ellipticity of earths orbit (eccentricity), changes in axial tilt (obliquity), and the precession of earths axis (precession). Since the periods of the different cycles are well understood [@laskar2020; @hinnov2013], astrochronologic records can serve as a "metronome" for the relative passage of time in the rock record.  Unlike radioisotopic geochronology which produces point estimates of age, astrochronologic records can be more-or-less continuous throughout stratigraphic sections. This allows the construction of high-resolution chronologies with uncertainties closely linked to the period of the Milankovitch frequencies [@meyers2018; @meyers2015; @malinverno2010]. However, these chronologies "float" in absolute time and rely on radioisotopic data as temporal anchors.

Several studies have linked astrochronologic and radioisotopic data in a Bayesian framework [@devleeschouwer2014; @harrigan2021; @meyers2012], however to our knowledge, there have no attempts to jointly invert the two data types into age-depth models. This inversion is appealing for several reasons. First, radioisotopic geochronology and astrochronology are complementary. Modern high-precision radioisotopic geochronology can produce point-estimates of age with sub-Milankovich-cycle precision, while astrochronologic durations create a continuous record of accumulation rate which can be leveraged to greatly reduce age-depth model uncertainties between dated horizons. 

In this paper we present a new joint inversion of radioisotope geochronology and astrochronology. 


# Background
## Bayesian Modeling

Bayesian statistics aims to determine the most probable values of unknown *parameters* given *data* and prior information about those parameters. This formalized in Bayes equation where: 

$$P(parameters | data) \propto P(data | parameters) \times P(parameters)$$ {#eq:bayes} 

The first term on the righthand side of @eq:bayes, known as the *likelihood*, is the conditional probability given a set of parameters values. The second term on the righthand side, known as the *prior*, represents the probability of previous knowledge or other constraints on the possible values of the parameters. The lefthand side of @eq:bayes is represents the *posterior* probability of the parameters. That is, how probable are the proposed parameters given a set of data. Bayes equation is often difficult or impossible to solve analytically and instead the posterior distribution is simulated using Markov Chain Monte Carlo methods (MCMC) to generate a random representative sample. Given a large enough sample size and adequate exploration of parameters space, this sample should have the same properties as the "true" posterior distribution [@gelman1996; @kruschke2015].

### Bayesian Age-Depth Modeling

# Methods
## Model Construction

![Schematic of model parameters.](./figures/workflow.pdf){#fig:workflow width=100%}

Developing a model that integrates astrochronology and geochronology requires defining likelihood functions that reflect the probability of both data types, given a common set of parameters. We use a two sets of parameters for our model. The firs consists of a vector of sedimentation rates (*r*) and stratigraphic boundary positions (*z*) that define regions of constant sedimentation (@fig:workflow A). Together, *r* and *z* can be transformed to create a floating age model of piecewise linear segments where (@fig:workflow B). A floating age model can be linked to absolute time by adding a constant (*a*) to the floating model age at every stratigraphic position. We refer to this age as the anchoring age (*a*) that acts as an anchor to link a floating age model to absolute time. Conveniently, the age (*a*) is also the absolute age of the uppermost stratigraphic point (@fig:workflow B). Optionally, sedimentary hiatuses can also be included by adding the duration of a hiatus (*h*) to the floating model age of all points below the stratigraphic position of a hiatus. 

Our data consists of measurements of astrochronologic proxy records, and a set of radioisotope dates that share a common stratigraphic scale. 

Our data consists of measurements of a astrochronologic proxy record and a set of radioisotope dates that share a common stratigraphic scale. That is, the stratigraphic position of the dates overlap with the stratigraphic positions of the proxy record.  

The parameters of our model are a vector of sedimentation rates (*r*) and layer boundaries (*z*) that define regions of constant sedimentation throughout a stratigraphic section. Optionally, the layer boundaries can also serve as the position of sedimentary hiatuses (*h*). An additional parameter, which we refer to as the anchor point (*a*) ties the model to absolute time.

# Probability of radioisotopic ages

The vectors *r* (sedimentation rate) and and *z* (layer boundaries) can be used to calculate a floating age model (see @fig:workflow), and this model can be anchored in absolute time by proposing an age for the *a* parameter (anchor point). The resulting age model consists of a vector of stratigraphic positions (*d*) and vector of ages (*t*) that relate stratigraphic position to absolute time. The probability of this anchored age model can be calculated using the radioisotopic dates. The stratigraphic positions of the dates {*d~j~* ... *d~n~*} and their corresponding ages {*t~j~* ... *t~n~*} are a subset of *d* and *t*, respectively. We therefore define the probability of an anchored age model as given a set of dates as: 

$$P(t) = \prod_{j=1}^{n} N(\mu_j, \sigma^{2}_j)$$ {#eq:radio_prob}

Where *μ~j~* is the weighted mean and *σ^2^~j~* is the variance of the *j^th^* radioisotopic date at stratigraphic position *d~j~*. In effect this probability calculation reflects how well the age model "overlaps" the radioisotope dates where model ages that are closer to the radioisotopic dates are more probable [@schoene2019]. Importantly, only the radioisotopically dated stratigraphic horizons influence this probability. 
 
## Notes 
<!-- Several bayesian models are available to fit age-depth models to radioisotope geochronology data including `OxCal` [@bronkramsey2008], `Bchron` [@haslett2008] `Bacon` [@blaauw2011], and `Chron.jl` [@schoene2019]. Each modeling framework takes a slightly different approach to model fitting but they each focus on fitting models to radioisotopic geochronology data alone. -->

<!-- `Bacon` models sedimentation accumulation as a series of discrete slices where the posterior distribution is of sedimentation rate. --> 

<!-- the rate of accumulation is controlled by two prior distributions, a gamma distribution that represents prior constraints on sedimentation rate and a beta distribution that controls a sedimentation memory parameter, that is how rapidly sedimentation rate can change between slices. While the second parameter is more  -->

<!-- `Bchron` uses a compound-Poisson-gamma distribution model to simulate sedimentation variability and fits a series piecewise-linear segments to the geochronology data. This process means that over the course of many MCMC model iterations sedimentation rate varies randomly throughout a stratigraphic section which may include near-hiatuses or period of near-infinite sedimentation rates. -->



\newpage

# References {.unnumbered}
:::{#refs}
:::