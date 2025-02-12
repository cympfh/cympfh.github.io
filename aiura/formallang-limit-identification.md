% 形式言語の極限同定
% 2015-11-13
% 形式言語 言語獲得

$\def\PAT{\mathrm{PAT}}\def\content{\mathrm{content}}$

<div id=toc></div>

## 参考文献

- [wikipedia/Language_identification_in_the_limit](https://en.wikipedia.org/wiki/Language_identification_in_the_limit)
- [wikipedia/Grammar_induction](https://en.wikipedia.org/wiki/Grammar_induction)
- [paper/gold67limit.pdf](http://web.mit.edu/6.863/www/spring2010/readings/gold67limit.pdf)
- [paper/Angluin80](http://www.sciencedirect.com/science/article/pii/0022000080900410)
- [paper/Shinohara83.pdf](http://repository.kulib.kyoto-u.ac.jp/dspace/bitstream/2433/103408/1/0482-7.pdf)
- [paper/Arimura94.pdf](http://www-ikn.ist.hokudai.ac.jp/~arim/papers/arimura_stacs94.pdf)

## 諸定義

- アルファベットとはシンボルの有限集合
    - 文脈によってはシンボルは2つ以上に限ることがある
    - $\Sigma = \{ 0, 1, \cdots \}$
- テキストとはアルファベットの上の文字列
    - $\Sigma^* = \{ \epsilon, 0, 1, \cdots, 00, 01, 10, 11, \cdots, 010, \cdots \}$
        - 空文字列を $\epsilon$ と書く
    - 1文字以上に限ったテキストを次の記号で表す
        - $\Sigma^+ = \{ 0, 1, \cdots, 00, 01, 10, 11, \cdots, 010, \cdots \}$
- 言語とはテキストの集合
    - $L \subseteq \Sigma^*$

## E. Mark Gold による言語の極限同定

- "Language Identification in the Limit", 1967

### 動機

- AIに言葉を話させたい (作文をさせたい)
- 言葉を話すためにはその言語を学習しなければならない
    1. AI (計算機) は言語を学習できるか
    1. どの時点で学習したと言えるか

### 言葉を話せるAI

- 人間の場合は, 英語のルールを正しく書き下せなくても, "英語を話せる" と言う
- AI の場合でも, 同様の "英語を話せる" とかいえるようなモデルが作れるはず（模倣）
    - すなわち言語のルールを書き下すことなく学習ができるはず
    - 英語に限らず自然言語一般のルールを学習させたい
        - 人間は任意の自然言語を学習可能
    - 自然言語よりも単純な言語はより容易に学習できる
        - 自然言語を lower bound とする
        - より複雑な言語は別にどうでもいい
    - 少なくとも自然言語を含むような単純な言語の枠組みを設定する

### 言語の枠組み: 言語クラス

何の枠組みもなしに言語を学習するってのは難しすぎる

個々の言語を考える代わりに言語の族, 言語クラスを考える.
$$C = \{ L_1, L_2, \ldots \}$$
(実際には添字付きなものに限らない)

- 言語クラス $C$
    - 例えば「ありえる自然言語全体」を設定する
    - 例えば「文脈自由文法全体」を設定する
        - その中には実在する自然言語 (英語など) が含まれる
- 言語の学習とは言語クラス $C$ からそれっぽい言語を選ぶことだとする

### 情報提示 (information presentation)

何はともあれ, 情報を提示されないと学習できない

Gold は Text , Informant の2つがあると考えた

現代語訳すると

- Text $\Rightarrow$ 正提示
- Informant $\Rightarrow$ 完全提示

紛らわしいので現代語を使います

### 正提示

言語 $L$ の正提示とは, その言語に出現するテキストの (無限) 列のこと
$$w_1, w_2, \ldots$$
この列には重複などがあってもいいが, 言語に含まれる任意のテキストはこの列のどこかではいつか必ず出現することを要請する.
すなわち,
$$\forall v \in L, \exists i \in \mathbb{N}, w_i = v$$
これは結構強い性質である.

気持ちとして, 正提示とは次のような状況に相当する.
すなわち「子供が大人から常に正しいテキストを一つずつ聞く」

#### Def. content

無限列を集合に変換する操作を $\content$ と呼ぶことにする.
例えば $\content \{ 0,1,2,\ldots \} = \mathbb N$ みたいに使う.

こうすると正提示で要求してる性質は,
正提示 $I = ( w_1, w_2, \ldots )$ に対して
$$\content(I) = L$$
だと書ける.

### 完全提示

言語 $L$ の完全提示とは, 何でもいいから任意のテキストの列であって, そのテキストが言語に含まれるかのラベル ($\mathrm{Bool} = \{0,1\}$) が付いているもの
$$(w_1, I_1), (w_2, I_2), \ldots$$

- $(w_i, I_i)$ は次を満たす
    - $I_i = 1 \iff w_i \in L$
    - $I_i = 0 \iff w_i \not\in L$
- ただし任意のテキストがいつかは出現する
    - $\forall v \in \Sigma^*, \exists i \in \mathbb N, w_i = v$

そして完全提示の気持ちはこういうもの:

- 子供が大人から常に正しいテキストを聞く ($I_i = 1$)
- 子供はたまに作文をする (話す)
    - 文法エラーをすると相手のリアクションから誤りだと知る ($I_i = 0$)

### 言語学習モデル (guessing machine)

1. 正提示または完全提示により, 学習者は $i_1, i_2, \ldots$ を逐次的に受け取る
    - 時刻 $t$ に情報 $i_t$ を受け取る
1. 学習者はその時点までに受け取った情報から, 何らかの手続き $G$ によって言語を推論する

時刻 $t$ における推論:
$$g_t = G(i_1, i_2, \ldots, i_t)$$

$g_t$ は特定の1つの言語を説明するもの, 或いは, 言語そのもの

### 極限における同定

原理的に有限個の情報からは学習できない, という言語クラスはいくらでもあるので極限を考える

$$g_t = G(i_1, i_2, \cdots, i_t)$$

が極限 $t \rightarrow \infty$ で同定してかつ正しい言語を指し示すことを
**極限同定**
という.
注意として, 学習者は「いつ自分は正しく言語を学習できたか」を知る必要はない.

### 言語クラスの学習可能性

Gold が提示した枠組みにおける **学習可能性** とは次のこと.

「ある言語クラス $C$ が学習可能である」とは,
任意の言語 $L \in C$ とその任意の情報提示 $I$ について,
ある guessing machine $G$ を構成することができて $I$ によって $L$ を極限同定できること.

### 例: 完全提示から正規言語は学習可能

正規言語全体のクラスを考えるこれは完全提示によって学習可能であることが知られている.
正規言語とはオートマトン (或いは正規表現) に対応するからそれを復元出来れば良い.
guessing machine $G$ の出力はオートマトン $g_t$

ただしこれは完全提示を要求していて, したがって無限のテキストについてそれが言語に含まれるか (つまりオートマトンに受理されるか, 或いは正規表現にマッチするか) を神託する必要がある.

### libalf: Automata Learning Framework

完全提示からオートマトンを復元してくれるツール
[libalf](http://libalf.informatik.rwth-aachen.de/index.php?page=about)
というものがある.
これがまさに今欲しかった guessing machine である.

![](https://i.imgur.com/Z2wOh8V.png)

### 正提示から正規言語を極限同定することは不可能

正提示だけからは正規言語のクラスは極限同定が不可能であることも知られている.

- 正規言語全体は大きすぎる (超有限)
- 正提示が完全提示に比べて弱すぎる (それはそう)

### 子供の言語学習 (acquisition of grammar by children)

ちょいちょい「子供が学習するときは〜」という話が出るが, 実際はどうなのか

psycholinguist 曰く [McNeill, 1966]:
「子供が文法誤りをしたとき, それを指摘することは滅多にない」

つまり完全提示は仮定が強すぎて現実的には正提示しか無い.
そしてその中でも人間は自然言語を学習することが出来る.

### 自然言語は正提示から学習可能説

- 多くの自明な言語クラスなら正提示から学習可能であることを Gold は示した
- 英語は文脈自由文法だと言われているが, 実際には, 全ての文脈自由文法が自然言語になるわけではない
    - もっと制限がある (もっと小さなクラスである)
    - 例えば, 学習可能性の結論として:
    あり得る自然言語のクラスは, 無限言語を少なくともひとつは含み,
    全ての有限言語を含むことはない (超有限ではない)

### 子供は, 我々がわからない方法で負例を学習する説

- 例えば, 発言をして, 思ったような反応が得られなかったとき
    - だとすると完全提示からの学習をしてもいい
- 原始再帰的言語は完全提示から学習可能であることをGoldは示している
    - 文脈依存文法も原始再帰的言語の一つ
    - 英語は完全提示から学習可能

## Dana Angluin のパターン言語

- "On the Complexity of Minimum Inference of Regular Sets", 1978
- "Finding Patterns Common to a Set of Strings", 1979

この人は正提示から学習可能な非自明な言語クラスを発見した.
それが **パターン言語**.

### パターン: $\PAT$

有限アルファベット $\Sigma = \{ 0, 1, \cdots \}$ と
無限変数 $X = \{ x_1, x_2, \cdots \}$ の列としてパターンは定義される.

$$\PAT = (\Sigma \cup X)^+$$

パターンに対しては次の操作と関係が定義される.

### 代入, $\preceq$ (less-general-than)

代入 $[x_i/p]$ とは, パターン中に出現する **全ての** 変数 $x_i$ を **空でない** パターン $p$ に置き換える操作.

$$
\begin{align*}
x_1 x_1 & \succeq \underline{x_2} ~ \underline{x_2} & [x_1/x_2] \\
& \succeq \underline{a x_1} ~ \underline{a x_1} & [x_2/a x_1] \\
& \succeq a \underline{b c} a \underline{b c} & [x_1/b c] \\
\end{align*}
$$

ただし空は代入できないことに注意.
$$a x_1 a x_1 \not\succeq a a$$

### パターン言語

パターンに対応して言語を構成することが出来る.
すなわち,
$$L(p) = \{ w \in \Sigma^* \mid w \preceq p \}.$$

(正規表現に対して正規言語があるようなもの.)

例えば,
$$L(x_1 x_1) = \{ w w \mid w \in \Sigma^+ \}$$

### 定理: パターン言語は正提示から学習可能

パターン言語のクラス
$$C = \{ L(p) \mid p \in \PAT \}$$
は正提示で学習可能.

### 学習過程 (推論機械 $G$)

学習ターゲットが $L = L(p) \in C$ であって,
その正提示として $s_1, s_2, \cdots (s_i \in L)$ を受け取るとする.

推論機械は言語そのものの代わりにパターンを出力すればよい:
$$p_t = G(s_1 \cdots s_t)$$

さて推論機械の構成方法であるが, それは大雑把に述べると

- $\forall t, \content(s_1, \cdots, s_t) \subseteq L(p_t)$ （無矛盾）
- $L(p_1) \subseteq L(p_2) \subseteq \cdots$ （保守的）
- 上2つを満たす為には次のようにすれば十分 （極小言語戦略）
    - $p_t = \mathop{\rm argmin}\limits_p L(p) ~s.t.~ \content \subseteq L(p)$

ってやると,
$$L = L(\lim_t p_t)$$
になる.

### Def. 有限の厚み

言語クラスが有限の厚みを持つとは $\iff$
任意のテキストの有限集合 $S$ について
$\{ L \mid S \subseteq L \}$
が有限であること

### Prop. 有限の厚みを持つ言語クラスは極小言語によって極限同定可能である

1. 無矛盾かつ保守的な推論による推論の列: $g_1, g_2, ...$
は収束する
    1. 有限の厚みより, 正提示の1つ目を含む言語は有限個しかない
        1. 推論も有限個しかない
    1. 保守性より $L(g_1) \subseteq L(g_2) \subseteq \cdots$ ($g_i$ に半順序がつく)
    1. 推論列はどこかで停まるか, 極大を定める

### Thm. パターン言語は正提示から学習可能

1. 先に挙げた極小言語戦略による推論機械を構成する
1. パターン言語クラスは有限の厚みを持つことを示す
    - $\forall w, \{ p \mid w \preceq p \}$ が有限であることを言えばよい
    - hint: $q \preceq p \Rightarrow |q| \geq |p|$
1. 先の Prop. から極限同定可能

## その他の話題

### Shinohara

- Shinohara: "Polynomial Time Inference of Extended Regular Pattern Languages", 1991

パターン言語を消去可能パターン言語に拡張した.
消去可能であるとは空文字列の代入を許すこと.

例えば:
$$a x_1 a x_1 \succeq a a$$

Shinohara は消去可能パターン言語であって正則なものは, 正提示から学習可能であることを示した.

> N.B. パターン言語が正則 $\iff$ 一つのパターンに出現する同じ変数 $x_i$ は高々一つ (出現する変数が全て異なる)

### Arimura, Shinohara: "Finding Minimal Generalizations of Unions of Pattern Languages and ...", 1994

パターンの和言語も正提示から学習可能であることを示した.
和言語とは, $k$ 個のパターン $p_1, p_2, \ldots, p_k$ について
$$L(p_1, \cdots, p_k) = L(p_1) \cup \cdots \cup L(p_k)$$
と定められるもの.
ただしこの個数 $k$ について上限を設けたりする.

### Takeuchi, Sato: "誤情報を含む正則パターン言語の多項式時間推論", 1998

タイトルの通り

- 学習したい言語からちょっとくらいズレた提示があっても良いようにする
- 言語の「近傍系」を学習していく
    - パターンの上の一種のハミング距離を取る

(一定の) 誤情報を含む正提示から学習可能

### Ng, Shinohara: "Inferring Unions of the Pattern Languages by the Most Fitting Covers", 2005

- 今見てきた極小言語戦略は提示 $s_1, \cdots, s_t$ を含む中で極小な言語を推論として出力する
    - 極小とは言語の包含関係に関する
    - 言語は無限集合なので大きさを比較するのは難しい
- 要するに小さければ良い
    - 実際の言語ではテキストの長さには上限が (たぶん) ある
        - $\Rightarrow$ 任意の自然言語は有限集合である
        - 大きさに関する極小を取ることができる

性質を調べたものであって, この場合の推論方法を示したわけでも学習可能性を言ったものでもない

## おわりに

- 誰も自然言語のことを忘れてパターン言語だけをやっている
- 完全提示からの学習なんて誰もやってない (ことはないけど)
- というか確率を導入すべきだ
- もはや誰も手をつけない分野
    - ちょっと古ければ論文は大量にある
    - 2000年以降もたま〜にぽつぽつ出てる

