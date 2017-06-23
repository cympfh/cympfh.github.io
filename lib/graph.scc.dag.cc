/*
 * "DAG に潰す" ということをしたい。
 * scc によって、グラフは頂点数 scc.K の DAG になったと考えられる。
 * scc.dag() は、その DAG の隣接グラフを返す。
 * 隣接リストにする場合は、
 *
 * 重複を除いて、リストに追加する必要があるだろう
 *
 */

  StronglyConnectedComponents scc(d);
  
  cout << scc.K << endl;
  auto dag = scc.dag();
  rep (i, scc.K) {
    cout << dag[i] << endl;
  }
