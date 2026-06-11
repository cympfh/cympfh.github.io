% 一般ルービックキューブ NxNxN 解法
% 2026-06-09 (Tue.)
% パズル

## index

<div id=toc-level-2></div>

## 概要

普通ルービックキューブは 3x3x3 からなる立方体であるが,
これを拡張した 4x4x4, 5x5x5 などが存在する.
ここではこれらを一般化した NxNxN について考える.

とは言え実は 4x4x4 と 5x5x5 までが必要な知識の上限であり（偶数奇数の違いはある）,
それ以上はただ再帰的に解法を適用していくだけである.

また 3x3x3 の解法は知っているものとする.

## 偉大なる参考リンク

- [[https://cube.uubio.com]]
- [[https://cubevoyage.net/speedcubing/]]

## 記法・名称

### 図

U 面と F 面と R 面を見せてルービックキューブの状態を示す.
色の配置は [世界基準色](https://store.tribox.com/user_data/puzzle_color.php) に従う.

<div style='text-align: center'>
    <figure style='width: 35%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/cube_front.svg" alt="ルービックキューブの図" width="200">
        <figcaption>F面が真正面にあって上にU面, 右にR面</figcaption>
    </figure>
    <figure style='width: 35%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/cube_balanced.svg" alt="ルービックキューブの図" width="200">
        <figcaption>等角図. 上にU面があって左下がF面, 右下がR面</figcaption>
    </figure>
</div>

また「状態が不明（問わない）」なパーツは灰色で描く.

### パーツの名称

ルービックキューブの内外側から見えていて回す対象であるパーツは次の3つに分類される.

- センターキューブ
    - 一色の面を持つパーツ
    - 各面の中心に位置する
- エッジキューブ
    - 二色の面を持つパーツ
    - 各面の辺に位置する
- コーナーキューブ
    - 三色の面を持つパーツ
    - 各面の角に位置する

<div style='text-align: center'>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/center.svg" alt="センターキューブ" width="200">
        <figcaption>センターキューブ</figcaption>
    </figure>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge.svg" alt="エッジキューブ" width="200">
        <figcaption>エッジキューブ</figcaption>
    </figure>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/corner.svg" alt="コーナーキューブ" width="200">
        <figcaption>コーナーキューブ</figcaption>
    </figure>
</div>

### 回転の記法

[シングマスター記法](https://tribox.com/3x3x3/solution/notation/) に倣う.
ただし NxNxN なので拡張する.

#### 外側一層の回転

最も外側一層だけの回転は 3x3x3 のときと全く同様

- $U$: U 面を正面から見たとき一層だけを時計回りに 90 度回す
- $U'$: 反時計周りに 90 度回す
- $R$: R 面を正面から見たとき一層だけを時計回りに 90 度回す
- $R'$: 反時計周りに 90 度回す
- $F/F'$: 同様
- $D/D'$: 同様
- $L/L'$: 同様
- $B/B'$: 同様

#### 複数層の回転

一般の NxNxN の場合, 一度に複数の層を回すこともできる.
このとき層の数 $m$ とどの面であるかを組み合わせて次のように表記する.

- $mU$: U 面を正面から見たとき最も外側にあるものから連続した $m$ 層を時計回りに 90 度回す
    - ここで $m$ は具体的な数であって, 実際には $2U$, $3U$ などと表記する
    - もちろん $U$ 以外でも $2U'$ とか $3B$ などと書く.

<div style='text-align: center'>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/2U.svg" alt="2U" width="200">
        <figcaption>灰色の層が 2U</figcaption>
    </figure>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/2R.svg" alt="2R" width="200">
        <figcaption>灰色の層が 2R</figcaption>
    </figure>
</div>

#### 中間層の回転

また, 外側数えて $m$ 番目だけの一層の回転を考えることもある.
このときは $m$ と小文字でどの面かを組み合わせて次のように表記する.

- $mu$: U 面を正面から見たとき外側から数えて $m$ 番目の層を時計回りに 90 度回す
    - ここで $m$ は具体的な数であって, 実際には $2u$, $3u$ などと表記する

とくに $m$ が $1$ の場合の $1U$ とか$1u$ はただの $U$ と等しいので単に $U$ と書く.

<div style='text-align: center'>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/2u.svg" alt="2u" width="200">
        <figcaption>灰色の層が 2u</figcaption>
    </figure>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/2r.svg" alt="2r" width="200">
        <figcaption>灰色の層が 2r</figcaption>
    </figure>
</div>

#### 繰り返しは下添字で書く

- $X_m$: 操作 $X$ を $m$ 回繰り返す
    - 例えば $U_2$ は $U$ を 2 回繰り返すこと（すなわち 180 度回すこと）を意味する
    - $X$ は何でもよく, 括弧を使って $(RUR'U')_4$ のように複数の操作をまとめて繰り返すこともできる

> 3x3x3 では $U_2$ のことを `U2` と書くのが一般的であるが,
> 数字は層数にも使うので, 混乱を避けるために下添字で表記することにする.

#### 逆操作はプライム (') で書く

既に $U'$ や $F'$ などと書いていたが, もっと自由に複数の操作の逆操作を考えることが出来る

- $X'$: 操作 $X$ の逆操作
    - 例えば $U'$ は $U$ の逆操作である
    - 一般に $(AB)' = B'A'$
    - 例えば $(RUR'U')' = URU'R'$

#### 補助記号

既に使ったが意味ある単位でグルーピングするのに括弧を使う.
また単に区切る為に $-$ を使うこともある.
これらは読みやすさのためであって, 操作の意味には影響しない.

- $2R - (U R' U')_2 - 2R'$
- これは $2R U R' U' U R' U' 2R'$ と同じ意味

また特に互いに影響無く順序を入れ替えられる操作を並べるときは $+$ で区切る.

- $U+D'$

これは $U-D'$ と読んでも $D'-U$ と読んでも同じ意味.
特に「同時に回すことが可能」というニュアンスで使ってる.

### コミュテータ

[コミュテータ](https://scrapbox.io/speedcube/%E4%BA%A4%E6%8F%9B%E5%AD%90_%28commutator%29) または交換子とは,
二つの操作 $A$ と $B$ があるときに $ABA'B'$ と操作することで, ある特定のパーツだけを狙って動かす手順をいう.
これを$[A, B]$ と書く.

$$[A, B] = ABA'B'$$

例えば $[R, U]$ は $R U R' U'$,
$[R, UF]$ は $RUF - R'F'U'$ という手順を表す.

理論的な詳細はリンク先参照.

## 解法

### 全体の流れ

1. センターキューブを揃える
2. エッジキューブを揃える
3. 3x3x3 と見做して解く
4. パリティを修正する

<div>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/overline-4x4x4-1.svg" width="200">
        <figcaption>Step 0</figcaption>
    </figure>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/overline-4x4x4-2.svg" width="200">
        <figcaption>Step 1. 各面のセンターキューブを揃える</figcaption>
    </figure>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/overline-4x4x4-3.svg" width="200">
        <figcaption>Step 2. 各辺のエッジキューブを揃える</figcaption>
    </figure>
</div>

<div>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/overline-4x4x4-4.svg" width="200">
        <figcaption>Step 2'. ぐっと睨むと 3x3x3 に見えてくる</figcaption>
    </figure>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/overline-4x4x4-5.svg" width="200">
        <figcaption>Step 3. 3x3x3 として解く</figcaption>
    </figure>
</div>

<figure>
    <img src="cube-nxnxn/overline-4x4x4-5-parity.svg" width="200">
    <figcaption>Step 4. パリティを修正する</figcaption>
</figure>

4x4x4 以降のルービックキューブにはパリティエラーが存在する.
つまりエッジが反転した状態が発生しうる.
この場合は修正手順が追加で必要.

### センターキューブを揃える

$N$ が奇数の場合各面の中心のセンターキューブが正しい色として固定されていると見なせるので,
これを基準にして各面のセンターキューブを揃える.
偶数の場合はどの色を集めてきてしまえるのだが, 最後に 3x3x3 として解くときに不能な配置にもできるので注意.
例えば本来は白色の向かい面が黄色だが, ここに赤色を集めてしまうことも可能だが最終的には解けなくなってしまう.
3x3x3 のときの色の配置を覚えておいて, それに従ってセンターキューブを揃えること.

各面にセンターキューブは $(N-2) \times (N-2)$ あるがいきなり揃えるのではなく,
（奇数なら） $1 \times 1 \to 3 \times 3 \to \cdots \to (N-2) \times (N-2)$ と少しずつ育てていく.
奇数の場合は最初から $1 \times 1$ が, 偶数の場合は（見えないけど） $0 \times 0$ が揃っている状態からスタートする.

#### $k \times k$ が揃ってる状態から $(k+2) \times (k+2)$ を揃える

さらに 2 ステップからなる

<div>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/center-align-0.svg" width="200">
        <figcaption>k x k が既に揃ってる</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/center-align-1.svg" width="200">
        <figcaption>(k+2)x(k+2) のコーナーを全部持ってくる</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/center-align-2.svg" width="200">
        <figcaption>(k+2)x(k+2) のエッジを全部埋める</figcaption>
    </figure>
</div>

##### $(k+2) \times (k+2)$ のコーナーを全部持ってくる

最終的に全面のコーナーを持ってくることが目的.
それまではどの面のどのコーナーを持ってきてもいい.

コミュテータ
$$[mr, U']$$
すなわち $mrU' - mr'U$ を使うことで自由に集める.

実際には $mr$ は $mR$ としても影響はない.
また, 手順の最後の $U$ は特に意味が無いので, 以下の例では省略している.

<div>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/center-align-corner-a1.svg" width="200">
        <figcaption>黒色の層を mr とする</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/center-align-corner-a2.svg" width="200">
        <figcaption>mrU' - mr'</figcaption>
    </figure>
</div>

<div>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/center-align-corner-b1.svg" width="200">
        <figcaption>黒色の層を mr とする</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/center-align-corner-b2.svg" width="200">
        <figcaption>mrU' - mr'</figcaption>
    </figure>
</div>

<div>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/center-align-corner-c1.svg" width="200">
        <figcaption>黒色の層を mr とする</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/center-align-corner-c2.svg" width="200">
        <figcaption>mrU' - mr'</figcaption>
    </figure>
</div>

D面から持ってきたかったら $mr_2 U' - mr_2$ とすればいい.

##### $(k+2) \times (k+2)$ のエッジを全部埋める

コミュテータ
$$[mr, (U'kl'U)]$$
を使う
(実際には最後の $U$ は省く).

<div>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-align-7d.svg" width="200">
        <figcaption>F面の 2r 3u 層にある赤を上に持っていきたい</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-align-7f.svg" width="200">
        <figcaption>2rU'3l'U</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-align-7g.svg" width="200">
        <figcaption>2r'U'3lU</figcaption>
    </figure>
</div>

<div>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-align-7a.svg" width="200">
        <figcaption>F面の 2r 5u 層にある緑を上に持っていきたい</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-align-7b.svg" width="200">
        <figcaption>2rU'5l'U</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-align-7c.svg" width="200">
        <figcaption>2r'U'5lU</figcaption>
    </figure>
</div>

<div>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-align-double-a.svg" width="200">
        <figcaption>複数あってもOK</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-align-double-b.svg" width="200">
        <figcaption>2rU'(3l'+5l')U</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-align-double-c.svg" width="200">
        <figcaption>2r'U'(3l+5l)U</figcaption>
    </figure>
</div>

### エッジキューブを揃える

#### エッジペアリング

F面の左にあるエッジキューブを右に持ってくるという **エッジペアリング** を繰り返すことでエッジキューブを揃える.

<div>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-pairing-4-start.svg" width="200">
        <figcaption>このエッジのペアを</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-pairing-4-end.svg" width="200">
        <figcaption>くっつけたい</figcaption>
    </figure>
</div>

<div>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-pairing-7-start.svg" width="200">
        <figcaption>このエッジのペアは</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-pairing-7-end.svg" width="200">
        <figcaption>同じエッジにいるべき</figcaption>
    </figure>
</div>

左の動かしたいエッジが U 面から見て $ku$ 層にあるとき, コミュテータ
$$[ku'R, U']$$
を使うことでペアリングできる.

<div>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-pairing-4-a.svg" width="200">
        <figcaption>黒色のペアは壊れるで注意</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-pairing-4-b.svg" width="200">
        <figcaption>2u'RU'</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-pairing-4-c.svg" width="200">
        <figcaption>R'2uU</figcaption>
    </figure>
</div>

<div>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-pairing-7-a.svg" width="200">
        <figcaption>黒色は壊れる</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-pairing-7-b.svg" width="200">
        <figcaption>(3u+5u)RU'</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/edge-pairing-7-c.svg" width="200">
        <figcaption>R'(3u'+5u')U</figcaption>
    </figure>
</div>

ただしこれらは必ず黒色を壊してるので,
最後は以下が必要.

#### 三点交換

左から $k$ 層目と右から $k$ 層目のエッジの三点を交換する手順

<figure>
    <img src="cube-nxnxn/edge-rotate-3p.svg" width="200">
    <figcaption>この三点が時計回りに一個ずつ移動する</figcaption>
</figure>

$$\begin{align*}
[kl', U_2 krU_2 kr' U_2]
&= kl' U_2 krU_2 kr'U_2 - klU_2 kr U_2 kr'U_2 \\
\end{align*}$$

#### 四点交換a

左から $k$ 層目と右から $k$ 層目のエッジの四点を交換する手順

<figure>
    <img src="cube-nxnxn/edge-rotate-4p.svg" width="200">
    <figcaption>この四点が反時計周りに一個ずつ移動する</figcaption>
</figure>

$$kr_2 E' - (kr' U_2)_4 kr' - E kr_2$$

ただしここで $E$ とは
$E = (2f + 3f + \cdots + (N-1) f)$
のこと.

#### 四点交換b

こちらも
左から $k$ 層目と右から $k$ 層目のエッジの四点を交換する手順.
ただしF面の二つとD面の二つが交換される.

<figure>
    <img src="cube-nxnxn/edge-rotate-4p.svg" width="200">
    <figcaption>手前の二つと奥の二つの交換</figcaption>
</figure>

$$[kr_2, F_2U_2] - kr_2$$

### 3x3x3 と見做して解く

一旦 F2L なりで自由に解く.
ただし 50% の確率でエッジが反転している状態になるえる.

<figure>
    <img src="cube-nxnxn/miss-parity-4.svg" width="200">
    <figcaption>ダメなエッジパリティ</figcaption>
</figure>

これはもう 3x3x3 としては解けないので次のパリティ修正のステップに進む.

### パリティを修正する

四点交換a
$$kr_2 E' - (kr' U_2)_4 kr' - E kr_2$$
を適用してから三点交換
$$kl' U_2 krU_2 kr'U_2 - klU_2 kr U_2 kr'U_2$$
を適用するとパリティが修正される.
<div>
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/miss-parity-4.svg" width="200">
        <figcaption>FUエッジが反転してる</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/miss-parity-4b.svg" width="200">
        <figcaption>四点交換a を適用</figcaption>
    </figure>
    &rarr;
    <figure style='width: 25%; display: inline-block; margin: 0'>
        <img src="cube-nxnxn/miss-parity-4c.svg" width="200">
        <figcaption>三点交換を適用</figcaption>
    </figure>
</div>

