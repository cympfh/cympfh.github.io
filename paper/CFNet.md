% Hybrid Recommender System based on Autoencoders
% https://arxiv.org/abs/1606.07659
% 推薦システム 深層学習

## src

- https://github.com/fstrub95/Autoencoders_cf

## 概要

- 行列分解による協調フィルタリングの行列分解部分をニューラルなネットワークでやる
    - CF のネットだから "CFN"
- 結果は、行列分解による既存手法よりも、僅かに良かった
- cold-start に強いと言っている

## 手法

- 行がユーザー (N) で列がアイテム (M) の rating 行列
- CF はこの行列が含む欠損値を埋める枠組みである
- これは denoising な autoencoder にほかならない

- 行列の 1行 または 1列 $x$ を取ってくる.
    - $x \in \mathbb{R}^N$ or $\in \mathbb{R}^M$
    - "U-CFN", "V-CFN" と呼び分ける
- 入力にはまずノイズ $x \mapsto \tilde{x}$ (corrupted version)
    - ここで言う corrupted の操作が具体的に書かれてない?
    - 都合よく汲み取ってやると、ランダムにインデックスを0個以上選んで、$x_i \leftarrow x_i + noise$

### autoencoder

- $\tilde{x} \mapsto \sigma(W' \sigma(W\tilde{x}+b) +b') \sim x$
    - 2層に限定してるわけではないが、実験では2層
    - loss を $\tilde{x}$ と $x$ の誤差自乗で計算するのだけど、 corrupted したインデックスかどうかで、重みを付けて和を取る
    - あとL2正則化もする

### Integrating Side Information

こっからやばい気がする

- ユーザーやアイテムに関するさらなる情報を用いたい.
- $P$次元情報 $z$ を autoencoder の入力に加える:

$[x;z] \mapsto \sigma(W' [\sigma(W[x;z]+b);z] +b') \sim [x;z]$

ここで $[;]$ はベクトルの連結.

- 強引すぎないか？
- "cold start に強い" って言ってるのは、これのことなんだろうな
- 一般に、"各層で、$z$ を加える" とある
    - $z$ の影響が強すぎるので、$z$ の次元数をかなり抑えるように、ともある

## 実験

- V-CFN
    - 行列の列 (N users * 1 item) で autoencode
- V-CFN++
    - Integrating Side Information を更に乗っける

- Dataset
    - MovieLens
        - 定番らしい
        - [推薦システム用データセットMovieLensについて Wolftail Bounds](http://yag.xyz/blog/2015/10/03/movielens-datasets/)
        - データセットのサイズごとに 1M/10M/20M を使う
- Side Information
    - ユーザー情報: 年齢、性別
        - U-CFN ではこちらを使う
    - 映画情報: カテゴリー、タグ
    - データセットのサイズによって一部使ったり使わなかったりする. ややこしい.

- 結果
    - V-CFN が強い
    - ただし本人たちも言ってるように slightly improvement

## REMARKS

- Torch はいいぞ！
- でもDAEを書くためのモジュールが整備されてないから書いたので使ってくれ
    - [fstrub95/Autoencoders_cf](https://github.com/fstrub95/Autoencoders_cf)
