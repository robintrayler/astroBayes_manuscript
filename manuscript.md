---
title: "Bayesian Integration of Astrochronology and Radioisotope Geochronology"
author:
  - Robin B. Trayler
  - Stephen R. Meyers
  - Mark D. Schmitz
bibliography: /Users/robintrayler/Zotero/ref_library.bib
csl: /Users/robintrayler/Zotero/styles/copernicus-publications.csl
mainfont: "Helvetica"
fontsize: 11pt
geometry: margin=1.0in
tblPrefix: Table
figPrefix: Figure
secPrefix: Section
autoEqnLabels: true
link-citations: false
indent: true
header-includes:
    - \usepackage{lineno}
    - \linenumbers
    - \usepackage{setspace}
    - \doublespacing
---

<!-- pandoc -s -o manuscript.pdf --pdf-engine=xelatex --filter pandoc-crossref --citeproc --number-sections manuscript.md --> 

<!-- pandoc -s -o manuscript.docx --pdf-engine=xelatex --filter pandoc-crossref --citeproc --reference-doc=reference.docx manuscript.md --> 

* 1Department of Life and Environmental Sciences, University of California, Merced, CA
* 2Department of Geosciences, Boise State University, Boise ID
* 3Department of Geosciences, University of Wisconsin, Madison, WI
* \*Corresponding author: rtrayler@ucmerced.edu



# Introduction

Linking the rock record to numerical time is crucial step when investigating the timing, rate, and duration of geologic, climatological and biotic processes, but constructing chronologies (age-depth modeling) from the rock record is complicated by a variety of factors. The premier radioisotopic geochronometers, the Argon-Argon (^40^Ar/^39^Ar) and Uranium Lead (U-Pb) methods enable direct determination of age from single mineral crystals (e.g., sanadine, zircon) to better that 0.1% [@schmitz2013]. However, rocks amenable to radioisotopic dating, mostly volcanic ashes, usually only occur in a few randomly distributed horizons within a stratigraphic section. This leads to the problem of a small number of high-precision dates scatter throughout stratigraphy with limited chronologic information between these horizons. Consequently, chronologies developed using only radioisotopic dates have widely varying uncertainties, with precise ages near the position of the dates and much lager uncertainties in stratigraphically  distant areas [@blaauw2011; @parnell2011; @trachsel2017; @trayler2020a]. 

Adding more chronologic information is the best way to improve age-depth model construction [@blaauw2018]. In particular, including stratigraphically-continuous data can significantly reduce model uncertainties. Astrochronology uses the geologic record of oscillations in earth climate ("Milankovitch cycles") to interpret the passage of time [@hinnov2013; @laskar2020]. Some of these oscillations can be linked to astrologic processes with well understood periods, including changes to the ellipticity Earth's orbit (eccentricity; ~0.1 Ma, 0.405 Ma), axial tilt (obliquity ~0.041 Ma), and axial precession (precession; ~0.02 Ma) [@laskar2020]. The manifestation of these astrologic frequencies in the rock record can be used as a metronome that provides a direct link between the rock record and relative age [see reviews of  @meyers2019; and @hinnov2013]. Unlike radioisotopic dating methods, astrochronology produces near-continuous chronologies from stratigraphic records, sometimes at sub-centimeter resolution, a strength that make it an ideal tool for fine-scale investigations of geologic proxy records. Perhaps the biggest limitation of astrochronology is that, in the absence of independent constraints, it produces "floating" chronologies that lack numerical time information.

