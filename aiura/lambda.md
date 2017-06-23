% ラムダ計算
% 2017-03-15 (Wed.)
% 計算機言語
% ラムダ式、SKI式、不動点コンビネータ

## index

<div id=toc></div>

## ラムダ項

ラムダ項とは次のBNFで記述されるもの.

- $M ::= \text{Var} | \lambda \text{Var}. M | M M$
- $\text{Var} ::= x | y | z | \cdots$

これに適切な意味を与えたのがラムダ式.

$\lambda x. \lambda y. M$ みたいなのは
$\lambda xy. M$
と略記する.

関数適用は左結合.
つまり $xyz = (xy)z$.

### 自由変数 (Free Variables)

束縛されてない変数のことを自由変数という.
束縛とは、$\lambda x. M$ で言う $x$ のこと.

例えば、$\lambda xy. (xyz)$ で言うと、$x, y$ は束縛された変数で、
$z$ は自由変数.
形式的には次のように定義出来る.

- $FV(x) = \{x\}$
    - $x \in \text{Var}$
- $FV(\lambda x. M) = FV(M) \setminus \{ M \}$
- $FV(M N) = FV(M) \cup FV(N)$

## SKIコンビネータ

SKIコンビネータとは3つの演算 $S,K,I$ のことで、
ここではラムダ式で定義する.

- $S = \lambda xyz. xz(yz)$
- $K = \lambda xy. x$
- $I = \lambda x. x$

SKI式とは、変数、SKIコンビネータ、関数適用の組み合わせで出来る式のこと.

### 定理

任意のラムダ式は等価なSKI式で書き直せる.

#### $I$ は不要

$I$ と等価な式は $S,K$ の組み合わせで定義できて、
任意の $SKI$ 式 $M$ を用いて

$$SKM = (\lambda xyz. xz(yz))(KM) = \lambda z. Kz(Mz) = \lambda z.z = I$$

と出来る.
$M$ は任意であるが、よく $SKK=I$ という等式が用いられる.

#### 諸性質

1. $\lambda x. x = SKK$
1. $\lambda x. M = KM$
    - ただし $x \not\in FV(M)$
1. $\lambda x. MN = S (\lambda x. M) (\lambda x. N)$

これを左辺から右辺への書換規則だと見做せば、ラムダ式から ($I$ を使わない) SKI式への変換が出来る.
この3つのルールのいずれかがいつも適用できて、長さに関して厳密に短く出来ることが言えれば証明はできる (らしい).

