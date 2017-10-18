% Swish: a Self-Gated Activation Function
% https://arxiv.org/abs/1710.05941
% 活性化関数 深層学習

## 概要

- 新しい活性化関数 Swish の提案
- それは $f(x)=x \sigma(x)$ で表されるようなものでグラフは下図
    - この亜種として Swish-$\beta$, $f(x;\beta) = 2x \sigma(\beta x)$
- 明らかにこれは relu の亜種であるので、 relu を使っているような場面で Swish は候補の1つとなる

```gnuplot
set grid
set xrange [-5: 8]
sigmoid(x) = 1/(1+exp(-x))
plot sigmoid(x), x * sigmoid(x)
```

## 実験

いくつかの実験で活性化関数を戦わせて Swish の良さを主張している.

1. MNIST/fully-connected (not CNN)
    - 層数を増やしすぎると性能が悪くなるが relu と較べて悪くなり方がマシ
1. CIFAR-10/ResNet-32
    - バッチサイズを増やしすぎると性能が悪くなるが relu と較べて悪くなり方がマシ
1. ImageNet/various networks
    - どの活性化関数でもチューニングを施すと、どんぐりの背比べではあるが swish が最善である場合がいくつかある
    - (これは苦しい主張に見える)

## 感想

使う活性化関数の候補の1つにはなり得るが、今までもそうであったように、どの活性化関数使っても基本的に性能は大きくは変わらない.
どれがいつも最良の結果である、ということもなく、場合場合で違う.
