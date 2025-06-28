{
    if (NR==2) {
        print "<ul>"
        print "<li>original paper: <a href="$2">"$2"</a></li>"
        print "</ul>"
    }
    else if (NR==3) {
        print "<div class='is-pulled-right'>"
        for (i=2; i <= NF; i++) print "<a class='tag is-blue' href=index.html#"$i">"$i"</a>"
        print "</div>"
    }
    else {
        print $0
    }
}
