% Bag of Tricks for Efficient Text Classification (FastText)
% https://arxiv.org/abs/1607.01759
% 自然言語処理 テキスト分類

## src

- [[https://github.com/facebookresearch/fasttext]]

## 概要

自然言語処理の文書分類など.
GPUでがんがんディープラーニングとかじゃなくて、普通にCPUで一分程度の処理で済まそうぜ.

分類目的なら文書の表現はBoWで十分.
とは言え線形分類やSVMでは汎用性に問題がある.

## モデル

word2vecでお馴染みの CBOW [Mikolov; 2013] (Mikolov も共著に入ってる) を参考にしたというモデル.
ほんとかよ.

- ドキュメントをBoW $x \in \{0,1\}^V$ で表現する ($V$ は語彙サイズ)
- ドキュメントを $k$ クラスに分類したい
- $N$ 個のドキュメント $x_1, x_2, \ldots, x_N$
    - 各ラベル $y_1, y_2, \ldots, y_N \in \{0,1\}^k$

次の最小化を目指す:

$$- \frac{1}{N} \sum_n y_n \log f(BAx_n)$$

ここで $f$ は softmax 関数.
$A, B$ は重み行列.
要するにニューラルネットの全結合層が2つあって softmax するだけ.


```python
class FastText(chainer.Chain):

    """
    なんの高速化テクも使ってないのでFastと名乗ってはダメだけど
    """

    def __init__(self, n, m, k):
        super().__init__(
            a=chainer.links.Linear(n, m, nobias=True),
            b=chainer.links.Linear(m, k, nobias=True),
        )

    def __call__(self, x, y=None):
        h = self.b(self.a(x))
        if y is None:
            h = chainer.functions.softmax(h)
            return h
        h = chainer.functions.log_softmax(h)
        loss = chainer.functions.sum(-y * h) / x.data.shape[0]
        return loss
```

最適化はSGDとかで.

### テクニック

1. hierarchical softmax
    - ようわからん. softmax の計算が速くなる？
    - [Goodman, 2001]
1. bag-of-ngram
    - ngram の multiple-set
1. hashing trick
    - n-gram マッピングの高速化
    - [Weinberger et al, 2009]
    - [Mikolov et al, 2011]

## やっぱよくわからん

間に活性化を挟まない全結合層が2つ並んでても意味ないでしょ.
1つあるのと等価のはず.
ああでも、一応計算量的には意味がある.
