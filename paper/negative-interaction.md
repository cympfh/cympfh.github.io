% Negative Interactions for Improved Collaborative Filtering: Don’t go Deeper, go Higher
% https://dl.acm.org/doi/10.1145/3460231.3474273
% 推薦システム Netflix

## 概要

協調フィルタリングによる推薦システムの適合率 (Accuracy) は
higher-order interaction
を使うことで改善できる.
非線形の Deep learning でこれを学習することは理論上可能なはずだが実用上は奮わない.
そこで explicit な入力を追加できる full-rank な線形モデルの拡張を考える.
この論文で出来るモデルは線形の HOSLIM モデルの拡張だと見る事ができることも見ていく.
この改善の理由としては, 使ったデータセットでは負例の数に対して正例の個数が少なすぎることにある.
要するにデータがスパースすぎるのが問題!!
higher-order interaction はこれを大きく改善できる.

## Review: Pair-wise Model

ここでは Shallow AutoEncoder, [EASE, Netflix](EASE) を紹介する.
あとでこれを higher-order interaction を使うような拡張をする.

訓練データセットではユーザー集合 $U$ とアイテム集合 $I$ があって,
interaction データとして $X \in \mathbb R^{U \times I}$ が与えられる.

モデルはパラメータ $B \in \mathbb R^{I \times I}$ を以て次の損失を最小化する.

$$\|X - XB\|^2 + \lambda \|B\|^2 ~  \text{ s.t. } ~ \mathrm{diag}(B) = 0$$

ただしここで行列の絶対値 $\| X \|^2$ はフロベニウスノルムの自乗を表す.
$\lambda$ は罰則項へのハイパーパラメータ.

$\mathrm{diag}(B)=0$ は対角成分がゼロという意味.
これは $B=I$ という自明解を避ける意味がある.

