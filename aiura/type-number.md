% 型の数
% 2018-08-21 (Tue.)
% 計算機言語 プログラミング

Haskell の知識をちょっとだけ仮定します.
$\def\Bool{\mathrm{Bool}}\def\dd#1#2{\frac{\partial #1}{\partial #2}}$

## 参考

この文書に書いてある内容は全て以下に書いてあります.

1. [The algebra (and calculus!) of algebraic data types](https://codewords.recurse.com/issues/three/algebra-and-calculus-of-algebraic-data-types)
1. [Zippers: Derivatives of Regular Types](https://www.slideshare.net/JayCoskey/zippers-derivatives-of-regular-types)

## 型

ここでは擬似コードとして Haskell 風言語を用いる.
いくつか主要な型及び型クラスがあるわけだが, この文書では以下が型だとする

1. Unit型
    - $()$ と書く
    - Unit型を持つ値は `()` というただ一つの値
1. Bool型
    - $\Bool$ と書く
    - この型を持つ値は `true` と `false` という二つだけ
1. リスト型
    - $\tau$ が型であるとき $[\tau]$ もまた型である
    - $[\tau]$ を $\tau$ のリスト型と呼ぶ
1. タプル型
    - $\tau$ と $\sigma$ が型であるとき $(\tau, \sigma)$ もまた型である
1. Maybe型
    - 型 $\tau$ に対して $\mathrm{Maybe}~\tau$ は型
    - `Maybe t = Just t | None` と書く
1. Either型
    - 型 $\tau, \sigma$ に対して $\mathrm{Either}~\tau~\sigma$ は型
    - `Either t s = Left t | Right s`

## 型の数

型に数を, それも (0以上の) 自然数を割り当てることをしてみる.

ある型 $\tau$ について, その型を取る値が有限通りしかない場合がある.

$()$ と $\Bool$ 型がそれで,
Bool型は `true, false` という2つの値しか持たない.
また特別に作った $()$ という型は `()` という1つの値しか持たない.
これを型の数だということにしてみる.

| type    | number  |
|:-------:|--------:|
| $()$    |       1 |
| $\Bool$ |       2 |

リスト, タプル, Maybe, Either という型は, 型を与えて型を構成するものであったので,
既に数が分かっている型を与えた場合の型の数を調べることにする.

簡単な順に見ていく.

## タプル型の数

$\tau$ の数が $t$ で $\sigma$ の数が $s$ のとき
$(\tau, \sigma)$ を取る値はそれらの直積なので:

| type                  | number       |
|:---------------------:|-------------:|
| $(\tau, \sigma)$      | $t \times s$ |

例えば $(\Bool, ())$ の値は `(true, ())` と `(false, ())` の 2つがある.

## Maybe 型の数

$\tau$ の数を $t$ とすると,
$\mathrm{Maybe}~t$ は $t$ または $()$ であるので, 1 だけ増えて:

| type                  | number  |
|:---------------------:|--------:|
| $\mathrm{Maybe}~\tau$ |   $t+1$ |

## Either 型の数

Maybe と同様で, $\sigma$ または $\tau$ なので, 単純に足す.

| type                          | number  |
|:-----------------------------:|--------:|
| $\mathrm{Either}~\tau~\sigma$ |$t+s$    |

### リスト型の数

$\tau$ の数を $t$ とするとき $[\tau]$ の数を考える.
いくつか考え方はある.

リストは長さを固定した場合, それがタプルと等価であることはすぐに分かるだろう (例えば `[a,b,c] == (a,b,c)`).
従って, 長さが $n$ に固定されたリスト $[\tau]$ の数は $t^n$ である.
実際にはリストの長さは $0$ 以上の整数全てを取るので
$$L(\tau) = \sum_{n\geq 0} t^n = 1 + t + t^2 + t^3 + \cdots$$
と書ける.
もちろんこれは収束しない値だが.

あるいは次のような考え方もできる.
リストとは長さが $0$ であるかそれより大きいかに場合分けできる.
空リストは $()$ と等価.
長さが $0$ より大きい時, 1つ目の要素と2つ目以降のリストとの組に分解できる.

```haskell
f : [t] -> Either () (t, [t])
f [] = Left ()
f (x:xs) = Right (x, xs)
```

この $f$ は $[\tau]$ と $\mathrm{Either}~()~(\tau, [\tau])$ との同型になっている.
つまり等価な型であり, その数も等しいはずである.

$[\tau]$ の数を $L$ と置くと, 今タプルや Either の数は分かっているので次のように立式できる:
$$L = 1 + t \times L$$
これを解くと
$$L = \frac{1}{1 - t}$$
を得る.
右辺を級数展開すると先程の結果と一致する.
$$\frac{1}{1-t} = 1 + t + t^2 + \cdots$$
($-1 < t < 1$ の範囲の実数ならだけど.)


| type            | number  |
|:---------------:|--------:|
| $[\tau]$        | $\frac{1}{1-t}$ |

## 型の微分

型に自然数を割り当てることをしてきたが,
リストやMaybe, またそれらの合成は, いわば自然数から自然数への関数として機能しているように見える.
最後のリストがまさにそうだった.
$$L(t) = \frac{1}{1-t}$$
`[]` が型 `t` を型 `[t]` に写すものであるのと同様に,
$L$ は型の値 $t$ を型の値 $L(t)$ に写すものである.

タプル, Maybe や Either には
$$T(t, s) = t \times s$$
$$M(t) = t + 1$$
$$E(t, s) = t + s$$
という関数があるのが見える.

これらを微分することにはどんな意味があるか.
とりあえず代数的には (偏) 微分することが出来る.
$$\dd{T}{t} = s, \dd{T}{s}=t$$
$$\dd{M}{t} = 1$$
$$\dd{E}{t} = 1, \dd{E}{s} = 1$$
$$\dd{L}{t} = \frac{1}{(1-t)^2}$$

$T,M,E$ の微分には, それに対応する型があるが, $L$ についてはよくわからない.
実はこれに対応する型は次のようなものである.

### Zipper

次のようなデータ構造を考える.
リストをある地点に注目してそこから左と右とに分割するのだ.

```haskell
data Zipper a = Zipper [a] [a]

pop :: Zipper a -> a
pop (Zipper _ (x:xs)) = x

lpush :: Zipper a -> a -> Zipper a
lpush (Zipper left right) x = Zipper (x : left) right

rpush :: Zipper a -> a -> Zipper a
rpush (Zipper left right) x = Zipper left (x : right)

lrot :: Zipper a -> Zipper a
lrot (Zipper left (x : right)) = Zipper (x : left) right

rrot :: Zipper a -> Zipper a
rrot (Zipper (x : left) right) = Zipper left (x : right)
```

これは全体として表現するものはリストと同じであるが, リストの中のある地点 (要素と要素の境界) に注目して `pop` `push` を書き直したもの.
その値を `pop` する, その左右に値を `push` する, 注目する要素を動かす (`rot`), といった操作で編集することで計算量がリストとは違う.

ところでそれはいいんだけど, `Zipper a` という型の値を計算すると,
`a` の値をやはり $t$ だとすると
$$Z(t) = L(t) \times L(t) = \frac{1}{(1-t)^2}$$
であることが分かる.
そしてこれは明らかに $\dd{L}{t}$ である.

Zipper はリストを分割したものであって, 分割の仕方に意味があるので (一意ではないので) リストよりも豪華になっている.

まあリストの微分に対応する型がなんでもいいから知りたいなら何でも作れるし, `Zipper` とか導入しなくていい.
のだけど, この事実を元にして, ある型 (データ構造) `T` の微分に対応する型 (データ構造) を `T-Zipper` と呼ぶ.

### BTree (2分木)

ノードのみに値を持つ二分木を定義する.

```haskell
data BTree a = Empty | Node a (BTree a) (BTree a)
```

この値は
$$B(t) = 1 + t B^2(t)$$
という式を満たすものである.
陽には解かないで微分だけして, それに対応するデータ構造を考えてみる.
まず両辺を微分すると,
$$\dd{B}{t} = 2t B(t) \dd{B}{t} + B^2(t)$$
を得る. これを解くと
$$\dd{B}{t} = \frac{1}{1-2tB(t)} B^2(t)$$
になる. 右辺に $B(t)$ があるのでやはり陽に解けてはないが.
$\dd{B}{t}$ に対応するデータ構造を考える.
$\frac{1}{1-2tB(t)}$ はリストの値を思い出せば $L(2tB(t))$ に等しいので, 例えば `[(Bool, a, BTree a)]` という型の値に等しい.
$B^2(t)$ は BTree が2つ並んだものと解釈するしかない.
というわけで $\dd{B}{t}$ に対応する型として次のようなものがある.

```haskell
data BTreeZipper a = BTreeZipper BTree BTree [(Bool, a, BTree a)]
```

リストの Zipper がある地点に注目して分割したものであったように,
BTree の Zipper も, あるノードに注目して分割したものだと思える.
つまり

```haskell
zipper = BTreeZipper left right steps
```

とはあるノード (の直下) に注目してその左下に `left`, 右下に `right` という二分木があって,
更にそこからルートまで一つずつ辿ったものが `steps`.
`steps` の各要素

```haskell
step = (dir, value, child)
```

は, ノードの値が `value` で, 今来たのと逆 (左から来たなら右) に二分木 `child` が付いてて, その方向を `dir :: Bool` で決めている.

と解釈できる.

以上のように再帰構造の Zipper を取ると意外と, それそのものの別な表現が得られることがある.
