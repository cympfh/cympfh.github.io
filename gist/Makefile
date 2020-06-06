do: index.html

index.html: README.md
	cat $^ | sed 's#https://gist.github.com/cympfh/\([0-9a-f][0-9a-f]*\)#[\1](&)#g' | sed 's#https://github.com/cympfh/\([0-9a-zA-Z]*\)#[cympfh/\1](&)#g' | pandoc -s --css ../resources/css/c.css -o $@
