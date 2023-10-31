---
title: "Response to CC1: 'Comment on gchron-2023-22', Niklas Hohmann, 11 Oct 2023"
author:
  - ^1,2,\*^Robin B. Trayler
  - ^3^Stephen R. Meyers
  - ^4^Bradley B. Sageman
  - ^2^Mark D. Schmitz
bibliography: ./bibtex.bib
csl: ./copernicus-publications.csl
mainfont: "Helvetica"
fontsize: 11pt
geometry: margin=1.0in
#chapters: True
#chaptersDepth: 1
#chapDelim: ""
tblPrefix: Table
figPrefix: Fig.
eqPrefix: Eq.
secPrefix: Section
autoEqnLabels: true
link-citations: false
from: markdown+mark
indent: true
header-includes:
    - \usepackage{lineno}
#  - \linenumbers
    - \usepackage{setspace}
    - \doublespacing
---

<!-- pandoc -s -f markdown+mark -o CC1_response.docx --pdf-engine=xelatex --filter pandoc-crossref --citeproc CC1_response.md --> 

<!-- pandoc -s -f markdown+mark -o CC1_response.pdf --pdf-engine=xelatex --filter pandoc-crossref --citeproc CC1_response.md --> 

> ^1^Department of Life and Environmental Sciences, University of California, Merced, CA
> 
> ^2^Department of Geosciences, Boise State University, Boise ID
> 
> ^3^Department of Geosciences, University of Wisconsin, Madison, WI
>
> ^4^Department of Earth and Planetary Sciences, Northwestern University, Evanston, IL
> 
> ^\*^Corresponding author: rtrayler@ucmerced.edu

* The manuscript presents a Bayesian approach to estimate age-depth models from cyclostratigraphic and radiometric information. The method is implemented in an R package, and applied to synthetic and empirical examples. A highlight of the method is to incorporate information on hiatuses.

* Code availability and documentation are excellent, and meet best practices in research software development. 

> Thank you. 

* I have some comments regarding the package and how it could be improved (see below). Given the already very high level of code quality these comments are minor.

* The authors use a Bayesian approach to estimate age-depth models. This mathematical part would profit from more technical details to document the model and the inner workings of the package. E.g., merging Eqs. 2 & 3 would make the model more explicit and easier to connect it with the provided code. A justification of the choice of priors and the MCMC algorithm as well as a discussion of computation time and convergence of the MCMC method should be added to the text (or in the supplementary material).

> Dr. Blaauw made a similar comment in Referee Comment 1, and we have added some discussion there on the justification of the choice of a uniform prior distribution as well as some guidance on choosing appropriate prior values. 

> As far as the performance of the MCMC algorithm, computational time and convergence can vary quite a bit in our experience depending on many factors, including the number of model layers, the strength (e.g., signal:noise) of the astronomical data, and the precision of the radioisotopic dates. As such it is difficult for us to give any general advice on the appropriate length of MCMC chains since different problems will require different settings as choosing MCMC chain lengths is somewhat of a heuristic process. 
 
## Double use of cyclostratigraphic information

* Cyclostratigraphic information is used twice in the analysis: Once before the Bayesian analysis to visually identify the breakpoints in sedimentation rate, and then in the Bayesian analysis to estimate the sedimentation rate & age depth model. Intuitively it is not obvious how this re-use of data influences the outputs. If the break point are determined based on spatially stable frequencies, how informative can they still be for the Bayesian analysis? E.g. in the extreme case where the visual inspection shows no change in sedimentation rates between two tie points, it is not straightforward to see how much information the approach adds. A brief discussion of the relation between the two steps of analysis and how one influences the other (or why they are independent) would help clarify this.

> The reviewer is correct that the cyclostratigraphic data is used twice, once to estimate breakpoint positions (layer boundaries) and later as part of the MCMC estimation of sedimentation rate. We do not belie this is "reuse" of the data though. Determining the layer boundary positions by identifying stratigraphically stable frequencies only identifies that the sedimentation rate is stable within that layer. The second step, the full MCMC model, estimates the rate within the layer. If "the visual inspection shows no change in sedimentation rates between two tie points" then in our view, that would justify the placement of the two layer boundaries since they are defining a zone of stable sedimentation.

## Comparison with BChron and assumptions on sedimentation rates

* The authors show figures with uncertainties from their approach and those derived from BChron, and briefly discuss the different assumptions made by both methods. They conclude that “astrochronology provides a clear, strong constraint on the stratigraphic variability in sedimentation rate” and “astrochronology […] can substantially improve [age-depth] model accuracy and precision”

* This is potentially misleading, as BChron has very loose assumptions on variability in sedimentation rates, while astroBayes has piecewise constant sedimentation rates “baked in”. Naturally, this assumption limits the uncertainty the model can display between the radiometric dates. An example demonstrating that the reduced uncertainty is generated by the information added by cyclostratigraphic data, and not by the model assumption of piecewise constant sedimentation rates, would greatly strengthen the authors point.