Combining radioisotopic dates and floating astrochronolgic records into an integrated model of age is an attractive prospect as it combines the strengths and overcomes the limitations of both data sources. here we present a new freely available `R` package (`astroBayes`; *Bayesian Astrochronology*) for joint Bayesian inversion of astrochronologic records and radioisotopic dates to develop high-precision age-depth models for stratigraphic sections. We used `astroBayes` to investigate the sensitivity of age-depth model construction to a variety of geologic scenarios, including varying the number and stratigraphic position of radioisotopic dates and the presence or absence of sedimentary hiatuses. This method has several strengths over existing "dates only" age-depth models. The inclusion of astrochronological data allows simpler sedimentation models which results in an overall reduction in model uncertainty. Furthermore, these age-depth models are simultaneously anchored in numerical time while simultaneously preserving astrochronologic durations, making them ideal for correlating proxy records to other global records. Finally, we present a case study from the Bridge Creek Limestone of the Western Interior Basin, where we refine the age of the Cenomanian–Turonian boundary. 

# Background

## Astrochronology

**Steve can write this** 

## Radioisotope Geochronology

**Mark can write this**

## Bayesian Statistics

Bayesian statistics aims to determine the most probable value of unknown parameters given *data* and *prior* information about those parameters. This is formalized in Bayes equation: 

$$P(parameters | data) \propto P(data | parameters) \times P(parameters)$$ {#eq:bayes} 

The first term on the righthand side of @eq:bayes, known as the likelihood, is the conditional probability of the data, given a set of parameters. The second term represents any prior beliefs about these parameters. The left hand side is the posterior probability of the parameters. Bayes equation is often difficult or impossible to solve analytically, and instead the posterior distribution is simulated using Markov Chain Monte Carlo methods (MCMC) to generate a representative sample, which assuming a properly tuned MCMC process [@haario2001], should have the same properties (mean, median, dispersion, etc.) as the theoretical posterior distribution [@gelman1996].   

## Bayesian Age-Depth Modeling

Existing Bayesian methods for age-depth model construction rely on sedimentation models that link stratigraphic position to age. This is usually accomplished by fitting a curve to several dated horizons throughout a stratigraphic section which is then used to estimate the age and uncertainty at undated points [@blaauw2012]. A variety of Bayesian approaches have been proposed to fit age-depth models including `Bchron` [@haslett2008] `rbacon` [@blaauw2011], and `Chron.jl` [@schoene2019; @keller2018b]. While these methods vary considerably in their mathematical framework, most they share two fundamental characteristics. First, they treat sediment accumulation as a stochastic process where accumulation rate is allowed to vary randomly and considerably throughout a stratigraphic section. Second, they rely on discrete point-estimates of absolute age, usually in the form of radioisotopic dates (e.g., ^40^Ar/^39^Ar, U-Pb, ^14^C), as the only basis for chronology construction. This leads to "dates-only" chronologies with widely variable uncertainties [@trachsel2017; @telford2004; @devleeschouwer2014] that are largely a function of data density. That is, model errors are lower in areas where there are more age determinations and higher in areas with less data, leading to "sausage" shaped uncertainties [@devleeschouwer2014].

Previous attempts to link astrochronology and radioisotopic dates have relied either on post-hoc comparisons or by "transforming" one data type  into another. @devleeschouwer2014 recalibrated the Devonian time scale and calculated new stage boundaries using a two step process. First the authors generated a bayesian age-depth model using the  `Bchron` `R` package [@haslett2008] and the performed a post-hoc rejection of model iterations that violated previously derived astrochronologic stage durations. While these results are consistent with both data types the inclusion of astrochronology did not directly influence age-model construction. @harrigan2021 further refined the Devonian timescale by using a modified version of `Bchron` [@trayler2020a]. The authors used a Monte Carlo approach to convert astrochronology derived durations into stage boundary ages which were then included as inputs along-side radioisotopic dates for Bayesian modeling. Each of these methods requires external processing and interpretation of astrochronologic data, either to derive durations or to transform it into a from (i.e. age±uncertainty) that is amenable to inclusion into existing models.  

## Case Study: Bridge Creek Limestone

**This is mostly placeholder text. Steve please expand the this section as you see fit** 

The Bridge Creek Limestone is the uppermost member of the Greenhorn Formation of central Colorado. It is primarily composed of hemipelagic marlstones and limestone couplets that extend laterally for over 1,000 km in the Western Interior Basin [@elder1994]. These couplets are characterized by alternations from darker organic carbon rich laminated clay and mudstones to lighter carbonate rich, organic poor limestone facies. Previous work has reported Milankovich scale cyclicity in the Bridge Creek Limestone  and ^40^Ar/^39^Ar ages from several bentonites throughout the section [@sageman1998; @meyers2001; @meyers2012]. @meyers2012 previously calibrated the age of the Cenomanian-Turonian boundary as 93.90±0.15Ma (mean±95%CI) using a Bayesian "stacked bed" algorithm [@buck1991] that respects both superposition and astrochronologic durations between the dates and the boundary position.  

# Methods

## Model Construction

![Schematic of model parameters.](./figures/final figures/workflow.pdf){#fig:workflow width=100%}

The data consists of measurements of an cycostratigraphy record (*data*) (e.g., δ^18^O, XRF scans, core resistivity, etc), and a set of radioisotopic dates (*dates*) that share a common stratigraphic scale. Developing an age-depth model from these records requires 1) a likelihood function that reflects the probability of both data types, 2) a common set of parameters to calculate the probability of, and 3) in the case of age-depth modeling, a model that reflects the best aproximation of sediment accumulation. We focus on estimating the probability of sedimentation rate as the basis for the `astroBayes` age-depth model. Since sedimentation rate is expressed as depth-per-time (e.g., m/Ma, cm/ky) it directly links stratigraphic position to relative age to create floating age models, and when combined with radioscopic dates, models anchored in numerical time. 

