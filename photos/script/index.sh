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
const beta = 1.0;  // randomness coeff
urls = urls.map((url, i) => [i + Math.random() * urls.length * beta, url])
  .sort((a, b) => b[0] - a[0])
  .map((item) => item[1]);
</script>
<div class="outer">
  <div class="photos">
  <script>
    var rows = 15;
    document.open();
    let num = Math.min(2 * rows, urls.length);
    for (var i = 0; i < num; ++i) {
      var idx = i < rows ? i * 2 : (i - rows) * 2 + 1;
      document.write(\`<img src="\${urls[idx]}" />\`);
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
