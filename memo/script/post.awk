{
    if (NR==2) {
        print "<div class='is-pulled-right'>"
        for (i=2; i <= NF; i++) print "<a class='tag is-green' href=index.html#"$i">"$i"</a>"
        print "</div>"
    }
    else {
        print $0
    }
}
