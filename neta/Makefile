ngram:
	ruby ./bin/gram.rb > js/ngrams.js
	hash=$$(md5sum js/ngrams.js | cut -c1-8); \
	sed -i "s|ngrams\.js?v=[^']*|ngrams.js?v=$$hash|; s|ngrams\.js'|ngrams.js?v=$$hash'|" index.html

git: ngram
	git add -A .
	git commit -m "neta `date`"