> $\mathrm{diag}$ は
> $N \times N$ 行列を渡したらその対角成分を取ってきて長さ $N$ ベクトルを作る両方を表す関数のこと.
> 逆に,
> 長さ $N$ のベクトルを渡したら, それを対角成分に持つ $N \times N$ 対角行列を作る関数のことも,
> 同じ記号 $\mathrm{diag}$ で表す.
> 参考として NumPy の [numpy.diag](https://numpy.org/doc/stable/reference/generated/numpy.diag.html)
> 関数がある.

そしてこの最小化はラグランジュの未定乗数法を使うと次の式で解けるそう.

- $P = (X^t X + \lambda I)^{-1}$
- $\hat{B} = I - P \cdot \mathrm{diag}(1 / \mathrm{diag}(P))$

ここで $/$ はベクトルの成分ごとの割り算.
この $\hat{B}$ がさっきの式の最適解になっている.

さてこれで $\hat{X} = X \hat{B}$ を計算して, その成分 $\hat{X}_{u,i}$ がスコアになってる.

## Higher-Order Model

先の章で紹介したモデル (EASE^R) を higher-order に拡張する.

### データ表現

さっきのモデルでは行列 $B$ はアイテム同士のペアワイズな関係を表していた.
アイテム $i,j$ の関連度を $B_{i,j}$ で表して, アイテム $k,j$ の関連度を $B_{k,j}$ が表している.
ではアイテム $i$ と $k$ の２つをプレイしたユーザーに対して $k$ をレコメンドするスコアは
$$B_{i,j} + B_{k,j}$$
だと計算できる.

一方で $(i,k)$ をプレイした人に $j$ をレコメンドするスコアというものを直接計算できるように
$(i,k;j)$ という三組を持ってまわるモデルを考えることもできる.
このモデルを pair-wise と比較して higher-order であると表現することにする.

ここで $(i,k)$ の部分を一般化して集合 $S$ で置き換える.
すなわち $(S,k)$ という組を持って回る.
これを次数 (order) が $|S|+1$ のモデルと呼ぶ.
pair-wise モデルは次数が 2 のモデルであった.

これを実現する方法としては次数を揃えた高次元のテンソルで表現する方法が一つあるが,
この論文では行列になるように flatten する.
その際には most relevant な $m$ 個に限定して持つ.
すなわち higher-order な関係としてはたかだか $m$ 個の
$$S_1, S_2, \ldots, S_m$$
に限定される.
モデルが持つ関係は
$$\{ (S_r, j) \mid 1 \leq r \leq m, j \in I \}$$
である.

この $m$ 個を選ぶ方法もいくつか考えられるが, それはもう決まった後のモデルの作り方を見てく.

この $S_r$ は次のような行列 $M$ で表現できる.

- $M \in \{0,1\}^{m \times I}$
- $M_{r,i} = 1$ iff $i \in S_r$

つまり $|S_r|$-hot encoding である.

観測データ (interaction data) は次の行列 $X$

- $X \in \mathbb R^{U \times I}$

この2つの行列 $M,X$ を用いて,
higher-order な教師データ $Z$ を手に入れる:

- $Z \in \mathbb R^{U \times m}$
- $Z = f(X \cdot M^t)$

ここで $f$ は適当な（要素ごとへの）非線形関数.

<figure>
<img src="https://i.imgur.com/taVcBh9.png" /><br />
<caption>図は全て本論文からの引用</caption>
</figure>

彼らの例ではすべての $S_r$ は $|S_r|=2$ としてるので,
$Z_{u,r} = 2$ であることが, $S_r$ のすべてをそのユーザーがプレイしたことを意味する.
というわけで $f$ として $2$ 以上かどうかを閾するような関数が考えられる.
といった関数にするとよい.

### モデル

最初のモデルで言うところの interaction データ $X$ に今回作った $Z$ を右にくっつける.
パラメータ行列 $B$ の下に $C$ をくっつける.

<figure><img src="https://i.imgur.com/K3aRXHM.png" /></figure>

あとやることは同じ.

### 目的関数

$X,Z$ を横に並べて作る行列 $(X,Z)$ と,
$B,C$ を縦に並べて作る行列 $(B;C)$ との積は簡単で
$$(X,Z) \cdot (B;C) = XB + ZC$$
であることに注意して,
次を損失関数だとして, これを最小化する.

$$\| X - XB - ZC \|^2 + \lambda_B \| B \| + \lambda_C \| C \| ~ \text{ s.t. } ~ \mathrm{diag}(B)=0, C \odot M=0$$

$B$ が過学習しないように相変わらず $\mathrm{diag}(B)=0$ としてるのと全く同様に,
$C$ の過学習防止に $C \odot M=0$ としてある.
これはつまり, $M$ でビットが立ってるところは $C$ では全部ゼロになるようにしてある.

ハイパーパラメータ $\lambda_B, \lambda_C$ があるが,
実験でこれらをグリッドサーチした結果,
$\lambda_B$ は higher-order でないバージョンでの $\lambda$ をそのまま使って良かった.

### 最適解

ラグランジュの未定乗数法を使いつつ, 逐次的にパラメータ更新する方法が載ってある.
結構複雑だし自力で導出も出来ないので省略.

かいつまむと, パラメータ $B$ と $C$ を交互に更新してく.
$B$ を更新するのはさっきと同じで解析的に一発で最適解が求まる.
$C$ はよくわからんことをするんだけど, 成約を満たすようには $(1-M) \odot$ をマスクとして使うと良いよ.

### 関係の選び方

(これは飛んで 5.1 の実験の章の内容)

$m$ 個の $S_r$ の作り方.
ただしここで $|S_r|=2$ としてある.
interaction 行列 $X \in \mathbb R^{U \times I}$ から作る.
$X^t X$ は $I \times I$ 行列.
これの $(i,j)$ 成分は $i$ も $j$ もプレイしたユーザーたちの評価の和になってるのでこれを閾する.

- $\{i,j\} \in S$ iff $(X^tX)_{i,j} > t$
    - $t$ は適当な閾値

## HOSLIM との比較

HOSLIM を知らないんで省略.

## 実験

[hasteck/Higher_RecSys_2021](https://github.com/hasteck/Higher_RecSys_2021)

$m$ を大きくになるにつれて確かに良くなってる.
だがその得られる効果はそんなに大きくなくて, 思ったより $m$ を大きくしないと他と戦えてない.
逆に他手法に勝ててるときはただの EASE^R (つまり $m=0$) でも勝ててる.
Million Song Data データセットでは $|U| = 571k$, $|I| = 41k$ に対して $m=40k$.
それでも $|I^2|$ と比較すれば 40k は全然小さいでしょという主張.

また実験では $|S_r|=2$ の3次までの結果しか載せてないが,
頑張って4次も試したが, 特に良くはならなかったそう.
(じゃあ Go higher じゃねえじゃん！)

HOSLIM との比較.
HOSLIM では $C$ に相当するパラメータに非負である成約がかかってる.
これに揃えて見るために本手法でも $C \geq 0$ を入れたところ悪化した.
負値を取りうるようにしたことに効果がありそう.
関係の選び方は観測データからポジティブなペアとして選んだもののはずなのに, 学習結果の $C$ は大半が負だったそう.
pair-wise では過度にスコアをだそうとしたものを下方修正してると思われる.

Figure 4.
1ユーザーあたりにどのくらいインタラクションがある場合に, higher-order にする効果があるか.
純 pair-wise (EASE^R) と, higher-order (3次) との比較.
非アクティブであるユーザーほど, higher-order の効果が高い.
アクティブ ($>500$) になると緩やかに逆転する.

Figure 5.
higher-order なモデルは中身は pair-wise の部分と 3次の部分とがある.
純 pair-wise と, higher-order モデルから pair-wise 部分だけ取り出して使ったものの比較.
ユーザーが非アクティブであるほど, 後者が上回っている.
Figure 4 でも同じように上回っていたが実はその効果は pair-wise 部分が作っていた.
アクティブ ($>100$) であると逆転する.
($>100, \leq 500$) のことを思うと, これは 3次 部分の補正で勝ってた事がわかる.

つまり, higher-order の pair-wise 部分は非アクティブなユーザーに貢献していて,
残りの higher-order 部分はアクティブなユーザーに貢献している（補正している）, という仮説が生まれる.

誇大広告だなあ
