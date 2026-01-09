# 代数 - 超数 (Hyper Numbers)

## 概要

全順序集合（整数など） $X$ に最大元及び最小元 $\pm \infty$ を付加した数
$$X \cup \{ +\infty, -\infty\}$$
を超数 $\mathrm{Hyper}(X)$ と呼ぶ.

もし $X$ がモノイド/加法群/環である場合,
$\pm \infty$ にも自然に拡張することで
$\mathrm{Hyper}(X)$ も同様の代数系にできる.

- 順序
    - $-\infty \lt x \lt +\infty$ for all $x \in X$
- $X$ に加法があるとき
    - $x + y =$ 通常の加法 for all $x, y \in X$
    - $(-\infty) + x = -\infty$
    - $(+\infty) + x = +\infty$
    - NOTE
        - $(+\infty) + (-\infty)$ は本来未定だが実装上では $+\infty$ としてある
- $X$ に乗法があるとき
    - $x \times y =$ 通常の乗法 for all $x, y \in X$
    - $(+\infty) \times (+\infty) = +\infty$
    - $(-\infty) \times (-\infty) = +\infty$
    - NOTE
        - 上記以外は全て $-\infty$ になってる
            - ($2 \times \infty = \infty$ にもならないのはバグっぽいんでそのうち直す)

## 実装

- $-\infty$ : `Hyper::NegInf`
- $+\infty$ : `Hyper::Inf`
- 通常の数 : `Hyper::Real(X)`

@[rust](procon-rs/src/algebra/hyper.rs)
