% Using Maximum Entropy for Text Classification
% http://www.kamalnigam.com/papers/maxent-ijcaiws99.pdf
% 自然言語処理 機械学習 テキスト分類

1999年の論文。
なんか線形SVMっぽい??

## 最大エントロピーによるテキスト分類の直感的な知見

4つのクラス A, B, C, D に各文書が振り分けられているときに、
次の命題があるとする。

> "professor" という単語を含む文書の 40% が クラス A であった

ここから次のように確率を推定するのは自然だろう.

> "professor" を含む文書は、40% の確率で クラス A. 各々 20% の確率で、クラス B, C, D

加えて、

> "professor" を含まない文書は、各々 25% ずつの確率で、クラス A, B, C, D

## model

### Maximum entropy

文書 $d$ とクラス $c$ に関する適当な素性

$$f_i(d, c) \in \mathbb{R}$$

を考える.
これは、実関数ならなんでもよく、例えば、ある単語 $w_i$ の出現頻度とか.

コーパス $D = \{ (d_i, c_i) \}_i$ が与えられているとする.

コーパスにおける素性 $f_i$ の平均は

1. $\frac{1}{|D|} \sum_{d \in D} f_i(d, c(d))$

仮に分布 $Pr(d)$, $Pr(c|d)$ が与えられてれば、
ある文書 $d$ についての $f_i$ の期待値は、
$\sum_c Pr(c|d) f_i(d, c)$
と厳密に表せる.
更に、コーパス全体でこの期待値を取ると、

2. $\sum_{d \in D} Pr(d) \sum_c Pr(c|d) f_i(d, c)$

となる.

`(1.)` と `(2.)` が等しいことを、最大エントロピー法は仮定する.

$$Pr(d) = \frac{1}{|D|}$$
としてしまえば、
これを `(2.)` に代入して `(1.)` と比較することで、

$$\sum_{d \in D} f_i(d, c(d)) = \sum_{d \in D} \sum_c Pr(c|d) f_i(d, c)$$

を得る.

さて、
`Della Pietra+, 1997`
によれば、最大エントロピーに従う確率分布は、exp の形に書ける。
今の場合、
$n$ 種類の素性 $f_1, f_2, \ldots, f_n$ について、
対応する重み
$$\Lambda = [ \lambda_1, \lambda_2, \dots, \lambda_n ] $$
が存在して、次のように、

$$Pr_\Lambda(c|d) = \frac{1}{Z(d)} \exp \left[ \sum_i \lambda_i f_i(d, c) \right]$$

という形に表せるという仮定が通用するらしい.
ここでお決まりの $Z(d)$ は確率全ての和が $1$ になるよう正規化するために割る数.

これを使えば、対数尤度は、

$$\ell(\Lambda; D) = \sum_{(d, c) \in D} \log Pr_\Lambda(c | d)$$

### Improved Iterative Scaling (IIS)

先ほどの、
$\ell(\Lambda; D) = \sum_{(d, c) \in D} \log Pr_\Lambda(c | d)$
の最大化を目指す.
実は、 $\frac{\partial^2}{\partial \lambda_i^2} \ell$ を調べると、
関数 $\ell$ は上に凸であることが分かるので、山登り法で解く.

$\Lambda$ に関する微小な変化 $\Delta = [\delta_1, \delta_2, \ldots, \delta_n]$ について、

$$\begin{align*}
\ell(\Lambda + \Delta | D) - \ell(\Lambda | D)
& = \sum_d \sum_i \delta_i f_i - \sum_d \left[
\log \sum_c \exp \sum_i \left[ (\lambda_i + \delta_i) f_i \right]
- \log \sum_c \exp \left[ \sum_i \lambda_i f_i \right] \right] \\
& = \sum_d \sum_i \delta_i f_i
- \sum_d \log \dfrac{\sum_c \exp \sum (\lambda + \delta) f}{\sum_c \exp \sum_i \lambda f}
\end{align*}$$

Jensen の不等式を用いると、

$$\ge \sum_d \sum_i \delta_i f_i
- \log \sum_d \dfrac{\sum_c \exp \sum (\lambda + \delta) f}{\sum_c \exp \sum_i \lambda f}$$

加えて、$- \log(x) \geq 1 - x$ を使って

$$\ge 1 + \sum_d \sum_i \delta_i f_i
- \sum_d \dfrac{\sum_c \exp \sum (\lambda + \delta) f}{\sum_c \exp \sum_i \lambda f} = B(\Lambda)$$

もうちょっと式を綺麗にする.
$f^\# = f^\#(d, c) = \sum_i f_i(d, c)$ を定める.

$$\begin{align*}
B(\Lambda)
& = 1 + \sum_d \sum_i \delta_i f_i - \sum_d \dfrac{\sum_c \exp \sum (\lambda + \delta) f}{Z(d)} \\
& = 1 + \sum_d \sum_i \delta_i f_i - \sum_d \dfrac{\sum_c \exp \left[ \sum_i \lambda_i f_i \right] \cdot \exp \left[ \sum_i \delta_i f_i \right]}{Z(d)} \\
& = 1 + \sum_d \sum_i \delta_i f_i - \sum_d \sum_c P_\Lambda(c|d) \exp \left[ f^\#(d, c) \sum_i \frac{\delta_i f_i(d,c)}{f^\#(d,c)} \right]
\end{align*}$$

> ここでの論文における式変形は恐らく誤り.

これは何だったかというと、
$\ell(\Lambda + \Delta | D) - \ell(\Lambda | D)$ の下限だったので、これを大きくするような $\\Delta$ を見つけたい.
次の偏微分を考える.

$$\frac{\partial B}{\partial \delta_i} = 
\sum_d \left[
f_i(d, c(d)) -
\sum_c P_\Lambda(c|d) f_i(d,c) \exp \left[ \delta_i f^\#(d,c) \right]
\right]$$

これが 0 となるような、$\Delta$ を例えばニュートン法などを用いて解けばよい.
凸性から、解があることは分かっている.

### Gaussian 事前分布

コーパスが大きくない時、求まった $\Lambda$ は実際よりかけ離れたものだろう.
事前分布を仮定すると上手く行く場合がある.
例えばガウシアン分布を仮定する:

$$Pr(\Lambda) = \prod_i \frac{1}{\sqrt{2 \pi \sigma_i^2}} \exp \left[ \frac{- \lambda_i^2}{2 \sigma_i^2} \right]$$

尤度には、これを乗算すれば良い。
対数尤度には $\log Pr(\Lambda)$ を加えるだけなので、
導関数では

$$\frac{\partial Pr(\Lambda)}{\partial \lambda_i} = \frac{\lambda_i+\delta_i}{-\sigma_i^2}$$

が加わった形になるだけ.

## features for Text Classification

素性としては何を用いても良いと言ったが、やっぱり単語の頻度が使われる.
特に文書の単語数で割ることで正規化した値が使われる.
コーパス中でクラス毎にこれの統計を取る必要があるので、

$$f_{w,c'}(d, c) = \begin{cases}
0 & \text{ if } c \ne c' \\
\frac{N(d,w)}{N(d)} & \text{ otherwise }
\end{cases}$$

## Experiment

次の比較を行っている.

- Naiive Bayse (comparison)
- Maximum Entropy (w/o Gaussian Prior)
- Maximum Entropy (w/ Gaussian Prior)

3通りのコーパスで実験を行ってるが、まあ良かったり悪かったり.
事前分布を導入してよくなる場合は良くなってるし、変わらない場合もある.
基本的には、ガウシアン事前分布は入れておいて悪く無さそう.

