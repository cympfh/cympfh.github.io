% Recurrent Additive Network (RAN)
% http://www.kentonl.com/pub/llz.2017.pdf
% 深層学習

## 概要

LSTMよりもさらに単純化した再帰型ネットワークのための構造の提案.
LSTM よりパラメータ数は 3/5 程度でありながら、タスクに依っては性能が上回る.

## 提案手法

セルは状態 $c_{t-1} \in \mathbb{R}^m$ 一つを持つ.
入力 $x_t$ に対して次の手続きによって状態を $c_t$ に遷移し、$h_t$ を出力する.

- $\tilde{c} = W_0 x$
- $i = \sigma(W_1 c_{t-1} + W_2 x_t)$ (input)
- $f = \sigma(W_3 c_{t-1} + W_4 x_t)$ (forget)
- $c_t = i \circ \tilde{c} + f \circ c_{t-1}$ (要素ごとの積)
- $h_t = \tanh(c_t)$ (output)

$\tilde{c}$ は content layer と呼ばれ主に入力の次元を内部状態の次元に揃えるためにあるが、
気にせず次元を揃えるならば $\tilde{c} = x$ としてしまっても良いそう.
