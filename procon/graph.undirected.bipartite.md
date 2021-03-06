# 無向グラフ - 二部グラフ判定

## 概要

与えられた無向グラフが二部グラフであるかどうか判定する.

## 参考

- [二部グラフ判定をUnionFindTreeで行う - noshi91のメモ](http://noshi91.hatenablog.com/entry/2018/04/17/183132)

## アルゴリズムの詳細

参考に書いてあるとおりにやる.

すなわち, 頂点 $u$ がグループ $1,2$ にあることを表す述語 $P^1(u), P^2(u)$ を用意して,
エッジ $e = (u, v)$ を
$(P^1(u) \land P^2(v)) \lor (P^2(u) \land P^1(v))$
と解釈して論理グラフを組み立てて（頂点が命題で連結なときには同時に成り立つ）,
最後に矛盾 ($P^1(u) \land P^2(u)$) が無いことを確認する.

## 実装

論理グラフは同じグラフに所属するかだけが問題なので, これを UnionFind で実装する.

@[rust](procon-rs/src/graph/undirected/is_bigraph.rs)
