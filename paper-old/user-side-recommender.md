% [2208.09864] Towards Principled User-side Recommender Systems
% https://arxiv.org/abs/2208.09864
% 推薦システム

* [[https://github.com/joisino/consul]]

前回の [Private Walk](private-recommender) の続編.

## 概要

伝統的には推薦システムとは開発側が開発側の為に開発するものだったが,
近年では User-side Recommender System という概念が提唱され始めた(!).
提供されてるレコメンドがフェアでないと思ったユーザーに開かれたシステム.
ユーザーはシステムのデータを使えないからログデータ等なしで推薦システムを構築することになる.

この論文ではシステムの推薦から隠されたアイテムの特徴ベクトルが復元できること,
これを使って推薦システムが構築できることを見ていく.
理論上可能だがその通りに実装することを効率的ではない.
実用的に **健全な (sound)** 推薦システムの実装も見てく.
ここで満たすべき3つの性質を提唱する.

## 記法

$\def\A{\mathcal{A}} \def\I{\mathcal{I}} \def\H{\mathcal{H}}$
$\def\Prov{\mathcal{P}_{\mathit{prov}}}$

- $[n]$, 集合 $\{1,2,\ldots,n\}$ のこと
- グラフ $G = (V,E)$
- アイテム集合 $\I = [n]$
- protected group の集合 $\A$
    - アイテム $i$ の protected 属性 $a_i \in \A$
- インタラクションしたアイテムの集合 $\H \subset \I$
- システムが提供しているレコメンダ $\Prov$
- レコメンドリストの長さ $K \in \mathbb{Z}_+$
- minimal requirement of fairness $\tau \in \mathbb{Z}_{\leq 0}$
- num of dimentions of embeddings $d \in \mathbb{Z}_+$

## 問題設定

### Service Provider's Official Recommendation System

システムの推薦システムとして item-to-item があるとする.
これを $\Prov$ と書く.
アイテム $i$ があったとき, 推薦システムは $K$ 個のアイテム列を返す.

$$\Prov(i) \in \I^K$$

この $k$ 番目を $\Prov(i)_k \in \I$ と書こう ($k=1,2,\ldots,K)$.

ユーザーから見て $\Prov$ の中身は完全にブラックボックスであるのが普通だ.
これを fair かつ white-box にするのが目的.

### Embedding Assumptions

$\Prov$ の中身が次のようだと仮定する.

- アイテム $i$ には特徴ベクトル $x_i \in \mathbb{R}^d$ が割り当てられている
- $\Prov$ は k-近傍を取ってくる操作である

$x$ 自体はユーザーからは絶対に見えない.
で, やりたいことは $\Prov$ の入出力のサンプルから $x$ を復元すること.

### Sensitive Attributes

アイテム $i$ には何か具体的なセンシティブな属性 $a_i \in \A$ があるとする.
例えば性別や人種が考えられる.
ここではユーザーから観測可能なものだけを取り扱う.

### Misc Assumptions

ユーザーは既に何らのアイテム $\H \subset \I$ についてはインタラクションをしてきていて,
それらについては知っていることとする.
例えば購入履歴である.
テクニカルな仮定として, $\Prov$ は $H$ のアイテムをレコメンドすることはないこととする.

提案される方法では $\H$ は空集合であっても機能する.

## 特徴量の復元

次のような推薦グラフ $G = (V,E)$ を考える

- 頂点集合 $V$ はアイテム集合 $\I$,
- $E$ は有向辺の集合であって,
    - アイテム $i$ について $\Prov$ がオススメするものの中に $j$ があったとき,
    - 辺 $i \to j$
        - そのランクで重み等は考えない

実際に $\Prov$ を用いることは出来るから, ユーザーから見て $G$ は観測可能な対象である.
ひたすらページをクローリングしてく.

ランクまで考慮することでアイテムの類似度やスコアまで推定することは理論上可能だろうが,
話が難しくなりすぎるのでここでは考慮しない.

特徴ベクトルの復元を考える.
ここで距離を保存する変換（平行移動, 回転, 拡大縮小）は無視して考える.
それらは kNN の結果を変えないので.

Hashimoto らではこのグラフの上を Random Walk してくことで,
任意の誤差未満で復元できることを示している.
（なんか色々条件付きで.）

Alamgir & von Luxburg は,
グラフに適切に重みを割り当ててくことで,
グラフ上の最短距離が特徴ベクトル間の距離と一致するように出来ることを示した.
これを使うことで, グラフ $G$ を与えてアイテム同士（その特徴ベクトル）の距離行列
$$D \in \mathbb R^{n \times n}$$
得られる.

Terada & von Luxburg は,
重みなし k-NN グラフに彼らの提案する Local Oridinal Embeddings (LOE) を割り当てることで復元できたことを示した.
ことを示した.
これも実際にはなんやかんや条件があるらしいが, ともかく本論文の実験では LOE を使ったそう.

色々言ったがともかく,
推薦グラフ $G$ が手に入ったらアイテムの特徴ベクトルは復元できる.
そしてらこれを元にまた推薦システムを構築できるし,
fair な推薦をするために後処理を施すこともできる (ETP; Estimate-then-postprocessing).

### 実験

Figure 1.
二次元のでトイデータから kNN グラフを作って復元する実験.
完璧じゃないけどほぼほぼ復元できてる.

## Design Principles

これから User-side Recommendation, $Q$ を設計する.
パラメータとして, 非負整数 $\tau$ を持たせる.
これは fairness と preformance をトレードオフに調整する.

### Consistency

$\Prov$ と比較したときに性能がほとんど劣化してないその度合いを指す.
特に $\tau=0$ のときに, $\Prov$ と nDCG が下がってないときに consistent であるという.
(全く同じ結果が出せるようになっていれば consistent だ.)

### Soundness

どのレコメンド結果 $Q(i) \in I^K$ についても,
各属性 $a \in \A$ に属するアイテムが $\tau$ 個以上あること.

$$\forall i \in \I ,~ |\{ k \in [K] \mid Q(i)_k = j, a_j = a \}| \geq \tau$$

### Locality

グラフ $G$ の部分だけからでも復元できること.
全てのアイテムについて集めてきてフルな $G$ を作れば復元できるのは良いけど,
それだと実用上は大変なので, 一部のアイテムについてだけでもグラフを作って,
そのアイテムの分だけでも特徴量ベクトルが復元できると便利.

## 提案手法, Consul

- 必要なデータ
    - $\Prov, \{a_i \mid i \in \I\}, \tau, \H$
    - 探索の上限 $L$
    - ソースとなるアイテム $i \in \I$
- 初期化
    - レコメンド結果, $R \leftarrow ()$
    - $p \leftarrow i$
    - 訪れたことのあるアイテム $V = \{\}$
    - 各属性を用いた回数, $c(a) \leftarrow 0, \forall a \in A$
    - スタック,  $S \leftarrow ()$
- 以下を $L$ 回繰り返す
    - $p \leftarrow$ スタック $S$ から $V$ に属さないものをポップ
        - そのようなものがなければループを抜ける
    - For $k=1,2,\ldots,K$
        - $j \leftarrow \Prov(p)_k$
        - If $j \not\in R \cup H$ and $\sum_{a \ne a_j} \max(0,\tau-c(a))\leq K-|R|-1$
            - $R \leftarrow R + (j)$
            - $c(a_j) \leftarrow c(a_j) + 1$
        - If $|R| = K$
            - Return $R$ を返して終了
- あとは足りなかったアイテムを埋める処理
    - 省略

Consul は consistent で sound で local であることが示されている.

### 実験
Table 3.
Oracle ($\Prov$) をそのまま使うのに比べて Consul を使うと Accuracy/nDCG がどのくらい変わるか.
もちろん下がるがその下がり幅が小さいことが大事.
また Access では Oracle を何回使うかだが, たいてい 10 回未満で済んでいる.

## 感想

Consul 自体は, まあそう, といった感じ.
提供されてる item-to-item レコメンダがあって, これを多段で叩くことでバリエーションが増やせるようになる（だからこそ fair なものが作れる）というのはノウハウとしてはなるほど.
特徴量ベクトルが復元できる話は結局, フェアなレコメンドを作りたい話とは関係なかった.
それ自体は知識として有用だけど, LOE 単体のレポートな気がする, それは.
