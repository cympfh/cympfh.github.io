% Combining Monads
% http://homepages.inf.ed.ac.uk/wadler/papers/monadscomb/monadscomb.ps
% 計算

## 論文リンク

- King, David J., and Philip Wadler. "Combining monads." Functional Programming, Glasgow 1992. Springer London, 1993. 134-143.

## 概要

リストモナド $L$ と任意のモナド $M$ を合成してモナド $ML$ を作れることを示す.

## モナド

次はいわゆるリストモナド

```haskell
map :: (a -> b) -> [a] -> [b]
map f [x, y, ...] = [f x, f y, ...]

unit :: a -> [a]
unit x = [x]

join :: [[a]] -> [a]
join = concat
```

モナドはこれを一般化したもので、`[a]` を `M a` と書く.
モナドには次の3つの関数があって、

```haskell
map :: (a -> b) -> M a -> M b
unit :: a -> M a
join :: M (M a) -> M a
```

更に次の7つの制約が成立することを要請する.

```haskell
-- M-1
map id == id

-- M-2
map (f . g) == map f . map g

-- M-3
map f . unit == unit . f

-- M-4
map f . join == join . map (map f)

-- M-5
join . unit == id

-- M-6
join . map unit == id

-- M-7
join . map join == join . join
```

型 (`a` や `M a`) を対象とし、(1変数の) 関数を射とするような所謂 Hask 圏を考える
(恒等写像 `id` が恒等射).
`M-1` と `M-2` は `map` が Hask 圏から Hask 圏への関手であることを言っている
(関手としての定義を満たす; 恒等射を恒等射に写してかつ準同型).

対象 (型) `a` について `map a` という対象 (型) を `M a` と書いてると思う.
(この `M` のことを単にモナドという.)
つまり、

- 関手 `map` は `f: a -> b` を `map f: M a -> M b` に写す

`M-4` は `unit` が恒等関手から関手 `map` への自然変換であることを言っている.

```dot
digraph {
    node [shape=plaintext width=0.9 height=0.0 fixedsize=false]
    edge [arrowhead=vee]
    bgcolor=transparent;
    a -> b [label=f];
    Ma -> Mb [label="map f"];
    a -> Ma [label="unit  "]
    b -> Mb [label="unit  "]
    Ma [label="M a"];
    Mb [label="M b"];
    rankdir=LR;
    {rank=same a Ma}
    {rank=same b Mb}
}
```

`M-5` `M-6` は `unit` と `map unit` とが `join` の右単位元であること.
`M-7` は 一種の結合則.

## モナド内包 (Monad Comprehension)

リストにはリスト内包があるのだからモナドにもモナド内包が考えられる.
リスト内包表記と全く同様の表記法と定義を与える.

```haskell
-- mc-1
[ t ] == [ t | Empty ] == unit t

-- mc-2
[ t | x <- u ] == map (\x -> t) u

-- mc-3
[ t | p, q ] == join [ [ t | q ] | p ]
```

ここで `Empty` は空を表現するシンボル.

`mc-3` で `[ t | p, q, r ]` みたいに3つ以上ある場合を網羅してないように見えるが、
適当に `[ t | p, (q, r) ]` みたいに２つにグルーピングする.
グルーピングに関して `(p, q), r` としても `p, (q, r)` としても同じであるという、
一種の結合則が成立するがこれについては後述.

特に最後の `mc-3` だが、順序故に

```haskell
[(x, y) | x <- [1, 2], y <- [3, 4]]
== join [[(x, y) | y <- [3, 4]] | x <- [1, 2]]
== join [[(x, 3), (x, 4)] | x <- [1, 2]]
== join [[(1, 3), (1, 4)], [(2, 3), (2, 4)]]
== [(1, 3), (1, 4), (2, 3), (2, 4)]
```

とか

```haskell
[x | xs <- ls, x <- xs]
== join [[x | x <- xs] | xs <- ls]
== join [(map (\x -> x) xs) | xs <- ls]
== join [xs | xs <- ls]
== join (map (\xs -> xs) ls)
== join ls
```

ていう感じになる.

さてモナド内表表記を用いると初めのモナドに関する記述を書き直せる.
例えば `M-5` `M-6` `M-7` は

```haskell
-- M-5
[ t | Empty, q ] == [ t | q ]
-- M-6
[ t | q, Empty ] == [ t | q ]
-- M-7
[ t | (p, q), r ] == [ t | p, (q, r) ]
```

と同じ.
`M-7` だけやってみる.
 `join . join == join . map join` を仮定したとき

```haskell
[ t | (p, q), r ]
== join [[ t | r ] | p, q ]
== join . join [[[ t | r ] | q ] | p ]
== join . map join [[[ t | r ] | q ] | p ] -- !!
== join [join [[ t | r ] | q ] | p ]
== join [[ t | (q, r) ] | p ]
== [ t | p, (q, r) ]
```

`!!` のとこで開けば逆も示せて結局、2つの `M-7` は同値であることが分かる.

