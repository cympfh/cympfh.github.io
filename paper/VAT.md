% Virtual Adversarial Training
% https://arxiv.org/abs/1507.00677
% 物体検出 深層学習

## 概要

画像を入力、出力をクラスごとの確率分布とするような所謂画像認識を考える.
十分に訓練させた画像認識モデルは入力に対して予測分布が急峻となる問題がある.
すなわち、入力に鋭敏で、人の目にはほとんど変化がないようなノイズを加えただけでも予測が急激に変化することがある.
これは本来、不自然なことで、適切な汎化性能を持ったモデルとは言えない.

## Adversarial Example

自然画像 $x$ に対して予測分布 $y=f(x)$.

適当なノイズ $e$ が加わった場合の予測:
$$y' = f(x + e)$$

出力は確率分布なので、予測の乖離は $\delta_e = \text{KL}(f(x) \| f(x+e))$ で測れる.
これが本来小さくあるべき.

ノイズに何にも制限がないといくらでも $\delta$ は大きくなって当然なので、
ノルムに関して制限を与える.
適当な定数 $\epsilon$ を以って

$$\| e \| \leq \epsilon$$

とする.

ノイズをランダムに生成しても大した $\delta$ にはならないが、
ちゃんと計算して作ると大きくなる.

$$e_{ad} = \text{arg max}_{\|e\| \leq \epsilon} \text{KL}(f(x) \| f(x + e))$$

このようなノイズを加えた

$$x_{ad} = x + e_{ad}$$

を、adversarial example という.

### adversarial example の作り方

次のような方法で近似的に $e_{ad}$ が求まる.

1. 単位ベクトル $d$ をランダムに生成
1. 次を $I_p$ 回繰り返す ( $I_p$ は十分大きいほど精度が良いが $1$ 回やれば十分という話がある)
    - $d \leftarrow \text{grad}_d \text{KL}(f(x) \| f(x + \xi d))$ ( $\xi$ は適当な定数, $10$ くらい)
    - $d \leftarrow d / \|d\|$
1. $e_{ad} = \epsilon d$

## Adversarial Training

先行研究の Adversarial Training では、

$$(x, y)$$

の訓練の際に、

$$(x + e_{ad}, y)$$

を新たな事例として加えて学習する、という使い方をした.

## Virtual Adversarial Training (VAT)

本研究は教師ナシ学習に adversarial example を用いる.
全体として半教師学習にする.

### 教師アリ部分

普通に $(x, y)$ を学習する.

### 教師ナシ部分

ラベルなしデータ $x$ から adversarial example $x_{ad}$ を作って

$$\text{KL}(f(x), f(x_{ad}))$$

を正則化項として付け加える.
すなわち、この KL を最小化することで $f(x)$ の周りの予測分布の滑らかさを要請して汎化性能を上げる.

## 実装

https://github.com/cympfh/MNIST-etude/blob/master/chainer/vat.py

