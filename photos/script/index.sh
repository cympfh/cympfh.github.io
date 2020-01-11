#!/bin/bash

cat <<EOM
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="description" content="cympfh.cc/photos" />
  <meta property="og:url" content="http://cympfh.cc/photos">
  <meta property="og:title" content="photos/" />
  <meta property="og:description" content="cympfh.cc/photos" />
  <meta property="og:image" content="http://cympfh.cc/resources/img/identicon.png" />
  <meta name="twitter:card" content="summary" />
  <meta name="twitter:site" content="@cympfh" />
  <title>photos/</title>
  <style type="text/css">code{white-space: pre;}</style>
  <link rel="stylesheet" href="../resources/css/c.css">
  <link rel="stylesheet" href="resources/c.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
</head>
<body class="with-bg">
  <h1 class="title"><i class="fa fa-camera"></i></h1>

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
    let num = Math.min(30, urls.length);
    for (var i = 0; i < num; ++i) {
      document.write(\`<img src="\${urls[i]}" />\`);
    }
    document.close();
  </script>

</div>
</div>
<div class="zoom hidden" id="zoom_container">
  <img id="zoom" src="" />
</div>
<script src="resources/zoom.js"></script>

</body>
</html>
EOM
