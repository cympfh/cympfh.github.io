% Field-aware Factorization Machines for CTR Prediction
% http://www.csie.ntu.edu.tw/~cjlin/papers/ffm.pdf
% 分類器 機械学習 推薦システム

## 概要

[Factorization Machines (FMs)](FM.html) の改良.

FMs では性別だろうが地名だろうがお構いなしに、one hot vector でエンコードしたものを並べたものを入力 $x$ として
$$\phi : \mathbb{R}^N \to \mathbb{R}$$
$$\phi(x) = b + \sum_i w_i x_i + \sum_{i < j} \langle v_i, v_j \rangle x_i x_j$$
としたのだった.
ここで $w_i$ はスカラー値で、$v_i$ は適当な $k$ 次元のベクトル.

FFMs はその入力のフィールド (e.g. 性別, 地名) まで考慮しようというもの.
その分パラメータは増えるが.

## 実装

作者等による
[LIBFFM](https://www.csie.ntu.edu.tw/~cjlin/libffm/)
がある.

この `Download` のとこを見ると

```
Warning: FFM is prone to overfitting. See README in the package before using. 
```

という警告がある. なるほど.

## FFMs

入力 $x$ の成分に関してフィールドが $F$ 個 ($f_1, f_2, \ldots, f_F$) あるとする.
FMs の肝は相互作用
$\langle v_i, v_j \rangle$
であるが、これに、相手のフィールドを考慮させる.
すなわち、$x_i$ に対応するベクトル $v_i$ に、どのフィールドへの作用かの情報を持たせる.
今まで $v_i$ 一個だったのを、
$$v_{i,1}, \ldots, v_{i,f}$$
と、$F$ 個にして、
$$\phi(x) = b + \sum_i w_i x_i + \sum_{i < j} \langle v_{i,f_j}, v_{j,f_i} \rangle x_i x_j$$
とする.
ここで $f_j, f_i$ はそれぞれ、$x_j, x_i$ に対応するフィールド.
$v_{i, f_j}$ は $x_i$ のフィールド $f_j$ への作用に相当する.

## パラメータ数、計算量

パラメータ数は FMs が $nk$ だったのに対して $nFk$ 個になる.
計算量は FMs では素朴に実装して $O(n^2k)$ 、最適化して $O(nk)$ であったが、
FFMs では特に最適化は提示されておらず、$O(n^2k)$ のままとなる.

