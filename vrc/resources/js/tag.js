function search_worlds_by_a_tag() {
  let hash = location.hash;
  if (hash.length < 2 || hash.indexOf('#wrld_') === 0 || hash == '#README') {
    // Shows all if no hash or anchor to a world.
    show_by_tag(null);
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
