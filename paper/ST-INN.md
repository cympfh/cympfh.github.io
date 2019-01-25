% [1805.06447] Spatial Transformer Introspective Neural Network
% https://arxiv.org/abs/1805.06447
% 深層学習 画像認識 データ水増し 正則化 GAN

誤植っぽいのが多い?
pdfのスタイルも悪いし、読みにくい.

## 概要

広大な画像の空間について、限られたデータセットでいかにして頑強なモデルを作るか.
画像を回転させて伸縮させるような、普通のデータ水増しはそのための一つの解決策であるが、いくらでもある画像のバリエーションに対して限界がある.
見たことのない未知のバリエーションを作りたい.
モデルを騙そうとするGANを取り付けるのも、また一つの解決策である. これはどんどん未知の画像を生成しようとする. Introspective Neural Network (INN) は考え方はこれに近い.
しかし、提案する Spatial Transformer (ST) を取り付けることで実装する INN は GAN と違って計算が一続きになっているので、一つの逆伝播で学習が可能で、普通の勾配最適化による学習が容易であるそうだ
(GANだと敵対する部分で伝播が途切れるので).

## 手法

### Introspective Learning

二値分類 $(X=\mathbb R^m) \to (Y=\{-1,+1\})$ について、
[Tuの生成モデル](Tu-Generative.html) を使って、
分類器 $q_t(y|x)$ と、疑似負例生成モデル $p^-_t(x|y=-1)$ を反復的に学習していく.

分類器 $q_t$ は CNN で組む.
彼らはどうも "Wasserstein Introspective Neural Networks" みたいなことがしたいらしいので、単に分類する他に wasserstein 距離の計算もこいつに持たせる.
すなわち、
$$f: X \to Y \times \mathbb R$$
という機械 $f$ を構成する.

$f(x)$ の第一成分 ($Y$ 部分) を $f_C(x)$ と、第二成分 ($\mathbb R$ 部分) を $f_w(x)$ と書く.
$x, x'$ の wasserstein 距離は $f_w(x) - f_w(x')$ と計算される (ように学習する).

> $f, f_C, f_w$ には共通のパラメータ $\theta$ があるので $f(x;\theta), f_w(x;\theta)$ などと書くのが正確だが、省略する.

### Spatial Transformer

入力画像をパラメータ $\tau$ の下でアフィン変換する操作を $T( - ; \tau)$ と書く.
具体的には次のような操作である

$$\left[\begin{array}{c}
x^s \\ y^s
\end{array}
\right] =
\left[\begin{array}{ccc}
\tau_{11} & \tau_{12} & \tau_{13} \\
\tau_{21} & \tau_{22} & \tau_{23} \\
\end{array}\right]
\left[\begin{array}{c}
x^t \\ y^t \\ 1
\end{array}\right]$$
元画像の座標 $(x^s, y^s)$ にあるピクセルを、変換後の座標 $(x^t, y^t)$ に割り当てる.

### 分類器の学習

分類器を学習する.
普通の教師あり学習のように正例と負例として $S^+, S^-$ があるとする.

正例については普通のロスを設計する.
ただし $T$ による変換した画像についても正しく分類できるようにする.
定数 $t_1, t_2$ を以て
$$t_1 \times L(f_C(x^+)) + t_2 \times L(f_C(T(x^+; \tau)))$$
$L$ はなんか損失関数？かな.

次に、負例を用いて、wasserstein 距離を学習させる.
正例の分布と負例の分布の距離
$f_w(x^+) - f_w(x^-)$
を最大化するのと、
あと wasserstein 距離が wasserstein 距離であるために $f_w$ の傾きが 1 未満である必要がある.
というわけで次を損失 (最小化) に加える:
$$t_3 \times \left[ f_w(x^-) - f_w(x^+) + \lambda \left( \| \nabla f_w(\hat{x}) \| - 1 \right)^2 \right]$$
いやこれだと傾きがちょうど1であることのが正しいことになるけど、、まあいいのかな？

以上2つの和を $L_D(\theta)$ と書いて分類器の学習のための損失関数とする.
ただし $x^+, x^-$ は $S^+, S^-$ からサンプリングされてきたもの.
$\hat{x}$ は正例と負例の中間点をランダムに選ぶとある.

### Transformer の学習

Transformer の役割は、分類器にとって難しいデータのバリエーションを与えることなので、分類器にとっての損失を最大化させればよい.
というわけで次を損失関数にする.
$$L_{stn}(\tau) = -L(f_C(T(x^+; \tau)))$$

### 負例の増強

学習した疑似負例生成モデル $p^-_t$ を用いて $S^-$ を増強する.
$p^-_t$ からいくらか疑似負例を集めて $Z$ を作って
$$S^- \leftarrow S^- \cup Z$$

### 全体の流れ

- 以下を収束まで繰り返す
    - 適当回数だけ分類器を学習
    - Transformer を学習
    - 負例の増強
