function idf(n) {
  var N = data.images.length + 1;
  return Math.log(N / n);
}

/// String -> [Url]
function filter(query) {
  var i, j, k;
  var vote = {};

  query.toLowerCase().split(/[ \t　]/).forEach(function (q) {
    for (j = 0; j < q.length; ++j) {
      var gram = [];
      for (k = 0; k < 5; ++k) {
        if (j + k >= q.length) break;
        gram.push(q[j+k]);
        var ngram = gram.join('');
        if (!data.ngrams[ngram]) { continue; }
        var indices = data.ngrams[ngram];
        indices.forEach(function (idx) {
          if (vote[idx]) {
            vote[idx] += idf(indices.length);
          } else {
            vote[idx] = idf(indices.length);
          }
        });
      }
    }
  });

  var result = [];
  for (idx in vote) {
    result.push([idx, vote[idx]]);
  }
  result.sort(function (a, b) { return b[1] - a[1]; }); // 降順
  if (result.length < 10) {
    return result.map(function (a) { return a[0]; });
  }
  var threshold = result[1][1]/3.2;
  result = result.filter(function (a) { return a[1] >= threshold; });
  return result.map(function (a) { return a[0]; });
}
