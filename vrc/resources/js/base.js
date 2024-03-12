function collapse_init() {
  var nodes = document.getElementsByClassName('collapse');
  for (var node of nodes) {
    var wid = node.getAttribute('wid');
    if (!wid) continue;
    var bind = ((node) => {
      return () => {
        var wid = node.getAttribute('wid');
        location.href = `#${wid}`;
      }
    })(node);
    node.addEventListener('click', bind);
  }
}


collapse_init();
