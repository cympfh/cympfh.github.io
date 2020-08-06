% CD圏の条件付き独立性
% 2020-08-06 (Thu.)
% 確率論 CD圏 マルコフ圏

$\def\Hom{\mathrm{Hom}}\def\C{\mathcal C}$
$\def\independent{\mathrel{\perp\mkern-10mu\perp}}$
$\def\p#1#2{p_{#1 \mid #2}}$
$\def\and{\mkern5mu\mathrm{and}\mkern5mu}$

## disintegration 可能な affine CD 圏での条件付き独立性

disintegration が許される affine CD 圏 $\C$ を考える.
暗黙にここに登場する確率変数に対応する対象すべての同時確率を与える状態
$\omega \colon I \to X_1 \otimes X_2 \otimes \cdots \otimes X_N$
があるとする.
例えば $P(x)$ 相当の状態 $I \to X$ はこれを適切に周辺化すれば自然に手に入る.
そこで, これを用いて [前回](cd-category-almost-equality.html) 定義した $\sim_\sigma$ や $\sim_\sigma'$ は単に $\sim$ と書く.

また適当に disintegration することで自由に
$f \colon X_1 \otimes \cdots \otimes X_n \to Y_1 \otimes \cdots \otimes Y_m$
も手に入る.
このような射を $\p{Y_1,\ldots,Y_m}{X_1,\ldots,X_n}$ と書くことにする.

同様に状態
$I \to X_1 \otimes \cdots \otimes X_n$
は $p_{X_1,\ldots,X_n}$ と書くことにする.

### 定義

普通の確率論では
$x \independent y \mid z$
は
$$P(x,y \mid z) = P(x \mid z) P(y \mid z)$$
なのでこれをそのままCD圏に持ってくる.

対象 $X,Y,Z$ について
$$X \independent Y \mid Z$$
とは
$$p_{X,Y \mid Z} \sim (\p{X}{Z} \otimes \p{Y}{Z}) c_X.$$

### 定理

以下は同値

1. $X \independent Y \mid Z$
2. $p_{X,Y,Z} = (\p{X}{Z} \otimes \p{Y}{Z} \otimes 1_Z) c_Z^3 p_Z$
    - ここで $c_Z^3$ は $Z \to Z \otimes Z \otimes Z$ なる copy 射
3. $\p{X}{Y,Z} \sim d_Y \otimes \p{X}{Z}$
4. $p_{Y,X,Z} = (1_Y \otimes (\p{X}{Z} \otimes 1_Z) c_Z) p_{Y,Z}$

#### 証明

$1 \iff 2$ は $\sim$ をそのまま言い換えただけ.

$$\begin{align*}
X \independent Y \mid Z
& \iff \p{X,Y}{Z} \sim (\p{X}{Z} \otimes \p{Y}{Z}) c_Z \\
& \iff (\p{X,Y}{Z} \otimes 1) p_Z = ((\p{X}{Z} \otimes \p{Y}{Z}) c_Z \otimes 1) p_Z \\
& \iff (\p{X,Y}{Z} \otimes 1) p_Z = (\p{X}{Z} \otimes \p{Y}{Z} \otimes 1) c_Z^3 p_Z \\
\end{align*}$$

最後の左辺は $\p{X,Y}{Z}$ の構成から $p_{X,Y,Z}$ の disintegration になっていて結局
$p_{X,Y,Z} = (\p{X}{Z} \otimes \p{Y}{Z} \otimes 1) c_Z^3 p_Z$
を得る.

$2 \iff 4$ もそのまま.

対称性より左辺は $p_{X,Y,Z} = p_{Y,X,Z}$.
右辺だが,
$p_{Y,Z}$ を disintegration すると $= (\p{Y}{Z} \otimes 1_Z) c_Z$ が出てきてこれを代入すればそのまま等しくなる.

$3 \iff 4$ も 3 の $\sim$ を言い換えると分かる.

$$\begin{align*}
\p{X}{Y,Z} \sim d_Y \otimes \p{X}{Z}
& \iff (\p{X}{Y,Z} c_{Y \otimes Z} \otimes 1) c_{Y \otimes Z} p_{Y,Z} = ((d_Y \otimes \p{X}{Z}) \otimes 1_{Y \otimes Z}) c_{Y \otimes Z} p_{Y,Z} \\
& \iff p_{X,Y,Z} = \left( ((d_Y \otimes 1_Y) c_Y) \otimes ((\p{X}{Z} \otimes 1_Z) c_Z) \right) p_{Y,Z} \\
& \iff p_{X,Y,Z} = \left( 1_Y \otimes ((\p{X}{Z} \otimes 1_Z) c_Z) \right) p_{Y,Z} \\
\end{align*}$$

以上.

### 条件付き独立性の性質

1. Symmetry: $X \independent Y \mid Z \iff Y \independent X \mid Z$
2. Decomposition: $X \independent (Y_1 \otimes Y_2) \mid Z \implies X \independent Y_1 \mid Z \and X \independent Y_2 \mid Z$
3. Weak Union: $X \independent (Y \otimes W) \mid Z \implies X \independent Y \mid (Z \otimes W)$
4. Contraction: $X \independent Z \mid W \and X \independent Y \mid (Z \otimes W) \implies X \independent (Y \otimes Z) \mid W$
