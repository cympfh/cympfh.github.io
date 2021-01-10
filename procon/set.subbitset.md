# 集合 - 部分集合及びその部分集合の列挙

今考える集合を $N \leq 128$ として
$$U = \{0,1,\ldots,N-1\}$$
であるとする.

## 部分集合

$U$ の部分集合は [BitSet](set.bitset.html) の方法で unsigned 128 bit int 一つで表現出来る.
この対応付けを用いることで,
部分集合の列挙は $0$ 以上 $2^N$ 未満の整数を列挙すればよいことになる.

```rust
for tset in 0..1 << N {
    // now `uset` is a bitset for U.
}
```

実際 $T \subseteq U$ なる $T$ は $2^N$ 個あるのでこれは無駄なく列挙出来ている.

## 部分集合の部分集合

$U$ の部分集合 $T$ のその部分集合 $S$
$$S \subseteq T \subseteq U$$
を列挙したい.

単純に二重で部分集合を列挙する場合,
つまり, $S \subseteq U$, $T \subseteq U$ をそれぞれ列挙して $S \subseteq T$ であるかをチェックするような方法が一つ考えられる.
この包含関係は
`S & !T == 0`
で判定可能.
二重列挙で $O(2^N \times 2^N = 4^N)$ 掛かる.

```rust
for tset in 0..1 << N {
    for sset in 0..1 << N {
        if sset & !tset == 0 {
            // now sset <: tset <: U
        }
    }
}
```

実際のところ $S \subseteq T \subseteq U$ なる $S$ がいくつあるのかを数えると,
$$\begin{align*}
\sum_{T \subseteq U} \sum_{S \subseteq T} 1
& = \sum_{T \subseteq U} 2^{|T|} \\
& = \binom{N}{0} 2^0 + \binom{N}{1} 2^1 + \binom{N}{2} 2^2 \cdots + \binom{N}{N} 2^N \\
& = (2+1)^N \\
& = 3^N
\end{align*}$$
と分かる. 

実は次のようにすると無駄なく $3^N$ が列挙出来る.

```rust
for tset in 0..1 << N {
    let mut sset = tset;
    while sset > 0 {
        // now sset <: tset <: U
        sset = (sset - 1) & tset;
    }
}
```

## 参考文献

- [ビット列による部分集合表現 【ビット演算テクニック Advent Calendar 2016 1日目】 - prime's diary](https://primenumber.hatenadiary.jp/entry/2016/12/01/000000)

## 例題

- [ABC 187/F](https://atcoder.jp/contests/abc187/tasks/abc187_f)
- [EDPC/U](https://atcoder.jp/contests/dp/tasks/dp_u)
