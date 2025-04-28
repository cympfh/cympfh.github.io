% b-Bit minwise hashing
% https://arxiv.org/abs/0910.3349
% Jaccard 係数を bit 演算で確率近似する
% ハッシュ

$$
\def\Pr{\mathop{\mathrm{Pr}}}
$$

## その他の参考文献

- [[https://en.wikipedia.org/wiki/MinHash]]
- [[https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/CACM_hashing.pdf]]

## Intro

２つの集合 $S_1, S_2$ の類似度を表現する方法の一つに Jaccard 係数がある．

$$R = \frac{\#(S_1 \cap S_2)}{\#(S_1 \cup S_2)}$$

ここで $\#()$ は集合の要素数を表す.

使い方は何でもある.

例えば類似した web page を見つけたいだとか.
この当時によくある手法はページごとに 5-ngram を取ってこれの集合と見なす.
仮に英単語が $10^5$ 個くらいだとしても n-gram の個数は $(10^5)^5 = 10^{25}$.
$S_1,S_2 \subset \Omega = [10^{25}]$
という世界で上の Jaccard 係数を計算することになる.
現実的に厳しいので効率化が必要だ.

## Minwise Hashing

$\Omega = \{0,1,\ldots, D-1 \}$ としてこれから考える集合はすべてこれの部分集合とする.

これに関する置換 $\pi \colon \Omega \to \Omega$ を用意する.
そこで Min Hashing は集合 $S \subset \Omega$ について $\min \pi(S)$ を考える.

すると次が成り立つことを言う.

$$\Pr \left[ \min \pi(S_1) = \min \pi(S_2) \right] = \frac{\#(S_1 \cap S_2)}{\#(S_1 \cup S_2)} = R$$

これが確率的挙動なら,
では $\pi$ を複数用意して実際に試してみてその平均を取れば良いだろう.
この場合さらに次が言える.

$\pi_1, \pi_2, \ldots, \pi_k$ を独立に用意したとき

- 命題 $\min \pi_i(S_1) = \min \pi_i(S_2)$ が真の確率は独立に $R$
- その分散は二項分布になる
    - $V = \frac{1}{k} R (1 - R)$

## b-bit Minwise Hashing

さてまだここから.
$\min \pi(S)$ は整数だがその下位 $b$ bit だけに注目する.
$\left[ \min \pi(S_1) = \min \pi(S_2) \right]$
をチェックする代わりにその下位 $b$ bit だけが一致する確率 $P_b$ を考えると,
ある定数 $C_1,C_2$ があって

$$P_b = C_1 + (1-C_2) R$$

という関係が成り立つ.
ここで $C_1,C_2$ は元論文 Theorem 1 に計算式があるのでこれを参照のこと.

実験では $b=1$ でも十分なことを実際に試している.
