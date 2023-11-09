---
title: "Response to RC1: comment on gchron-2023-22', David De Vleeschouwer, 13 Oct 2023"
author:
  - ^1,2,\*^Robin B. Trayler
  - ^3^Stephen R. Meyers
  - ^4^Bradley B. Sageman
  - ^2^Mark D. Schmitz
bibliography: ../bibtex.bib
csl: ../copernicus-publications.csl
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

<!-- pandoc -s -f markdown+mark -o RC2_response.pdf --pdf-engine=xelatex --filter pandoc-crossref --citeproc RC2_response.md --> 

> ^1^Department of Life and Environmental Sciences, University of California, Merced, CA
> 
> ^2^Department of Geosciences, Boise State University, Boise ID
> 
> ^3^Department of Geosciences, University of Wisconsin, Madison, WI
>
> ^4^Department of Earth and Planetary Sciences, Northwestern University, Evanston, IL
> 
> ^\*^Corresponding author: rtrayler@ucmerced.edu

<!-- A note on the comments below. The original comments by Dr. De Vleeschouwer are included as regular text and our responses are in bold. A formatted PDF version of the comments is also included as an attachment to this comment. -->

* In their manuscript, Trayler et al. introduce a novel R package named `astroBayes`, designed for constructing geologic age-depth models that incorporate both radio-isotopic dates and astrochronologic information. To create such a model for a specific section, the user must provide four key pieces of information:

* A proxy depth-series containing an **assumed** astronomical imprint. At this stage, user input is minimal, and the choice of proxy and its sampling interval is the primary user consideration.

> Dr. De Vleeschouwer has highlighted an important point that we should have made explicit in the manuscript. That is, `astroBayes` is *not an astrochronologic testing method*. Statistical testing for the presence of an astronomical signal must be done using other hypothesis-testing approaches (e.g., see @meyers2019; @sinnesael2019) before age-depth modeling with `astroBayes`. `astroBayes` is most similar to the frequency domain Bayesian approach of  @malinverno2010, which does not conduct statistical testing (e.g., no *p*-value is calculated; see also the time-domain tuning approach of @lisiecki2005). In our view, `astroBayes` is intended to be the end-point of an astrochronologic workflow not the beginning. Text will be added to highlight these points.  

* Geochronologic dates for the section (stratigraphic position, age, and uncertainty). This input also does not require additional user intervention/decisions.

> Dr. De Vleeschouwer is correct that this step does not require additional user intervention, but we will highlight that we are assuming that the user will use "good" dates that have already been screened for outliers or anomalies, which may arise from geologic processes such as open system behavior (e.g., loss of daughter product). 

* Target frequencies, represented as a vector of astronomical frequencies that are expected to be imprinted in the proxy depth-series mentioned above. The user's input is essential at this stage and likely influences the results in a considerate manner. The potential impact of this user choice becomes evident in the manuscript: The authors made different target frequency choices for the synthetic data sets (Table 2) and the Bridge Creek dataset (Table 4). The different selections raise concerns regarding whether the authors may be favoring certain results by adjusting these frequencies. Notably, the Bridge Creek dataset uses three obliquity periods, despite two of those obliquity components have significantly lower amplitudes compared to the primary 39-kyr obliquity forcing. It also uses only a single precession period, despite precession being influenced by multiple quasi-periodicities.

> Dr. De Vleeschouwer is correct that the choice of target frequencies can potentially have a substantial influence on the `astroBayes` posterior. We choose different target frequencies for the testing data and case study for two reasons. First, both testing data series (TD1 and CIP2) were designed to mimic late-Quaternary records, while the Bridge Creek Limestone section is Late Cretaceous. The target frequencies used for with the TD1 and CIP2 testing data sets were calculated using the @laskar2004 solution for precession and obliquity from 0-10 Ma, and the @laskar2011 LA10d solution for eccentricity from 0-20 Ma.The Late Cretaceous precession and obliquity terms were calculated using the reconstruction of @waltham2015. The target frequencies used for the Bridge Creek Limestone case study were chosen from two sources. The precession and obliquity terms were calculated from the reconstruction of @waltham2015. The eccentricity terms were based on the LA10d solution [@laskar2011] from 0-20 Ma (the short and long eccentricity periods are not expected to undergo persistent long term drift, as is the case for precession and obliquity). We included the additional ~0.050 Myr and ~0.028 Myr obliquity periods (based on the @waltham2015 “k” estimate) for the Cretaceous, since these periods have previously been reported for this section [@sageman1997; @meyers2001]. The choice to use a singe precession term was based on an observation that multiple precession terms lead to a multimodal likelihood function that disagreed with previous sedimentation rate estimates for the Bridge Creek Limestone [@meyers2001]. However we recognize that this was a qualitative decision on our part and we will investigate this further during revision. We will re-run these analyses using different combinations of precession terms (e.g., averaging or including both ~0.018 Ma terms), to test if they significantly influence modeling results

