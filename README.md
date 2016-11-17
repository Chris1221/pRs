# `pRs`: Polygenic Risk Score Toolkit in R

This package has been designed to work on large datasets in a computationally efficient manner. We introduce

- A more efficient (and natively coded) method for finding optimal polygenic risk scores improving on [`PRSice`](prsice.info) able to be run on a laptop.
- A novel method for aggregate co-morbid PRS (acmPRS) and optimal co-morbid PRS (ocmPRS) as presented in the companion article.  
- Convenience tools to quickly (faster than `read.table`, `fread`, or any existing strategy) read large genetic data into R.
- A toolkit including various options for PRS construction and analysis.
