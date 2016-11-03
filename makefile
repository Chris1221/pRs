.all: commitpush

commitpush:
	git add -A
	git commit -am "update aprs, see changelog"
	git push
