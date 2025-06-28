% An Empirical Evaluation of Thompson Sampling
% https://proceedings.neurips.cc/paper/2011/file/e53a0a2978c28872a4505bdb51db06dc-Paper.pdf
% 多腕バンディット問題

## イントロ

定常多腕バンディット問題を考える.
近代ではとりあえず UCB (Upper Confidence Bound) が使われる.
それとは別に, ベイズアプローチによる方法としてトンプソンサンプリング (TS; Thompson Sampling) があるが,
あまりメジャーではない.

TS は各々腕から報酬を得る確率分布を推定してそこからサンプリングすることで腕を選択する.
これがメジャーでは無い理由は UCB と違って統計的解析が行われてないことだろう.
彼らによれば解析した論文は2本だけで, しかも漸近的に収束することくらいの事実しか得られてない.

この論文では実験的に調べることをする.
結論としてはその単純さに関わらず SOTA と並ぶ性能を出せるし,
試行回数が有限のときには強い性能が出てる.

## アルゴリズム

### 一般トンプソンサンプリング

contextual bandit を考える.
これは時刻 $t$ に context $x_t$ が来るので,
これに対して, アクション空間 $A$ からアクション $a_t \in A$ を一つ選択する.
すると報酬 $r_t \in \mathbb R$ が降ってくる.

時刻 $t$ の時点では,
$$D = \{ (x_i, a_i, r_i) \mid i \lt t \}$$
が観測データとして使える.

報酬は何かしらの確率分布 $P( r \mid x,a,\theta)$ で与えられる.
ここで $\theta$ がパラメータ.
ベイズの立場から $\theta$ の事前分布 $P(\theta)$ が何かあるとする.
$$P(\theta \mid D) \propto \prod_i P(r_i \mid x_i, a_i, \theta) P(\theta)$$
が導かれるので, これで $D$ を観測した時点で最尤の $\theta$ を得たい.
得たいが実際の問題ではここを厳密にやるのが難しいので, 確率分布 $P(\theta \mid D)$ から実際に $\theta$ をランダムにサンプリングして得ることにする. 平均的には最尤なものが得られるはずである.

$$\theta^\ast \sim P(\theta \mid D)$$

以上のときに $x$ に対しては次を最大にするようにアクション $a$ を選べば良い.
$$\max_a \mathbb E(r \mid a,x,\theta^\ast)$$

- ThompsonSampling:
    - $D \leftarrow \emptyset$
    - For each $t=1,2,\ldots,T$
        - Receive context $x_t$
        - Draw $\theta^\ast \sim P(\theta \mid D)$
        - $a_t = \mathop{\mathrm{argmax}} \mathbb E(r \mid x,a,\theta^t)$
        - Receive reward $r_t$
        - $D \leftarrow D \cup (x_t,a_t,r_t)$

### 01-Bandit

次のようないわゆる多腕バンディットを設定する.

腕が $K$ 本あり, それぞれの腕はそれをアクションとして選択すると確率的に報酬 $r \in {0,1}$ を返す.
ここで報酬の返し方をベルヌーイ分布（コイン投げ）だと仮定する.

ベルヌーイ分布は一回のコイン投げに関する離散分布であるが,
これをベータ分布にする.
これは 「$N$ 回のコイン投げで何回表がであるか（二項分布）」の $N$ を無限大に飛ばした先の分布.

これをさっきの一般の場合に適用すると次のようになる.

- K-arms 01-Bandit by ThompsonSampling:
    - Hyper Parameters (これが事前分布を与える), $\alpha, \beta$
    - 成功回数
        - $S_i = 0$ ($i=1,2,\ldots,K$)
    - 失敗回数
        - $F_i = 0$ ($i=1,2,\ldots,K$)
    - For each $t=1,2,\ldots,T$
        - For each $i=1,2,\ldots,K$
            - Draw $\theta_i \sim \mathop{Beta}(S_i + \alpha, F_i + \beta)$
        - $a = \mathop{\mathrm{argmax}}_i \theta_i$
            - これが選んだ腕
        - Receive reward $r$
        - If $r = 1$
            - $S_a \leftarrow S_a + 1$
        - Else ($r=0$)
            - $S_a \leftarrow S_a + 1$

## 実験

### シミュレーション

模擬実験で TS と UCB を比較する.
TS の事前分布としては $\alpha=1,\beta=1$ としてある.
Figure 1 はリグレット（失った報酬, ゼロに近いほど良い）をプロットしていて, UCB より良い性能を出してる.

### 悲観的トンプソンサンプリング (Optimistic Thompson Sampling)

という改良バージョンがある.
Figure 2 は僅かだが性能向上することを確認している.

### 広告CTR実験

TS, LinUCB, Exploit-only（常に最高のものを出す, epsilon-greedy, Random で比較実験する.
Figure 4 がこれを四日間動かしたレグレットの結果.
やっぱり TS が最良.
ただしパラメータチューニングは必須.

### Delay Batch Updating

彼らの環境では, 報酬が与えられるたびにパラメータ更新してると遅いので,
バッチに溜めておいて, 一定期間おきに更新したらしい.

Figure 5 はその溜める期間を変えて実験した結果.
基本的には溜める期間が長いほど悪くなるが, UCBは最も顕著に悪くなっていく.
TS はそんなに下がってないっぽい.
