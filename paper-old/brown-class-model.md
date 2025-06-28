% Class-based n-gram models of natural language
% http://dl.acm.org/citation.cfm?id=176316
% 言語モデル 自然言語処理

Brown+ら.

[Learning phrase patterns for Text Classification](memo/learning-phrase-patterns.md)
の中で, "単語のクラスを1次マルコフモデル尤度を最大化することによって自動分類した" とあって引用されていた.

## Introduction

noisy channel 経由で来た, 歪んだ英語の文章を元に戻したい. これが第一の議論である.
それに関与することとして, 単語にクラスを当てはめることを統計的にしたい. これが第二の議論である.

## 言語モデル

次のような言語モデルを考える.

単語列 $w_1, \ldots, w_k$ を条件付き確率
$$P(w_k | w_1, \ldots, w_{k-1})$$
で特徴づける.
ここで $w_1,\ldots,w_{k-1}$ のことを $w_k$ の history と呼ぶことにする.

文章全体が出来上がる確率は先頭から順に生成されると仮定して,
$$P(w_1,\ldots,w_k) = \prod_{i=1}^k Pr(w_k | w_1,\ldots,w_{k-1})$$

### n-gram 言語モデル

n-gram 言語モデルでは,
history の内の最後の $n-1$ words だけを見る.
すなわち
$$P(w_k | w_1,\ldots,w_{k-1}) = P(w_k | w_{k-n+1},\ldots,w_{k-1})$$
とする.

ただし $k < n$ のときは勝手に短くする.

では確率 $P(w_k | w_{k-n+1},\ldots,w_{k-1})$ をどっからもってくるか.
training text における最尤推定を行う.
すなわち数えて割合を出すことをする.

training text において (連続) 部分列 $w_1,\ldots,w_k$ の頻度を $C(w_1,\ldots,w_k)$ とするとき,
$$Pr(w_n | w_1,\ldots,w_{n-1}) = \dfrac{C(w_1,\ldots,w_n)}{\sum_v C(w_1,\ldots,w_{n-1}, v)}$$

### interpolated estimation (Jelinek and Mercer, 1980)

語彙は十分多いことが望ましいが $n$ が増えるに従って必要な語彙数は指数的に増える.
しかしながら精度のためには $n$ はできるだけ多い方がよい.

interpolated estimation はいくつかの言語モデル $P^{(j)}$ を構築して, それらをcombineすることで $P'$ を得る手法.
$$P'(w_k | w_1,\ldots,w_{i-k}) = \sum_j \lambda_j(w_1,\ldots,w_{k-1}) P^{(j)}(w_k | w_1,\ldots,w_{i-k})$$

重み $\lambda_j$ は EMアルゴリズムで作る.

## Word Classes

意味的にか, 構造的にか, ある語とある語が似ているということがある.
例えば `Thursday`, `Friday` とか.

vocabulary $V$, classes $C$ があって, 語 $w$ をclass $c$ に写す写像を $\pi$ とする.
$$\pi : V \to C$$

### n-gram class model

写像 $\pi$ が既に与えられた上で, クラスを用いた言語モデルを次のように定める.
単語列 $w_1,\ldots,w_k,\ldots,w_N$ についてクラス列 $c_i = \pi(w_i)$ があって,
$$P(w_k | w_1,\ldots,w_{k-1}) = P(w_k | c_k) P(c_k | c_1,\ldots,c_k)$$

さらに n-gram クラスモデルとは, 上の history を $n-1$ に制限したもの:
$$P(w_k | w_1,\ldots,w_{k-1}) = P(w_k | c_k) P(c_k | c_{k-n+1},\ldots,c_k)$$

training text から, 右辺の2つの確率を最尤推定する.

1-gram であれば,

- $P(w | c) = \dfrac{C(w)}{C(c)}$
- $P(c) = \dfrac{C(c)}{C()}$

2-gram であれば,

- $P(w | c) = \dfrac{C(w)}{C(c)}$ (同じ)
- $P(c_2 | c_1) = \dfrac{C(c_1, c_2)}{\sum_d C(c_1, d)}$

ただし空列の $C()$ とは training text に登場する単語数のこと.

### 尤度

$T=C()$ として, training data 全体の単語列を $t_1,\ldots,t_T$ とする.

$$L(\pi) = \dfrac{1}{T-1} \log P(t_2,\ldots,t_T | t_1)$$
を $\pi$ の尤度とする.
2-gram model の下でこれを式変形すると,
$$L(\pi) = \sum_{w_1, w_2} \dfrac{C(w_1 w_2)}{T-1} \log P(c_2 | c_1) P(w_2 | c_2)$$

さらにうわぁーってやると,
$$L(\pi) = -H(w) + I(c1, c2)$$
ここで, $H$はエントロピー, $I$は相互情報量.
$w$ は training text から降ってくる.

$L(\pi)$を最大化するような $\pi$ を選択する, というのは,
相互情報量を最大化するようなクラス分類を選択することになる.

### 最適化

$\max I$ を厳密に解くのは大変 (また最大であるかを判定するのも大変).
貪欲法で頑張る.

語彙数 $V$ に対して欲しいクラスの数 $C$ を決める ($C < V$).
始めは全ての語彙は異なるクラスにあるとし, 一個ずつマージしてクラス数が $C$ になったら止める.
始めはクラス数が $V$ あるのでちょうど $V-k$ 回マージした時点でクラス数は $k$ 種類ある.
それを
$$C^k_1, \ldots,C^k_k$$
とする.

$1 \leq i < j \leq k$ について $C^k_i$ と $C^k_j$ とをマージすることを考える.

次の4つの値を導入する:

- $p_k(l,m) = P(C^k_l, C^k_m)$
- $\def\pl{\mathrm{pl}}\pl_k(l) = \sum_m p_k(l,m)$
- $\def\pr{\mathrm{pr}}\pr_k(m) = \sum_l p_k(l,m)$
- $q_k(l,m) = p_k(l,m) \log \dfrac{p_k(l, m)}{\pl_k(l) \pr_k(m)}$

こうすると $C^k$ の相互情報量は
$$I_k = \sum_{l,m} q_k(l, m)$$
で表される.

さて $i$ と $j$ をマージするならば, あたらしい $i \oplus j$ クラスが出来て,
各値は

- $p_k(i \oplus j, m) = p_k(i, m) + p_k(j, m)$
- $q_k(i \oplus j, m) = p_k(i \oplus j, m) + \log \dfrac{p_k(i \oplus j, m)}{\pl_k(i \oplus j) \pr_k(m)}$

で更新されて, 相互情報量は
$$I' = I_k - s_k(i) - s_k(j) + q_k(i,j) + q_k(j,i) + q_k(i+j,i+j) + \sum_{l \ne i,j} q_k(l, i+j) + \sum_{m \ne i,j} q_k(i+j,m)$$
where
$s_k(i) = \sum_l q_k(l, i) + \sum_m q_k(i, m) - q_k(i,i)$

というわけで $I'$ を最大化するペア $(i,j)$ を探してマージしていけばよい.

> そのまま実装すると $V^2$ で大変そう.

### Classes gotten with this alogrithm

次のようなものが同じクラスの語彙として得られた:

1. Friday, Monday, ... Sunday, weekends
1. June, March, July ...
1. people guys folks fellows ...
1. down, backwards, ashore, sideways ...
1. water, gas, coal, liquid ...
1. had, hadn't hath would've could've ...
