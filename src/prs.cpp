// -*- mode: C++; c-indent-level: 4; c-basic-offset: 4; indent-tabs-mode: nil; -*-

#include <RcppArmadillo.h>
#include <sstream>
#include <fstream>
#include <string>
#include <iostream>


// This comes from
// 	http://stackoverflow.com/questions/236129/split-a-string-in-c
// Before you ask, I have no idea.
void split(const std::string &s, char delim, std::vector<std::string> &elems) {
	    std::stringstream ss;
	        ss.str(s);
		std::string item;
		while (std::getline(ss, item, delim)) {
			elems.push_back(item);
		}
}

std::vector<std::string> split2(const std::string s, char delim) {
	std::vector<std::string> elems;
	split(s, delim, elems);
	return elems;
}

// [[Rcpp::depends(RcppArmadillo)]]

//' @title Construct a raw weighted PRS from cleaned input
//' @param map plink style .map file path. (char)
//' @param ped plink style .ped file path. (char)
//' @param assoc A vector of beta coefficients passed from R. (arma::vec)
// [[Rcpp::export]]
Rcpp::StringVector prs(std::string path) {	

	Rcpp::StringVector myvector2(4);	

	std::ifstream inf(path);
	int i = 0;
	
	while(!inf.eof())
	{
		Rcpp::Rcout << "i = " << i << std::endl;
		std::string strInput;
		getline(inf, strInput);
		
		Rcpp::Rcout << "input = " << strInput << std::endl;
		//std::vector<std::string> output = split2(strInput, ' ');	
		//myvector2(i) = strInput; 
		i++;
	}

	return myvector2;	

}

// And now for something completely different
// [[Rcpp::export]]
SEXP prs2(std::string path){

	Rcpp::StringVector myvector2(4);	

	std::ifstream inf(path);
	std::vector<std::string> numvec;

	while(!inf.eof())
	{
		std::string strInput;
		getline(inf, strInput);

		std::string value;

	//	while(strInput >> value){
	//		numvec.push_back(value);
	//	}
	
	}

	return Rcpp::wrap(numvec);	

}

// need to get each entry into a seperate slot in vector, line by line
// look into this
// http://stackoverflow.com/questions/10369483/parse-a-string-by-whitespace-into-a-vector


// Attempt 3. Simple this time
//' @export
SEXP prs3(std::string path){

	Rcpp::StringVector myvector2(4);	

	std::istringstream s2(path);
	std::vector<std::string> numvec;

	std::string value;

	while(s2 >> value){
		numvec.push_back(value);
	}


	return Rcpp::wrap(numvec);	

}
