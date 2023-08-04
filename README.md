# Bayesian Integration of Astrochronology and Radioisotope Geochronology

[![DOI](https://zenodo.org/badge/411031242.svg)](https://zenodo.org/badge/latestdoi/411031242)

This repository contains the data, code, and manuscript editing history for **Trayler, R. B., Meyers, S. R., Sageman, B. B., Schmitz, M. D., (in prep) *Bayesian Integration of Astrochronology and Radioisotope Geochronology*

## File Structure 


```
.
├── data
    └── BCL # data for Bridge Creek Limestone case study
        └── cyclostratigraphic_record.csv   # greyscale data
        └── meyers_radioisotopic_dates.csv  # dates from Meyers et al. (2012)
        └── updated_radioisotopic_dates.csv # updated dates for BCL 
        └── segment_edges.csv               # layer boundary positions for modeling
        └── tuning_frequency.csv            # target frequencies for modeling
    └── CIP2 # CIP2 testing data
        └── cyclostrat_data.csv     # synthetic cyclostratigraphic data 
        └── segment_edges.csv       # layer boundary positions for modeling
        └── radioisotopic_dates.csv # dates used for stability modeling
        └── true_age.csv            # true age model 
        └── tuning_frequency.csv    # target frequencies for modeling
    └── TD1 # TD1 testing data
        └── cyclostrat_data.csv     # synthetic cyclostratigraphic data 
        └── segment_edges.csv       # layer boundary positions for modeling
        └── radioisotopic_dates.csv # dates used for stability modeling
        └── true_age.csv            # true age model 
        └── tuning_frequency.csv    # target frequencies for modeling
├── R # R scripts to to reproduce figures and calculations
    └── CIP2_stability.R   # runs 1,000 CIP2 models with the same inputs
    └── CIP2_validation.R  # runs 4,000 CIP2 models with randomly placed dates
    └── TD1_stability.R    # runs 1,000 TD1 models with the same inputs
    └── TD1_validation.R   # runs 4,000 TD1 models with randomly placed dates
    └── CIP2_hiatus_sensitvity  # tests sensitivity of hiatus duration to date position
    └── BCL_case_study.R         # Bridge Creek Limestone case study
    └── model_reproducibility.R  # calculates the reproducibility of the 95% CI
    └── proportion_constrained.R # calculates proportion of true age model within 95% CI
    └── figure_2.R         # generates figure 2
    └── figure_3.R         # generates figure 3
├── figures                # output directory for pdf figures
    └── final figures      # cleaned up figures for publication 
├── results # contains the model results for stability and validation models
    └── stability_validation # contains the outputs of CIP2_stability.R and TD1_stability.R
    └── random_age_validation # contains the outputs of CIP2_validation.R and TD1_validation.R 
├── manuscript.md         # pandoc markdown formatted manuscript
└── README.md
```

## Manuscript

This manuscript is written in [`Pandoc`](https://pandoc.org) flavored markdown. Follow the instructions [here](https://pandoc.org/installing.html) to install `pandoc`. The manuscript also relies on the [`pandoc-crossref`](https://github.com/lierdakil/pandoc-crossref) filter to handle figure, table, and section numbering. 

The manuscript file, `manuscript.md` can be compiled into a nicely formatted pdf but running the following pandoc command.

```bash
pandoc -s manuscript.md -o manuscript.pdf --pdf-engine=xelatex --filter pandoc-crossref --citeproc --number-sections
```



