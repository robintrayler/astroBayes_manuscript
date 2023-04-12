---
title: "Bayesian Integration of Astrochronology and Radioisotope Geochronology"
author:
  - Robin B. Trayler
  - Stephen R. Meyers
  - Mark D. Schmitz
bibliography: /Users/robintrayler/Zotero/ref_library.bib
csl: /Users/robintrayler/Zotero/styles/copernicus-publications.csl
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

Linking the rock record to numerical time is a crucial step when investigating the timing, rate, and duration of geologic, climatologic, and biologic processes. However, constructing chronologies from the rock record is complicated by a variety of factors. The premier high-precision geochronometers, the ^40^Ar/^39^Ar and U-Pb methods enable the direct determination of age from single mineral crystals (e.g., sanidine, zircon) to better than 0.1% [@schmitz2013], However, horizons amenable to radioisotopic dating, mostly volcanic ashes, usually occur in only a few, randomly distributed, horizons within a given stratigraphic section. This leads to the problem of a small number of high-precision dates throughout stratigraphy with limited chronologic information between these horizons. Since these rocks usually occur in only a few horizons, chronologies developed using only radioisotopic dates have widely varying uncertainties, with precise, well-understood ages near the stratigraphic positions of the dates, and much larger uncertainties in stratigraphically distant areas [@blaauw2011; @parnell2011; @trachsel2017; @trayler2020a]. 

Adding more chronologic information is the best way to improve age-depth model construction [@blaauw2018]. Astrochronology uses the geologic record of oscillations in earths climate ("Milankovitch cycles") to interpret the passage of time [@meyers2019; @hinnov2013; @laskar2020]. Some of these climate oscillations can be linked linked to astrologic processes with well understood periods [@laskar2020], including changes to the ellipticity of Earth's orbit (eccentricity; ~0.1 Ma, 0.405 Ma), axial tilt (obliquity ~0.041 Ma), and axial precession (precession; ~0.02 Ma). Together, these changes in Earth's orbit and rotation directly influence the climate which in turn is recorded in the rock record. Since the periods of different astrologic cycles are known, their manifestation in the rock record can be used as a metronome that provides a direct link between the passage of time and the geologic record [see reviews of  @meyers2019; and @hinnov2013]. unlike radioisotopic dating methods, astrochronology can produce near-continuous chronologies from the rock record, a strength that makes it ideal for fine-scale investigation of geochemical or other proxy records. Perhaps the biggest limitation of astrochronology is that, in the absence of independent constraints, astrochronology produces "floating" chronologies that lack absolute age information. Anchoring floating chronologies in time relies on independently determining the age of a subset of stratigraphic positions using radioisotopic geochronology.

Linking radioisotopic dates and and floating astrochronologies into an integrated model of age is an ataractic prospect, as it combines the strengths and overcomes the limitations of both data sources. In this paper we present a new joint Bayesian inversion of astrochronologic and radioisotopic dates (`astroChron`) to develop high-precisions age depth models for stratigraphic sections. This joint inversion has several strengths over existing "dates only" age-depth models including a significant reduction in overall model variability, with uncertainties closely linked to those of the radioisotopic dates. Furthermore these chronologies are internally consistent and are anchored in numerical time while simultaneously preserving astrochronologic durations, making them ideal for correlating proxy records to other global records. First, we tested `astroChron` using synthetic datasets designed to mimic real-world scenarios. We investigated how the number and stratigraphic position of dates influences overall model precision and uncertainty, and how well our framework can resolve temporal gaps and changes in sedimentation rates. Second we present a case study from the Greenhorn Formation of the Western Interior basin where we refine the age of the Cenomanian–Turonian boundary.   

# Background

## Astrochronology

**Steve can write this** 

## Radioisotope Geochronology

**Mark can write this**

## Bayesian Age-Depth Modeling

Bayesian statistics aims to determine the most probable values of unknown parameters given data and prior information about those parameters. This is formalized in Bayes equation: 

