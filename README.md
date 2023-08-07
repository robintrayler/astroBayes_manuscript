# Bayesian Integration of Astrochronology and Radioisotope Geochronology

This repository contains the data, code, and manuscript editing history for 

**Trayler, R. B., Meyers, S. R., Sageman, B. B., Schmitz, M. D., (in prep) *Bayesian Integration of Astrochronology and Radioisotope Geochronology***. 

The code, installation instructions, and user guide for the `{astroBayes}` `R` package can be found at [github.com/robintrayler/astroBayes](https://github.com/robintrayler/astroBayes). 

## File Structure 
The breakdown of the files and R scripts in this repository is below. If you would like to reproduce the tests in the manuscript run the scripts in the `./R/` directory *in the order listed* below. Note that the `results` directory is empty in this repository as it is too large to archive on GitHub.  

## **🚨WARNING🚨** 
These scripts are designed to be run in parallel on a fairly powerful desktop computer or cluster. **Otherwise, they will take several days or weeks to complete and will generate approximately 1 terabyte of results files**. It is not recommended to run them on a personal laptop. 

```
├── data
    └── BCL # data for Bridge Creek Limestone case study
        └── cyclostratigraphic_record.csv   # greyscale data
        └── meyers_radioisotopic_dates.csv  # dates from Meyers et al. (2012)
        └── updated_radioisotopic_dates.csv # updated dates for BCL 
        └── layer_boundaries.csv            # layer boundary positions for modeling
        └── target_frequency.csv            # target frequencies for modeling
    └── CIP2 # CIP2 testing data
        └── cyclostrat_data.csv             # synthetic cyclostratigraphic data 
        └── layer_boundaries.csv            # layer boundary positions for modeling
        └── radioisotopic_dates.csv         # dates used for stability modeling
        └── true_age.csv                    # true age model 
        └── target_frequency.csv            # target frequencies for modeling
    └── TD1 # TD1 testing data
        └── cyclostrat_data.csv             # synthetic cyclostratigraphic data 
        └── layer_boundaries.csv            # layer boundary positions for modeling
        └── radioisotopic_dates.csv         # dates used for stability modeling
        └── true_age.csv                    # true age model 
        └── target_frequency.csv            # target frequencies for modeling
├── R # R scripts to to reproduce figures and calculations
    └── CIP2_stability.R                    # runs 1,000 CIP2 models with the same inputs
    └── CIP2_validation.R                   # runs 4,000 CIP2 models with randomly placed dates
    └── TD1_stability.R                     # runs 1,000 TD1 models with the same inputs
    └── TD1_validation.R                    # runs 4,000 TD1 models with randomly placed dates
    └── CIP2_hiatus_sensitvity              # tests sensitivity of hiatus duration to date position
    └── BCL_case_study.R                    # Bridge Creek Limestone case study
    └── model_reproducibility.R             # calculates the reproducibility of the 95% CI
    └── proportion_constrained.R            # calculates proportion of true age model within 95% CI
    └── figure_2.R                          # generates figure 2
    └── figure_3.R                          # generates figure 3
    └── figure_8.R                          # generates figure 8
├── figures                                 # output directory for pdf figures
    └── final figures                       # cleaned up figures for publication 
├── results # contains the model results for stability and validation models
    └── stability_validation                # contains the outputs of CIP2_stability.R and TD1_stability.R
    └── random_age_validation               # contains the outputs of CIP2_validation.R and TD1_validation.R 
├── manuscript.md                           # pandoc markdown formatted manuscript
```

## Manuscript Structure

This manuscript is written in [`Pandoc`](https://pandoc.org) flavored markdown. Follow the instructions [here](https://pandoc.org/installing.html) to install `Pandoc`. The manuscript also relies on the [`pandoc-crossref`](https://github.com/lierdakil/pandoc-crossref) filter to handle figure, table, and section numbering. 

The manuscript file, `manuscript.md` can be compiled into a nicely formatted PDF by running the following pandoc command.

```bash
pandoc -s -f markdown+mark -o manuscript.pdf --pdf-engine=xelatex --filter pandoc-crossref --citeproc --number-sections manuscript.md
```



