{
    if (NR==2) {
        print "<p class=date style='text-align: right'>"substr($0, 3)"</p>"
    }
    else if (NR==3) {
        print "<div class='is-pulled-right'>"
        for (i=2; i <= NF; i++) print "<a class='tag is-red' href=index.html#"$i">"$i"</a>"
        print "</div>"
    }
    else {
        print $0
    }
}
