% Deep contextualized word reprensetations (Embedding from Language Models; ELMo)
% http://www.aclweb.org/anthology/N18-1202
% 深層学習 単語分散表現

$$
\def\vec#1{\overrightarrow{#1}}
\def\cev#1{\overleftarrow{#1}}
$$

## 概要
つよつよ単語分散表現を作る.
タイトルにあるとおり "deep contextualized" であることを目指す.
他の単語分散表現と違って, 単語一個にベクトルを与えるのではなくて, 文全体を取ってから単語にベクトルを与えることをする.
関連として [Melamud et al,. 2016] の context2vec は pivot word とその周辺の context からベクトルを作るものがある.

[Chelba et al,. 2014] の 30 million sentences をデータセットに 2層 bi-LSTM で Language Model を作る.

## Bidirectional Language Model (biLM)

$N$ 個のトークンからなる文 $(t_1, \ldots, t_N)$ について普通の forward な language model は
$$p(t_1,\ldots,t_N) = \prod_{k=1}^N p(t_k | t_1,\ldots,t_{k-1})$$
という右辺の $p$ を与えるもの.

これをLSTMなんかで学習するとセルは内部状態 $h$ を持つ.
全部で $L$ 層あるときに トークン $t_k$ を読んだ直後に $j=1,\ldots,L$ 層目の LSTM のセルが持つ状態を $\vec{h_{k,j}}$ とする.
$t_{k+1}$ は $\vec{h_{k,L}}$ を使って予測されるわけである.

backward な language model とはトークン列の順序を逆順にしただけのもので
$$p(t_1,\ldots,t_N) = \prod_{k=1}^N p(t_k | t_{k+1},\ldots,t_N)$$
という右辺の $p$ を与えるもの.
同様に $j$ 層目の LSTM のセルが $t_k$ を読んだ直後に持つ状態を $\cev{h_{k,j}}$ とする.

bidirectional な language model は以上の forward と backward を次のように組み合わせる:
$$p(t_1,\ldots,t_N) = \prod_{k=1}^N p(t_k | t_1,\ldots,t_{k-1}) \times \prod_{k=1}^N p(t_k | t_{k+1},\ldots,t_N)$$
ここで 右辺の2つの $p$ をパラメータを持つわけだが、 token representation のためのパラメータ $\Theta_x$ と
最後の softmax layer のパラメータ $\Theta_s$ は共通して持たせる.
つまり一層目と最終層だけ共通.

## ELMo

ELMo は biLM の中の $h$ を使う.
トークン $t_k$ を何かしらの方法でまずはベクトル化してるわけだがそれを $x_k$ とし、またそれを $0$ 層目の状態 $h_{k,0}$ と見做す.
また forward の $h$ と backward の $h$ を結合して
$h_{k,j} = [ \vec{h_{k,j}}; \cev{h_{k,j}} ]$
とする.

ELMo では $[t_1,\ldots,t_N]$ における $t_k$ の表現を次の集合で表す:
$$R_k = \{ x_k, \vec{h_{k,j}}, \cev{h_{k,j}} ~|~ j=1,\ldots,L \} = \{ h_{k,j} ~|~ j=0,1,\ldots,L \}$$


