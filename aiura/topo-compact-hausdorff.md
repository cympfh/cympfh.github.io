% コンパクト空間からハウスドルフ空間への連続全単射は同相写像
% 2020-09-28 (Mon.)
% 位相空間

## 概要

位相空間とはなにかの知識までを仮定する.

一般に位相空間の間に連続な全単射があったとき, これの逆写像は連続とは限らず,
従って同相（位相同型）を与えない.
しかしこれがコンパクト空間からハウスドルフ空間への連続全単射の場合には同相を与える.

このことの説明と証明をする.

## 諸概念

### 位相空間, 開集合

[ここ](topo) で説明したので略.

### 連続写像

2つの位相空間 $X,Y$ の間に写像 $f \colon X \to Y$ があったときに,
この $f$ が **連続** であるとは次を満たすこと.

- $Y$ の任意の開集合 $U$ に対してその逆像 $f^{-1}(U) \subset X$ が開集合

### 同相写像

連続写像 $f$ であって, その逆写像 $f^{-1}$ もあってそれもまた連続であるとき,
この $f$ を **同相写像** （または位相同型写像とも）という.

### 開被覆

位相空間 $X$ の **開被覆** （あるいは単に被覆）とは,
開集合の族
$$\{ U_\lambda \mid U_\lambda \subset X \}_\lambda$$
であって,
$\bigcup_\lambda U_\lambda = X$
を満たすようなもののこと.

### コンパクト空間

位相空間 $X$ が **コンパクト** であるとは,
任意の被覆 $\{ U_\lambda \}_{\lambda \in \Lambda}$ が与えられたときに,
そこから有限個の開集合

- $\{ U_i \}_{i \in I}$
    - $I \subset \Lambda$, $|I|$ は有限

を取り出して $\bigcup_i U_i = X$ と出来ること.

言い換えれば, 無限個の開集合からなる被覆があるとき, 上手く選ぶことで必ず有限の被覆に出来ること.

### ハウスドルフ空間

位相空間 $X$ が次を満たすとき, これを **ハウスドルフ空間** であるという.

1. 任意の二点 $x,y \in X$ を取り出す
2. 開集合 $U_x, U_y$ が必ず存在して次を満たす:
    - $x \in U_x$
    - $y \in U_y$
    - $U_x \cap U_y = \emptyset$

便宜上, この二点 $x,y$ から $U_x, U_y$ を選ぶ操作を $H$ として
$(U_x,U_y) = H(x,y)$
と書くことにする.
この開集合の選び方はただ一通りである必要はないが, 便宜上 $H$ はその中から一つを決定的に返すものとする.

## 補題 1: コンパクト空間の部分閉集合はコンパクト

コンパクト空間 $X$ に対して閉集合 $Y \subset X$ を考える.
このとき $Y$ もコンパクトになる.

$Y$ に任意の被覆 $\{ U_\lambda \}_{\lambda \in \Lambda}$ を与える.
この各 $U_\lambda$ を $U_\lambda \cup (X \setminus Y)$ に置き換えればこれは $X$ の被覆になる.
ここで $Y$ が閉集合であることから $X \setminus Y$ は開集合であることを利用している.

さて $X$ はコンパクトなので, 上手く $I \subset \Lambda$ を選ぶことで,
$$\bigcup_I (U_i \cup (X \setminus Y)) = X$$
ここからそのまま
$$\bigcup_I U_i = X \cap Y = Y$$
を得る.
これは結局 $Y$ に対する有限の被覆になる.

以上から $Y$ はコンパクト.

## 補題 2: コンパクト空間を連続写像で写す像はコンパクト

コンパクト空間 $X$ と連続写像 $f$ によって $Y = fX$ であるとする.
このとき $Y$ もコンパクトになる.

$Y$ に任意の被覆 $\{ U_\lambda \}$ を与える.
これの $f$ の逆像を考えると, $f$ が連続であることから各 $f^{-1}(U_\lambda)$ は $X$ の開集合になる.
被覆全体も $f^{-1}(Y)=X$ なので, 結局 $X$ の被覆
$\{ f^{-1}(U_\lambda) \}$
が手に入る.

