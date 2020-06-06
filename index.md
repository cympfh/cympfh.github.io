<div class="tabs is-centered">
<ul>
<li><a target="" href="#" id="identicon"><img class='icon' src='resources/img/identicon.png'></a></li>
<li><a target='_blank' href='https://github.com/cympfh'><img class='icon' src='resources/img/GitHub-Mark.png'></a></li>
< cat ls | awk -F '\t' '{print "<li><a href=\""$2"\">"$1"</a></li>"}'
</ul>
</div>

<div class='page'>
<div class='container'>
<img class="portrait" id="portrait" />
</div>
</div>

<script>
// identicon href
var children = [
< cat ls | awk -F '\t' '{print "\""$2"\","}'
""
];
children.pop();
document.getElementById('identicon').href = children[(children.length * Math.random()) | 0];
</script>

<script>
// portrait photo
var photos = [
< tail -n 10 photos/resources/photos_list | awk '{print "\""$1"\","}'
""
];
photos.pop();
document.getElementById('portrait').src = photos[(photos.length * Math.random()) | 0];
</script>
