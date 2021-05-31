function web_emb_init() {
  /*
   *   <div class="web-emb"
   *       meta-title="{TITLE}"
   *       meta-image="{IMAGE}"
   *       meta-description="{DESCRIPTION}"
   *       meta-url="{URL}"
   *   ></div>
   */
  var nodes = document.getElementsByClassName('web-emb');
  for (var node of nodes) {
    var title = node.getAttribute('meta-title');
    var image = node.getAttribute('meta-image');
    var description = node.getAttribute('meta-description');
    var url = node.getAttribute('meta-url');

    var card = document.createElement('div');
    card.className = 'web-emb-card';

    if (image) {
      card.innerHTML = `
        <div class="web-emb-cotainer">
          <div class="web-emb-media">
            <a href="${url}"><img src="${image}" /></a>
          </div>
          <div class="web-emb-content">
            <span class="web-emb-title"><a href="${url}">${title}</a></span>
            <span class="web-emb-description">${description}</span>
          </div>
        </div>
      `;
    } else {
      card.innerHTML = `
        <div class="web-emb-cotainer">
          <div class="web-emb-content">
            <span class="web-emb-title"><a href="${url}">${title}</a></span>
            <span class="web-emb-description">${description}</span>
          </div>
        </div>
      `;
    }

    node.innerHTML = '';
    node.appendChild(card);
  }
}

web_emb_init();
