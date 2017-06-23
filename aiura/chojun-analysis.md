% 超準解析
% 2017-02-12 (Sun.)
% 数学
% ノートです

## 超準解析とは何か?

1960年に Abraham Robinson が作った nonstandard analysis は無限の数を扱うなんか計算モデル？
standard analysis (epsilon-delta) の上位互換として作られる.

## 定義

以下を満たす $U$ を集合 $J$ 上のフィルタ (filter) と呼ぶ.

1. $U \subseteq 2^J$
1. $\emptyset \not\in U$
1. $\forall A, B \in U, A \cap B \in U$ (intersection property)
1. $\forall A \in U, \forall B (A \subseteq B), B \in U$

以下の $U$ を $J$ 上の超ウィルタ (ultrafilter) と呼ぶ.

1. $U$ は $J$ 上のフィルタ
1. $\forall A \in J$ について次のどちらかちょうど一つが成立 (maximality)
    1. $\{A\} \in U$
    1. $J \setminus \{A\} \in U$

以下の $U$ を $J$ 上の自由超フィルタ (free-ultrafilter) と呼ぶ.

1. $U$ は $J$ 上の超フィルタ
1. $\nexists A \in U, |A| < \infty$ (freeness)

## 諸定理

### 定理

$A$ 上の超フィルタ $U$ 及び $A$ の有限個への分割 $A_1, \ldots, A_n$ について
$$\exists! i, A_i \in U$$
が成立する.

### 証明

まず、$\exists i, A_i \in U$ を背理法によって示す.

$\forall i, A_i \not\in U$ を仮定すると maximality 故に $\forall i, A \setminus A_i \in U$.
更に intersection property から
$\emptyset = \bigcap_i (A \setminus A_i) \in U$.
これは $U$ の超フィルタの定義に反する.

従って $\exists i, A_i \in U$ は成立する.

異なる $i = i_1, i_2$ についてこれが成立するとき、同様に
$\emptyset = \cap_{i=i_1, i_2} A_i \in U$
となるので、そのような $i_1, i_2$ は存在しない.

以上から唯一の $i$ で成立する.


### 定理

$A$ 上のフィルタ $F'$ から超フィルタ $F$ を導くことができる.
$\Phi$ を $A$ 上のフィルタ全てからなる集合とする ($F' \in \Phi$).

$\Phi$ の元に関して包含関係によって半順序を附けることができる.
その最大限が欲しかった超フィルタ $F$ である.

### 証明

(略)


## 定義

2つの $n$ 次元実ベクトル $a, b$ 、実数に関する二項演算 $\circ$  に関して、
$\{ i : 1 \leq i \leq n, a_i \circ b_i \}$ を
$$[\![ a \circ b ]\!]$$
と書くことにする.
例えば $[\![ a = b ]\!]$ は、成分の値が等しいインデックスの集合.

### 超フィルタの法の下の等号性 (Equivalence Modulo an Ultrafilter)

超フィルタ $U$ 及び2つの $n$ 次元実ベクトル $a, b$ について
$$a = b \mod{U} \iff [\![ a=b ]\!] \in U$$

### 超フィルタの法の下の順序

$$a \leq b \mod{U} \iff [\![ a \leq b ]\!] \in U$$

この順序は全順序である.

### 例

- $\mathbb{a} = (0, 1, 0, 1, \ldots)$
- $\mathbb{b} = (1, 0, 1, 0, \ldots)$
- $\mathbb{0} = (0, 0, 0, 0, \ldots)$
- $\mathbb{1} = (1, 1, 1, 1, \ldots)$

について

- $\mathbb{a} \ne \mathbb{b} \mod{U}$
- $\mathbb{a} = 0 \mod{U}$ または $\mathbb{a} = 1 \mod{U}$
- $\mathbb{b} = 0 \mod{U}$ または $\mathbb{b} = 1 \mod{U}$

が $U$ によって成立する.
例えば $\{0,2,4,\ldots\} \in U$ なる超フィルタが作れる.


## Ultrapower

ある超フィルタ $U$ を法とする等号によって
$n$ 次元実ベクトル空間 $R^n$ の同値類を取った空間を **超実空間 (hyperreal)** と呼び ${}^*R$ と書く.
次のように加算と乗算を定めることで体になる.

- $\mathbb{a} + \mathbb{b} = (a_1, a_2, \ldots) + (b_1, b_2, \ldots) = (a_1 + b_1, a_2 + b_2, \ldots)$
- $\mathbb{a} * \mathbb{b} = (a_1, a_2, \ldots) * (b_1, b_2, \ldots) = (a_1 * b_1, a_2 * b_2, \ldots)$

成り立ってほしい性質はだいたい成り立つ.

- $a_1=a_2 \land b_1=b_2 \mod U$
- $\iff [\![ a_1=a_2 ]\!] \in U \land [\![ b_1=b_2 ]\!] \in U$
- $\implies [\![ a_1=a_2 ]\!] \cap [\![ b_1=b_2 ]\!] \in U$
- $\iff [\![ a_1=a_2 \land b_1=b_2 ]\!] \in U$
- $\iff [\![ a_1+b_1=a_2+b_2 ]\!] \in U$
- $\iff a_1 + b_1 = a_2 + b_2 \mod U$

加算に関する単位元

- $a + zero = a \mod U$
- $\iff [\![a + zero = a]\!] \in U \iff [\![zero=0]\!] \in U$
- $\iff zero = 0 \mod U$

同様に乗算に関する単位元

- $a * one = a \mod U$
- $\iff one = 1 \mod U$

$U$ の法の下で、それぞれ単位元は唯一に存在する.

逆元

- $a = (-a_1, -a_2, \ldots)$
- $\implies a + (-a) = 0 \mod U$

とすることで $+$ に関する $a$ の逆元 $(-a)$ を構成することができる.
唯一の存在であることも確認できる.
2つの逆元 $m, n$ があるとする.

- $a + m = 0 \mod U$
- $a + n = 0 \mod U$

このとき

- $a + m + n = 0 + n = n \mod U$
- $a + m + n = 0 + m = m \mod U$

ということで自明に $m = n \mod U$.
というわけで $U$ の法の下で逆元は唯一.

乗算に関してもだいたい実数と同じ.


## 無限小、無限大

自然数の列の集合を ${}^*N$ と書く.
$a \in {}^*R$ と $n \in {}^*N$ との大小を超フィルタ $U$ の下で定める.

1. $\forall n \in {}^*N, a \leq n$ を満たす $a$ を無限小と呼ぶ.
1. $\forall n \in {}^*N, a \geq n$ を満たす $a$ を無限大と呼ぶ.
