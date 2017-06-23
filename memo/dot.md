# Dot言語処理系(変換器)

dot言語(あるいはその拡張)から画像へ変換するツールのメモです

## graphviz

[http://www.graphviz.org/](http://www.graphviz.org/)

おそらくに一番古いもの.
純粋にグラフの絵を出力させる目的にはおそらくいちばん最適．

graphvizとは

- dot
- neato
- circo

など複数のプログラムを含むパッケージ名であり，
dotから，ある処理を施したdotへの変換をするプログラムなんかもある．
[Graphvizの非レイアウト系ツールメモ - ならば](http://d.hatena.ne.jp/naraba/20110326/p1)
の参照を強くお薦めする．

正直使い勝手が大変に難しい．
使いこなせれば強いと思うんだけど．

## blockdiag

[ブロック図生成ツール blockdiag — blockdiag 1.0 ドキュメント](http://blockdiag.com/ja/blockdiag/)

graphviz (のdot) の拡張である．
使い方なども基本的にほとんど同じで大変良い感じ．
エッジの描き方 (生え方) が，ブロック図に最適である．
graphviz (のdot) はdotに忠実に枝を生やすだけだけど，
これは始点が同じノードなら途中から分岐させる，とか．
(そういうdotのためのオプションもあるけれど，たぶん面倒)

## Mscgen

[Mscgen: A Message Sequence Chart Renderer](http://www.mcternan.me.uk/mscgen/)

こちらはグラフではなくて，MSC．
まだ使う機会は無さそうだし使ったこと無いけれどメモ程度に．

