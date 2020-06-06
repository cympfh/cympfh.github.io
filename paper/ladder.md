% Semi-Supervised Learning with Ladder Networks
% https://arxiv.org/abs/1507.02672
% 深層学習 半教師アリ学習

## 参考

- [NIPS2015読み会: Ladder Networks](http://www.slideshare.net/eiichimatsumoto106/nips2015-ladder-network)


## 関連

- Deconstructing the Ladder Network Architecture (2016)
    - Ladder Network の各部品を除去したり交換したりして、どこが貢献しているのかを調べる
    - 全部品良い
    - ただし combinator の部分はMLPにしたほうがいい場合があった
- A Semisupervised Approach for Language Identification based on Ladder Network
    - 音声を入力に何語であるかを推定するのに Ladder Network を使った
    - 音声は i-vector (その筋の定番) に変換したものを入力にした


## 概要

- Ladder Networks (Valpola, 2015)
    - ノイズへの頑強を目指す (denoising)
    - もともと教師ナシ学習を想定
        - ノイズあり x' からオリジナル x の推定
- この論文では、組み合わせて半教師アリに適用させる
    -  まさにスライドの p.25 だ
- たぶん先に普通の教師アリでパラメータを訓練すると書いてある

## 手法

- 所謂普通のネットワーク (`:: x -> y`) を Encoder と呼ぶ
    - 実際には制限は無いが、簡単のため、$N$ 層のMLPを想定する
        - 第 $i$ 層での値を $z_i$、活性化したあとのそれを $h_i$ とする.
        - ただし、$x = z_0 = h_0$, $z_n = h_n = y$
    - 各 $z_i$ は正規化しませう
        - 平均 0 分散 1
    - オプションとして、各層ではノイズを加えられることにする
        - $z_i$ は (正規化した直後) 正規分布に乗ったノイズが乗る
- Encoder をちょうど逆に辿るような Decoder を想定する
    - Decoder とは、 Encoder における各層にそれぞれ denoiser を並べたものである
    - 第 $i$ 層にある denoiser は、$z_i, u_{i+1}$ から $u_i$ を求めるもの
        - $z_i$ とは Encoder によって計算される (ノイズが加わった) 値
        - $u_i$ とは、$z_i$ (からノイズを除いたもの) を近似するものである
        - ただし $y = u_n$

### 学習

- 学習には2種類ある
    - すなわち、ラベルありの学習事例 $(x, y)$ を用いるものと、
    - ラベルなしの学習事例 (ただの $x$) だけを用いるものである
- 教師アリ
    - $(x, y)$ を用いる
    - ノイズの入ったEncoder で $y'$ を計算して $y$ との差で訓練
- 教師ナシ
    - $x$ を用いる
    - ノイズの入った Encoder で $y'$ を計算
    - Decoder で $y'$ から $x'$ を計算
    - Decoder における各層での $u_i$ と、ノイズのない Encoder での $z_i$ との差で訓練

## 実装

- mattya さんによる Python 2.x/chainer な実装がある
    - https://github.com/mattya/chainer-semi-supervised
