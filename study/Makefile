all: index.html

index.html: README.md
	pandoc -s -t html5 --css ../resources/css/c.css -i $^ -o $@

git:
	cd ..; make git
