% Shake-Shake Regularization
% https://github.com/xgastaldi/shake-shake
% 深層学習 物体認識

## 概要

url 先の Figure 1 を見れば、内容のほぼ全てがそこにあるのでメモをちょろっとだけ.

残渣ネットワーク (Residual Network) とは、
次のように **残渣** $F(x)$ をこれを求めて足す機構

- $y = x + F(x)$

を組み入れたネットワークのことであった.
$F$ と同様に $y = x + F'(x)$ となるような $F'$ を作って

- $y = x + \alpha F(x) + (1 - \alpha) F'(x)$

とすると、Dropout が汎化性能を上げるのと凡そ同じ理由から汎化性能を上げそうである.
ここで $\alpha=0.5$ とする、或いは定数とすると、 $F, F'$ は逆伝播によって同じ更新が係かり、
ほぼ同様の計算をする $F, F'$ が得られてしまう.
汎化性能を上げる目的のためには、2つは違った学習をしている必要がある.

"Shake-Shake" という名前の由来は、
この $\alpha$ を順伝播のたびに $(0, 1)$ からランダムに設定し
(つまり $F$ と $F'$ の値をランダムに混ぜる)、
かつ、逆伝播の際にもまたランダムに設定することにある.

逆伝播のときは $\alpha$ とは異なる値 $\beta \in (0,1)$ を用いて

- $y = x + \beta F(x) + (1 - \beta) F'(x)$

であったとして更新をする.

## 実験

いくつかバリエーションが考えられる.

- 順伝播
    - Even: $\alpha=0.5$
    - Shuffle: $\alpha \in_u (0,1)$
- 逆伝播
    - Even: $\beta = 0.5$
    - Keep: $\beta = \alpha$
    - Shuffle: $\beta \in_u (0,1)$

ともに Shuffle を取った "Shuffle-Shuffle" のときが最大の効果を得たらしい.
