index.html: README.md
	pandoc -s -t html5 \
		--template=templates/index.html \
		$^ -o $@

%.pdf: %.dvi
	docker run --rm -v $(shell pwd):/workdir paperist/alpine-texlive-ja dvipdfmx $^

%.dvi: %.tex
	docker run --rm -v $(shell pwd):/workdir paperist/alpine-texlive-ja uplatex $^

%.tex: %.md
	pandoc -s $^ -o $@ --latex-engine=lualatex \
	-V papersize=a4 \
	-V documentclass=bxjsarticle \
	-V classoption=pandoc \
	-V classoption=jafont=ipaex \
	-V header-includes=\\usepackage{amscd}

clean:
	rm -f $(shell cat .gitignore)
