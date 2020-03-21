<div class="tabs is-centered">
<ul>
< cat ls | awk '{print "<li><a href=\""$2"\">"$1"</a></li>"}'
</ul>
</div>

<div class='page'>
<a target="" href="#" id="identicon"><img class='icon' src='resources/img/identicon.png'></a>
<a target='_blank' href='https://github.com/cympfh'><img class='icon' src='resources/img/GitHub-Mark.png'></a>
</div>

<script>
children = [
< cat ls | awk '{print "\""$2"\","}'
""
];
children.pop();
document.getElementById('identicon').href = children[(children.length * Math.random()) | 0];
</script>