次の3つは `mc-1` から `mc-3` を使って示せるが有用な命題

```haskell
-- mc-4
[ f t | p ] == map f [ t | p ]
-- mc-5
[ x | x <- u ] == u
-- mc-6
[ t | p, x <- [ u | q ], r ] == [ t' | p, q, r' ]
```

ここで `t'` 及び `r'` は出現する自由変数から `x` を全て `u` に置き換えたもの.

## リストモナドと他モナドとの合成

### リストの操作 (補助関数)

```haskell
-- 結合
++ :: [a] -> [a] -> [a]
[x, ...] ++ [y, ...] = [x, ..., y, ...]

-- 畳み込み
fold :: (a -> a -> a) a -> [a] -> a
fold _ e [] = e
fold _ e [x] = x
fold * e [x, y...] = x * y * ...
```

<!--
この2つを用いるとリストモナドに関する `map` `join` が改めて定義できる:

```haskell
map :: (a -> b) -> [a] -> [b]
map f [] = []
map f [x] = unit (f x)
map f (xs ++ ys) = (map f xs) ++ (map f ys)

join :: [[a]] -> [a]
join :: fold (++) []
```
-->

### 準同型

関数 `h` が準同型であるとは、次のような形で定められること.

```haskell
h = fold (*) e (map g)
  where
    (*) :: b -> b -> b
    e :: b
    g :: a -> b
```

### ML モノイド

リスト (`L`) をモナド (`M`) で包んで出来る `ML` を考える.

```
ML a == M [a]
```

次の `*` は直積のある種の一般化である.

```haskell
(*) :: ML a -> ML a -> ML a
a * b = [ x ++ y | x <- a, y <- b ]
```

`unit []` が `(*)` の単位元となっている.
というわけで
集合 `A` (型 `a` の値全体) に対して `(ML(A), *)` はモノイドである.

#### 諸性質

```haskell
(unit a) * (unit b)     == unit (a ++ b)
h (a ++ b)              == h a ++ h b  -- h is homomorphism
join (f a) * join (f b) == join (f (a * b))
```

### `(*)` による畳込み

```haskell
prod :: [M [a]] -> M [a]
prod = fold (*) e
  where
    e = unit []
```

#### 諸性質

```haskell
prod . unit                  == id
prod . map unit              == unit . join
prod . map (map (map f))     == map (map f) . prod
prod . map (join . map prod) == join . map prod . prod
prod . map prod              == prod . join
```

### ML モナド

`ML` はモナドである.
すなわち次の3つの関数が定義できる.

- $\text{unit}^{ML} = \text{unit}^M \cdot \text{unit}^L$
- $\text{map}^{ML}~f = \text{map}^M \cdot \text{unit}^L~f$
- $\text{join}^{ML} = \text{join}^M \cdot \text{map}^L~\text{prod}$

右上の添字はどのモナドに関するそれらであるかを示す.
ただし $L$ はリストモナドのこと.

## モナドの分配則 (distributive laws)

直積 (Cartesian product) 相当の

- $cp :: [M a] \to M [a]$
- $cp = \text{prod} \cdot \text{map}^L (\text{map}^M \text{unit}^L)$

を定める.
これを用いると

- $\text{join}^{ML} = \text{map}^M ~ \text{join}^L \cdot \text{join}^M \cdot \text{map}^M ~ cp$

```dot
digraph {
    node [shape=plaintext width=0.7 height=0.7 fixedsize=true]
    edge [arrowhead=vee]
    bgcolor=transparent;
    rankdir=LR;
    a -> La [label=unit];
    Ma -> MLa [label="map unit"];
    LMa -> LMLa [label="map(map unit)"];

    a -> Ma [label="unit  "];
    Ma -> LMa;

    La -> MLa;
    MLa -> LMLa [label="prod  " dir=back];

    LMa -> MLa [xlabel="                cp" weight=0.1];

    {rank=same a Ma LMa}
    {rank=same La MLa LMLa}

    La [label="[a]"];
    MLa [label="M[a]"];
    LMa [label="[Ma]"];
    LMLa [label="[M[a]]"];
}
```

#### 諸性質

$$\begin{align*}
cp \cdot \text{unit}^L                 & = \text{map}^M \text{unit}^L  & :: a \to [M a] \\
cp \cdot \text{map}^L \text{unit}^M    & = \text{unit}^M               & :: a \to M a \\
cp \cdot \text{map}^L (\text{map}^M f) & = \text{map}^M (\text{map}^L f) \cdot cp \\
cp \cdot \text{map}^L \text{join}^M    & = \text{join}^M \cdot \text{map}^M cp \cdot cp \\
cp \cdot \text{join}^L                 & = \text{map}^M \text{join}^L \cdot cp \cdot \text{map}^L cp \\
\end{align*}$$

特にこの3つめは $cp$ が
$map^L \circ map^M$ から $map^M \circ map^L$ への自然変換であることを言っている.
