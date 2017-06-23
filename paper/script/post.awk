{
    if (NR==2) {
        print "<ul>"
        print "<li>url: <a href="$2">"$2"</a></li>"
    }
    else if (NR==3) {
        print "<li>tags:"
        for (i=2; i <= NF; i++) print "<span class=tag><a href=index.html#"$i">"$i"</a></span>"
        print "</li></ul>"
    }
    else {
        print $0
    }
}
