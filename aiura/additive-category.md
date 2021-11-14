% 加法圏
% 2021-11-14 (Sun.)
% 圏 代数

清水勇二による「圏と加群」の p.146 あたりの話.
初版第一刷を読んでるが, 記号の誤りが激しい（後述するように直積と直和が実は同値な圏の話ではあるのだが, 記号は一貫してほしいものだ）.

また nLab の次のページでカバーされている.

- [nLab - additive category](https://ncatlab.org/nlab/show/additive+category)
- [nLab - Ab-enriched category](https://ncatlab.org/nlab/show/Ab-enriched+category)

## INDEX

<div id=toc></div>

## 記法

圏の始対象のことを $0$ と書く.
圏の終対象のことを $1$ と書く.
また恒等射のことも対象を明記せずに単に $1$ と書く.

対象の $X,Y$ の直積を $X \times Y$, 直和を $X \sqcup Y$ と書く.
直積は自然に射影を伴うがこれを $\pi_1, \pi_2$ と書く.
同様に直和は入射を伴ってこれを $\iota_1, \iota_2$ と書く.
また, それぞれは射 $f,g$ から自然に $f \times g$, $f \sqcup g$ を導くが, これらは次のことを言う.

![](https://uc8d450052deb9479734c4161562.previews.dropboxusercontent.com/p/thumb/ABVU3kEOVP799PWQQVcMCBXHjkuK3_YHAcX0QH4MwXCRrvVuvlrFll4J7O90Sl_9JGC9uU6B273TScJgMPx1fhx4uwsagbQCx7WetKoRIDRBg60KS8JJaweNZaCMntzUsVOQepwL1WJ8LGn8dGh2UhcmMr9Cwrzk4iV6CDGL2fBD9G2bWA26Ph7paSyvEUpVaciGza5cmifYRSSPm9PpdIWzOa26zWJ1vjGqeq4F0mj7qOKsC_rQa_j4ZWdtf67qPIXWqQrjhDEpkayK_sB1aBJ-Vwrporz-ZXSuoOlOkBM3Y2Hyy3BRnz5n2JUV6ZULOKX6g4tRj5Z762pyebuT-xr0gMGboIy0wNcwqAveJFk84-nmEXNH1H_nxtSz5stdehY/p.jpeg)

ここで登場する群はすべて加法に関する群で, 演算を $+$, 単位元を $0$ とする.
射の合成は普通に $f \circ g$ などとも書くが,
乗算のように $fg$ のようにも略記する.

$\def\C{\mathcal C}$

## 対角射と余対角射

必要になるのは少し後だが先にやっておく.

直積及び直和が存在する圏において,
$X = X = X$ という図式を $X \times X$ 及び $X \sqcup X$ の普遍性に当てはめるだけで次のような2つの射が作れる.

![](https://uc8f3e4e523307de852a0b1e5bfd.previews.dropboxusercontent.com/p/thumb/ABUmtl413VT3cHDCj3K661T4MFbQ-mdJ6jMus6zUJ20CjUtfaguroN-B-RmHa5kCAFrExCL_0374ME6Hkl2S59j2dZnLKBk98qrdlyPDWppf7iWpCu1Fw5hMTcmgWEWjGhe4n1whDCaYDo-5GyT-FM_vWTPyQfQbOy-bKlXxU8F_dKfF34JZpb7ylBWk2epg6BMq1ZwJgD62G6sw6opLsw809ABy32iuInIqQc8kMqW_6E9vOHoPmNab_l5xl_xgHWLKJ25bUWbAY4zdD9X-c0FWCy29c0yuVWQHZsORZidIQzF1RF_xn1JGj7Xy1C1BOQEIS2D71e0EH-_RvkA7jKbAgcPlq7uormiMMBqrNiErp4-uJtgbvNJurOKbTHpUeNg/p.jpeg)

各対象 $X$ について, 次の射が存在する:

- 対角射 $\Delta \colon X \to X \times X$
    - $\pi_1 \Delta = \pi_2 \Delta = 1$
- 余対角射 $\nabla \colon X \sqcup X \to X$
    - $\nabla \iota_1 = \nabla \iota_2 = 1$

## 前加法圏の定義

圏 $\C$ の各 Homset $\C(X,Y)$ が Abel 群になっている.
さらに射の合成がこの群に関する準同型になっているとする.
つまり,

- $f (g+h) = fg + fh$
- $(f+g) h = fh + gh$

が成り立っている.
次は自然に導かれる.

- $f0=0$
- $0f=0$

以上が成り立つとき, $\C$ を **前加法圏** という.

### 前加法圏の例

対象が唯一 $\ast$ しかない前加法圏は環である.
つまり $M = \C(\ast, \ast)$ は $+$ に関する Abel 群で,
合成 $m \colon M \times M \to M$ は $\times$ に関するモノイドになっている.

## 加法圏の定義

前加法圏 $\C$ が

- ゼロ対象を持つ
    - 始対象であってかつ終対象でもあるような対象のこと
- 2つの対象に関する直和をいつも持つ
    - 「有限余極限をいつも持つ」くらいに言い換えても問題ない

この2つを満たすとき, これを **加法圏** という.

## 有限直積のある前加法圏は加法圏

前加法圏 $\C$ が,

- 終対象 $1$
- 直積 $X \times Y$

を持つときに, $1$ がゼロ対象であり, $X \times Y \simeq X \sqcup Y$ が成り立つことで加法圏の要件を満たす.

### 証明

#### 概略

$X \times Y \simeq X \sqcup Y$ だけ示せば良い.
これには適切な入射 $\iota$ を以て $X \times Y$ が確かに直和であることを確認すればよい.

これがすでに示されたとき,
終対象 $1$ について
$1 \simeq 1 \times 1 \simeq 1 \sqcup 1 \simeq 0$
となって始対象であることは簡単に分かる.

#### 入射 $\iota$ の構成

さて, 直積があることから $X_1 \times X_2$ に対してその射影

- $\pi_1 \colon X_1 \times X_2 \to X_1$
- $\pi_2 \colon X_1 \times X_2 \to X_2$

ここで入射のようなもの（実は入射そのものになっている）を次のとおりに定める.

- $\iota_1 = (1 \times 0) \Delta$
- $\iota_2 = (0 \times 1) \Delta$

ここで $\iota_1$ の右辺に登場する $1$ は $X_1 \to X_1$ なる恒等射のことで,
$0$ は群 $\C(X_1, X_2)$ の単位元であることに注意.

![](https://ucfb0f4f8df90507aa3030e2a55a.previews.dropboxusercontent.com/p/thumb/ABV8uOu1zhn8PvkTgaBnFNKELj4_MH-HZjD6e3asN8CLD6TP7f-xwtywq1FOxvb_qN-QoV1r1euQKxqXInypApp0qBEQ3YesBu7NDWazK4o4XvqvOJjSAurAMhbDhDSdNX2tJ1xB8kOlk1Bvc0qiuGTnfQ3H_neS2no14AH6GjrNaEvseFIulw9aOh1Pegej_vquc0thSfBUnxzHDd3icyJSCywEz4xOPvHQNkHznmDR1EPCw4K6cjBHwp9XPUC8R77fLi__tO5dRn7mwMmu1ClPnHuaQ3fClL2ztSoZilVnBmk4Mxg6jmGu4wgHRXYn0ANzXOEkBhKacC5UOZtcr3FzizzADfA3a0cv4cjalO9_hZAkMFOILj4k7rZbkocA6sk/p.jpeg)

#### 射影と入射が満たす性質

$\pi_1, \pi_2$ 及び上記で作った $\iota_1, \iota_2$ について確認しておくべき性質は次の5つ.

- $\pi_1 \iota_1 = 1$
- $\pi_1 \iota_2 = 0$
- $\pi_2 \iota_1 = 0$
- $\pi_2 \iota_2 = 1$
- $\iota_1 \pi_1 + \iota_2 \pi_2 = 1$

最初の4つについては, クロネッカーのデルタを使って,
従って $1$ がゼロ対象となる.
$$\pi_i \iota_j = \delta_{i,j}$$
なんて書くこともできる.
さて $\iota_j$ の定義を入れれば,
$$\pi_1 (f \times g) \Delta = f$$
を一般に示せれば4つすべて示せたことになる.
これには $f \times g$ の作り方を思い出せば良くて, そのために「記法」の章に載せた図式をぐっと睨むと,
$$\pi_1 (f \times g) = f \pi_1$$
が得られる.
これを代入して,
$$\pi_1 (f \times g) \Delta = f \pi_1 \Delta = f 1 = f$$
$\pi_1 \Delta=1$ も「対角射と余対角射」の章に書いた.

5つ目については左辺から $\pi_1, \pi_2$ を掛けると,

- $k = \iota_1 \pi_1 + \iota_2 \pi_2$ として,
    - $\pi_1 k = 1 \pi_1 + 0 \pi_2 = \pi_1$
    - $\pi_2 k = 0 \pi_1 + 1 \pi_2 = \pi_2$
        - 逆に, この2つを満たす射 $k$ として $k=1$ があるわけだが, 普遍性よりこれが唯一なので $k=1$

#### 直和であることの確認

これで実は $(X_1 \times X_2, \iota_1, \iota_2)$ が $X_1, X_2$ の直和になっていることを見ていく.
直和の定義は下を可換にするような射 $!$ が存在して, そしてそれが唯一であることだった.

![](https://uc80a2fd225a99447bba47c23827.previews.dropboxusercontent.com/p/thumb/ABWn5WMHT-If6RZJiqqmSR6FusyGDlSYQhO-Nb8zhbj26OHYBZuCHuIyucuR1fA-IhljSRl-KBnugGAMTXc-MFZyl8fVOMX2JFGop25SdCmDhLVh-ahJWNhumfMnzd_2SI_YK2HdpaaAzdaaL_93NrjSQeX-AhKC4smkVdJcrujZLp4ftlaBmBf56KuoDhK_mlUpotbbrTEdyl8hBS0yFk-JYL_PUxbWZMrm0hIbmAeti3gZncOVqoVGJtPamuSbsQQYbV7L5S0va68xxgcq_T3HHNFQXPAfPjhJD44Ers2Gw7QrUGZFek__DR3JKoSEudlSBkVrbaTzSq0kT1DbnClOrf4F94TR_N05xZ9ApZ7SxjDyvUm7gAfZzZyNaX7gqTM/p.jpeg)

$\iota_1 \pi_1 + \iota_2 \pi_2 = 1$ という等式があったが, これの $\iota$ を $u$ に取り替えれば
$$! = u_1 \pi_1 + u_2 \pi_2$$
これでよい.

- 可換であること
    - $! \iota_1 = u_1 \pi_1 \iota_1 + u_2 \pi_2 \iota_1 = u_1 \circ 1 + u_2 \circ 0 = u_1$
    - 同様に $! \iota_2 = u_2$
- 唯一であること
    - 別な $? \colon X_1 \times X_2 \to Z$ でも可換だとすると,
    - $u_1 = ! \iota_1 = ? \iota_1$
        - 右辺から $\pi_1$ を掛ければ
        - $u_i \pi_1 = ! (\iota_1 \pi_1) = ? (\iota_1 \pi_1) \implies ! \circ 1 = ? \circ 1 \iff ! = ?$

以上から, 終対象と直積だけあれば加法圏であるし,
しかも直積と直和（終対象と始対象）が同型であることがわかった.

## 加法圏は直積を持つ

逆に加法圏は直和の存在だけが定義として要請されているが,
先程の議論を全く同様に適用することで,
始対象と直和だけがあれば終対象と直積を持つ加法圏であって,
しかも直積と直和（終対象と始対象）が同型であることが分かる.

双対を取るだけなので自明だが,
入射 $\iota$ に対して

- $\pi_1 = \nabla (1 \sqcup 0)$
- $\pi_2 = \nabla (0 \sqcup 1)$

とすればこれが直積への射影となっていることが確認できる.

## 加法圏の性質

$X \times X \simeq X \sqcup X$ の射影及び入射について,

- d1) $\iota_1 + \iota_2 = \Delta$
- d2) $\pi_1 + \pi_2 = \nabla$

この記事の加法圏の定義ではそもそも陽には直積がなく, 従って $\Delta$ と $\pi$ が無いわけだが,
その場合は (d1) 自体が $\Delta$ の定義であり, 前章で作った $\pi$ について (d2) が成立する.
前加法圏が直積を持つ場合には, 前々章で作った $\iota$ が (d1) を満たし, (d2) が $\nabla$ の定義になる.

$f, g \colon X \to Y$ について,

- e1) $f \times g = f \sqcup g = \iota_1 f \pi_1 + \iota_2 g \pi_2$
- e2) $f + g = \nabla (f \sqcup g) \Delta$

すべて簡単な式変形で確認できる.
また (e2) は $X \times Y \simeq X \sqcup Y$ と (e1) の $f \times g = f \sqcup g$ という同一視を暗黙に使った等式になっている.
