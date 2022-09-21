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

While the geologic record is the best and often only documentation of past environmental change [@zachos2001], climatic and tectonic forces "distort" the rock record, with systematic and stochastic changes (or hiatuses) in accumulation which paradoxically lead to difficulty quantifying the forces at play [@meyers2018; @miall2004]. Developing accurate and precise models that relate stratigraphic position to absolute age (e.g., age-depth models) is an important step when interpreting the rate and tempo of geologic and climatological processes [@blaauw2012; @parnell2011]. However, developing these chronologies is difficult for multiple reasons. First, many rocks cannot be accurately dated by the most precise geologic clocks (e.g., ^40^Ar/^39^Ar, U-Pb dating). Instead, high precision geochronology is usually only suitable at a subset of points in a stratigraphic section leading to point estimates of age. 

There has been  




# Background
## Classical age-depth modeling
## Bayesian age-depth modeling
* random walk models
* Malinverno "floating" bayesian model 


# Statistical Methods 

$$P(parameters~|data) = \frac{P(data~|parameters)}{P(data)} \times P(parameters)$$



In our case, the data takes two forms. First, our cyclostratigraphic proxy record, which consists measurements $[d_1, d_2, ... d_i]$ where $i$ is the stratigraphic position of each measurement. We assume that cyclic signals in $d$ is derived from orbital forcing and the record can therefore be tuned. 

\newpage

# References {.unnumbered}
:::{#refs}
:::

