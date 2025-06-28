% Latent Linear Critiquing for Conversational Recommender Systems
% https://dl.acm.org/doi/10.1145/3366423.3380003
% 推薦システム

## Critiquing (批評)

ユーザーと対話的に結果を絞り込むレコメンド手法.
特にこの論文ではこんな設定を考えている.

1. ユーザーはアイテム一つを提示される
    - アイテムには説明属性が与えられている
1. ユーザーは次の二通りができる
    1. 提示されたアイテムを受け入れる
    1. その属性を批評して次のアイテムを提示してもらう
        - 「もっとこういう性質を持ったものが良い」

## Notation

- $R_{i,j}$
    - user $i$ に対する item $j$ の Preference 行列
- $S_{i,k}$
    - user $i$ の key phrase $k$ を使う頻度行列
- $S'_{j,k}$
    - item $j$ の属性記述に key phrase $k$ が使われる頻度行列
- $j^{-k}$
    - $S'_{j,k} = 0$ であるような $j$ のこと
- $j^{+k}$
    - $S'_{j,k} > 0$ であるような $j$ のこと

## Projected Linear Recommendation (PLRec)

ユーザー同士及びアイテム同士の類似度を得る方法.

Preference 行列 $R$ の各ユーザー $i$ に対応する各列ベクトルを $r_i$ と書くことにする.

次のような素朴な方法で類似度行列を得られる (Liner Recommendation):
$$\min_W \sum_i \| r_i - r_i W \|_2^2 + \Omega(W)$$
ここで $\Omega$ の方は正則化項.

ただし当然 $W$ はユーザー数の正方行列になって膨大になる.
実用的なのは射影するような行列を挟む方法で,
"Practical Linear Models for Large-Scale One-Class Collaborative Filtering"
で提案されている次の方法.

$$\min_W \sum_i \| r_i - r_i V W \|_2^2 + \Omega(W)$$

ここで $V$ は SVD 低ランク分解で $R = U \Sigma V^T$ によって得てこれを使う.
$V$ のランクを十分小さく設定することで実用性が生まれる.
また
$z_i = r_i V$
を user $i$ の埋め込み表現として用いる.

$\| r_i - z_i W \|_2 \simeq 0$ となるように $W$ は学習されるので,
$$\hat{r_i} = z_i W$$
によって $z_i$ から $r_i$ が近似的に復元できる.

## Conversational Critiquing

Critiquing の各ステップは, user $i$ の preference の行ベクトル $r_i$ を修正する演算として定義される.
行列 $S$ の user $i$ の行ベクトル $s_i$ に批評 $c$ をしたとき,
新しいベクトル
$$\tilde{s_i} = \psi(s_i, c)$$
を生成して, $r_i$ を修正する:
$$\hat{r_i} = f_m(r_i, \tilde{s_i}).$$

批評を逐次的に行うことを考えると, $\psi$ は前回の批評を蓄積的に計算するものであってもよい.

### Co-embedding of Language-based feedback

ユーザーからの批評は自然言語で来て, キーワードベースでベクトル $s_i$ になる.
これをユーザーの埋め込みベクトル $z_i$ に対応付けることでキーワードの埋め込みベクトルを得る.
$$\min_{X,b} \sum_i \| z_i - (s_i X + b) \|_2^2 + \Omega(W)$$

以上から $f_m$ を構成する.
すなわち,

- Coding
    - user:  $r_i \mapsto z_i = r_i V$
    - keyphrases: $s_i \mapsto \tilde{z_i} = s_i X + b$
- Merging
    - $\hat{z_i} = \phi(z_i, \tilde{z_i})$
- Decoding
    - $\hat{r_i} = \hat{z_i} W$

## 疲れた。続きはいつか読む。

