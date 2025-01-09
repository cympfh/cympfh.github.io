% クライスリ圏, モナドから導く随伴
% 2020-08-26 (Wed.)
% 圏論

クライスリ圏及びこれを用いたモナドを随伴に分解する方法を紹介する.

$\require{amscd}$
$\def\KL#1{\mathcal{Kl}(#1)}\def\Set{\mathrm{Set}}\def\Hom{\mathrm{Hom}}$

## クライスリ圏

圏 $C$ 及びこれの上のモナド $(T, \mu, \eta)$ があるとする.
このときに $\KL T$ とは次のような圏:

- 対象は $C$ の対象そのまま:
    - $X \in C$ に対して $X \in \KL T$
- 射
    - $f \colon X \to Y \in C$ に対して $f \colon X \to TY \in \KL T$

### 例. 冪集合モナド

冪集合を取る Set の上の自己関手
$$P \colon X \mapsto \{ U \mid U \subset X \}$$
は [モナド](power-monad) である.
これによるクライスリ圏 $\KL P$ を考える.
$$f \colon X \to Y \in \KL P$$
が何かは Set に戻してみると分かって,
$$f \colon X \to PY \in \Set$$
つまり,
Set の射が $X$ の点を $Y$ の点に写すのに対して,
$\KL T$ の射は, $X$ の点を $Y$ の **部分集合** に写す.

$$f \colon x \in X \mapsto y \in Y ~;~ \Set$$
$$f \colon x \in X \mapsto \upsilon \color{red}{\subset} Y ~;~ \KL P$$

## 随伴への分解

圏 $C$ 及びこの上のモナド $(T, \mu, \eta)$ があるときに, 二つの関手を構成する:

- $F \colon C \to \KL T$
    - $FX = X$
    - $f \colon X \to Y \in C$ について
        - $Ff = \eta_Y f$
- $G \colon \KL T \to C$
    - $GX = TX$
    - $f \colon X \to TY \in C$ について
        - $Gf = \mu_Y Tf$

この二つの関手は, 関手 $T$ の分解になっている.
すなわち
$$T = GF$$
が成り立っている.

このこと自体は簡単に確認できる.
対象 $X$ について
$GFX = G(FX)=GX=TX$.
射 $f \colon X \to Y \in C$ について
$GFf = G(Ff) = \mu_Y T(\eta_Y f) = \mu_Y T\eta_Y Tf = 1_{TY} Tf=Tf$.
特に最後の $\mu_Y T(\eta_Y) = 1_{TY}$ はモナド則から.

### 定理

$F$ は $G$ の左随伴になっている.
$$F \dashv G$$

#### 証明

これもほぼクライスリ圏の構成から自明.

随伴の定義は, $X \in C, Y \in \KL T$ について,
$$\Hom_{\KL{T}}(FX,Y) \simeq \Hom_{C}(X, GY)$$
という **自然な** 同型があること.

自然であることを一旦気にしないで対象についてだけ言えば,
$FX=X, GY=TY$ を入れて,
$$\Hom_{\KL{T}}(X,Y) \simeq \Hom_{C}(X, TY)$$
であり,
これはまさにクライスリ圏の射 $X \to Y$ （左辺）が $C$ の射 $X \to TY$ （右辺）に対応するという定義そのままを言っている.

これが自然であることは射の写し方についてまで見る必要があって,
任意の

- $g \colon X' \to X \in C$
- $h \colon Y \to Y' \in \KL{T}$

について

$$\begin{CD}
\Hom_{\KL{T}}(FX, Y) @>\simeq >> \Hom_C(X, GY) \\
@VVV @VVV \\
\Hom_{\KL{T}}(FX',Y') @>\simeq >> \Hom_C(X', GY') \\
\end{CD}$$

横方向の射: $f \in \KL{T}$ を同型に $f \in C$ に写す操作は（同じ記号を使いつつも明示するために） $\Phi(f) \in C$ と書くことにする.
縦方向の射は $\Hom$ 関手によるもので, 具体的に言うと次の通り.
自由に $f \colon FX \to Y \in \KL{T}$ を取ってきたときに,

$$\begin{CD}
f \in \KL{T} @>>> \Phi(f) \in C \\
@VVV @VVV \\
hf Fg \in \KL{T} @>>> \Phi(hf~Fg) = Gh~\Phi f~g \in C \\
\end{CD}$$

この可換性は右下のイコール
$\Phi(hf~Fg) = Gh~\Phi f~g$
を示せばよくて, 次の通り.
$$\begin{align*}
\Phi(hfFg)
& = \mu_{Y'} T(\Phi h) \mu_Y T(\Phi f) \Phi(Fg) \\
& = \mu_{Y'} T(\Phi h) \mu_Y T(\Phi f) \eta_X~g \\
& = Gh~\Phi(f \Phi^{-1}(\eta_X))~g \\
& = Gh~\Phi(f 1_X)~g \\
& = Gh~\Phi(f)~g \\
\end{align*}$$

以上から $F \dashv G$ がわかった.

### 例. 冪集合モナド

冪集合モナド $P \colon \Set \to \Set$ の場合にクライスリ圏からどんな随伴が導かれるか見る.

- $f \colon X \to Y \in \Set$
    - $Ff \colon X \to PY$
    - $Ff \colon x \mapsto \{ f(x) \} \subset Y$
- $g \colon X \to PY \in \Set$
    - $Gg \colon PX \to PY$
    - $Gg \colon \alpha \mapsto \bigcup{x \in \alpha} g(x)$

これらが随伴になる.

