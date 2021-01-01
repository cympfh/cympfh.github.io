
function youtube_init() {
  /*
   * 初期化:
   *   <div class="youtube" src-id="..."></div> について,
   *   1. サムネ画像と再生ボタンにする
   *   2. クリックして初めて再生可能な iframe にする
   */
  var nodes = document.getElementsByClassName('youtube');
  for (var node of nodes) {
    var src_id = node.getAttribute('src-id');
    if (!src_id) {
      src_id = node.getAttribute('data-src-id');
      if (!src_id) continue;
    }

    var img = document.createElement('img');
    img.src = `https://img.youtube.com/vi/${src_id}/hqdefault.jpg`;
    node.appendChild(img);

    var button = document.createElement('div');
    button.classList.add('play-button');
    node.appendChild(button);

    var bind = ((node) => {
      return () => clickable(node)
    })(node);
    node.addEventListener('click', bind);
  }
}

function clickable(node) {
  var iframe = document.createElement('iframe');
  var src_id = node.getAttribute('src-id');
  iframe.setAttribute("frameborder", "0");
  iframe.setAttribute("allowfullscreen", "");
  iframe.setAttribute("src", `https://www.youtube.com/embed/${src_id}?rel=0&showinfo=0&autoplay=1`);
  node.innerHTML = '';
  node.appendChild(iframe);
}

youtube_init();