そして $X$ はコンパクトなので, やはり $I$ を上手く選んで, 有限の被覆
$$\{ f^{-1}(U_i) \}_{i \in I}$$
を構成できる.
そしてこれを再び $f$ で移せば, $Y$ の有限の被覆
$$\{ U_i \}_{i \in I}$$
を構成できる.

従って $Y$ はコンパクト.

## Remark: 開集合であることはより小さい開集合を取れることと同値

位相空間 $X$ の部分集合 $V \subset X$ が開集合であることは次と同値.
$$\forall x \in V ,~ \exists V_y \subset V ,~ y \in V_y$$
ここで $V_y$ は開集合であることとする.

## 定理: コンパクト空間からハウスドルフ空間への連続全単射は同相写像

コンパクト空間 $X$ とハウスドルフ空間 $Y$ があって,
その間に連続な全単射 $f \colon X \to Y$ があるとする.

$f$ が同相写像とはそれと逆写像のどちらもが連続であることだったが, $f$ が連続なのは仮定しているので,
これの逆写像 $f^{-1}$ が連続であることだけ確認すれば, $f$ が同相写像であると言える.

連続写像の定義から, $f^{-1}$ が連続であるとは,
任意の開集合 $U \subset X$ に対して $fU \subset Y$ が開集合であること.
このことを先程の Remark を使って証明する.
すなわち,
任意の点 $y \in fU$ に対して,
$$y \in K \subset fU$$
を満たすような開集合 $K$ が存在すれば, 定理が証明される.

自明なケースとして, $fU = Y$ または $fU = \emptyset$ である場合は自明に開集合なのでこのケースは除外する.
すると, $fU$ も $Y \setminus fU$ も空でない集合となる.

一点 $y \in fU$ と $Y \setminus fU$ の各点を次のようにして分離する:
$$\{ H(y, y') \mid y' \in Y \setminus fU \}$$

さて $X$ はコンパクトで $U$ は開集合なので, 補題 1 より, $X \setminus U$ はコンパクト.
これを $f$ で写すと $f(X \setminus U) = fX \setminus fU = Y \setminus fU$ を得るが,
これも補題 2 よりコンパクト.

そこで $Y \setminus fU$ の被覆を次のように作る.
$$\{ V_{y'} \cap (Y \setminus fU) \mid y' \in Y \setminus fU, (\_, V_{y'}) = H(y, y') \}$$
この各開集合は $y' \in Y$ によって添字付することが出来る.
そしてコンパクトであることから, 有限の点集合 $J \subset Y$ を上手く選んで,
$$Y \setminus fU = \bigcup \{ V_{y'} \cap (Y \setminus fU) \mid y' \in J \setminus fU, (\_, V_{y'}) = H(y, y') \}$$
と出来る.
ここから
$$Y \setminus fU \subset \bigcup \{ V_{y'} \mid y' \in J \setminus fU, (\_, V_{y'}) = H(y, y') \}$$
を導く.
さて, この右辺に対応して,
$$K = \bigcap \{ V_{y} \mid y' \in J \setminus fU, (V_y, \_) = H(y, y') \}$$
を考える.

実は, $V_y$ と $V_{y'}$ が分離されてることから
$$fU \supset K$$
であることが言える.

なぜなら,
もし $fU$ 外の点 $z \in Y \setminus fU$ を右辺が持つなら, 全ての $y'\in J$ に対して $z \in V_y$,
すなわち $z \not\in V_{y'}$. $\bigcup V_{y'}$ に $z$ が含まれないことになり,
被覆であったことに反するから.

さて $K$ は有限個 $(J)$ の開集合の積であり, そのようなものは一般にまた開集合である.
従って,
$$y \in K \subset fU$$
を満たす開集合 $K$ を見つけることが出来た.
このことは任意の $y \in fU$ に対しても行うことが出来る.

以上から $fU$ は開集合であり, 定理も証明された.