$$P(parameters | data) \propto P(data | parameters) \times P(parameters)$$ {#eq:bayes} 

The first term on the righthand side of @eq:bayes, known as the likelihood, is the conditional probability of the data, given a set of parameters, and the second term represents any prior beliefs about these parameters. The lefthand side of @eq:bayes is the posterior probability of the parameters. In other words, how probable are the proposed parameters given a data set and our prior knowledge. Bayes equation is often difficult or impossible to solve analytically, and instead the posterior distribution is simulated using Markov Chain Monte Carlo methods (MCMC) to generate a random representative sample. Given a large enough samples size and adequate exploration of parameter space, this sample should have the same properties (mean, median, dispersion, etc.) as the true posterior distribution [@gelman1996]. 

Developing chronologies for rock records rely on models (age-depth models) that relate stratigraphic position to age. This is usually accomplished by fitting a curve to several dated horizons throughout a stratigraphic section which is then used to estimate the age and uncertainty at undated points [@blaauw2012]. A variety of Bayesian approaches have been proposed to fit age-depth models including `Bchron` [@haslett2008] `bacon` [@blaauw2011]`OxCal` [@bronkramsey2008], and `chron.jl` [@schoene2019]. While these methods vary considerably in their mathematical framework, most they share two fundamental characteristics. First, they treat sediment accumulation as a stochastic process where accumulation rate is allowed to vary randomly and considerably throughout a stratigraphic section. Second, they rely on discrete point-estimates of absolute age, usually in the form of radioisotopic dates (e.g., ^40^Ar/^39^Ar, U-Pb, ^14^C), as the for chronology construction. This leads to chronologies with widely variable uncertainties [@trachsel2017; @telford2004; @devleeschouwer2014] that are largely a function of data density. That is, model errors are lower in areas where there are more age determinations and higher in areas with less data, leading to "sausage" shaped uncertainties [@devleeschouwer2014]. Incorporating more chronologic information is the best way to improve model accuracy and reduce uncertainty [@blaauw2018], however, this is not always possible. While some records are amenable to almost continuous radioisotopic dating (e.g., ^14^C analysis of peat cores), dating most deep-time stratigraphic sections relies on the presence of volcanic ashes, which usually occur in only a few horizons. Since the density of radioisotopic ages is unlikely to change in most deep-time cases, incorporating other forms of chronologic information is crucial to improving age-depth models.

Previous integrations of astrochronology and radioisotopic geochronology have focused on either anchoring floating astrochronologies to radioisotopic dates or incorporating astrochronologically derived duration into model construction. @meyers2012 calibrated the age of the Cenomanian-Turonian boundary using a "stacked bed" algorithm [@buck1991] that respects both superposition and astrochronologic durations between the dates and the boundary position.

@devleeschouwer2014 recalibrated the Devonian time scale and calculated new stage boundaries using a two step process. First the authors generated a bayesian age-depth model using the  `bchron` `R` package [@haslett2008] and the performed a post-hoc rejection of model iterations that violated previously derived astrochronologic stage durations. While these results are consistent with both data types the inclusion of astrochronology was not explicitly Bayesian. @harrigan2021 further refined the Devonian by using a modified version of `bchron`. In this case the authors used a Monte Carlo approach to convert astrochronology derived durations into stage boundary ages which were then included as inputs for Bayesian modeling using `Bchron`. 

Each of these methods requires some external processing and interpretation of astrochronologic data, either to derive durations or to transform it into a from (i.e. age±uncertainty) that is amenable to inclusion into existing models.  


# Methods

## Model Construction

![Schematic of model parameters.](./figures/workflow.pdf){#fig:workflow width=100%}

Our data consists of measurements of an astrochronologic record (*data*) (e.g., δ^18^O, XRF scans, core resistivity, etc), and a set of radioisotopic dates (*dates*) that share a common stratigraphic scale. Developing an age depth model from these records requires 1) a likelihood function that reflects the probability of both data types, 2) a common set of parameters to calculate the probability of, and 3) in the case of age-depth modeling, a model that reflects our best understanding of sediment accumulation. We focus on estimating the probability of sedimentation rate as the basis for our age-depth model. Since sedimentation rate is expressed as depth-per-time (e.g., m/Ma, cm/ky) it directly links stratigraphic position to relative age to create floating age models, and when combined with radioscopic dates, models anchored in numerical time. 

Existing Bayesian age depth models (discussed above) model sedimentation as a relatively large number of piecewise linear segments. Sedimentation rate can vary substantially between segments, leading to the "sausage-shaped" uncertainty envelopes that characterize these models [@trachsel2017; @devleeschouwer2014; @parnell2011]. However, this mode of sedimentation is not ideal for the construction of astrochronologies, as fluctuations in sedimentation rate can be mapped to astrochronologic cycles even if they are unrelated. Instead a sedimentation model for astrologic tuning should minimize fine-scale fluctuations in sedimentation rate [@muller2002; @malinverno2010]. We therefore adopt a relatively simple sedimentation model with a few layers of consistent sedimentation rate. 

