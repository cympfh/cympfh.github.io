% 坪井 多様体 &sect;2 - ユークリッド空間上の多様体
% 2017-02-12 (Sun.)
% 幾何学 微分幾何
% 第二章です

## ユークリック空間上の $p$ 次元部分多様体の定義

$\mathbb{R}^n$ 上の図形 $M$ $(M \subseteq \mathbb{R}^n)$
について、
$M$ が $\mathbb{R}^n$ 上の $p$ 次元部分多様体であるとは、
後述する3つの条件のいずれかが成立するもののことである.
3つの条件同士は同値である (証明略).

$p$ を $M$ の次元というのに対し、
$q = n-p$ を $M$ の余次元という.

これらが言ってることは、直感的には、パラメータ表示の場合を考えれば分かりやすい.
$M$ という図形の上の点は、$p$ 個の実パラメータで指定できること.
図形が持つ辺や面が交わらないこと.
また、至るところで無限回微分可能なほど滑らかであることを要請している.

### 1. 陰関数表示

任意の点 $a \in M \subset \mathbb{R}^n$ について、その近傍 $U (\ni a)$ を適切にとった場合に、
次のような $U$ 上の写像 $F$ が作れること.

1. $F$ は $C^\infty$ 級写像 $F: U \to \mathbb{R}^q$
1. そのヤコビアン $DF$ が full-rank ($\text{rank}=q$)
1. $M \cap U = \{ x \in U : F(x) = F(a) \}$

### 2. グラフ表示

任意の点 $a \in M \subset \mathbb{R}^n$ について、
$a$ の $n$ コある成分から適切に $p$ コを選ぶ.
簡単の為に、一般性を失わず $1,2,\ldots,p$ とする.
その $p$ 成分 $(a_1, a_2, \ldots, a_p)$ に関する近傍 $W$ を適切にとる.
このとき、次のような $W$ 上の写像 $G$ が作れること.

1. $C^\infty$ 級の写像 $G: W \to \mathbb{R}^q$
1.  $M \cap U = \{ (x_1, x_2, \ldots, x_p; G(x_1,x_2,\ldots,x_p)) : (x_1, x_2, \ldots,x_p) \in W \}$

### 3. パラメータ表示

任意の点 $a \in M \subset \mathbb{R}^n$ について、
**任意** のその近傍 $U (\ni a)$ に対して、
その中に含まれる近傍 $V$ を適切にとったとき、
次のような $V$ 上の写像 $\Phi$ があること.

1. $C^\infty$ 級の $W \to V$
    - 定義域は適当な開球 $W \subset \mathbb{R}^p$
1. $D\Phi$ の rank は $p$
1. $M \cap U = \{ \Phi(u) : u \in W \}$

