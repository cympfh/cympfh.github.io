// Append `.html` to links
document.addEventListener('DOMContentLoaded', () => {
  let n = document.links.length;
  for (var i = 0; i < n; ++i) {
    let href = document.links[i].href;
    if (href.indexOf('localhost') >= 0 && href.indexOf('taglibro') >= 0 && href.indexOf('.html') == -1) {
      document.links[i].href = `${href}.html`;
    }
  }
});
