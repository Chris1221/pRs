// -*- mode: C++; c-indent-level: 4; c-basic-offset: 4; indent-tabs-mode: nil; -*-


#include <RcppArmadillo.h>
#include <iostream>
#include <sstream>
#include <fstream>
#include <string>
#include <vector>

// [[Rcpp::depends(RcppArmadillo)]]
//' Construct several polygenic risk scores from a matrix of weights. 
//' @param name Path to .ped file (or binary file, working on this now). 
//' @param weights A matrix of weights with each row being beta corresponding to the association between SNP at that position and the outcome. 
// [[Rcpp::export]]
std::vector<std::vector<double> > prs(std::string name, arma::mat weights){
    std::vector<std::vector<double> > result;
    std::ifstream input (name);
    std::string lineData;




    while(getline(input, lineData))
    {
        double d;
        std::vector<double> row;
        std::stringstream lineStream(lineData);

        while (lineStream >> d)
            row.push_back(d);

	// conv_to from std::vector to arma::vec
	// multiply by weights and take the sum
	// put that sum into the result vector and push back
	
	arma::vec score = arma::conv_to<arma::vec>::from(row);

	std::vector<double> si;

	for(arma::uword i = 0; i < weights.n_rows; ++i){
		si.push_back(accu(score % arma::conv_to<arma::vec>::from(weights.row(i))));
	}
	
        result.push_back(si);
    }

    return result;
}
