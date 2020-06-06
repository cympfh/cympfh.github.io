# t-SNE による高次元データの可視化

## 参考

- [sklearn.manifold.TSNE — scikit-learn 0.18.1 documentation](http://scikit-learn.org/stable/modules/generated/sklearn.manifold.TSNE.html)

## 概要

3次元でもやっとなのにそれ以上の次元のデータをプロットするにはどうにか次元削減をしないといけない.
t-SNE はそのための一つの手法.
Python ライブラリの scikit-learn の中に実装があるのでそれを使う.
t-SNE して可視化するまでの一連をツールとして書いた.

本当はプロットするところは matplotlib を使おうと思ったけど gnuplot が当たり前にやってくれることが全然出来なくて酷いので gnuplot を使う.
特に点が混み合うような散布図を書くと、ユーザーが対話的に拡大したら移動したりしたくなる.
terminal に Qt (あるいは X11 等) を使うとそれが可能なので便利.

## 実装

- [https://gist.github.com/cympfh/2c970e4656f52adf57f91483f9b1e75c](https://gist.github.com/cympfh/2c970e4656f52adf57f91483f9b1e75c)
    - tsne-vis.py
        - データを読んで t-sne した結果を吐き出す
        - あるいは一時ファイルとして吐き出して即座に gnulot を実行する
    - usage.sh
        - 使ってみるサンプルです

## 依存

- Python 3.6 (3.x なら大丈夫だろう)
- sklearn
    - t-sne はこれのものを用いた
    - pip で入る
- click
    - CLI ライブラリ
    - pip で入る

## 使い方

```bash
   ./tsne.vis.py --help
Usage: tsne.vis.py [OPTIONS]

Options:
  -d TEXT              deliminator between the label and its vector
  -c TEXT              deliminator for the vector
  --dim INTEGER RANGE
  -o, --output TEXT    When no --output is specified, run gnuplot/Qt directly
  --help               Show this message and exit.
```

### データフォーマット

```
<DATA> ::= <LINES>
<LINES> ::= <LINE> | <LINE> "\n" <LINES>
<LINE> ::= <LABEL> <D> <VECTOR>

<LABEL> ::= string
<D> ::= "\t" (-d で変更可能)

<VECTOR> ::= float | float <C> <VECTOR>
<C> ::= " " (-c で変更可能)
```

ラベルはプロット点にアノテートするのに使う.
要らないなら 'x' とか指定すればいい.

### 埋め込み次元

`--dim` では何次元空間に埋め込むかを指定する.
`2` か `3` かが指定できてデフォルトは `2`.

### 出力

gnuplot で可視化するまでの工程を任せる場合は `-o` を指定しない.
埋め込むデータが必要な場合は `-o` で出力先を指定する.

