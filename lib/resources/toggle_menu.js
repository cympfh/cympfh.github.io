function hidden(cs) {
  var j = 0, m = cs.length;
  for (; j < m; ++j) cs[j].style.display = 'none';
}

function display(cs) {
  var j = 0, m = cs.length;
  for (; j < m; ++j) cs[j].style.display = 'block';
}

function make_toggle(x, cs) {
  return function () {
    if (x.style.zIndex == 1) {
      x.style.zIndex = 0;
      hidden(cs);
    } else {
      x.style.zIndex = 1;
      display(cs);
    }
  };
}

function init() {
  var xs = document.getElementById('dates').children;
  var i, n = xs.length;
  for (i = 0; i < n; ++i) {
    if (xs[i].tagName === 'H1') {
      (function () {
        var cs = []
        for (var j = i + 1; j < n && xs[j].tagName !== 'H1'; ++j) cs.push(xs[j]);
        xs[i].style.zIndex = 0;
        hidden(cs);
        xs[i].onclick = make_toggle(xs[i], cs);
      }());
    }
  }
}

window.addEventListener('load', init);
