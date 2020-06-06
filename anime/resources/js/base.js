function collapse_init() {
  var nodes = document.getElementsByClassName('collapse');
  for (var node of nodes) {
    var aid = node.getAttribute('aid');
    if (!aid) continue;
    var bind = ((node) => {
      return () => {
        var aid = node.getAttribute('aid');
        location.href = `#${aid}`;
      }
    })(node);
    node.addEventListener('click', bind);
  }
}


collapse_init();
