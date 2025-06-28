/*

  以下を埋め込むと H2 タグを列挙してそれぞれへのリンクにする.
  ただし "INDEX" は除外する.

    <div id=toc></div>


  H2, H3 タグまでを列挙するには以下を埋め込む.

    <div id=toc-level-2></div>

*/
(function() {

  function naming(obj, name) {
      var PREF = document.createElement('a');
      PREF.name = name;
      obj.appendChild(PREF);
  }

  function level1() {

    var sections = document.getElementsByTagName('h2');
    var OL = document.createElement('ol');
    for (var i=0; i < sections.length; ++i) {
      var LI = document.createElement('li');
      var A = document.createElement('a');
      A.innerHTML = sections[i].innerHTML;
      if (A.innerHTML.toUpperCase() == 'INDEX') continue;
      A.href = '#' + i;
      LI.appendChild(A);
      OL.appendChild(LI);
      naming(sections[i], i);
      // var PREF = document.createElement('a');
      // PREF.name = i;
      // sections[i].appendChild(PREF);
    }

    return OL;
  }

  function level2() {

    var sections = document.querySelectorAll('h2,h3');
    var tree = [];
    for (var i = 0; i < sections.length; ++i) {
      if (sections[i].tagName == 'H2') {
        if (sections[i].innerHTML.toUpperCase() === 'INDEX') continue;
        tree.push([sections[i]]);
      } else {
        if (tree.length > 0) {
          tree[tree.length-1].push(sections[i]);
        } else {
          tree.push([sections[i]]);
        }
      }
    }

    var OL = document.createElement('ol');
    for (var i = 0; i < tree.length; ++i) {

      // h2-level
      var LI = document.createElement('li');
      var A = document.createElement('a');
      A.innerHTML = tree[i][0].innerHTML;
      A.href = '#' + i;
      naming(tree[i][0], i);
      LI.appendChild(A);

      // h3-level
      if (tree[i].length > 1) {
        var OL_sub = document.createElement('ol');
        for (var j = 1; j < tree[i].length; ++j) {
          var LI_sub = document.createElement('li');
          var A = document.createElement('a');
          A.innerHTML = tree[i][j].innerHTML;
          A.href = `#${i}-${j}`;
          naming(tree[i][j], `${i}-${j}`);
          LI_sub.appendChild(A);
          OL_sub.appendChild(LI_sub);
        }
        LI.appendChild(OL_sub);
      }

      OL.appendChild(LI);
    }

    return OL;
  }

  function append_toc() {
    if (document.getElementById('toc')) {
      document.getElementById('toc').appendChild(level1());
    }
    if (document.getElementById('toc-level-2')) {
      document.getElementById('toc-level-2').appendChild(level2());
    }
  }

  window.addEventListener('DOMContentLoaded', append_toc, false);
}());