Existing Bayesian age depth models model sedimentation as a relatively large number of piecewise linear segments. Sedimentation rate can vary substantially between segments, leading to the "sausage-shaped" uncertainty envelopes that characterize these models [@trachsel2017; @devleeschouwer2014; @parnell2011]. However, this mode of sedimentation is not ideal for the construction of astrochronologies, as fluctuations in sedimentation rate can be mapped to astrochronologic cycles even if they are unrelated. Instead a sedimentation model for astrologic tuning should minimize fine-scale fluctuations in sedimentation rate [@muller2002; @malinverno2010]. We therefore adopt a relatively simple sedimentation model with a few layers of consistent sedimentation rate. 

@malinverno2010 presented a simple sedimentation model appropriate for orbital tuning of sedimentary records and we use their framework as the basis for the joint inversion. The sedimentation model consists of two sets of parameters. The first is a vector of sedimentation rates (*r*), and stratigraphic boundary positions (*z*) that define regions of constant sedimentation (@fig:workflow A). For example, the model shown in @fig:workflow A has 11 parameters, five sedimentation rates (*r~1~* -- *r~i~*) and six layer boundaries (*z~1~* -- *z~i~*). This model formulation allows step changes in sedimentation rate at layer boundaries (*z*) but otherwise hold sedimentation rate (*r*) within each layer. 

Choosing layer boundary positions is informed by detailed investigation of the cycostratigraphy data. Evolutive harmonic analysis is a time-frequency method that can identify changes in accumulation rate by tracking the apparent frequency of astrologic frequencies. Expressed as cycles/depth, high spectral-power regions may "drift" towards higher or lower frequencies throughout stratigraphy. Assuming these frequencies reflect relatively stable astrological processes, the most likely explanation of those shifts is therefore spatial changes in sedimentation rate [@meyers2001]. We visually inspected EHA plots to develop a simple sedimentation models (e.g., @fig:workflow B) for our testing data sets. We chose layer boundary positions (z~1~ -- z~i~) by identifying regions with visually stable frequencies (see @fig:testing_data). We allow these boundary positions to vary randomly (within a specified range) to account for the uncertainties in boundary position, similar to the approach of @malinverno2010.

