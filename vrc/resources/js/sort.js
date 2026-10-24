// ワールドカードの並び替え.
// 初期状態 (HTML に書かれた順) が「新しい順」. README は常に先頭に固定する.
// 選択は ?sort=old|rate|name でも指定でき, タグの絞り込み (#タグ名) とは独立に動く.
(function() {
  const select = document.getElementById('sort-select');
  const container = document.querySelector('.columns.is-multiline');
  if (!select || !container) return;

  const columns = Array.from(container.getElementsByClassName('world_column'));
  columns.forEach((el, i) => { el.dataset.index = i; });

  const title = (el) => {
    const a = el.querySelector('.card-header-title');
    return a ? a.textContent.trim() : '';
  };
  const rate = (el) => parseInt(el.dataset.rate, 10) || 0;
  const index = (el) => parseInt(el.dataset.index, 10);
  const isReadme = (el) => {
    const card = el.querySelector('.card');
    return card && card.id === 'README';
  };

  const comparators = {
    new: (a, b) => index(a) - index(b),
    old: (a, b) => index(b) - index(a),
    rate: (a, b) => rate(b) - rate(a) || index(a) - index(b),
    name: (a, b) => title(a).localeCompare(title(b), 'ja') || index(a) - index(b),
  };

  function apply(key) {
    if (!comparators[key]) key = 'new';
    const readme = columns.filter(isReadme);
    const rest = columns.filter((el) => !isReadme(el)).sort(comparators[key]);
    for (const el of readme.concat(rest)) container.appendChild(el);
    select.value = key;
  }

  function currentKey() {
    return new URLSearchParams(location.search).get('sort') || 'new';
  }

  select.addEventListener('change', () => {
    const url = new URL(location.href);
    if (select.value === 'new') url.searchParams.delete('sort');
    else url.searchParams.set('sort', select.value);
    history.replaceState(null, '', url.toString());
    apply(select.value);
  });

  apply(currentKey());
})();
