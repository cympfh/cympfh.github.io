% [2208.11970] Understanding Diffusion Models: A Unified Perspective
% https://arxiv.org/abs/2208.11970
% 生成モデル VAE 画像生成

## 生成モデル

観測可能なサンプルデータ $x$ から, このデータが存在する確率分布 $p(x)$ を学習することが生成モデルのゴール.
学習した分布を使うことで, 新しいサンプルを生成することが出来る.

よく知られた方法として GAN があり VAE がある.
GAN は判別できるということを敵対的に学習してくことで複雑な分布が得られる.
一方で VAE は最尤法ベースになってる.
似た別な方法としてエネルギーモデルがありスコアベースがある.
エネルギーモデルは任意のエネルギー関数として分布を学習する.
スコアベースはエネルギー関数を学習する代わりにスコアを学習する.

この論文では Diffusion Model を VAE とスコアベースモデルの側面で解釈してく.

## ELBO, VAE, and Hierarchical VAE

同時確率の周辺化
$$p(x) = \int dz ~ p(x,z)$$

確率のチェーンルール（ベイズの定理）
$$p(x) = \frac{p(x,z)}{p(z \mid x)}$$

観測できない潜在変数 $z$ があり, サンプルデータ $x$ を観測してるとする.
$p(z \mid x)$ はデータから潜在変数を導出しようとする関数なので ground truth latent encoder だと言える.
単純に観測されたデータ $x$ について, $p(x)$ が尤度なのでこれを大きくしたい（最尤法）.
上の2つの数式はどちらも $p(x)$ を表現しているので, これらを直接最大化できればいいが,
その方法は難しい.
これを緩和する手法として **Evidence Lower BOund; ELBO** がある.
これは $p(x)$ の下限を与え, その下限を大きくすればそれに連れて $p(x)$ も大きくなるというやり方だ.

先に上げた2つの式を変形してく.

ここで $q_\phi(z|x)$ という自由な分布を使う.

$$\begin{align}
\log p(x)
& = \log \int dz ~ p(x,z)  \\
& = \log \int dz ~ \frac{ p(x,z) q_\phi(z\mid x) }{q_\phi(z\mid x)} & \text{分母と分子に同じものを掛けた} \\
& = \log \mathbb E_{q_\phi} \frac{ p(x,z) }{q_\phi(z\mid x)}        & \text{期待値の定義} \\
& \geq \mathbb E_{q_\phi} \log \frac{ p(x,z) }{q_\phi(z\mid x)}     & \text{Jensen の不等号} \\
\end{align}$$

完全に自由な分布 $q_\phi$ を用いて, $p(x)$ に対する下限を与えることが出来た.
この下限を与える数式を指して ELBO と呼ぶ.
$q$ のパラメータ $\phi$ を最適化することで, ELBO を大きくし, 間接的に $p(x)$ を大きく出来るはずという手法.
実際これは成立する.

不等号ではあるが, ではその差が何なのかというと実は KL ダイバージェンスになっていて,
$$\log p(x) - \mathbb E_{q_\phi} \log \frac{p}{q_\phi} = D_{KL}(q_\phi(z \mid x); p(z \mid x))$$
が成り立つ.
というわけで下限を最大化することはこの KL ダイバージェンスを最小化することになっていて,
すなわち $q_\phi$ を $p(z \mid x)$ に近づけることになっている.

では ELBO を最大化することを考える.

$$\begin{align}
\mathbb E_{q_\phi} \log \frac{ p(x,z) }{q_\phi(z\mid x)}
& = \mathbb E_{q_\phi} \log \frac{ p(x \mid z) p(z) }{q_\phi(z\mid x)} & 確率のチェーンルール \\
& = \mathbb E_{q_\phi} \log p(x \mid z) + \mathbb E_{q_\phi} \log \frac{p(z)}{q_\phi(z\mid x)} & 期待値の線形性 \\
& = \mathbb E_{q_\phi} \log p(x \mid z) - D_{KL}(q_\phi(z \mid x); p(z \mid x)) & \text{KL の定義}
\end{align}$$

最後の式の $p(x \mid z)$ を $p_\theta(x \mid z)$ で置き換える.
これは「潜在ベクトル $z$ を入れたらサンプル $x$ を出してくれるデコーダー」だと思う.
ここで $\theta$ がパラメータである.

結局 $\theta$ と $\phi$ を動かすことで次の値を最大化することが目的になる.

$$\mathbb E_{q_\phi} \log p_\theta(x \mid z) - D_{KL}(q_\phi(z \mid x); p(z \mid x))$$

この第一項を reconstruction term, 第二項を prior matching term と呼ぶ.
前者は $z$ から $x$ を生成する確率を高めること,
後者はエンコードが事前分布 $p(z)$ に近づけることを言っている.

この最適化を **Variational AutoEncoder; VAE** という.
エンコーダー $q_\phi(z \mid x)$ とデコーダー $p_\theta(x \mid z)$ を学習するのでオートエンコーダになっているものと考えられる.

![](https://i.imgur.com/7SRqEVg.png)

特に VAE は事前分布 $p(z)$ 及び $q_\phi(z \mid x)$ としてガウス分布を仮定することが多い.

- $p(z) = \mathcal{N}(z; 0,1)$
- $q_\phi(z \mid x) = \mathcal{N}(z; \mu_\phi(x), \sigma^2_\phi(x))$

実用的には $z$ の各次元は独立だとしていいから共分散 $\sigma^2$ は対角行列だとしていい.
ここまで仮定すると KL ダイバージェンスが簡単に計算できるのでいいね.
残るは reconstruction term の計算.
ここは期待値はサンプリングすることで近似する.

サンプリング $z \sim q_\phi(z \mid x) = \mathcal{N}(z; \mu, \sigma^2)$ をし,
この $z$ について中身を計算する.
そしてまたこのサンプリングは,
正規分布
$\epsilon \sim \mathcal{N}(0,1)$
からのサンプリングを定数として扱って,
$$z = \mu_\phi(x) + \sigma_\phi(x) \odot \epsilon$$
とすれば欲しかったサンプリングになる (reparameterized technique とか呼ばれる).

以上の VAE を階層化（というか多段に）したものとして **Hierarchical VAE; HVAE** がある.

![](https://i.imgur.com/HoGtGLu.png)

$$p(x, z_{1:T}) = p(z_T) p_\theta(x | z_1) \prod p_\theta(z_{t-1} \mid z_t)$$
$$q_\phi(z_{1:T} \mid x) = q_\phi(z_1 \mid x) \prod q_\phi(z_t \mid z_{t-1}$$

このときに ELBO は
$$\log p(x) \geq \mathbb E_{q_\phi} \log \frac{p(x, z_{1:T})}{q_\phi(z_{1:T} \mid x)}$$

## Variational Diffusion Models

![](https://i.imgur.com/Cyqrrcz.png)

- $z$ の空間をサンプルデータ $x$ の空間と同じものとする
- エンコードは学習しない. 予め定めたガウス分布で $x_{t+1} \sim x_t + \mathcal{N}(0, \sigma^2)$ というサンプリングをするだけ
- 最終ステップ $T$ で $p(z_T)$ はほとんどただの正規分布になる
