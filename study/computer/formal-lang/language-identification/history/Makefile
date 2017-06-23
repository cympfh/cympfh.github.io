do: this.md
	pandoc -t beamer --template ~/beamer/themes/ponde2.tex -s -o it.tex this.md
	platex -shell-escape it && platex -shell-escape it && dvipdfmx it

.PHONY: clean
clean:
	rm it.aux it.dvi it.log it.out it.tex it.nav it.snm it.toc
