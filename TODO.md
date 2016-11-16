## Nov 16th

- Wrapper around `prs_test()` to take into account P value thresholds and create new scores
- Verify accuracy
- Wrapper for multiple traits also (input assoc files and P value thresholds as a vector)
	- Optionally put in trait names to be reported alongside.
- Impliment 10 fold CV to train weights.
	- I.e. find P value thresholds 

## Nov 2nd

- [ ] How to find optional inclusion criteria for SNPs in scores
	- I.e. training/test split 
- [ ] What about traits as predictors?
- [ ] Weighting schemes (i.e. shrinkage through Lasso)