> This is similar to a critique made by Dr. De Vleeschouwer in Referee Comment 2. We agree that the improvement in uncertainties *is because* our choice of a simpler sedimentation model naturally limits variability relative to `Bchron`. We feel that the second point here - demonstrating that the reduction comes from the astrochronology - is a little difficult to test, however. The astrochronology is what allows us to use a simple sedimentation model, and removing the information added by it would necessarily mean that we should not use such a model. in other words, in the absence of informative astrochronologic data, `astroBayes` would not be an appropriate tool. Nevertheless, expanding the discussion of this is very relevant to the manuscript and we will do so. 

## Comments on the astroBayes package & repository

### Software citation:

* The package itself uses other scientific software (e.g. `astrochron`). This should be made explicit in the main manuscript by stating the dependencies and citing the used packages.

> `astroBayes` relies on several established R packages including `astrochron` to calculate periodograms and manipulate the astronomical data. It also relies on various `tidyverse` packages for data manipulation and plotting.  The package dependencies are documented in the package `DESCRIPTION` file. Since most of these packages are used "under-the-hood", we feel that they do not need to be explicitly mentioned in the main manuscript, but can be documented as is and in the GitHub `README` and the (to be added) package vignette. 

* Based on the README, the package is deposited on Zenodo and assigned a DOI. This is excellent, and should be mentioned in the main text. The package should also be cited in the main text to specify on which version the analyses were run, and increase computational reproducibility.

> We will add appropriate citations to the Zenodo DOI's immediately before revision. Since these comments and others have necessitated making some changes to both the `astroBayes` and `astroBayes_manuscript` repositories both will get new releases/DOI's once the revision process is finished. The `astroBayes` GitHub repository will remain under active development as we add more capabilities in the future. 

* Citation info generated using `citation(“astroBayes”)` does not show the DOI. I suggest adding it in there to have a tighter association between the package and the archived version.

> We have added a citation to the draft version of the manuscript to the `astroBayes` package (commit 10b517bd7711d3cf9cb35e7e6368dde4a619790e). Currently it cites the preprint version and DOI but we will update this after the review process is complete. 

* I suggest to add a CITATION.cff file to the repository (https://citation-file-format.github.io/) so the package can be directly cited from GH.

> We have added a citation file to the `astroBayes` repository. (commit 10b517bd7711d3cf9cb35e7e6368dde4a619790e). We will update this as necessary after the publication process is complete. 

## Examples

* The example provided in the README runs smoothly and is instructive. From a packaging perspective I recommend moving it to a vignette so it is directly associated with the package and also available to non-GH users.

> This is similar to a comment made by Dr. Blaauw in RC1. We will add a vignette to the R package with a fully worked example. 

* Package installation from GH works, but `devtools::check()` throws an error due to missing package dependencies. Fixing this is a requirement for submitting the package to CRAN (which I highly recommend)

> Thank you for catching this. We have fixed the missing package dependencies (see commit `bd600b4209a2ee828f5efd726ed348be0dc0379c` to the `astroBaye` GitHub repository). CRAN submission is planned for some time after paper acceptance. 

* `summary(age_model, type = 'hiatus')` does not return anything. I think it’d be helpful if it returned that there is no hiatus in the age-depth model (which is relevant information)

> This was a bug and has been fixed. see commit `bd600b4209a2ee828f5efd726ed348be0dc0379c` to the `astroBayes` GitHub repository.

## Comments on the `astroBayes_manuscript` repository

* Running instructions are present, but requires to execute scripts in a specific order. Will the outputs still be the same if the scripts are executed in a different order, or will the scripts break? If so, it might be worth having a higher-level script that ensures everything is executed in the right order.

> The first 4 scripts (`_stability.R`, `_validation.R`) can be run in any order but must be run before the remaining scripts. We can add an additional script that uses `source()`' to run all the scripts in the appropriate order. 

* I am torn regarding the computational reproducibility of the study. As the data generated by the code is not available, I cannot reproduce the figures. Based on the estimated run time of a week it is also not feasible to produce the data on my machine. This is not a problem with the study itself, but rather Bayesian approaches in general: Computation time is too long to generate data from scratch, and the amount of data generated is too large to be easily archived. I am unsure how or if this can be resolved, but the runtime and amount of data generated should be mentioned in the manuscript.

> We agree that making the full results and testing data available is a challenge since they total ~1.5 Tb of data. Currently there are 10,000 age-depth model outputs in the testing data set. This is a lot of data, but it is not completely out of the question to generate these models on a personal computer. All model testing was done on a 2023 Mac Studio with 64Gb of RAM, a 2 Tb hard drive, and an Apple M1 Ultra processor. This is a powerful computer but most academic researchers likely have access to a computer with similar specs. We do note that it is very feasible for an individual to use the code in the `astroBayes_mansuscript` repository to generate a smaller number of models on a personal computer. In most cases the scripts have a single line of code that sets the number of models to generate a smaller (but still useful) number. This in itself is a good test. Since we are using a Bayesian approach, independently generated models should reproduce our results. 

> That said, we are currently looking into solutions to host the original testing outputs for public download. Again this doesn't solve the size problems (~1.5 Tb) but it would make the exact testing data available. 

* As the discussion on the manuscript continues, it might be worth to make releases of the manuscript repo to make it clearer to which version of the manuscript the comments refer to.

> This is the plan. We will revise and commit changed to the manuscript that correspond to each reviewer/ commenter.