> We agree that it is puzzling that such a strong ~0.050 Myr cycle is observed in the data, although this appears to be a feature of other contemporaneous records, such as at DSDP Site 603B, Tarfaya S13, and ODP Site 1261B [@kuhnt1997; @meyers2012b].  It is possible, for example, that an Earth-System process is amplifying the ~0.050 obliquity response, and/or that it is impacted by oceanographic processes such as outlined in @wallmann2019.

* Layer boundaries, representing stratigraphic positions where sedimentation rate changes are expected based on visual inspection of an evolving power spectrum or sedimentological indicators (e.g., hardgrounds, hiatuses, lithology changes). This piece of information is notably user-dependent.

* The manuscript is generally well-written and clear. The authors succeed in conveying the general idea behind the algorithm. However, throughout the manuscript, the authors overlook two critical questions: First, it remains unclear as to what extent the age-depth model results are influenced by the user's selection of layer boundaries (both the number of boundaries and their stratigraphic positions). Second, the authors do not describe the behavior of the astroBayes model when applied to a pure-noise proxy depth-series.

* To investigate the second question, I ran the astroBayes model with a purely random noise signal (autoregressive noise with a rho value of 0.9). Apart from the pure-noise character, other depth-series characteristics were similar to the test “cyclostratigraphy” dataset provided in the R package. It appears that, indeed, for a depth-series without an astronomical signal, the age-depth model produces wider uncertainty bands compared to depth-series with an astronomical signal. Nevertheless, these uncertainty bands remain considerably narrower than the "Bchron sausages" referenced in the authors' Figure 3. Obviously, this is because the assumption of piecewise constant sedimentation rates is inherent to the astroBayes model. This obviously remains a questionable assumption to make, and to my taste, this assumption does not fully acknowledge true geologic variability in sedimentation rate and the possibility of cryptic hiatuses anywhere in the section. 

> We appreciate this comment. We have more comments on the random-noise test below, but would like to point out that Dr. De Vleeschouwer's first point about the piecewise linear model is explicitly discussed in section 5.1 of the manuscript, starting around line 525. We feel that this discussion, paired with the added discussion below should provide enough guidance for users to know when a piecewise linear accumulation model is appropriate (or not). We also note that simpler sedimentation models have often been used in the past to approximate accumulation [@malinverno2010; @meyers2019]. 

* Hence, to my taste, the uncertainty bands for the “pure noise” series in the Figure below seem somewhat over-optimistic, particularly within the interval between bentonite B and C. I recommend that the authors write a dedicated section in the discussion to address this question, explicitly addressing the assumption of piecewise linear interpolation in-between layer boundaries. This is of paramount importance because the algorithm's user-friendliness can make it highly susceptible to misuse.

> We appreciate the thought that Dr. De Vleeschouwer has put into this review and are especially glad that he has provided an example noise series analysis. He raises an important point that we did not really make clear in the manuscript. `astroBayes` is intended to be used after the cyclostratigraphic data has been vetted and shown to contain statistically significant astronomical signals through other means (e.g., null-hypothesis testing). We were able to skip this step for the synthetic testing data since they were generated directly from astronomical solutions, and for the Cenomanian-Turonian case study since this section has been repeatedly investigated over the past c. 20 years, including with the Average Spectral Misfit astrochronologic testing approach (see Fig. 7  & of @meyers2007) [@sageman1997; @sageman1998; @meyers2001; @meyers2004; @meyers2012]. 

> To address Dr. De Vleeschouwer’s comments, we have added a section cautioning about the appropriate use and potential misuse of `astroBayes`. We now include a similar noise series example as that provided by Dr. De Vleeschouwer (see Figure 1 below) and have provided some guidance on when astroBayes is an inappropriate tool.  New text underscores that the use of time-frequency analysis to assess bedding stability in specific layers is requisite for evaluation of the underlying simplifying assumption of piecewise-linear sedimentation rates.  We also note that the astroBayes approach is robust to moderate departures from this assumption, as noted in the response to Dr. Blaauw’s review:

>> “Ultimately our goal is to capture the "true" age model within the `astroBayes` posterior even if we are somewhat simplifying the problem. For example, in figure 2C, the second layer from the base of the section has a varying sedimentation rate that is only partially approximated by our choice of treating it as a single layer. Nevertheless, inspecting the age-depth models in figure 3A-D shows that even when our assumptions of more-or-less constant accumulation are violated the true age-depth model still falls within the 95% credible interval of the posterior, which is reproduced in nearly all cases (see line 300).” 

