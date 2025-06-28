% [1706.05125] Deal or No Deal? End-to-End Learning for Negotiation Dialogues
% https://arxiv.org/abs/1706.05125
% 言語獲得 ゲーム

## 概要

新しいタスクの提案. 及びベースラインとなるようなAIの実装の公開.
自然言語による対話を必要とするゲームをAI同士にプレイさせる.
評価はゲームの利得で行えるので定量的に評価が出来る.

## ソースコード・データセット

- [https://github.com/facebookresearch/end-to-end-negotiator](https://github.com/facebookresearch/end-to-end-negotiator)

## ゲーム (タスク) の概要

"multi issue bargaining" [Fershtman 1990] をベースにした
[Toward Natural Turn-Taking in a Virtual Human Negotiation Agent](https://www.aaai.org/ocs/index.php/SSS/SSS15/paper/view/10335)
の更にその一例を採用したとのこと.
の一例を使ったとのこと.
ルールは次の通り.

2人ゲーム.
いくつかのアイテムのセットが二人の前に提示されるので、2人は交渉をしてアイテムを2人の間で分割する.
アイテムには種類毎に一個当りの利得が定まっており、獲得したアイテムの利得の和の最大化を目指す.
利得はプレイヤーごとに異なる値がランダムに定まる. 自分にとっての利得は自分だけが知っており、相手は知らないし、相手にとっての利得を自分は知らない.

今考えるタスクではアイテムの種類は本、帽子、ボールという3つだけ.
これらを合計 5-7 個、適当に提示する.

交渉は必ずお互いが納得する形に落とさない限り、分割は行われず、決裂した場合、2人の利得はゼロとする.

> "I want the books and the hats, you get the rest."
> と言った具合.

### データセット

人間同士でこのゲームを行わせた. クラウドソーシングしたそう.
上に貼った github のレポジトリの中に含まれる.

## 手法

### データの表現

まず、入力として、ゲームの初期状態がある.
これは提示されたアイテム (3種類) の個数及び (自分にとっての) 利得という計6つの整数の列.
これを $g$ とする.

会話は全てトークンの列とする.
例えば、まず相手が
"I want all."
と言って、自分が
"Ok, deal" と返し、そこで会話が終わったとすると、学習するトークン列は
I want all **turn-end** ok deal **end-of-dialogue**
となる.
ここで **bold** で書かれたものはスペシャルトークンであることを示す.
会話の終端記号として **end-of-dialogue** がある.
この列を $x=x_1 \ldots x_T$ と書く.
会話が終わった時点で合意に達したモノと仮定する.

ゲームの出力として、2人がそれぞれ獲得したアイテムの個数がある.
計 6 つの整数のリストで表現され $o$ と書く.

### 教師アリ学習

ひとまず、人間のプレイを模倣することを目指す.
すなわち、条件 $g$ の下でトークン列 $x$ の学習/予測をする.

- 行列 $E$
    - トークンのエンコーダー・デコーダー
        - エンコード: $h = E x$
        - デコード: $x = E^T h$
- $GRU_g$
    - goal (6つの自然数) をエンコードする用
    - $h^g = GRU_g(g)$
- $GRU_w$
    - $h^g$ 及びそれまでのトークンの断片 $x_1 \ldots x_t$ を読んで内部表現 $h_t$ を得る
        - $h_t = GRU_w(h_{t-1}; Ex_t, h^g)$
    - $h_t$ を使って次のトークンの予測をする
        - $p(x_t|\ldots) \propto \exp(E^T h_t)$
    - また、列 $h_1 \ldots h_T$ を出力して $GPU_o$ に渡す
- $GRU_o$
    - これだけ bidirection
    - $(x_1, h_1) \ldots (x_T, h_T)$ を双方向から読む
        - [[1409.0473] Neural Machine Translation by Jointly Learning to Align and Translate](https://arxiv.org/abs/1409.0473) にある "attention mechanism" を持たせる
    - 最終的に一個の $h^s$ なる実ベクトルを出力して、これを使って
        - $p(o_i|\ldots) \propto \exp(W h^s)$

### ゴールベース学習

とりあえず人間の模倣だけをさせたので次に利得最大化を学習させる.
というわけで強化学習を行う.
(こういう教師あり事前学習から強化学習をするのを "two-stage learning strategies" などと言うらしい [Li et al 2016] [Das et al 2017].)

プレイヤー A と B を用意する.
A はこれから学習させる AI.
B は人間でもなんでも良いが、彼らの実験ではここまでで学習して得た (初めは人間を模倣するだけの) AI を使う (これは学習させない).

ゲームの入力 $g$ を入れて、ターン制でお互いに発話させる.
**turn-end** を出力する毎に発話を交代させる.
お互いに **end-of-dialogue** を出力した時点で交渉を終え、お互いにゲームの出力 $o$ を返す.
$o$ は交渉の結果お互いが獲得したアイテムの個数であったわけだが、お互いの $o$ が一致しなかった場合、報酬をゼロとする.
(交渉で合意に至らなかったと解釈する.)

> 会話だけ適当にやって、アイテムを全て自分のものだと主張する、という学習を、これで避けるのだろう.
> 相手 AI である B は不取敢はゲームのルールに忠実に従っているはずだから.

獲得した利得 (スコア) $r$ をそのまま報酬に与える.
ただし報酬がいつも非負なのはなんか良くないらしい.
過去のプレイから利得の平均 $\mu$ を見積もって、$r-\mu$ を報酬に与える.
ただし列の位置によって減衰させて、
出力した列 $x_t$ について
$$R(x_t) = \gamma^{T-t} (r - \mu)$$
こんな感じか.

発話する際の次トークン予測に関する最適化の目的関数は
$p_\theta(x_t | x_0\ldots x_{t-1}, g; \theta)$
に就いて
$$L_\theta = \mathbb{E}_{x_t} R(x_t)$$
これの最大化.
この勾配は
$$\nabla_\theta L_\theta = \sum_{x_t} \mathbb{E}_{x_t} \left[ R(x_t) \nabla_\theta \log p_\theta(x_t|\ldots) \right]$$
になるそうです [^1].
この参考文献もいつか読もう.

## 結果

とりあえず人間を模倣するだけのAIには大体勝てる.
しかし、そもそも交渉が合意に至る割合が87-94% 程度しかない.

次に対人間とのプレイの結果.
強化学習だけではそんな強いのが作れて無くて、Rollouts とかいうよくわからん謎技法を加えてようやく、対等くらい.
ただし合意に至る割合が低くなっていて、57% 程度.
「自分に不利な場合、合意に至らない」という戦略があるのかな?
いや、でも、報酬は単に自分の利得であって相手の利得は見てないから、そんなポジティブに捉えていい結果ではない.

実際の動作例を見るとめっちゃ強く見える.

## 参考文献

[^1]: ["Ronald J Williams. 1992. Simple Statistical Gradient-following Algorithms for Connectionist Reinforcement Learning," Machine learning, 8(3-4):229–256. http://www-anw.cs.umass.edu/~barto/courses/cs687/williams92simple.pdf](http://www-anw.cs.umass.edu/~barto/courses/cs687/williams92simple.pdf)
