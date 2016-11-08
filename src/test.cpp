// [[Rcpp::export]]
Rcpp::StringVector prs(std::string path) {	

	Rcpp::StringVector myvector2(5);	

	std::ifstream inf(path);
	int i = 0;
	
	while(inf)
	{
		std::string strInput;
		getline(inf, strInput);
		std::vector<std::string> output = split2(strInput, ' ');	
		myvector2(i) = strInput; 
		i++;
	}

	return myvector2;	

}
