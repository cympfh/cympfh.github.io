# 代数 - 環上の加群

環 $R$ が加法アーベル群 $(M, +)$ への右作用
$$M \times R \to M$$
になっているとき, $M$ を **$R$-加群** といい,
この作用のことを **スカラー倍** という.

ただし,

- $(x+y) a = xa + ya ,~ x,y \in M ,~ a \in R$
- $x (a+b) = xa + xb ,~ x \in M ,~ a,b \in R$
- $x (ab) = (xa) b   ,~ x \in M ,~ a,b \in R$
- $x1 = x            ,~ x \in M ,~ 1 \in R$

を満たすこと.
例えば, 体 $F$ 上のベクトル空間 $V$ は $F$-加群.

## 実装

ここでは都合上, 右加群としてあるのと,
必ずしも必要としないので, 加法アーベル群であることは気にせずに, 作用だけを `std::ops::Mul` で要請してある.

@[rust](procon-rs/src/algebra/module.rs)