@malinverno2010 presented a simple sedimentation model appropriate for orbital tuning of sedimentary records and we use their framework as the basis for our joint inversion. The sedimentation model consists of two sets of parameters. The first is a vector of sedimentation rates (*r*), and stratigraphic boundary positions (*z*) that define regions of constant sedimentation (@fig:workflow A). For example, the model shown in @fig:workflow A has 11 parameters, five sedimentation rates (r~1~ to r~i~) and six layer boundaries (z~1~ to z~i~). This model formulation allows step changes in sedimentation rate at layer boundaries (*z*) but otherwise hold sedimentation rate (*r*) within each layer. 

Together *r* and *z* can also be transformed to create an age-depth model consisting of piecewise linear segments that form a floating age-depth model (@fig:workflow B). This floating model can be linked to absolute time by adding a constant age (*a*) to the floating model at every stratigraphic position.   This age (*a*) acts as an anchor to link the floating age model to absolute time. Optionally, sedimentary hiatuses can also be included in the model in a similar manner by adding the duration of the hiatus (*h*) to the all the points of the anchored blade below the stratigraphic position of the hiatus.


| parameter |                          explanation                             |
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

![Testing data set 1 (TD1). A) The synthetic eccentricity-tilt-precession time series. B) The sedimentation model used as an Earth System transfer function to modify the time series in panel A. C) Evolutive harmonic analysis of panel A. Lighter colors are higher spectral power. Note the variations in the high-power central frequency between about 2 - 4 cycles/meter as a result of sedimentation rate shifts shown in panel B.](./figures/TD1.pdf){#fig:TD1 width=100%}

![Cyclostratigraphy Intercomparison Project Case 2 data (CIP2). A) The synthetic eccentricity-tilt-precession time series. B) The sedimentation model used as an Earth System transfer function to modify the time series in panel A. Note the ~0.2 Ma hiatus. C) Evolutive harmonic analysis of panel A. Note the smearing of the high spectral power frequencies at about 5.5 meters as a result of the hiatus in panel B.](./figures/CIP2.pdf){#fig:CIP2 width=100%}

We tested our model using two synthetic data sets that consist of a true age-depth model and a cyclostratigraphic record. The first (TD1) consists of a simple sedimentation model that was used as an earth system transfer function to  distort an eccentricity-tilt-precession time series to generate a synthetic cyclostratigraphic record (@fig:TD1). **Steve can fill in details here** The second (CIP2), was originally generated by @sinnesael2019 as a testing exercise for the Cyclostratigraphy Intercomparison Project which assessed the robustness of different cyclostratigraphic methods. CIP2 was designed to mimic a Pleistocene proxy record with multiple complications including nonlinear cyclical patterns and a substantial hiatus. For full details on the construction of CIP2 see @sinnesael2019 and at [cyclostratigraphy.org](https://www.cyclostratigraphy.org/the-cip-initiative). For each of our testing schemes, outlined below, we used the true age-depth model to generate synthetic radioisotopic dates from varying stratigraphic positions. When paired with the cyclostratigraphic data these dates form our model inputs. 

We calculated assessed model performance using two metrics. First, we assessed model accuracy and precision by calculating the proportion of the true age-depth model that fell within the 95% credible interval (95% CI) of our model posterior. We assume that a well performing model should contain the true age model in most cases. This method that has been used previously to assess performance of existing Bayesian age-depth models [@parnell2011; @haslett2008]. Second we monitored the variability of the model median (50%) and lower and upper bounds (2.5% and 97.5%) of the credible interval.

### Reproducibility and Stability

We assessed model reproducibility and stability by generating 1,000 individual age-depth models for each testing data set using the the same input data (cyclostratigraphy, radioisotopic dates, astrologic frequencies). Each simulation ran for 10,000 MCMC iterations with the initial 1,000 steps discarded to allow for model convergence and sufficient exploration of parameter space. 

### Sensitivity to Date Positions

We tested the sensitivity of our model to both the number and stratigraphic position of radioisotopic dates. For each of our testing data sets, we randomly generated a set of dates from the underlying sedimentation model using Monte Carlo methods which were then used as model inputs along with the synthetic astrochronologic records. We repeated this procedure 1,000 times using 2, 4, 6, or 8 dates for a total of 4,000 test models per testing data set (i.e. CIP2 and TD1). 

Since the CIP2 data set includes a significant hiatus [@sinnesael2019] we investigated the influence of the number and stratigraphic position of radioisotopic dates on the quantification of the hiatus duration. Currently, estimation of hiatus duration requires at least one date above and below the stratigraphic position of a hiatus. Consequently, we added an additional constraint for the the CIP-2 dataset to ensure the the hiatus was always bracketed by dates. For each of the sensitivity validation models (2, 4, 6, and 8 dates) we calculated the stratigraphic distance between the hiatus and the nearest date. 

# Results

## Model Validation

Reproducibility tests indicated that our model converges quickly and its parameter estimates remain stable. Individual trace plots for for each parameter (sedimentation rates, anchor age, hiatus duration) for the TD1 and CIP2 data sets stabilized quickly and appeared visually well mixed indicating adequate exploration of parameter space (**see supplements figures XYZ**). Similarly, kernel density estimates of each parameter were indistinguishable among the 1,000 simulations. The model median and 95% credible interval were likewise stable, and varied only slightly (± 0.XXX Ma; 2 sd). 

The model does not appear to be particularly sensitive to the number or stratigraphic position of radioisotopic dates for both testing data sets. In nearly all cases the true age model fell within the models 95% credible interval (@tbl:contained}. For the CIP2 data set, other than the requirement that there is at least one date above and below the hiatus, the stratigraphic position of the dates does not appear to have a strong influence on hiatus quantification as in all cases the model posterior of hiatus duration contained the true duration of 0.203 Ma. with 95% CI of the duration parameter containing the true hiatus duration (0.203 Ma) in all cases (@fig:hiatus_duration). 

| data set | number of dates | fraction contained |
|:--------:|:---------------:|:------------------:|
|   TD-1   |         2       |         wxyz       |
|          |         4       |         wxyz       |
|          |         6       |         wxyz       |
|          |         8       |         wxyz       |
|  CIP-2   |         2       |         wxyz       |
|          |         4       |         wxyz       |
|          |         6       |         wxyz       |
|          |         8       |         wxyz       |

Table: Proportion of the synthetic sedimentation model contained within the 95% credible interval of the model posterior with an increasing number of dates. The dates were drawn directly from the sedimentation model with no outlier ages. {#tbl:contained}

# Discussion

### Hiatus Duration Estimation

![Hiatus duration versus the stratigraphic distance between the hiatus and the nearest radioisotope date for the CIP2 data set. The points are the model median and the error bars are the 95% credible interval. The red line is the true hiatus duration of 0.203 Ma. A-D) Models with 2, 4, 6, and 8 ages respectively.](./figures/hiatus_duration.pdf){#fig:hiatus_duration width=50%}

The ability to estimate hiatus durations is a significant strength of our modeling framework. Hiatuses in stratigraphic records significantly complicate the interpretation of biologic and geochemical proxy records. Detecting and resolving the duration of hiatuses is therefore important to ensuring the accuracy of age-depth models. In principle, hiatuses can be detected and quantified from cyclostratigraphic records alone [@meyers2004; @meyers2019]. However, these approaches can be skewed towards minimum hiatus duration and are sensitive to distortions of the astrologic signal from other non-hiatus sources @meyers2004]. Our approach relies on both astrochronology and radioisotopic geochronology to estimate the duration of one or more hiatuses with astrochronology controlling the sedimentation rate (slope) and radioisotopic geochronology controlling the absolute duration (intercept(s)). This approach requires that at least two dates bracket a given hiatus. 

## Sedimentation models and constraining uncertainty 

A potential criticism of our approach is that our choice of a simple sedimentation model artificially influences overall model uncertainties. Since we do not allow sedimentation rate to vary randomly throughout stratigraphy our models lack the "sausage-like" credible intervals that characterize other Bayesian age depth models (i.e, `bchron`, `bacon`). Indeed,  @haslett2008 consider a minimal assumptions of smoothness as a fundamental feature of age-depth modeling as there is "*is no reason a priori to exclude either almost flat or very steep sections*".  While @blaauw2011 considers some smoothness, as expressed by the rate-of-change of sedimentation rate, as a desirable feature, both modeling approaches allow sedimentation rate to vary randomly in the absence of other constraints. 

Astrochronology provides a clear, strong constraint on both absolute and spatial variations in sedimentation rate. Orbital tuning should not involve frequent changes in sedimentation rate as these can cause fluctuations unrelated to orbital frequencies [@muller2002; @malinverno2010]. In principle our underlying probability calculations could be applied to any sedimentation model, however...

\newpage

# References {.unnumbered}
:::{#refs}
:::