Together *r* and *z* can also be transformed to create an age-depth model consisting of piecewise linear segments that form a floating age-depth model (@fig:workflow B). This floating model can be linked to absolute time by adding a constant age (*a*) to the floating model at every stratigraphic position.   This age (*a*) acts as an anchor to link the floating age model to absolute time. Optionally, sedimentary hiatuses can also be included in the model in a similar manner by adding the duration of the hiatus (*h*) to the all the points of the anchored blade below the stratigraphic position of the hiatus.

| parameter |                       explanation                        |
|:---------:|:---------------------------------------------------------|
|    *r*    | sedimentation rate (m/Ma)                                |
|    *z*    | layer boundary positions (stratigraphic positions)       |
|    *a*    | anchoring age (Ma)                                       |
|    *D*    | depth (stratigraphic positions; transformation of *z*)   |
|    *T*    | age (Ma; transformation of *r* and *z*)                  |
|    *f*    | orbital tuning frequencies (cycles/Ma)                   |
|  *data*   | astrochronologic data (value vs stratigraphic position)  |
|  *dates*  | radioisotopic dates (Ma)                                 |

Table: explanation of model parameters. {#tbl:parameters}

## Probability Calculations

Together the vectors of sedimentation rates (*r*) and layer boundaries (*z*) and anchoring age (*a*) can be used to to calculate an anchored *age-depth model* which consists of a series of piecewise linear segments (@fig:workflow B). The slope (m/Ma) and length of these segments is controlled the sedimentation rates (*r*) and layer boundary positions (*z*), while the absolute age is controlled by the anchoring constant (*a*). The anchored age-depth model now consists of a vector of stratigraphic positions (*D*) and a corresponding vector of ages (*T*) that relate stratigraphic position to absolute age. The probability of this age-depth model can be assessed by calculating the probability of the segmentation rates (*r*) and anchoring constant (*a*) given an astrochronologic record (*data*) and a series of radioisotopic dates (*dates*). 

### Probability of a Astrologic Frequencies

We followed the approach of @malinverno2010 to calculate the probability of our data given a sedimentation rate and set of orbital frequencies (*f*).  

$$P(data |r, f) \propto exp[\frac{C_{data}(f)}{C_{background}(f)}]$$ {#eq:malinverno}

Where the data is the astrochronologic record, *r* is a sedimentation rate, and *f* is an orbital frequency (e.g., @tbl:frequencies), *C~data~* is the periodogram of the data, and *C~background~* is the red noise background. The probability in @eq:malinverno is calculated independently for each model layer (i.e., between adjacent *z*'s), and the overall probability is therefore the joint probability of all individual layers. @eq:malinverno calculates the concentration of spectral power on orbital frequencies, where a given sedimentation rate is more probable if it causes peaks in spectral power that rise above the red noise background to "line up" with orbital frequencies.

| Period (Ma)| Frequency (1/Ma) |    Cycle      |
|:----------:|:----------------:|:-------------:|
| 0.4056795  |        2.465000  | eccentricity  |
| 0.1307190  |        7.649997  | eccentricity  |
| 0.1238390  |        8.075001  | eccentricity  |
| 0.0988631  |       10.115001  | eccentricity  |
| 0.0948767  |       10.540000  | eccentricity  |
| 0.0409668  |       24.410000  | obliquity     |
| 0.0236207  |       42.335766  | precession    |
| 0.0223187  |       44.805517  | precession    |
| 0.0189934  |       52.649737  | precession    |
| 0.0190677  |       52.444765  | precession    |

Table: Astrologic frequencies used for model testing and validation. {#tbl:frequencies}

### Probability of Radioisotopic Dates

The now anchored age-depth model consists of two paired vectors which that relate stratigraphic position (*D*) to absolute time (*T*). The stratigraphic positions of the dates {*d~1~* ... *d~j~*} and their corresponding ages [*t~1~* ... *t~j~*] are a subset of *D* and *T*, respectively. We therefore define the probability of the modeled age (*T*) at a depth (*D*), given a set of dates as: 

$$P(T | dates) = \prod_{j = 1}^{n} N(\mu_j, \sigma^{2}_{j})$$ {#eq:radio_prob}

Where *μ~j~* is the weighted mean age and *σ^2^~j~* is the variance of the j^th^ radioisotopic date at stratigraphic position *d~j~*. Notice that while *d* and *t* are continuous over the entire stratigraphic section, only the stratigraphic positions that contain radioisotopic dates influence the probability of the age model. In effect, this probability calculation reflects how well the age model "overlaps" the radioisotope dates, where modeled ages that are closer to the radioisotopic dates are more probable @fig:workflow B [@schoene2019; @keller2018b]. 

### Overall Probability and Implementation

The overall likelihood function of an anchored age-depth model is the joint probability of @eq:malinverno and @eq:radio_prob. We use a vague uniform prior where sedimentation rate may take any value between a specified minimum and maximum value. `astroBayes` estimated the most probable values of sedimentation rate, anchoring age, and hiatus duration(s) using a Metropolis-Hasting algorithm and an adaptive Markov Chain Monte Carlo (MCMC) sampler to generate a representative posterior sample for each parameter [@haario2001]. The complete model is avalible as an `R` package called `astroBayes` (*Bayesian astrochronology*) at [github.com/robintrayler/astroBayes](https://github.com/robintrayler/astroBayes).

## Testing and Validation

![Testing data sets used for model validation. A, D) The synthetic cyclostratigraphy records for TD1 and CIP2. B, E) True age-depth models for both data sets. C, F) Evolutive harmonic analysis of panels A and D. Lighter colors indicate higher spectral power. The dashed lines are layer boundary positions (*z*) chosen by visual inspection of the evolutive harmonic analysis results.](./figures/final figures/testing_data.pdf){#fig:testing_data width=100%}

We tested our model using two synthetic data sets that consist of a true age-depth model and a cyclostratigraphic record. The first (TD1) consists of a simple sedimentation model that was used as an earth system transfer function to  distort an eccentricity-tilt-precession time series to generate a synthetic cyclostratigraphic record (@fig:testing_data). **Steve please fill in details here on the construction of this data set**. The second (CIP2), was originally published by @sinnesael2019 as a testing exercise for the Cyclostratigraphy Intercomparison Project which assessed the robustness and reproducibility of different cyclostratigraphic methods. The CIP2 dataset was designed to mimic a Pleistocene proxy record with multiple complications including nonlinear cyclical patterns and a substantial hiatus. For full details on the construction of CIP2 see @sinnesael2019 and at [cyclostratigraphy.org](https://www.cyclostratigraphy.org/the-cip-initiative). For each of our testing schemes, outlined below, we used the true age-depth model to generate synthetic radioisotopic dates from varying stratigraphic positions. When paired with the cyclostratigraphic data these dates form our model inputs. 

We assessed model performance using two metrics. First, we assessed model accuracy and precision by calculating the proportion of the true age-depth model that fell within the 95% credible interval (95% CI) of our model posterior. We assume that a well performing model should contain the true age model in most cases. This method that has been used previously to assess performance of existing Bayesian age-depth models [@parnell2011; @haslett2008]. Second we monitored the variability of the model median (50%) and lower and upper bounds (2.5% and 97.5%) of the credible interval.

### Reproducibility and Stability {#sec:stability}

| Data Set | Sample |    Age±1σ (Ma) | Position (m) |
|:--------:|:------:|:--------------:|:------------:|
|   TD1    |    A   |  0.069±0.01    |     0.64     |
|          |    B   |  0.520±0.02    |     5.17     |
|          |    C   |  1.790±0.05    |    17.48     |
|  CIP2    |    E   |  0.062±0.009   |     1.24     |
|          |    F   |  0.820±0.012   |     3.49     |
|          |    G   |  1.290±0.019   |     6.99     |
|          |    H   |  1.460±0.022   |     9.49     |
|  BCL     | bent A |   94.20±0.14   |     1.62     |
|          | bent B |   94.10±0.14   |     3.3      |
|          | bent C |   93.79±0.13   |     5.95     |
|          | bent D |   93.67±0.15   |     6.98     |

Table: Dates used as inputs for reproducibility & stability testing (TD1 and CIP2) and for the Bridge Creek Limestone (BCL) case study. The BCL ^40^Ar/^39^Ar ages were originally reported by @meyers2012 **(Is this correct?)**.  {#tbl:testing_dates}

We generated 1,000 individual age depth models for each testing dataset to assess model reproducibility and stability. We used the same input data for each testing set (cyclostratigraphy (see @fig:testing_data), radioisotopic dates, astrologic frequencies; see: @tbl:testing_dates). Each simulation ran for 10,000 MCMC iterations with the initial 1,000 steps discarded to allow for model convergence and sufficient exploration of parameter space.

### Sensitivity Testing

We tested the sensitivity of our model to both the number and stratigraphic position of radioisotopic dates. For each of our testing data sets, we randomly generated a set of dates from the underlying sedimentation model using Monte Carlo methods which were used as model inputs along with the synthetic astrochronologic records. We repeated this procedure 1,000 times using 2, 4, 6, or 8 dates for a total of 4,000 test models per testing data set (i.e. 4,000 for CIP2 and TD1). Each simulation ran for 10,000 MCMC iterations with the initial 1,000 steps discarded.

Since the CIP2 data set includes a significant hiatus [@sinnesael2019] we investigated the influence of the number and stratigraphic position of radioisotopic dates on the quantification of the hiatus duration. Currently, estimating hiatus duration requires at least one date above and below the stratigraphic position of a hiatus. Consequently, we added an additional constraint when generating synthetic dates from the CIP2 dataset to ensure the the hiatus was always bracketed by dates. For each of the sensitivity validation models (2, 4, 6, and 8 dates) we calculated the stratigraphic distance between the hiatus and the nearest date. 

# Results

## Model Validation

![Example age-depth models of the TD1 and CIP2 data sets with randomly placed dates shown as colored Gaussian distributions. The dates were randomly generated from the true age-depth model (dashed red line). The black line and shaded grey region are the `astroBayes` model median and 95% credible interval. The dark grey solid and dashed lines are `Bchron` models generated using only the dates as model inputs. Panels A - D) 2, 4, 6, and 8 date models for the TD1 data. Panels E - H) 2, 4, 6, and 8 date models for the CIP2 data. Note that the left and right columns have different vertical and horizontal scales.](./figures/final figures/random_models.pdf){#fig:random_models height=75%}

Reproducibility tests indicated that the `astroBayes` model converges quickly and its parameter estimates remain stable across model runs. Individual trace plots for for each parameter (sedimentation rates, anchor age, hiatus duration [CIP2 only]) for the TD1 and CIP2 data sets stabilized quickly and appeared visually well mixed indicating adequate exploration of parameter space (**see supplements figures XYZ that don't exist yet**). Similarly, kernel density estimates of each parameter were indistinguishable among the 1,000 simulations. The model median and 95% credible interval were likewise stable, and varied by no more than ±0.0018 Ma; 2σ) for both testing data sets. 

Model accuracy does not appear to be particularly sensitive to the number or stratigraphic position of dates as the true age-depth model fell within the 95% credible interval of the `astroBayes` posterior 99% of the time with no clear bias towards greater or fewer dates (@fig:random_models). Similarly, for the CIP2 data set, other than the requirement that there is at least one date above and below the hiatus, the stratigraphic position of the dates does not appear to have a strong influence on hiatus quantification and in all cases the true hiatus duration (0.203 Ma) was contained within the 95% CI of the hiatus duration parameter (*h*; @fig:hiatus_duration). 

# Discussion

## Developing Sedimentation Models 

Clearly, our choice of a simple sedimentation model influences age-depth model construction. Since @eq:malinverno is calculated layer-by-layer, a limitation of our model is that each layer must contain enough time and astrochronologic data to resolve the frequencies (*f*) of interest. Both the astrochronologic and radioisotopic dates can inform sedimentation model construction. First, the dates can be used to calculate average sedimentation rates which to a first approximation can inform the duration of sedimentation model layers.

For example, @tbl:testing_dates contains the dates and stratigraphic positions used for inputs for TD1 stability testing (see @sec:stability). A time difference of 1.72 Ma between the uppermost and lowermost dates separated by 16.84 meters implies an average sedimentation rate of ~9.8 m/Ma or alternatively ~0.1 Ma/m. A sedimentation model with a layer thickness of 1 meter would unable to resolve long (~0.405 Ma) and short (~0.1 Ma) eccentricity cycles, and would only weakly resolve obliquity (~0.41 Ma) and precession scale cycles (~0.02 Ma) within each layer. The choice of layer thickness is therefore dependent on both the average sedimentation rate and the dominant astrologic signals present in the data. Records dominated by eccentricity and obliquity scale fluctuations will necessarily require layers thicknesses that capture longer timescales than records dominated by high frequency precession scale variations. 

**Steve some discussion of nyquist frequency, sampling rates, etc could go here too**

## Hiatus Duration Estimation

![Hiatus duration versus the stratigraphic distance between the hiatus and the nearest radioisotope date for the CIP2 data set. The points are the model median and the error bars are the 95% credible interval. The red line is the true hiatus duration of 0.203 Ma. A-D) Models with 2, 4, 6, and 8 ages respectively.](./figures/final figures/hiatus_duration.pdf){#fig:hiatus_duration}

The ability to estimate hiatus durations is a significant strength of our modeling framework. Hiatuses in stratigraphic records significantly complicate the interpretation of biologic and geochemical proxy records. Detecting and resolving the duration of hiatuses is therefore important to ensuring the accuracy of age-depth models. In principle, hiatuses can be detected and quantified from cyclostratigraphic records alone [@meyers2004; @meyers2019]. However, these approaches can be skewed towards minimum hiatus duration and are sensitive to distortions of the astrologic signal from other non-hiatus sources [@meyers2004]. `astroBayes` relies on both astrochronology and radioisotopic geochronology to estimate the duration of one or more hiatuses with astrochronology controlling the sedimentation rate (slope) and radioisotopic geochronology controlling the absolute duration (intercept(s)) of layers bounding hiatuses. Crucially this approach allows the estimation of robust uncertainties of hiatus duration. **This needs a concluding sentence or two** 

## Sedimentation Models and Constraining Uncertainty 

A potential criticism of our approach is that our choice of a simple sedimentation model artificially reduces overall model uncertainties. Since we do not allow sedimentation rate to vary randomly at all points throughout stratigraphy, our model lacks the inflated credible intervals that characterize "dates-only" age-depth models (i.e, `Bchron`, `rbacon`, `Chron.jl`). Indeed, @haslett2008 consider this minimum assumption of smoothness as a fundamental feature of age-depth modeling as there is *"no reason a priori to exclude either almost flat or very steep sections"*. While @blaauw2011 considers some smoothness desirable, both modeling approaches allow sedimentation rate to vary randomly and considerably in the absence of other constraints. However, astrochronology provides a clear, strong constraint on both the absolute and spatial variability in sedimentation rate. Orbital tuning approaches show that frequent changes in sedimentation rate can introduce fluctuations unrelated to astrologic frequencies [@muller2002; @malinverno2010] and spatial investigation of astrologic frequencies often reveal long periods of near constant sedimentation rates [@shen2022; @sinnesael2019; @meyers2001]. Therefore the addition of cyclostratigraphic data to model construction allows for the informed construction of simpler sedimentation models which result in substantially lower uncertainties.

## Case Study: Bridge Creek Limestone

![Results of `astroBayes` modeling of the Bridge Creek Limestone greyscale record showing the modeled age of the Cenomanian Turonian Boundary. A) Bridge Creek Limestone grayscale record. B) age-depth model using ^40^Ar/^39^Ar dates originally reported by @meyers2012. C) Evolutive harmonic analysis of panel A showing layer boundary positions (dashed white lines).](./figures/final figures/ct_boundary.pdf){#fig:ct_boundary}

![A) Periodogram of the Bridge Creek Limestone Greyscale data after applying the median `astroBayes` age-depth model. The solid red line is the AR1 red noise background and the dashed red line is the 95% confidence interval. B) Evolutive harmonic analysis of  Astrologic Bridge Creek Limestone Greyscale data after applying the median `astroBayes` age-depth model. In both panels astrologic frequencies (@tbl:ct_frequencies) used in model construction are shown as vertical dashed lines. Note that in panel B distortion from variations in sedimentation rate (see @fig:ct_boundary C) has been removed.](./figures/final figures/ct_modeled.pdf){#fig:ct_modeled}

| Period (Ma) | Frequency (1/Ma) |     Cycle     |
|:-----------:|:----------------:|:-------------:|
| 0.4056795   |   2.46500        | eccentricity  |
| 0.0948767   |  10.54000        | eccentricity  |
| 0.0988631   |  10.11500        | eccentricity  |
| 0.0504434   |  19.82420        | obliquity     |
| 0.0391000   |  25.57545        | obliquity     |
| 0.0279130   |  35.82561        | obliquity     |
| 0.0224100   |  44.62294        | precession    | 

Table: Astrologic periods used for modeling the Bridge Creek limestone greyscale record and ^40^Ar/^39^Ar dates. {#tbl:ct_frequencies}

**Steve can you add details about how you chose these frequencies?**

We divided the Bridge Creek Limestone (@fig:ct_boundary A) into three layers based on the observed shifts in the high spectral power frequency-track (~1.1 cycles/m) at about 5.5 and 8.5 meters depth (@fig:ct_boundary C). We used four ^40^Ar/^39^Ar dates originally reported by @meyers2012, and a suite of astrologic frequencies (@tbl:ct_frequencies) to construct an `astroBayes` age-depth model of the Bridge Creek Limestone (@fig:ct_boundary B). Evolutive harmonic analysis of the greyscale record after applying the median age depth model, reveals stable, high power, eccentricity (~10 cycles/Ma) and obliquity (~20 cycles/Ma) scale frequencies, suggesting that age-depth modeling has successfully removed distortion of these astrologic frequencies as a result of varying sedimentation rates (@fig:ctfrequencies). 

We used the age-depth model to calculate the age of the Cenomanian-Turonian boundary as 93.90±0.14 Ma (median±95%CI). This age is essentially indistinguishable from the previous age of 93.90±0.15 Ma reported by @meyers2012, suggesting that `astroBayes` produces comparable results. Crucially however, our model provides a continuous record of age for the Bridge Creek Limestone which can be used to interpret the boundary ages and durations of several ammonite biozones present in the section [@meyers2012; @meyers2001] and foster correlations to other calibrated sections.

**Are there other discussion points folks think I should hit here? I could calculate the age of the ammonite biozone boundaries for example.**

# Conclusions

I should put something here

# Acknowledgements {.unnumbered}

We thank Dr. Matthias Sinnesael for providing the Cyclostratigraphy Intercomparison Project data used for model testing. We also thank Dr. Jacob Anderson and Dr. Alberto Malinverno for insightful discussions during the development of this project. This work was supported by NSF-###-###### M.D. Schmitz. 

\newpage

# References {.unnumbered}
:::{#refs}
:::