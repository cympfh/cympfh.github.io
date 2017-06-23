updatedb:
	: > list
	find . -type f | grep '20../q.' | sort -r | sed 's/.*/cat &/g' | sh >>list
	cat precure >>list
