#include <RcppArmadillo.h>
#include <iostream>
#include <fstream>
#include <cmath>
// [[Rcpp::depends(RcppArmadillo)]]
//' Construct several polygenic risk scores from a matrix of weights. 
//' @param name Path to .ped file (or binary file, working on this now). 
//' @param weights A matrix of weights with each row being beta corresponding to the association between SNP at that position and the outcome. 
//' @importFrom Rcpp evalCpp
//' @export
// [[Rcpp::export]]
bool new_prs(std::string input)
{
	
	std::ifstream fin(input.c_str(), std::ios::in | std::ios::binary );

	std::streamsize size = fin.tellg();
	std::vector<char> buffer(size);

	Rcpp::Rcout << size;

	if(fin.read(buffer.data(), size))
	{
	
		Rcpp::Rcout << size;
		for(int i=0; i < size; i++)
			Rcpp::Rcout << buffer[i] << std::endl;

	}

	return 0;

}