ちなみにこの書換規則 (ただし1つめのルールは $I$ に書き換える) を行う実装を
[ラムダ式からSKI式への変換](http://cympfh.cc/aiura/lambda2ski.html)
で与えた.

逆に SKI 式からラムダ式への変換は SKI コンビネータの定義をそのまま用いれば良いので自明.

### 基底、X式

全てのラムダ式は$S$ と $K$ で表現することが出来、
(証明は知らないけど) $S$ と $K$ は一方を他方のみで表現できない (まあそうだろう) ので、
$\langle S,K \rangle$ はラムダ式のいわば基底だと言える.
しかしこれは最小の基底ではなく、次のような $X$ は、それただ一つでラムダ式の基底になる.

$$X = \lambda x. xKSK$$

そのことを確認するには、 $X$ ただ一つで $S$ と $K$ が表現できることを確認すればよく、

1. $XX = XKSK = \lambda x. K$
1. $XXX = (\lambda x. K) X = K$
1. $X(XX) = X(\lambda x. K) = KSK = S$

というわけで、$X$ のみで $K$ と $S$ を構成できる.
従って $X$ のみで任意のラムダ式を表現することが出来る.

## ラムダ式による算術

ラムダ式で自然数の表現や、その上の加減算、乗算やべき乗などの表現が出来る.
あとで説明に用いるものを定義しておく.

### チャーチ数

自然数 $n=0,1,2,\ldots$ をラムダ式を次のように表現したものをチャーチ数という.

- $0 = \lambda fx. x$
- $1 = \lambda fx. fx$
- $2 = \lambda fx. f(fx)$
- $\vdots$

すなわち、 $f$ を適用する回数で自然数を表現する.
一般の場合を定義するには次の $+1$ の手続きの定義を見るとよい.

また、自然数の意味での $n$ に対して、それをチャーチ数で書き直したものを区別なく $n$ と書く.

### $+1$ (succ)

チャーチ数 $n$ からチャーチ数 $n+1$ を得る手続きを定義する.
$f$ への適用を一回増やせば良いだけ.
$\lambda fx$ で包んだりするとこだけ註意.

$$n+1 = \lambda fx. f(nfx)$$

- 例. $3 = \lambda fx. f(2fx) = \lambda f. f(f(f(x)))$

#### 加算 $+$ と乗算 $\times$

チャーチ数 $n$ は、それ自体が、 $f$ を $n$ 回適用する関数である.
この性質を使えば、

- $m$ に $+1$ を $n$ 回適用することで $m + n$ を得る
- $0$ に $+n$ を $m$ 回適用することで $m \times n$ を得る

これを使うことで、$+, \times$ を定義することが出来る.

### boolean (true, false)

- $\text{true} = \lambda xy. x$
- $\text{false} = \lambda xy. y$
- if 文
    - $(\text{if } C \text{ then } A \text{ else } B) = CAB$
    - ここで $C$ は $\text{true}$ または $\text{false}$

### $=0$ (zero?)

チャーチ数 $x$ が $0$ かどうかを判定する.
判定の返り値は true, false のどちらか.
$0$ は $x$ を返して、それ以外は $f$ を一回以上適用するという性質に注目すれば、次のように定義できることが分かる.

$$(x=0) = x~(K~\text{false})~\text{true}$$

ここで $K$ は $SKI$ の $K$ であって $K~\text{false}$ は何を適用しても $\text{false}$ を返す定数関数である.

### ペア (cons)

単に2つの値 $x,y$ を保存するためのデータ構造を定義する.
(そもそも関数とはデータそのものである.)

$$\langle x,y \rangle = \lambda f. fxy$$

ペアから値を取り出す手続きを用意しておく:

- $\text{car} = \lambda xy. x$
    - $\text{car} ~ \langle x,y \rangle = x$
- $\text{cdr} = \lambda xy. y$
    - $\text{cdr} ~ \langle x,y \rangle = y$

cons, car, cdr という名称は Lisp から.

### $-1$ (pred)

チャーチ数 $n$ から$n-1$ を得る手続き.
ただし、$0-1$ は特別に $0-1=0$ とする
(通常の減算と区別するために $\dot{-}$ と書くことがある).

これは $+1$ や他の演算と比べてめちゃんこ大変
(思うに $-1$ 相当をチャーチ数で定義出来ないことに由来する)
だが、cons を使うと見通しよく定義できる.

「$0$ に $+1$ を $n$ 回適用し、かつ適用する前の値を覚えておく」ということをする.
適用する前の値をペアの1つめの値として保存しておき、最後これを返すことで、$0$ に $n-1$ 回 $+1$ を適用したものを得ることが出来、結局 $n-1$ を得る.

今述べたことをラムダ式で記述すると、

$$f = \lambda p. \langle \text{cdr}~p, \text{cdr}~p + 1 \rangle$$

を $n$ 回適用することで

$$\langle 0,0 \rangle
\xrightarrow{f} \langle 0, 1 \rangle
\xrightarrow{f} \langle 1, 2 \rangle
\xrightarrow{f} \langle 2, 3 \rangle
\xrightarrow{f} \cdots
\xrightarrow{f} \langle n-1, n \rangle
$$

と出来る.
というわけで、

$$n-1 = \text{car}~ (n f \langle 0,0 \rangle)$$

と定義するとよい.
($0-1=0$ にもなってる.)

### 等号比較 $=$

2つのチャーチ数 $m,n$ の等号を判定する $=$ を定義する.
方法は一通りではないだろうが、例えば、

```haskell
(m = n) =
    if m = 0 then
        if n = 0 then
            true
        else
            false
    else
        if n = 0 then
            false
        else
            (m-1) = (n-1)
```

で出来そう.
すなわち、次を確かめている.

1. $m=0 \land n=0 \Rightarrow m=n$
1. $m=0 \land n\ne0 \Rightarrow m \ne n$
1. $m\ne0 \land n=0 \Rightarrow m \ne n$
1. $m\ne0 \land n\ne0 \Rightarrow (m-1) = (n-1)$

これは、適当な自然数 $k$ について
$m=n \iff m-k = n-k$
であることを利用している.

しかしこの定義には問題がある.
再帰的定義になっているのだ.
$=$ を定義するのに $=$ を用いている.

しかしループを表現するために再帰的定義は避けて通れない.

というわけで話は不動点コンビネータに移る (自然な流れだ).

## 不動点コンビネータ

ラムダ式でも再帰/ループを表現したい.

まず次のようなベータ項
$$\Omega = (\lambda x. xx)(\lambda x. xx)$$
は、ベータ簡約が停止しない、即ちベータ正規形が存在しないものとして有名.

これに似せて作った次のベータ項

$$Y = \lambda f. (\lambda x. f(xx))(\lambda x. f(xx))$$

適当なラムダ式 $F$ をこれに適用させると、

$$\begin{align*}
YF
& \Rightarrow^\beta (\lambda x. F(xx)) (\lambda x. F(xx)) \\
& \Rightarrow^\beta F ((\lambda x. F(xx)) (\lambda x. F(xx))) \\
& = F(YF)
\end{align*}$$

結局、このベータ簡約を繰り返すことで、

$$YF = F(YF) = F(F(YF)) = \ldots = F(\cdots F(YF) \cdots )$$

を得る.

これを解釈するには、具体的な $F$ の形式を見るのが早い.
[http://en.wikipedia.org/wiki/Lambda_calculus](http://en.wikipedia.org/wiki/Lambda_calculus)
にある関数 $G$ の例で実験する.

$$G = \lambda rn. \text{if } n=0 \text{ then } 1 \text{ else } n \times r(n - 1)$$

$$\begin{align*}
YG0
& \Rightarrow^\beta G (YG) 0 \\
& = (\lambda rn. \text{if } n=0 \text{ then } 1 \text{ else } n \times r(n - 1)) (YG) 0 \\
& = 1
\end{align*}$$

$$\begin{align*}
YG n
& \Rightarrow^\beta G (YG) n \\
& = (\lambda rn. \text{if } n=0 \text{ then } 1 \text{ else } n \times r(n - 1)) (YG) n \\
& = n \times (YG (n-1))
\end{align*}$$

これらから、
$$YGn = n \times (n-1) \times \cdots \times 1$$

が得られる.
つまり、$G$ は階乗を再帰を用いて定義する関数であった.

この例から得られる教訓としては、

1. ベータ正規形を得るためにはいわゆる基底条件が必要であること
1. ベータ簡約では正規形に向かって簡約が神託機械によって行われること
    - いじわるな簡約順序では、簡約が永久に終わらない
1. 適用する $F$ は第一引数に $YF$ を受け取ってこれを再帰関数として使う

### 等号比較 $=$

先に示した再帰的定義を今ならばラムダ式で記述できる.

```haskell
F r m n =
    if m = 0 then
        if n = 0 then
            true
        else
            false
    else
        if n = 0 then
            false
        else
            r (m-1) (n-1)
```

この $F$ を以って、

$$(m=n) = YFmn$$

できた！

