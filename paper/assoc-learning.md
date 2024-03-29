% [1706.00909] Learning by Association - A versatile semi-supervised training method for neural networks
% https://arxiv.org/abs/1706.00909
% 深層学習 半教師アリ学習

## 概要

半教師アリ学習の為の新しい手法を提案し、クラス分類に適用した.

## アイデア

半教師アリで学習する部分はデータから埋め込み表現に変換する
$$F: x \mapsto z$$
の部分だけ.
画像に適用するならこれは CNN 等で構成する.

同じクラスに属するデータならその埋め込み表現も似通っているべきである.
似ているということを assoc の操作によって表現する.
具体的には埋め込み表現ベクトルの内積を取って、値が大きいほど似ているということにする.
また Figure 1 の赤色矢印のように、それは１つのデータから別のデータへの有向エッジと見做す.
softmax を取る都合からエッジは対称ではない.

ラベル付きからラベルなしの assoc にラベルなしからラベル付きへの assoc を考えることで、
ラベル同士の比較に落とし込んで教師信号を与える事ができる.

### 形式化

ラベル付きデータの集合
$$x = \{x_1, \ldots, x_n\}$$
とラベルなしのデータの集合
$$y = \{y_1, \ldots, y_m\}$$
を用意して１つのバッチとして $F$ に順伝播し、埋め込み表現,
$$A = \{A_1, \ldots, A_n\}$$
$$B = \{B_1, \ldots, B_m\}$$
を得る.
$A$ が $x$ に、$B$ が $y$ に対応している.
$A$ についてのみ、そのクラスがわかっている (ラベル付きなので).

さて、 $A$ と $B$ との間の assoc を考える.
assoc matrix
$$M_{ij} = dot(A_i, B_j)$$
を作る.
正しく $A_i, B_j$ の間の関連度を表している.
ここで $dot$ はベクトルの内積である.
別のユークリッド距離等に置き換えても良いと彼らは言っている.

$A$ から $B$ への assoc を考える.
それはつまり $B_j$ が $A_j$ に関連するという確率 $P^{ab}(B_j | A_i)$ を考えることで、これを

$$
P^{ab}_{ij}
= \exp(M_{ij}) / \sum_{j'} \exp(M_{ij'})
= \exp(dot(A_i, B_j)) / \sum_{j'} \exp( dot(A_i, B_{j'} ))
$$

でモデリングする.
$j$ に関して正規化した softmax であることに注意.

逆も同様で、今度は $A_i$ の $i$ に関して正規化することで、確率 $P^{ba}(A_i | B_j)$ を次のようにモデリングする.

$$
P^{ba}_{ji}
= \exp(M_{ij}) / \sum_{i'} \exp(M_{i'j})
= \exp(dot(A_i, B_j)) / \sum_{i'} \exp( dot(A_{i'}, B_{j} ))
$$

> 一般に $P^{ab}_{ij} \ne P^{ba}_{ji}$ であることに注意

### walker loss

ラベルなしを経由して、ラベルあり同士の関連度を測る.
そうして同じクラスに属するデータ同士の関連度が高くなることを考える.

ラベルなしを経由する $A_i$ と $A_j$ の関連度
$$P^{aba}_{ij} = \sum_k P^{ab}_{ik} P^{ba}_{kj}$$
と定めて、
$$\mathcal{L}_{walker} = H(T, P^{aba})$$
を損失関数とする. ここで $H$ は交差エントロピー.
$T$ はこの教師で、次のように設計する.
$$T_{ij} = \begin{cases}
1 / \#class(A_i) & class(A_i) = class(A_j) \\
0 & else
\end{cases}$$
ここで $class(A_i)$ とはデータ $A_i$ に対応するクラス.
$\#class$ は $A$ の中で出現する回数.

### visit loss

ラベルなしの中に難しいケースが混じっている場合、どれとも関連しないということになり、
簡単なケースばかりが使われるようになってしまう.
どのラベルなしのデータも、どれかのラベルありデータと関連するという制約を持たせる.

いずれかとの関連度をその平均
$$P^{visit}_j = 1/|A| \sum_i P^{ab}_{ij}$$
で表現して、これについて
$$\mathcal{L}_{visit} = H(V, P^{visit})$$
を加える.
ここで教師 $V$ は単に一様であることを期待して
$$V_j = 1 / |B|$$
とする.

> バッチの中に全てのクラスが均一に出現することを期待している

### classification loss

最終的な目的なクラス分類なので、ラベルアリについてはクラス分類を普通に行うような損失
$$\mathcal{L}_{class}$$
を加える.

以上の３つを足した
$$\mathcal{L}_{walker} + \mathcal{L}_{visit} + \mathcal{L}_{class}$$
を目的関数として、彼らの実験では Adam を使って最小化を目指した.

## 実験

MNIST, STL-10, SVHN を使って実験を行った.

MNIST では確かに、ラベルなしの同じ文字が同じ文字と強く関連するように学習が行われている (Figure 2).
ところで先に述べたように $P^{ab}$ と $P^{ba}$ はモデルでは対称ではないが、学習した結果、対称的なものが得られている.
直感的にも、対称的なのが正しいと思うし.
そうなるようなモデリングは難しいのかな.
softmax とかいうものを使わなければいいと思うんだけど.

肝心のクラス分類自体の結果は、20 labeled samples と残りをラベルなしとして、 error rate 0.96%.
20 枚でこの精度はすごそうだけど、比較できる数字が見つからない.
100 枚でやった場合なら見つかったんだけど
([http://musyoku.github.io/2016/12/27/GAN-VAT-ADGM-AAEでMNISTのワンショット学習/](http://musyoku.github.io/2016/12/27/GAN-VAT-ADGM-AAEでMNISTのワンショット学習/)).

Figure 2 にあるように assoc については完璧なら、ラベルなしにラベルを付けて学習データに追加しちゃダメなのかな.

Table 3 では SVHN データセットで、ラベル付きの枚数とラベルなしの枚数を色々変えた結果を示している.
ラベル付きデータが元々ある程度量が無いと、ラベルなしを加えても返って悪さをしているらしい.
適量の場合 (500-2000) だけ、その真価を発揮している.
