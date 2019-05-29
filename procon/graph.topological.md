% graph.topological

有向グラフのトポロジカルソートを行う

## 参考

- [wikipedia:ja/トポロジカルソート](http://ja.wikipedia.org/wiki/トポロジカルソート)

## [graph.topological.rs](graph.topological.rs)

- 入力:
    - 隣接リスト `neigh`
    - `Topological::new(&neigh)`
- 出力
    - 行き順 `self.ord`
    - `let Topological(ord)`

@[rust](graph.topological.rs)

## [graph.topological.cc](graph.topological.cc)

- 入力;
    - 隣接リスト `d`
- 出力;
    - 行き順 `this.L`

@[cpp](graph.topological.cc)

## 例題 (その回答例)

- [#182117 No.497 入れ子の箱 - yukicoder](https://yukicoder.me/submissions/182117)
- [code-thanks-festival-2014-a-open.contest.atcoder.jp/submissions/294748](http://code-thanks-festival-2014-a-open.contest.atcoder.jp/submissions/294748)