## Misuse of `astroBayes`

![Results of `astroBayes` modeling of the TD1 testing dataset, with the cyclostratigraphic data replaced by randomly generated red-noise. A) Randomly generated red-noise B) Age-depth model generated using the correct dates, frequencies, and layer boundaries, and the red-noise cyclostratigraphic data C) Evolutive harmonic analysis of A). The dashed lines indicate the layer boundary positions used for other model testing (see Figure 2 in the manuscript). The arrows indicate the uncertainty in layer boundary position since the data lacks any stratigraphically stable and continuous frequencies.](../figures/final figures/red_noise_figure.pdf){#fig:red_noise}

"Because `astroBayes` is available as an R package, it is straightforward to install and use, assuming familiarity with the R programming language [@rcoreteam2023]. Given this, we feel we should discuss appropriate and inappropriate use of the modeling framework. First, `astroBayes` is not a method to test for the presence of statistically-significant astronomical signals and it does not include any null-hypothesis tests. There are a variety of statistical methods available to test for the presence of astronomical signals in the rock record [@huybers2005; @meyers2007; @zeeden2015; @meyers2019] which should be used prior to `astroBayes` modeling. Instead, `astroBayes` is intended to be used to develop age-depth models after the presence of astronomical signals has been established using other methods. Similarly, `astroBayes` does not include automated outlier rejection for radioisotopic dates [@bronkramsey2009] and these data should be pre-screened following best practices for high precision geochronology [@michel2016; @schmitz2013]. 

`astroBayes` is software, and it is quite possible to generate an age-depth model from data that lacks any astronomical signals or contains outlier radioisotopic dates. Therefore `astroBayes` makes three assumptions about the input data. First, the cyclostratigraphic *data* has been vetted and has been shown to contain statistically significant astronomical signals using other astrochronologic testing approaches. 2) The user-specified layer boundary positions (*z*) have been informed by either careful inspection of the cyclostratigraphic *data* (e.g., time-frequency analysis such as EHA), and other geologic data (e.g., visible facies changes), or both. 3) The radioisotopic dates have been prescreened and do not contain obvious outlier dates or violations of fundamental geologic principles (e.g., superposition). 

