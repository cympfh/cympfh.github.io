/*
 * Append `.html` to links
 */

function isLocalPage(url) {
  return ( url.indexOf("localhost") >= 0 || url.indexOf("127.0.0.1") >= 0 ) && url.indexOf("#") == -1;
}

document.addEventListener("DOMContentLoaded", () => {
  const n = document.links.length;
  for (let i = 0; i < n; ++i) {
    let url = document.links[i].href;
    if (isLocalPage(url)) {
      document.links[i].href = `${url}.html`;
    }
  }
});
