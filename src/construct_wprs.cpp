// -*- mode: C++; c-indent-level: 4; c-basic-offset: 4; indent-tabs-mode: nil; -*-

#include <RcppArmadillo.h>
#include <sstream>
#include <fstream>
#include <string>
#include <iostream>

// [[Rcpp::depends(RcppArmadillo)]]

//' @title Construct a raw weighted PRS from cleaned input
//' @param map plink style .map file path. (char)
//' @param ped plink style .ped file path. (char)
//' @param assoc A vector of beta coefficients passed from R. (arma::vec)
// [[Rcpp::export]]
arma::vec wprs(char map, char ped, arma::vec assoc) {

	std::ifstream  data(ped);

	    std::string line;
	    while(std::getline(data,line))
	    {
		std::stringstream  lineStream(line);
		std::string        cell;
		while(std::getline(lineStream,cell,','))
		{
			cout << cell;          
		}
	    }
}
