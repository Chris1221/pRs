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


	std::ifstream in(input.c_str(), std::ios::in | std::ios::binary );	
	std::vector<char> v( (std::istreambuf_iterator<char>(in)),
			      std::istreambuf_iterator<char>() );

	for(int i = 0; i < v.size(); i++)
	{

		std::cout << i << std::endl;

		char c = v[i];
		char mask = 1;
		char bits[8];

		for (int j = 0; j < 8; j++) {
			bits[j] = (c & (mask << j)) != 0;
		}

		for (int i = 0; i < 8; i++) {
//				printf("i = %d\n", i);
			printf("Bit: %d\n",bits[i]);
		}




	}


	return 0;

}

