#include <string>
#include <sstream>
#include <vector>

// [[Rcpp::depends(RcppArmadillo)]]
// [[Rcpp::export]]
void split(const std::string &s, char delim, std::vector<std::string> &elems) {
	    std::stringstream ss;
	        ss.str(s);
		std::string item;
		while (std::getline(ss, item, delim)) {
			elems.push_back(item);
		}
}

std::vector<std::string> split2(const std::string &s, char delim) {
	std::vector<std::string> elems;
	split(s, delim, elems);
	return elems;
}
