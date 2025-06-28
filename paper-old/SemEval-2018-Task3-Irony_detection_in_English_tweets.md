% SemEval-2018 Task 3: Irony detection in English tweets
% https://competitions.codalab.org/competitions/17468#learn_the_details
% 自然言語処理 感情分析

これに参加した論文を集める.
43チームが参加.

## [IIIDYT at SemEval-2018 Task 3: Irony detection in English tweets](http://aclweb.org/anthology/S18-1087)

- 421st
- official F1: 0.2905

### データ
データはバランスされてて 2396 ironic and 2396 non-ironic tweets からなる.
さらに irony の内訳は彼らの分類によれば
1278 verbal irony, 401 situational irony and the other 267 irony.
verbal irony というのは字面の意味と言いたいことがちょうど反対になってるようなものが典型.
"I love annoying people."
situational というのは, 期待する状態からかけ離れていることを説明するもの.
"An old man who won the lottery and died the next day."

### 前処理
ハッシュタグの削除.
NLTK TweetTokenizer によるトークナイズ.
two spaces を一個に置き換え.
ユーザーネームとURLの削除.
ステミングやトークンの小文字化 (lowercase) はやらなかった.
これは意図的に全文字をキャピタライズして書かれたものもあり, そういう情報に意味がある.

### アプローチ

GloVe を使う.
Pre-trained は必須.
vector size は小さくて全然良くて 25, 50 and 100 で実験する.
2B tweets (語彙サイズ 1.2 M tokens) で GloVe を訓練する.

十分頻出するのに語彙に登場しないような未知語には `UNK` トークンを割り当てる代わりに, 次のようにしてランダムなベクトルを割り当てた.
語彙から less freq words 集合 $S$ を選ぶ.
それらの各ベクトルを作る $V = \{g(s) \mid s \in S\}$.
中心ベクトル $c = \sum V / \# V$ との平均距離 $r = \sum_v \| v - c \| / \#V$.
中心を $c$ とし半径を $r$ とする球から一様ランダムに選んだベクトルを未知語に割り当てる.
そんなに頻出しない未知語には `UNK` トークンを割り当てる.

キャピタライズなどの情報を扱うために次の word-level features, sentence-level features を設定する.
単語単位で, fully lower, fully uppper, first-letter-capitalized, contains-digits の4つ.
文について, そのいずれかの単語が fully lower, fully upper, 同じ単語が複数回出現 の3つ.
この level を GloVe vector に concat する.

hidden vector が 150 units で dropout prob が 0.1 の BiLSTM が最良.
データの 80% で訓練して 20% で validation.
全く同じネットワークを四回訓練してそれらのアンサンブルで予測.

Token-level feature は無いほうが良い.
Sentence-level feature は僅かに良くすると言ってるが誤差レベル.

## [SemEval-2018 Task 3: Irony Detection in English Tweets](http://aclweb.org/anthology/S18-1005)

irony かどうかを2値分類する Task A とどの irony type かを当てる Task B とがある.
テストは 784 tweets でやる.
彼らは最高でそれぞれ F1スコアが $0.71$ と $0.51$ だった.

GloVe+LSTM
