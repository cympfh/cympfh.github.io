// Clicked/Selected a Year
function tab(year) {
  var midashi;
  if (year == "") {
    midashi = "All";
  } else {
    midashi = year;
  }
  document.getElementById("y-midashi").innerHTML = midashi;

  // filtering
  for (var y = 2010; y < 3000; ++y) {
    var ystr = y.toString();
    var objs = document.getElementsByClassName(`card-${y}`);
    for (var i = 0; i < objs.length; ++i) {
      var obj = objs[i];
      if (year == "") {
        obj.classList.remove("hidden");
      } else {
        if (year == ystr) {
          obj.classList.remove("hidden");
        } else {
          obj.classList.add("hidden");
        }
      }
    }
  }
}

window.addEventListener('hashchange', () => {
  var y = location.hash.slice(1);
  tab(y);
});
