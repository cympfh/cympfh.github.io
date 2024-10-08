# 自然数/整数 - 関数 - メビウス関数 (M&ouml;bius function)

## 定義

$n \geq 2$ の自然数について,
$n$ が 相異なる $N$ 個の素数の積で表されるとき
$$\mu(n) = (-1)^N$$
さもないとき (ある素数の平方因子を持つ)
$$\mu(n) = 0$$
なる関数 $\mu$ をメビウス関数と呼ぶ.

$n=1$ は $0$ 個の積だと思って $\mu(1)=1$ とする.

### 参考

- [oeis.org/A008683](https://oeis.org/A008683)

### アルゴリズム

エラトステネスの篩の拡張でできる.
$\mu(n)$ は $O(n \times \text{ちょっと}) (\leq O(n \log(n)))$ で求まる.

## Rust

@[rust](procon-rs/src/num/moebius.rs)

## 例題: [ICPC/pacific-northwest-div1 - B: Coprime Integers](https://codeforces.com/gym/245895/attachments)

問題が pdf で読みにくいので簡単に問題を説明する.

### 問題概要
4つの整数 $1 \leq a,b,c,d \leq 10^7$ が与えられる.
これは2つの閉区間 $[a,b], [c,d]$ を表している.
$x \in [a,b], y \in [c,d]$ であって $x$ と $y$ とが互いに素であるような組 $(x,y)$ は何通りあるか.

### 解答解説
まず知っておくこととして,
自然数 $n$ について $1$ 以上 $n$ 以下で $p$ の倍数の自然数の数は,
$n/p$
で表される.
ただしこの $/$ は自然数の範囲での除算で, 余りを除いた商のこと.
つまり C++ とかの `int` の `/` のこと.

さて $x, y$ が互いに素 **ではない** とは,
共通の素数 $p$ で割れることだから,
各 $p$ で割れる組 $(x,y)$ の数は割り算で数えられて,
$$M(p) = (b/p - (a-1)/p) (d/p - (c-1)/p)$$
となる.

単に
$x \in [a,b], y \in [c,d]$
なる $(x,y)$ の組数は
$(b-a+1) (d-c+1)$
だから, これから各 $p$ についてさっきのを引いていけば良い.

が、これだと例えば $6$ で割れるものが二回引かれている.
すなわち, $6=2\times 3$ だから, $p=2$ のときと $p=3$ のときとで二回引いてる.
なので今度は $M(6)$ を足さないといけない.

すると今度は $30=2\times 3 \times 5$ で割れるものが足しすぎだから, さらに $M(60)$ を引かないといけない.
というわけで包除原理である.
$$(b-a+1) (d-c+1) + \sum_{k=1}^\infty \sum_{p_1,\ldots,p_k \in \text{素数}} (-1)^k M\left(\prod_i p_i\right)$$
メビウス関数はまさに、これの $(-1)^k$ を与えてくれてる.
$0$ なるものはスキップしていい.

### 回答例

- [Rust](https://codeforces.com/gym/245895/submission/55326375)