For a simple example of an inappropriate use of `astroBayes`, we replaced the cyclostratigraphic *data* in the TD1 data set with randomly generated red-noise. All other parameters (dates, layer boundaries, target frequencies) remained the same (see: Figure 2, Table 2 and Table 3 in manuscript). Together, we used these data to generate an `astroBayes` age-depth model, shown in @fig:red_noise. The resulting age-depth model (@fig:red_noise B) looks superficially similar to the example models shown in @fig:random_models. Since the radioisotopic dates still offer some limits on sedimentation rate, the median model still appears similar to the true age model. While the model credible interval is somewhat wider, notably, it does not "balloon" and the overall uncertainties remain low compared to dates-only models (e.g., `BChron`. However, while this age-depth model looks superficially promising, it violates two of the assumptions discussed above. First, the "cyclostratigraphic" *data* (red-noise) does not contain any statistically significant astronomical periods, leading to meaningless probability calculations. Second, because the "cyclostratigraphic" *data* is random, it cannot be used to inform the placement of layer boundaries. Indeed the evolutive harmonic analysis shown in @fig:red_noise C shows no stratigraphically stable frequencies, making the layer boundary positions used for this example arbitrary and incorrect. The `astroBayes` modeling framework explicitly assumes a piecewise linear sedimentation model (Figure 1 in manuscript) where sedimentation rate only varies at layer boundaries but is otherwise stable. Since for this example the "cyclostratigrapy" contains no astronomical signals, and the layer boundary positions cannot be reliably determined, `astroBayes` would be an inappropriate modeling tool."

* I was also wondering how the model performs when there is an outlier radio-isotopic date? From what point onward, will astroBayes ignore this outlier? Answering this question will require some sensitivity runs, I assume.

> This concern was also raised by Dr. Blaauw in Referee Comment 1 and has been addressed there. Briefly, we have added a sensitivity analysis that includes outlier dates. The model is somewhat sensitive to the inclusion of outliers but the proportion of the true-age model contained by the `astroBayes` credible interval is still ~87-90%.

# Minor comments

* Line 14: Anchoring chronologies CAN rely on radio-isotopic geochronology… but can also rely on other stratigraphic markers (magnetostratigraphic reversals, biostratigraphic datums, event stratigraphic markers). Are there any ideas about how to incorporate stratigraphic uncertainties on such dates into the astroBayes model?

> Although it’s not explicitly stated in the paper, there is an option for radioisotopic dates to be assigned a stratigraphic “thickness” which is treated as a uniform stratigraphic uncertainty in astroBayes. The modeling algorithm randomly adjusts the stratigraphic position (with in the bounds) of the date each iteration to account for this. This does allow for “stratigraphic uncertainty”. As for the other anchor types, if they can be expressed as an age±uncertainty that is Gaussian, then they can be included in the same way as the radioisotopic dates. Other distribution types (gamma, uniform, etc.) would require some modification of the modeling code.

* Line 28: I find the end of the abstract rather weak. The last sentence does not represent the big “take-home” message for the reader of this paper. 

> We have edited this to read:

> "Finally, we present a case study of the Bridge Creek Limestone Member of the Greenhorn Formation where we refine the age of the Cenomanian-Turonian Boundary, showing the strength of this approach when applied to deep-time chronostratigraphic questions."

* Line 45: I would recommend a consistent use of Ma and ka for “million years ago” and “thousand years ago” (absolute time, ages). Myr and kyr for “million years” and “thousand years” (durations, relative time differences). In any case, there is no consistent use of these abbreviations throughout the manuscript.

> We have changed all references to Ma / Myr as appropriate. All durations now use Myr (long eccentricity = 0.405 Myr) while numerical ages remain as Ma (C-T boundary age = 94 Ma). 

* Line 129 - 148: I would move this part to the end of the Introduction, discussing previous attempts to integrate radio-isotopic dates and astrochronologic interpretations.

> We would prefer to keep this section where it so manuscript introduction remains short, without getting into the weeds. 

* Line 73-77: Repetition of information that was already given in the Introduction.

* Line 82: Wrong Berger et al. citation. You probably mean André Berger et al. 198X or 199X.

> Fixed. This was intended to cite @berger1992. 

* Figure 2f: I can’t recognize why the authors drew the horizontal dashed lines (layer boundary positions) at those exact depths. There are no obvious features in the evolutive spectrum that would make me draw them exactly there.

> The lower layer boundary was placed to correspond to the position of the known hiatus in the CIP 2 dataset. The upper layer boundary was chosen to correspond to the bifurcation of the 1-2 cycles/m frequently track and the "smearing" of the 3-4 cycles/m track. 

* Line 324 – 325: Not really relevant that future model developments could make the positioning of layers more objective… The required user input in the current version of the algorithm, to me, represents the Achilles heel of your work right now.

> It is our intention to continue development of the astroBayes package but Dr. De Vleeschouwer is correct that future revisions are not relevant to this present manuscript. However, we do not agree that the user-specification of layer boundaries is an “Achilles heel” as it informed based on cyclostratigraphic evaluation (e.g., EHA analysis) and other geologic data (e.g., facies changes), and can be addressed in sensitivity tests with iterative `astroBayes` analyses. We do recognize that this layer boundary specification makes developing an astroBayes age-depth model more involved than using `rbacon` or `BChron`. However, when used appropriately we feel that `astroBayes` is a powerful tool with capabilities not found in other approaches.

* Figure 4: I do not see any points, nor error bars

> Could this be a PDF rendering error? There are a lot of points / error bars on the figure. They do overlap and blur together but they are clearly visible to us.

* Figure 8: Batenburg et al. suggested two tuning options, with an astronomically-tuned age for the C-T boundary of either 93.69 +- 0.15 Ma (Tuning 1) or 94.10 +- 0.15 Ma (Tuning 2).

> We have added these ages to Figure 8 and to the manuscript text.

* Line 396: model à models

> Fixed

* Figure 5: Was the hiatus already known prior to this study? Or was it discovered by astroBayes?

> This hiatus was originally identified by @meyers2004 (see lines 375 and 398 of the manuscript) who also provided an estimation of its duration. We allowed the age model to include a hiatus at the previously identified position, but otherwise placed no constraints on its duration other than the duration must be strictly positive. Please see also our response to Dr. Blaauw's comment on hiatus prior distributions in our response to Referee Comment 1. 

* Figure 6: Which of the two models in Figure 5 are we looking at here? Or is the result in Figure 6 identical for both models in Figure 5?

> This is the result of the *Meyers Model*. The EHA and periodograms for both models in figure 5 look more or less identical (note that the model medians are parallel), so we choose to only highlight one in figure 6. 

* Line 466: Case 2 from the Cyclostratigraphic Intercomparison Project was designed by Christian Zeeden, not by Matthias Sinnesael. He should be acknowledged here.

> It was not our intent to exclude Dr. Zeeden. We requested the raw data from Dr. Sinnesael since he is the first author on the Cyclostratigraphic Intercomparison Project paper. We have updated the acknowledgements to say "We thank Dr. Matthias Sinnesael for providing, and Dr. Christian Zeeden for developing, the Cyclostratigraphy Intercomparison Project CIP2 data used for model testing."