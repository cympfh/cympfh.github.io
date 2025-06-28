% Values of User Exploration in Recommender Systems
% https://dl.acm.org/doi/10.1145/3460231.3474236
% 推薦システム Google

## 参考文献

- [[https://scrapbox.io/gunosydm/Values_of_User_Exploration_in_Recommender_Systems]]
- [[https://en-jp.wantedly.com/companies/wantedly/post_articles/351771]]

## 概要

- 強化学習しろ
    - 強化学習は探索と活用
    - 探索に価値がある
        - バンディットもそう
    - 短期的なユーザー体験は犠牲に, 長期的な利益を見ろ
- Serendipity を上げる工夫をする

## 背景: 強化学習による推薦システム

推薦システムは強化学習でやってく.
マルコフ決定過程モデルで定式化する.

- 状態空間 $S$
- アクション空間 $A$
    - 推薦するアイテムの空間
- 遷移確率
    - $P \colon S \times A \times S \to \mathbb R$
- 報酬
    - $R \colon S \times A \to \mathbb R$
    - 値を $r(s,a)$ と書く
- 初期状態 $\rho_0$
- 報酬の減衰率 $\gamma$

あるユーザーの履歴として列
$$H = \{ (A_i, a_i, r_i) \mid i = 0,1,\ldots,t-1 \}$$
がある.
ただしここで $A_i$ というのは時刻 $i$ にユーザーに提示したレコメンド結果.
$a_i$ はユーザーの反応.
$r_i$ はその反応に対する報酬.
ただし反応が得られな方ときは $r_i=0$ とする.

$a_i \in A_i$ ならレコメンドが正しかったけど,
そうでないならレコメンドにとって未知のアクションになる.

適当なニューラルネットでモデルを組むと次のようになる.
アイテム $a$ についての表現ベクトル $v_a$ を作っておく.
適当な RNN で $u_t = \mathrm{RNN}_\theta(H)$ を作って, この内積で
$$\pi_\theta(a \mid s_t) = \frac{ \exp( u_t \cdot v_a ) }{ \sum_v \exp(u_t \cdot v)}$$
とする (softmax).

減衰付きの報酬累積和
$$R_t = \mathbb 1_{( r(s,a) > 0 )} \sum_i \gamma^{t-i} r(s_i, a_i)$$
この期待値を最大化する
$$\max_{\theta} J(\pi_\theta) = \mathbb E_{s,a} [R_t]$$
ように $\theta$ を更新するのが目的.

## 手法

1. エントロピー正則化; Entropy Regularization
    - 多様性を重視するような正則化
2. 内発的動機づけ; Instrinsic Motivation and Reward Shaping
    - 新規的なアイテムに報酬を与える
3. Actionable Representation for Exploration

### エントロピー正則化

状態 $s$ 時点での多様性はエントロピー
$$H(\pi_\theta( \cdot \mid s))$$
で表現される.
これを正則化として,
$$\max_\theta J(\pi_\theta) + \alpha H(\pi_\theta)$$
の最大化にする.
$\alpha$ はブレンド比.

エントロピーは定義を展開して
$$H(\pi_\theta( \cdot \mid s)) = - \sum_a \pi_\theta(a \mid s) \log \pi_\theta(a \mid s)$$
になる.
エントロピーは一様分布 $U$ との KL ダイバージェンスとしても計算できる.
$$H(\pi_\theta( \cdot \mid s)) = - \mathrm{KL} ( \pi( \cdot \mid s) \| U )$$

### 内発的動機づけ

ユーザーのアクション $a_t$ がその時点の状態 $s_t$ から見て未知なものなら,
報酬を $c$ 倍 ($c>1$) する.

未知かどうかはトピッククラスタリングなどしておいてアドホックに判定する？

### Actionable Representation

履歴を $(A_i, a_i, r_i)$ の列で表現していた.
ここにそのアクションが新規的なものであるかどうかのフラグ $i \in {0,1}$ を付け足す.
（添字の記号と被ってしまって申し訳ないが別物と見てもらって）
$$H = \{ (A_i,a_i,r_i, i_i) \}$$
と表現し直す.

## 評価指標

計算式はすべて省略

- Accuracy
    - map@50
- 多様性 (Diversity)
    - 一回の推薦におけるアイテム提示の中の広がりを見る
- 新規性 (Novelty)
    - アイテムを自力で発見できない度合い
- Serendipity
    - 意外性と関連性

## オフライン実験評価

Accuracy は基本全部下がる.
それ以外が上がったりする.
エントロピー正則化は多様性と新規性を上げる. Serendipity は基本全部下がる
い内発的動機づけと Actionable Representation は多様性はあんまり変わらず Serendipity があがる.
