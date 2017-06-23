{
    if (NR==2) {
        print "<p class=date style='text-align: right'>"substr($0, 3)"</p>"
    }
    else if (NR==3) {
        print "<div class=tags style='text-align: right'>"
        for (i=2; i <= NF; i++) print "<a class=tag href=index.html#"$i">"$i"</a>"
        print "</div>"
    }
    else if (NR==4) {
        # abst は無視する
    }
    else {
        print $0
    }
}
