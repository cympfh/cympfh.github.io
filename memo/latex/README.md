% LaTeX

書籍やネットの情報の多さから、platexを処理系に使う.

## 処理系
### debian

`This is e-pTeX, Version 3.1415926-p3.3-110825-2.4 (utf8.euc) (TeX Live 2012/Debian)`

jsaiのフォーマットをこれでコンパイルすると目次が出ないということがあったので、できればUbuntu版を使いたい.

## 参考
### 書籍
- [［改訂第6版］LaTeX2e 美文書作成入門](http://oku.edu.mie-u.ac.jp/~okumura/bibun6/)

## ソースコードの埋め込み

### 擬似コード
`algorithmic.sty` を用いる.
tex-live には入ってないので、毎回、styを拾ってきては、
同じディレクトリに入れて使ってる.

### 現実のコードにシンタックスハイライトを付ける
`listings` を用いる.
これは tex-live に標準で入っている.

```latex
\usepackage{ascmac,here,txfonts,txfonts}
\usepackage{listings}
\usepackage{color}
```

このくらいが必要

### 例
- [tex](./listings.tex)
- [pdf](./listings.pdf)

