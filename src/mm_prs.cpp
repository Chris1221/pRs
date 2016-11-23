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
arma::mat prs(std::string input, bool debug, arma::uword n, arma::mat weights)
{
	std::ifstream in(input.c_str(), std::ios::binary);
  
	int count = 0; // overall counter
	int snp = 0; // snp counter, will be reset each time it hits nsnp in order to properly skip blank spcaes.
	
	char c;
	arma::uword n_u = n;
	// def results matrix
	arma::mat results(n_u, weights.n_cols); // maybe have to convert to unsigned
	results.fill(0);

	arma::uword which_snp = 0;

	while (in.get(c)) {
		
//		char c;
//		in.get(c);
		char mask = 1;
		char bits[8];

		for (int i = 0; i < 8; i++) {
			bits[i] = (c & (mask << i)) != 0;
		}

		// Read in, incriment count
		// If the count is less than 4 then its still in either
		// the magic number portion or the format
		//	
		// Will probably want to check the format portion 
		// at some point.
		count++;
		if(count < 4) continue;
	
		
	
		int gen;
		// Convert to gen and add in to results vector.
		for(int i = 0; i < 8; i+=2){
			
			
			// ! -------------------- ! //
			//	CHECK SNP COUNT     //
			// ! -------------------- ! //		
				
			if( (snp - n) == 0) {
				snp = 0;
				which_snp = which_snp+1;
				break;
			} // If hit the number of SNPs then skip the rest of the byte	
			// Find gen coding
			if( (bits[i] == 0) && (bits[i+1] == 0) ) {
				gen = 0;
			} else if( (bits[i] == 0) && (bits[i+1] == 1) ) {
				gen = 1; // check
			} else if( (bits[i] == 1) && (bits[i+1] == 0) ) {
				gen = 0; //missing is the same as 0
			} else if( (bits[i] == 1) && (bits[i+1] == 1) ) {
				gen = 2;
			} else {
				throw std::invalid_argument( "Non binary input or improper input." );
			}
		
			//printf("%d", i);
			//printf("%d", i+1);
			// Think about this
			// Need to make results
			results.row(snp) = results.row(snp) + weights.row(which_snp)*gen;



			if(debug){
				printf("%d", gen);	
			}
			
			snp++; // On first snp counter is going to be 1	
				
	
		}	

		// Check to see if everything is adding up correctly
		// only for debug
		if(debug) {
			for (int i = 0; i < 8; i++) {
//				printf("i = %d\n", i);
				printf("Bit: %d\n",bits[i]);
			}
				
			printf("byte %d\n", count);	
   		}

	
	}
	return results;
}
