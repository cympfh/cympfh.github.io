function zoom(url) {
  return function() {
    // console.log("zoom", url);
    document.getElementById("zoom").src = url;
    document.getElementById("zoom_container").className = "zoom show";
  }
}

function unzoom() {
  // console.log("unzoom");
  document.getElementById("zoom_container").className = "zoom hidden";
}

function init() {
  for (var img of document.images) {
    if (img.id === "zoom") continue;
    img.addEventListener("click", zoom(img.src));
  }
  document.getElementById("zoom_container").addEventListener("click", unzoom);
}

window.onload = init;
