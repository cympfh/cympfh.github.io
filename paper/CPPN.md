% Compositional Pattern Producing Networks
% http://eplex.cs.ucf.edu/papers/stanley_gpem07.pdf
% 画像生成

## 概要

ラスタ画像（二次元ピクセル）の生成であって逆畳み込みに頼らない方法.
座標そのものを受け取ってそのピクセルを返すような関数を構成することを目指す.

## 手法

座標 $x,y$ 及びそれから得られる特徴量 $g^i(x,y)$ を受け取ってピクセルを返す関数
$$f(x, y, g^1(x, y), \ldots, g^m(x, y))$$
をNNで構成する.
出来上がる画像は NN 関数の三次元プロットみたいな感じになる.

また $g^i$ として, 定数 $1$, 画像の中心からの距離 $r = \sqrt{(x-m_x)^2 + (y-m_y)^2}$ や角度.
また周期的な模様を出力するために $\sin(x)$ なども.

## 応用

入力に余計な乱数 $z$ を付け足して GAN をすることが考えられる.

- [Compositional Pattern Producing GAN](https://nips2017creativity.github.io/doc/CPPNGAN.pdf)
- [hardmaru/cppn-gan-vae-tensorflow](https://github.com/hardmaru/cppn-gan-vae-tensorflow)
