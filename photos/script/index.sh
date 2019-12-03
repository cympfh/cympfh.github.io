#!/bin/bash

cat resources/index.header.html

cat <<EOM
<script>
var urls = [
EOM

sed 's/.*/"&",/; $s/,$//' resources/photos_list

cat <<EOM
];
urls.sort((a, b) => 0.5 - Math.random());
</script>
<div class="outer">
    <div class="photos">

    <script>
        document.open();
        for (var i = 0; i < 30; ++i) {
            document.write(\`<a href="\${urls[i]}"><img src="\${urls[i]}" /></a>\`);
        }
        document.close();
    </script>

    </div>
</div>
<div class="footer">@cympfh</div>
EOM
