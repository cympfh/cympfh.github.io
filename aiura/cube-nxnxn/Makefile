all:
	for f in *.cube; do \
		make `basename $$f .cube`.svg; \
	done

%.svg: %.cube
	iso-cubeviz --state-file $< -o $@
