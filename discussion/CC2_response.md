---
title: "Response to CC2: 'Comment on gchron-2023-22', Matthias Sinnesael, 17 Oct 2023"
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

<!-- pandoc -s -f markdown+mark -o CC2_response.docx --pdf-engine=xelatex --filter pandoc-crossref --citeproc CC2_response.md --> 

<!-- pandoc -s -f markdown+mark -o CC2_response.pdf --pdf-engine=xelatex --filter pandoc-crossref --citeproc CC2_response.md --> 

> ^1^Department of Life and Environmental Sciences, University of California, Merced, CA
> 
> ^2^Department of Geosciences, Boise State University, Boise ID
> 
> ^3^Department of Geosciences, University of Wisconsin, Madison, WI
>
> ^4^Department of Earth and Planetary Sciences, Northwestern University, Evanston, IL
> 
> ^\*^Corresponding author: rtrayler@ucmerced.edu

Dear Trayler et al.,

* Investigating the incorporation of cyclostratigraphic data in Bayesian age-depth models is a very welcomed contribution. Below you can find some minor thoughts I had on what could maybe make some points easier to understand (for me at least):

> We thank Dr. Sinnesael for his comments and complement about the relevance of the study.

1) Around line 155: input is also frequencies, and positions of layer boundaries, could be worth specifying (more clear on GitHub). In general, an example script to run at least one of the cases could be nice for the supplementary information? 

> Dr. Sinnesael is correct that the target frequencies are also user-determined.  We have expanded section 3.1 slightly to state this.

>> "...The inputs for `astroBayes` consists of measurements of a cyclostratigraphic record (*data*) (e.g., δ^18^O, XRF scans, core resistivity, etc.), and a set of radioisotopic dates (*dates*) that share a common stratigraphic scale. **The user also specifies a set of appropriate target frequencies (*f*; eccentricity, obliquity, precession) for use in probability calculations**..."

2) Somehow indicate the positions of the layer boundary positions on the age-depth plots (e.g. small line on the axis or something)?

> We have added interior tick-marks to the panels in figure 3 that indicate the layer boundary positions and updated the figure caption so it now includes:

>> "... Interior tick marks on the vertical axis of each panel indicate the layer boundary positions (see also the dashed lines in Figure 2C and 2F)..."

3) Plot the dates from Table 3 on Figure 2?

> We have added the dates to figure 2 as colored PDFs and updated the figure caption so that it now reads:

>>  "...The colored probability distributions are the synthetic radioisotopic dates used for model stability testing (see Table 3)..."

4) It is nice to see that also the challenge of hiatuses is addressed, but it is important to be very explicit to say that the identification and positioning is user-defined (preferably informed by additional geological context). This is addressed in section 5.2, but I think it would be worth explicitly specifying when you present the CIP2 case that you put the position of the hiatus there because the correct age model is known is this case.

> Dr. Sinnesael makes an  important point to make and is correct that the hiatus position in the CIP2 and Bridge Creek Limestone case study were previously known. We have expanded section 5.2 to include discussion of this point, which now reads:

>> "**There are two weaknesses of this approach to estimating hiatus duration. First, since hiatus positions are user defined, the stratigraphic position of a hiatus must be known *a priori* and must be informed by geologic (i.e., a visible unconformity) or cyclostratigraphic data [@meyers2004]. In both the CIP2 testing data set and the Bridge Creek Limestone case study (discussed below), the stratigraphic position of the hiatuses were known in advance.** The second weakness is that `astroBayes` cannot reliably estimate durations for hiatuses unconstrained by radioisotopic dates. If a hiatus only has radioisotopic dates stratigraphically above or below, the undated side is unconstrained and duration estimates tend to wander towards an infinite duration. Likewise, if a model layer is bounded by two hiatuses and the layer does not contain any radioisotopic dates, then `astroBayes` cannot reliably resolve the duration of the bounding hiatuses and will tend to "split the difference". However, when hiatuses are well-constrained by radioisotopic dates, `astroBayes` allows the estimation of robust uncertainties of hiatus duration and is a powerful tool when there is external sedimentological or astronomical evidence for hiatuses, as shown in the Bridge Creek Limestone Member case study below."

Best wishes,

Matthias Sinnesael

# References {.unnumbered}
:::{#refs}
:::

