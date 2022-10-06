---
title: "Bayesian Integration of Astrochronology and Radioisotope Geochronology"
author:
  - Robin B. Trayler
  - Stephen R. Meyers
  - Mark D. Schmitz
bibliography: /Users/robintrayler/Zotero/ref_library.bib
csl: /Users/robintrayler/Zotero/styles/earth-and-planetary-science-letters.csl
mainfont: "Helvetica"
fontsize: 12pt
geometry: margin=1.0in
tblPrefix: Table
figPrefix: Figure
secPrefix: Section
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

 While proxy records recovered from stratigraphic sections often reflect underlying climatic, environmental, and geologic processes, they do not necessarily record absolute time. Instead changes in accumulation rate, diagenesis, subsidence, hiatuses, and other stochastic processes degrade the record [@meyers2018; @miall2004]. Developing accurate and precise models that relate stratigraphic position to absolute age (i.e., age-depth models) is an important step when interpreting these proxy records [@blaauw2012; @parnell2011]. However, developing these chronologies is difficult for multiple reasons. First, most rocks cannot be accurately dated by the most precise geologic clocks (e.g., ^40^Ar/^39^Ar, U-Pb). Instead, only a subset of rocks (usually volcanic ashes) are suitable for high precision geochronology, which leads to a series of point-estimates of age throughout a stratigraphic section. 

linking stratigraphy to time is a crucial step to understanding

While the geologic record is the best and often only documentation of past environmental change [@zachos2001], climatic and tectonic forces "distort" the rock record, with systematic and stochastic changes (or hiatuses) in accumulation which paradoxically lead to difficulty quantifying the forces at play [@meyers2018; @miall2004].  However, developing these chronologies is difficult for multiple reasons. First, many rocks cannot be accurately dated by the most precise geologic clocks (e.g., ^40^Ar/^39^Ar, U-Pb dating). Instead, high precision geochronology is usually only suitable at a subset of points in a stratigraphic section leading to point estimates of age. 

There has been  

# Background
## Classical age-depth modeling
## Bayesian age-depth modeling
* random walk models
* Malinverno "floating" bayesian model 


# Astronomic Tuning of Sedimentary Records 

Using the the geologic record of astronomical cycles to develop chronologies is complicated by the distortion of the signal by various geological and climatological processes (Earth system transfer functions; @meyers2018). Long term shifts and random variations in sedimentation degrade the original astronomic signal and can also introduce non-astronomic cyclicity into sedimentary records. accurately modeling and removing this distortion from these records is of considerable value because the precision of the resulting astronomical-tuned chronologies is often a significant improvement over un-tuned stratigraphic records. 

Astrochronologic tuning of sedimentary records is usually accomplished by applying a sedimentation rate model that, when stratigraphic position is converted to time, maximizes the amplitude of the signal in orbital frequencies (e.g., eccentricity, obliquity, precession)


Removing this distortion from records is of considerable value, because the precision of the resulting chronologies can be greatly improved relative to un-tuned stratigraphic records. 

the subdiscipline of cyclostratigraphy that uses the geologic record of astronomical cycles (or Milankovitch cycles) to develop geological timescales. Also, an “astronomical time scale” or “orbital time scale” constructed using this approach.

Orbital tuning of cyclostratigraphic records attempts to reverse the 


Tuning stratigraphic records to orbital cycles us usually accomplished by applying a sedimentation rate model



$$P(parameters~|data) = \frac{P(data~|parameters)}{P(data)} \times P(parameters)$$

In our case, the data takes two forms. First, our cyclostratigraphic proxy record, which consists measurements $[d_1, d_2, ... d_i]$ where $i$ is the stratigraphic position of each measurement. We assume that cyclic signals in $d$ is derived from orbital forcing and the record can therefore be tuned. 


# Model Validation 

# Results

# Discussion
\newpage

# References {.unnumbered}
:::{#refs}
:::

