void wall(vvi&d) {
  int n = d.size();
  rep (k, n) rep (i, n) rep (j, n)
    d[i][j] = min(d[i][j], d[i][k] + d[k][j]);
}
