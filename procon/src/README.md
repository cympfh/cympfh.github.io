# 代数

- [モノイド](algebra.monoid.md)
    - [Min/Max モノイド](algebra.monoid.minmax.md)
    - [Sum モノイド](algebra.monoid.sum.md)
- [(乗法)群と加法群](algebra.group.md)
- [環](algebra.ring.md)
- [体](algebra.field.md)
- [加群](algebra.module.md)
- [有理数](algebra.ratio.md)
- [虚数](algebra.complex.md)
- [行列](algebra.matrix.md)
- [超数](algebra.hyper.md)
- [全順序化](algebra.total.md)
- [ModInt](algebra.modint.md)
- [作用](algebra.act.md)
    - [代入作用](algebra.act.assign.md)
    - [加算作用](algebra.act.add.md)

# グラフ

## 最短路
- [ダイクストラ法](graph.dij.md)
- [ワーシャル-フロイド法](graph.wall.md)
- [ベルマンフォード法](graph.bellmanford.md)

## 無向グラフ
- [二部グラフ判定](graph.undirected.bipartite.md)
- [直径](graph.undirected.diameter.md)

## 最小全域木
- [プリム法](graph.prim.md)
- [クラスカル法](graph.kruskal.md)

## 木
- [高さ](graph.tree.height.md)
- [直径](graph.tree.diameter.md)
- [最小共通祖先](graph.tree.lca.md)

## 有向グラフ
- [最大流量](graph.maxflow.md)
- [トポロジカルソート](graph.topological.md)
- [強連結成分分解](graph.scc.md)

# 数列

- [最長増加部分列](seq.lis.md)
- [中央値ヒープ](seq.median.md)
- [スライド最小値](seq.slide_min.md)
- [BitVecBool](seq.bitvecbool.md)

## 累積処理

- [一次元累積和](seq.cumsum1d.md)
- [二次元累積和](seq.cumsum2d.md)

## 区間木

- [BIT](seq.bit.md)
    - [累積和に関するBIT](seq.bit_cumulative.md)
- [セグメントツリー](seq.segment_tree.md)
    - [RMQ](seq.rmq.md)
    - [加法セグメントツリー](seq.segment_tree_sum.md)
    - [乗法セグメントツリー](seq.segment_tree_prod.md)
- [遅延セグメントツリー](seq.lazy_segment_tree.md)
    - [区間代入 RMQ](seq.ranged_assign_rmq.md)
    - [区間加算 RMQ](seq.ranged_add_rmq.md)
    - [区間加算 加法セグメントツリー](seq.ranged_add_segment_tree_sum.md)

# 二次元ユークリッド幾何

## 図形の定義

- [点](geo.2d.point.md)
- [直線, 線分](geo.2d.line.md)
- [多角形](geo.2d.polygon.md)
- [円](geo.2d.circle.md)

## 線分
- [線分と点の接触判定](geo.2d.ccw.md)
- [線分と線分の交差判定](geo.2d.intersection.md)

## 多角形
- [三角形の外接円](geo.2d.circum.md)
- [多角形の内外判定](geo.2d.isin_poly.md)
- [凸包](geo.2d.convex_hull.md)

## 円
- [円と円との接触関係](geo.2d.circle.intersection.md)

## 最近点対
- [平面上の分割統治法](geo.closest_pair.md)

## その他

- [極座標](geo.polar.md)
- [Convex-Hull Trick (CHT)](geo.cht.md)

## 格子点上の幾何

- [点](geo.2d.int.point.md)
- [直線](geo.2d.int.line.md)

# 集合
- [UnionFind](set.union_find.md)
- [BitSet](set.bitset.md)
- [部分集合及びその部分集合の列挙](set.subbitset.md)
- [多重集合](collections.multiset.md)

# アルゴリズム

## 動的計画法
- [01-ナップザック](dp.knapsack.01.md)

## 二分探索
- [二分探索](bin.search.md)

## フーリエ変換
- [畳み込み](fft.convolution.md)

## 循環検出
- [フロイドの$\rho$アルゴリズム](algorithm.rho.md)

## 連立一次方程式
- [Gauss-Jordan の消去法](algorithm.gauss_jordan.md)

# 最適化

- [燃やす埋める問題](opt.moyasu_umeru.md)

# 自然数/整数

## 関数

- [GCD](num.gcd.md)
- [拡張GCD](num.exgcd.md)
- [二項係数 (パスカルの三角形)](num.binom.pascal.md)
- [二項係数 (ModInt)](num.binom.modint.md)
- [離散対数](num.dislog.md)
- [完全順列](num.derangement.md)
- [オイラーの関数](num.euler_phi.md)
- [メビウス関数](num.moebius.md)
- [自然数の対 ↔ 自然数 の変換](num.n_vs_nn.md)
- [最小自由数 (最小除外数)](num.mex.md)

## 素数

- [エラトステネスの篩](prime.sieve.md)
- [ミラー・ラビン素数判定](prime.MillerRabin.md)
- [フェルマーの小定理](prime.fermat.little.md)
- [素因数分解](prime.factorize.md)

## その他定理
- [中国人剰余定理](num.chinese.md)

## 多倍長
- [ビッグエンディアンベクタ](bigint.md)

## 組み合わせのイテレーター

- [階乗 - $n!$](num.iter.perm.md)
- [冪乗 - $n^m$](num.iter.powperm.md)
- [二項係数 - ${}_nC{}_m$](num.iter.comb.md)

## 乱数

- [線形合同法](rand.lcg.md)
- [Xor-Shift 法](rand.xorshift.md)

# 文字列 (Vector)

- [接尾辞配列](string.suffix-array.md)

## 文字列検索
- [Shift-And](string.shift-and.md)
- [Z-alogirhtm](string.z.md)
- [接尾辞配列による文字列検索](string.sa-search.md)

## 回文
- [manacher](string.manacher.md)

## 圧縮
- [Run-length](string.runlength.md)

# 時間/時刻

- [制限時間付きループ](time.while.md)

## 暦
- [ツェラーの公式](cal.zeller.md)
- [閏年判定](cal.uruu.md)

# ハッシュ

- [Zobrist Hash](hash.zobrist.md)
- [Rolling Hash](hash.rolling.md)

# collections

- [defaultmap](collections.defaultdict.md)
- [リスト内包表記マクロ](collections.list_comprehension_macro.md)

# misc
- [k-means](misc.kmeans.md)
- [一般化15パズル](15puzzle.md)
- [numeric sort](misc.sort-n.md)
- [乱択3-SAT](misc.3sat.md)
- [スターリングの近似式](misc.stirling.md)
- [サイコロ](dice.md)
- [近傍](misc.neighbor.md)
- [2-SAT](misc.two_sat.md)
- [座標圧縮](misc.coodinate_compression.md)
