% EMNIST でやっていく
% 2017-03-08 (Wed.)
% 日記
%

## INDEX

<div id="toc"></div>
## あらまし

[EMNIST](https://www.westernsydney.edu.au/bens/home/reproducible_research/emnist)
は MNIST の拡張で、digit (0-9) に加えて、大小英字が加わっている.
従って合計で、 $10+26+26=62$ のクラスが在ることになる.

とは言え、MNIST と比較して文字あたりの画像枚数は多くない.
具体的な内訳は
[https://arxiv.org/pdf/1702.05373.pdf](https://arxiv.org/pdf/1702.05373.pdf)
の Fig.2 にある.
枚数を稼ぐために、幾つかの文字については、大小文字を同一視している.
"c" と "C" のように、見た目が似てるものだけについてこのマージを行っており、この場合は合計で 47 クラスがある.

### 参考

- [EMNIST | Western Sydney University](https://www.westernsydney.edu.au/bens/home/reproducible_research/emnist)
    - [Manuscript (pdf)](https://arxiv.org/pdf/1702.05373.pdf)
- [【機械学習】Python3 + scikit-learn で識別率99%の手書き数字の分類器を作った - 株式会社クイックのWebサービス開発blog](http://aimstogeek.hatenablog.com/entry/2016/03/27/190548)

## レポジトリ

- [cympfh/EMNIST](https://github.com/cympfh/EMNIST/)

各小題の後ろにあるファイル名はこのレポジトリの中のファイル.


## データセットの利用

[EMNIST | Western Sydney University](https://www.westernsydney.edu.au/bens/home/reproducible_research/emnist)
から "The database in original MNIST format" をダウンロードし、解凍できるだけ解凍をすると、

```
desktop.ini
emnist-balanced-mapping.txt
emnist-balanced-test-images-idx3-ubyte
emnist-balanced-test-labels-idx1-ubyte
emnist-balanced-train-images-idx3-ubyte
emnist-balanced-train-labels-idx1-ubyte
emnist-byclass-mapping.txt
emnist-byclass-test-images-idx3-ubyte
emnist-byclass-test-labels-idx1-ubyte
emnist-byclass-train-images-idx3-ubyte
emnist-byclass-train-labels-idx1-ubyte
emnist-bymerge-mapping.txt
emnist-bymerge-test-images-idx3-ubyte
emnist-bymerge-test-labels-idx1-ubyte
emnist-bymerge-train-images-idx3-ubyte
emnist-bymerge-train-labels-idx1-ubyte
emnist-digits-mapping.txt
emnist-digits-test-images-idx3-ubyte
emnist-digits-test-labels-idx1-ubyte
emnist-digits-train-images-idx3-ubyte
emnist-digits-train-labels-idx1-ubyte
emnist-letters-mapping.txt
emnist-letters-test-images-idx3-ubyte
emnist-letters-test-labels-idx1-ubyte
emnist-letters-train-images-idx3-ubyte
emnist-letters-train-labels-idx1-ubyte
emnist-mnist-mapping.txt
emnist-mnist-test-images-idx3-ubyte
emnist-mnist-test-labels-idx1-ubyte
emnist-mnist-train-images-idx3-ubyte
emnist-mnist-train-labels-idx1-ubyte
```

を得る.
マージを行っていてかつ、文字ごとの枚数を均一化されたデータである `emnist-balanced-*-*-*-ubyte` を今回は利用する.

この (バイナリ）ファイルを Python プログラムから直接読もうと思ったけど上手く行かなかったので、
[【機械学習】Python3 + scikit-learn で識別率99%の手書き数字の分類器を作った - 株式会社クイックのWebサービス開発blog](http://aimstogeek.hatenablog.com/entry/2016/03/27/190548)
にあったワンラインのシェルスクリプトを使うことにする.

```bash
DATA_ROOT=/mnt/dataset/EMNIST/

cat $DATA_ROOT/emnist-balanced-test-labels-idx1-ubyte | od -An -v -tu1 -j8 -w1 | tr -d ' ' > $DATA_ROOT/emnist-balanced-test-labels-idx1-txt
cat $DATA_ROOT/emnist-balanced-test-images-idx3-ubyte | od -An -v -tu1 -j16 -w784 | sed 's/^ *//' | tr -s ' ' > $DATA_ROOT/emnist-balanced-test-images-idx3-txt

cat $DATA_ROOT/emnist-balanced-train-labels-idx1-ubyte | od -An -v -tu1 -j8 -w1 | tr -d ' ' > $DATA_ROOT/emnist-balanced-train-labels-idx1-txt
cat $DATA_ROOT/emnist-balanced-train-images-idx3-ubyte | od -An -v -tu1 -j16 -w784 | sed 's/^ *//' | tr -s ' ' > $DATA_ROOT/emnist-balanced-train-images-idx3-txt
```

`*-ubyte` とかよくわからんファイルの代わりに `*-txt` を読むことにする.

### データセットを読むライブラリ (`dataset.py`)

を予め作っておくと便利.
具体的には先程作ったテキストファイルを numpy 配列にする.
テキストファイルから読む作業はそれなりに時間がかかる (1分程度) ので、一度 numpy 配列を作ったら npz 形式でキャッシュとして保存しておく.

あとで気づいたが、画像の xy 方向が直感と逆だった.
予め transpose したほうがいいかもしれないけど、しないで作ったデータをキャッシュしてたからひとまず無視.

## オートエンコーダ (`autoencoder.py`)

何はともあれ、オートエンコーダを作る.

入力は $255$ で予め割っておくことにしたので (`dataset.load_emnist` にそのようなフラグを持たせておいた)、
$[0, 1]^{28 \times 28}$.
これを `Encoder` によって中間表現 $\mathbb{R}^{32}$ に落として、 `Decoder` によって元の入力を復元する.
`Encoder` の構成は、活性化が全て `relu` であるような畳み込み層をいくつか重ねて、最後に活性化関数のない (或いは線形) 全結合層を重ねている.

$$[0, 1]^{28 \times 28} \to \mathbb{R}^{32} \to [0, 1]^{28 \times 28}$$

損失関数に mse を用いるのは素人で、`binary_cross_entropy` を使う.
これは、各ピクセルを、 $[0, 1]$ ピクセルが $1$ である **確率** だと考えているのである.

> ちなみに、Python スクリプトを手軽に CLI コマンドにするための `click` を最近愛用していて、今回も利用している.
> `python ./autoencoder.py train` で訓練、
> `python ./autoencoder.py test` でテストを行う.
> 一つのファイルにしておくと、ライブラリにファイル分割する作業をサボれるので楽.

#### 学習曲線

![](http://i.imgur.com/XaT6Xa5.png)

100 epoch 回して 61 epoch で最良を得た.

#### テスト

モーフィングを行った.

![](http://i.imgur.com/ZRRVFGV.png)

見方としては、行毎に独立の実行で、最も左と最も右は、実際のテストデータからオートエンコーダで復元したもの.
その間は、中間表現を代数的に平均を取り、デコードして得たもの.

もちろん、ニューラルネットワークは連続関数にほかならないので、
中間値を入力すれば、中間の出力を得ることが出来る.
しかしながら得られるものは、手書き文字ではない何かである.
すなわち、実際の手書き文字全体 $\mathcal{X}$ を逸脱する.

