#!/bin/bash

date2822() {
    date --rfc-2822 $@
}

jsonvalue() {
    echo "$2" | jq -r "$1"
}

cat <<EOM
<rss version="2.0">
  <channel>
    <lastBuildDate>$(date2822)</lastBuildDate>
    <generator>@cympfh</generator>
    <title>cympfh.cc/taglibro</title>
    <link>https://cympfh.cc/taglibro</link>
    <description>@cympfh/taglibro</description>
EOM

cat index.html |
    web-grep --json '
    <div class="card">
        <header class="card-header">
            <a class="card-header-title" href="./{link}">{title}</a>
        </header>
        <div class="card-content">
            {description}
        </div>
    </div>' |
    while read json; do
        title=$(jsonvalue .title "$json")
        link=$(jsonvalue .link "$json")
        description="$(jsonvalue .description "$json" | html-encode)"
        pubDate=$(date2822 --date "$link")
        cat <<EOM
      <item>
        <title>${title}</title>
        <link>https://cympfh.cc/${link}</link>
        <description>
          ${description}
        </description>
        <pubDate>${pubDate}</pubDate>
        <guid isPermaLink="true">https://cympfh.cc/${link}</guid>
      </item>
EOM
    done

cat <<EOM
  </channel>
</rss>
EOM
