function search_worlds_by_a_tag() {
  let hash = location.hash;
  if (hash.length < 2 || hash == '#README') {
    // Show all if no hash
    show_by_tag(null);
  } else if (hash.indexOf('#wrld_') === 0) {
    // Nop
  } else {
    let tag = decodeURIComponent(hash.slice(1));
    show_by_tag(tag);
  }
}

function show_by_tag(tag) {
  let elems = document.getElementsByClassName('world_column');
  for (let elem of elems) {
    let tags = elem.dataset.tags.trim().split(' ');
    if (tag === null || tags.indexOf(tag) >= 0) {
      console.log(elem, tags, 'display');
      elem.style.display = 'block';
    } else {
      console.log(elem, tags, 'hidden');
      elem.style.display = 'none';
    }
  }
}

(function() {
  search_worlds_by_a_tag();
  window.addEventListener('hashchange', () => {
    search_worlds_by_a_tag();
  });
})();
