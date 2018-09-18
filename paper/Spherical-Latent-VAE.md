% Spherical Latent Spaces for Stable Variational Autoencoders
% https://arxiv.org/abs/1808.10805
% 深層学習 オートエンコーダ 生成モデル

$\def\vMF#1#2{\mathrm{vMF}(#1, #2)}$

## リンク

- [https://arxiv.org/abs/1808.10805](https://arxiv.org/abs/1808.10805)
- [https://github.com/jiacheng-xu/vmf_vae_nlp](https://github.com/jiacheng-xu/vmf_vae_nlp)

## 概要

潜在分布にガウシアン分布を用いた [VAE](VAE.html) のデメリットとして,
collapse してしまう現象に陥ってしまうことがあること.
つまり encoder は入力を無視して最適な分布に写し,
decoder は潜在分布を無視して平均的なデータを生成するような状態が期待しない局所的最適解として存在する.

この論文では, ガウシアン分布をやめて von Mises-Fisher (vMF) 分布を用いることで安定化を図る.

## vMF 分布

$x \in \mathbb R^d$ に関する $d$ 次元 vMF 分布とは球面 $S_{d-1}$ の上の分布であって, その密度関数は次の $f_d$ で与えられる.
ここで $\mu \in \mathbb R^d, \kappa \in \mathbb R$ がパラメータ.
ただし制約として $|\mu|=1, \kappa \geq 0$ を要請する.
また, $I_v$ は[第一種変形ベッセル関数](https://ja.wikipedia.org/wiki/%E3%83%99%E3%83%83%E3%82%BB%E3%83%AB%E9%96%A2%E6%95%B0#%E5%A4%89%E5%BD%A2%E3%83%99%E3%83%83%E3%82%BB%E3%83%AB%E9%96%A2%E6%95%B0).

$$f_d(x ; \mu, \kappa) = C_d(\kappa) \exp(\kappa \mu^T x)$$
$$C_d(\kappa) = \frac{\kappa^{d/2-1}}{(2\pi)^{d/2} I_{d/2-1}(\kappa)}$$

### 一様分布とのKL距離

パラメータ $\mu, \kappa$ での vMF 分布を $\vMF{\mu}{\kappa}$ と書くことにする.
一様分布は $\vMF{\mu}{0}$ で与えられる. $\mu$ は何でも良い.
$\vMF{\mu}{\kappa}$ と一様分布とのKL距離が次で与えられる.

$$KL(\vMF{\mu}{\kappa} \| \vMF{\cdot}{0}) =
\kappa \frac{I_{d/2}(\kappa)}{I_{d/2-1}(\kappa)}
+ (d/2-1) \log \kappa
- d/2 \log(2\pi)
- \log I_{d/2-1}(\kappa)
+ d/2 \log(\pi) + \log 2 - \log \Gamma(d/2)$$

$\mu$ は分布の平均？で, 一様分布との距離なので, $\mu$ には依存しない.
$\kappa$ が大きくなるに単調に $KL$ も増加する.

### sampling

VAE に使うためには vMF 分布から点をサンプリングする方法が必要.
[Wood 1994] "Simulation of the von mises fisher distribution"
の方法によると書いてあるが, これを読むには \$5.00 必要なので諦める.

実装が公開されてるのだが,
ちょうど
[NVLL/distribution/vmf_only.py#L92](https://github.com/jiacheng-xu/vmf_vae_nlp/blob/master/NVLL/distribution/vmf_only.py#L92)
の部分で $w$ という乱数を $\kappa, d$ によって決める.

ベクトル $\mu$ とそれに直交するベクトルをランダムに $v$ として選んだ時
$$w \mu + \sqrt{1-w^2} v$$
として, これを $\vMF{\mu}{\kappa}$ からサンプリングして得た点とする.

## vMF VAE

vMF を潜在分布として推定し, 先の方法でサンプリングした点からデータを復元するように VAE を構成する.

