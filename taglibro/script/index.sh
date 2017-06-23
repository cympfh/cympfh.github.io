#!/bin/bash

cat templates/index.header.html

find . -name '*.md' | sort -r |
while read f; do
    MD=$f
    HTML=${f%md}html
    echo "<blockquote class=post>"
    echo "<a class=post href=\"$HTML\">$(head -1 $MD | sed 's/^..//g')</a>"
    echo "<div class=description>"
    grep '^## ' $MD | sed 's,^## ,<span class=description>,; s,$,</span>,'
    echo "</div>"
    echo "</blockquote>"
done

cat templates/index.footer.html
