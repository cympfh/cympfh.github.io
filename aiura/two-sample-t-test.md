% 2標本のt検定
% 2021-01-06 (Wed.)
% 統計

## 平均の同等性の検定

$\def\N{\mathcal N}\def\bar#1{\overline{#1}}$
2つの正規分布

- $\N_1 = \N(\mu_1,\sigma_1^2)$,
- $\N_2 = \N(\mu_2,\sigma_2^2)$

があってそれぞれから $n_1, n_2$ 個ずつサンプリングしてくる.

- $X_1^1, \ldots, X_1^{n_1} \sim \N_1$,
- $X_2^1, \ldots, X_2^{n_2} \sim \N_2$

これらから $\mu_1 = \mu_2$ であるかどうかを検定したい.
特にここでは
$$\sigma_1 = \sigma_2$$
を仮定する.

## 2標本t検定

とりあえず結論だけ見たければ
[これ](https://bellcurve.jp/statistics/course/9427.html)
を見れば良いです.

## 導出

次のような方針を採用する.
$\mu_1, \mu_2$ は普通に標本平均から推定できそう.

- $\bar{X_1} = \frac{1}{n_1} \sum_j X_1^j$
- $\bar{X_2} = \frac{1}{n_2} \sum_j X_2^j$

これらに差があるかどうかだから, $\bar{X_1} - \bar{X_2}$ という差を調べる.
母平均に差が無いとは, この標本平均の差がゼロであるということ.

今, 母平均が等しいことを帰無仮説とする.
すなわち, $\mu_1 = \mu_2 = \mu$ だし $\sigma_1 = \sigma_2 = \sigma$ と仮定して話を考える.
$$\N_1 = \N_2 = \N(\mu,\sigma^2).$$

標本平均が従う正規分布は,

- $\bar{X_1} \sim \N(\mu, \sigma^2 / n_1)$
- $\bar{X_2} \sim \N(\mu, \sigma^2 / n_2)$

これの差もやはり正規分布に従って,

- $\bar{X_1} - \bar{X_2} \sim \N(\mu - \mu, 1^2 \sigma^2 / n_1 + (-1)^2 \sigma^2 / n_2) = \N(0, \sigma^2 (1/n_1+1/n_2))$

両辺を適当に割れば,

$$\frac{\bar{X_1} - \bar{X_2}}{\sigma \sqrt{1/n_1+1/n_2}} \sim \N(0,1)$$

これだけで検定をすることも考えられるが, これだけだと標本が $n_1 + n_2$ 点もあるのに, それぞれの平均という2点しか使ってないことになる.
t 検定まで考えることで, 標本をフルに使える.

標本から, 残差和

- $S_1 = \sum_j (X_1^j - \bar{X_1})^2$
- $S_2 = \sum_j (X_2^j - \bar{X_2})^2$

とすれば次が成り立つのだった.

- $S_1 / \sigma^2 \sim \chi^2_{n_1-1}$
- $S_2 / \sigma^2 \sim \chi^2_{n_2-1}$

さらにこれらの和も $\chi^2$ 分布に従ってしかもその自由度は単に足し算すればよく（再生性）

$$\frac{1}{\sigma^2} (S_1 + S_2) \sim \chi^2_{n_1+n_2-2}$$

以上から次の値が $t_{n_1+n_2-2}$ 分布に従うことが分かる.

$$T = \frac{ \frac{\bar{X_1} - \bar{X_2}}{\sigma \sqrt{1/n_1+1/n_2}} }{ \frac{1}{\sigma^2} (S_1 + S_2) } = \frac{\bar{X_1} - \bar{X_2}}{ (1/n_1 + 1/n_2) \frac{S_1+S_2}{n_1 + n_2 - 2}} \sim t_{n_1+n_2-2}$$

これを使った検定のことを, 表題のように言う.

