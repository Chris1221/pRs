# `pRs`: Polygenic Risk Score Toolkit in R

**NOTE**: *This project was started and never totally finished, however there still may be some useful code here should you wish to adopt it for your own projects. I've left the repository here archived however please be aware that I'm not maintaining it, and provide no guarentee of its functionality.*

--- 

This package has been designed to work on large datasets in a computationally efficient manner. We introduce

- A more efficient (and natively coded) method for finding optimal polygenic risk scores improving on [`PRSice`](prsice.info) able to be run on a laptop.
- A novel method for aggregate co-morbid PRS (acmPRS) and optimal co-morbid PRS (ocmPRS) as presented in the companion article.  
- Convenience tools to quickly (faster than `read.table`, `fread`, or any existing strategy) read large genetic data into R.
- A toolkit including various options for PRS construction and analysis.

## Quick Start

`pRs` is currently under development and not indexed by CRAN. As such, you may install directly from Github. Keep in mind that there may be errors, though we would be pleased to help you use the software at any stage.

```R
devtools::install_github("Chris1221/pRs")
```

The package has the following main high level functions:

- `make_prs()`: Construct a simple PRS
- `make_optimal_prs()`: Construct an Optimal PRS. Returns the optimal score and diagnostic figures along with association statistics. Similar output to `PRSice`.
- `make_comorbid_prs()`: Construct an (optionally optimal) comorbid PRS for arbitrary number of traits.
- `read_plink()`: Quickly read a binary genetic file into R.

There are accompanying low level `C++` functions which may directly be accessed for advanced users. Please see the wiki for interactig with the API.

- `prs()`: Reads a binary file and constructs a PRS with a given `arma::mat` of weights.
- `plink2r()`: Low level interface to plink reading.

