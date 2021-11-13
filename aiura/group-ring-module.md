% 群, 環, 加群
% 2021-11-13 (Sat.)
% 代数

群がすべてのベースになってるので, 丁寧にやってく.
$\def\ker#1{\mathop{\mathrm{Ker}{#1}}}\def\im#1{\mathop{\mathrm{Im}{#1}}}$
$\def\bar#1{\overline{#1}}$

## INDEX
<div id=toc-level-2></div>

## 群 (Group)

### 群の定義

集合 $G$ に単位元及び積という構造を入れる.

- $e \colon I \to G$
    - ここで $I$ は単集合 $\{ \ast \}$
    - $e$ は値 $e(\ast) \in G$ だけを持ち, この値を $1$ と書く
        - $1 = e(\ast) \in G$
    - この $1$ のことを（あるいは $e$ のことを） *単位元* と呼ぶ
- $\mu \colon G \times G \to G$
    - $\mu(x,y)$ のことを $x \times y$ とか $xy$ と書く
- $\nu \colon G \to G$
    - $\nu(g)$ のことを $g^{-1}$ と書いて $g$ の **逆元** という

ここで $1$ と $\mu$ ($\times$) は次を満たすことを要請する

- g1) $\forall x \in G ,~ 1 \times x = x \times 1 = x$
- g2) $\forall x,y,z \in G ,~ (xy)z = x(yz)$
    - 結合則という
- g3) $\forall x \in G,~  x^{-1} \times x = x \times x^{-1} = 1$

圏論っぽく書くと次の通り.
ただしここで登場する対象はすべて対象で射は写像.

圏の構造とは, つぎの3つの射のこと.

![](https://uc81450633ca547061fd53097749.previews.dropboxusercontent.com/p/thumb/ABXzEwrB2eA9KxksKyyJMyMSfJ0042pwUeixJB2LZbSOPh1mlqbpzNj5IIkKLnEI-pBbpB8s_NYzYDX6ByzICHyqbbkYzIApLOr4dTJbktmYqoXa3ievRhUucfhHEDZYO_oH5UL4q1QXApkFda7GxjiOIaggI9YwTkgekJOaPCjAIzzgqCV8QFkvKJkz1XJUpdLAFMXERsptNQgRPIdpmJzAptx4UImNu40b7bwLKr87undlLkUsEF-LOLd37qbGpyD25ktxkRngws8L2JuyjL-MFAcMJXqqKwR-9jA_kQhcHD0nn8p5JkV2Y09dz0pogXhgR5ZMdntda61aDgGueSfN8aXWuoViceyvD9mNB1Tym4iXqWVh_feZIfjalhWaTsU/p.jpeg)

ここで満たすべき性質は次の図式が可換であること.

![](https://uc8b7c825e61f3ea94a4338879ce.previews.dropboxusercontent.com/p/thumb/ABWw3WhBmb9vH2NDBExFD_t4C0CCqylBNOQ1U3DoM0UhCrYtSK-k2SpMYdAkF9t2mIYD6mHm8_1t12fL7TF7APOJ14YqZ8BpXAuY8rU0PtJii1v7KKi6gy8hBmQs4_3ljTUHcndUaxEsSZKLslXMXz7kSFt7P4d3ImjFhpnTC0DXf1ZdHGHnRST3HN7RmjhxdMHWKCed2zCnXCDrbxaF7wVIaPuAmFZ8Dh49Zm7IVxsjCBYgvcpex2wsQ-tO1iKxd4kC6ga0o9FR3Jn5yaZlw48tEsJw7oJ_2-i-HO2sMWq_Aw8lGEESKU9oZEKklxRgKlH_mbdyQd431wVCyjLW1aOPRhEUIu02CDatL3lnhm_xp_bLBmeYcHqEF6sOlFjNm1o/p.jpeg)

![](https://uca2ae819ab5d22ef1c61803ec2f.previews.dropboxusercontent.com/p/thumb/ABW5zlL5gyW3tMNc5lsjQXA2e2yWRtzApxjYvOcUl_yBDVeMvdLEnJx0dWmeVzslJ0GSZcDBfFK7ngOr411Ng8dlmeszY9hLSKgdhLbM0ydq2lfpF9IEW054K9zr4mUvJj0dhQW2x-hb9vbGsWUSmsXkr_1xrr73dDdlNBe7cCIBLzMmNW3CM_ycq0HCpV3vlYYbCvEr1Tk89l9ZWcvvtzaNQpoOIgxQFWwmFZeq3PZ_hEtSIuBY_ROmED4vskLvRrFAIGZxuoPRQdKG2MgvExdrFmI5OR3RUiItuMNiO32q0cO4zMDnlvxMsXjCIHOYncGRSqsWeerUiMU_hsfQbYw7Ks_HZGxN9VAZg3qel9uIUqc9QfASZ7koc6LpY1GlUjM/p.jpeg)

![](https://uc100b466de412af28071148e9eb.previews.dropboxusercontent.com/p/thumb/ABV2HZAJkE_yKB_XBWZtS97yj-NKKLMJdZbPxsIqPUuUPo_P0YJGaEqgZJ4uPODx8WtHWINNDO9ItWWBqzT9sFT12khoTdrLZXnqAcCamVpNyt_FqjIGNDIt5Y_Qi0PxLifq8dgpVqyLqcEhIm7JSyey_4JUyeR4E-tDWBk-1oD8JoWxIwD9C9bDSv0WgWQlhRXMMCViWnuSNmX85izsTlOtKZA29DrKfw1N5xKJDQpc9pM3RICDxuUNrwVNwkJUhb3eRBR_o2s6iIc43lVy2lZH8Jlrjt7jEDliVXXja09VQK01n9Va5HPAZYL9g1l1J11v-Q2f-rpOsMN7iuMSgbEdNULynrZ7ZOxMtCAOJSemLiu2nEgPMxkIU33ybJDcbOE/p.jpeg)

同じことだがストリング図で書くと次の通り（見やすい！）.
ただし下三角は単位元.

![](https://ucfd310b2c0654af61f8a57c23aa.previews.dropboxusercontent.com/p/thumb/ABXHoChqiWDMxf9-dG0CE3FXWa_PeGUs8qHWIT84AfcAvIqJ5lkreXDGng3t1CPVmM2NRU92MDSbp40o8Ey4Mg2Z_OIDdVI-ZVWZFDnWiu2DmhEgeJN79Y8IjblPJeuO5jemwLgHifPC_nCCxpOiEE2U0jZYeBBQciFYCOdFD5MvDqe61WwzlCy7zUhfvBx9bcryxF_X_XU-qiNzUdo3Ejg50WXrzh7ezflUoawP3naQ7BujW24xNaq-WC7IuffYXr6OypgHHhXJHprge2klB3gnPPK8tnW0ME5gyju_B3YsiVLF9sQ4PP5oTjB9AOPIs4PB_UjfdYn_M5sRFdT4nCScBvOvmojJHIAOGfbll2af-txpjR1zsZS5Q0p1IWbGtKc/p.jpeg)

### 群の準同型

2つの群 $G,H$ があるとする.
それぞれは集合でもあるから, その間の写像
$$f \colon G \to H$$
を考えることが出来る.
この写像が **準同型 (homomorphism)** であるとは, 概ねそれぞれの群としての構造を保つことを言う.
具体的には次の2つが満たされることである.

- homo1) $f(1) = 1$
    - $1 \in G$ を $1 \in H$ に写す
- homo2) $f(xy) = f(x) f(y)$
    - 掛け算してから $f$ するのと, $f$ してから掛け算するのは等しい

同じことであるが,
せっかく先程群の構造を圏論っぽく書いたので, それに揃えたバージョンも書くと次の図式が可換であることと言い換えられる.

![](https://ucebd461f8d3bbde4e36aaf20f5f.previews.dropboxusercontent.com/p/thumb/ABVAYrN5ZhwT4bVjcu16jM86PY75DmbS7OzijiH_P275GAVaEonBIZaV_mw0apLpnbuU_sGgzT_oLXDPPwjo9xBoYclSX8oM0SUkX12MbmL6y2SzM_JECca585eWQCG7TB_R7MLzZpJmb2zfKMWPzv7MaXfVNGXgNI4t92uXWz2jeKZ-MMDI0Eh7a0pgzSz3DruGexHGR9JGtM8-h-8pHYNaz0aVOE20Ny_6UXaoKkD4OCd_rXMov1Gq97iEMby9GTBiAW2of2wGl_w_asUhz-FqlPJNovnBiIDfzUtAa3npFLH0adNRQ813xZidBAp3boO-uba2MEqO4XU3jyIsJxb3RKY-kulEYLD3_LR4aTy95FuFaAykj32-_IXk1a6CFas/p.jpeg)

### 部分群

群 $G$ があるとする.
これは集合でもあるから部分集合 $H \subset G$ を考えることが出来る.
この $H$ が $G$ と同じ構造によって群であるとき, $H$ を **部分群** という.
具体的には $H$ が次を満たすことをいう.

- $1 \in H$
    - ここで $1$ は $G$ の単位元
- $\forall x,y \in H ,~ \mu(x,y) \in H$
    - ここで $\mu$ は $G$ の演算
    - 「演算について閉じている」と表現する

### 準同型の核と像

群 $G,H$ とその間の準同型 $f \colon G \to H$ があるとする.
このとき, $f$ の核とは
$$\ker{f} := \{ g \in G \mid f(g) = 1 \}$$
のことで, $f$ の像とは
$$\im{f} := \{ f(g) \mid g \in G \}$$
のこと.

- $\ker{f} \subset G$
- $\im{f} \subset H$

は集合としては自明だが, 実は群としても部分群になっている.
準同型という性質から実はほとんど自明だが, 群だけは丁寧にやろう.

- $1 \in \ker f$
    - $f$ が準同型なので $f(1) = 1$ であることと $\ker f$ の定義から
- $x,y \in \ker f \implies xy \ker f$
    - $f(xy) = f(x) f(y) = 1 \times 1 = 1$
- $1 \in \im f$
    - やはり $f(1)=1$ なので
- $x',y' \in \im f \implies x'y' \in \im f$
    - $f$ の像にあるということは, ある $x,y \in G$ があって $x=f(x), y'=f(x)$
    - $x'y' = f(x)f(y)=f(xy)$ より $x'y' \in \im f$

### 商群

群 $G$ とその部分群 $H \subset G$ があるとき,
商群 $G/H$ を次で定めることができる.

$$G/H := \{ gH \mid g \in G \}$$

$gH$ は $H$ を単位としたそういう数と思ってもいいし,
原理通りにいうなら
$gH = \{ gh \mid h \in H \}$
という値.

$g,g' \in G$ について $gH = g'H$ とは,
$\{ gh \mid h \in H \} = \{ g'h \mid h \in H \}$
のことであるが, 次のように易しく言い換えられる.
（特に逆元のおかげで $\exists$ だけでいい.）
$$gH = g'H \iff \exists h \in H, g = g'h$$
ついでに $g'$ を左に移項すれば単に
$$g g'^{-1} \in H$$
といえる.

#### 商群の例

典型定期な例は $\mathbb Z / n \mathbb Z$ だろう.
$\mathbb Z$ は整数全体であって, その $+$ に関して群をなす.
単位元のことは普通 $0$ とかく.

> 今まで暗黙に群の演算を掛け算のようにみなして演算を $\times$, 単位元を $1$ と書いたが,
> 足し算 $+$ と単位元 $0$ によって群をなすようなものも多い.
> 単に記号の違いであるが, このような群を加法群と呼ぶ.
> 逆元 $x^{-1}$ はやはり掛け算からのアナロジーでそう書いてたから, 加法群の場合の逆元は $(-x)$ と書こう.

$n \mathbb Z$ は各要素を $n$ 倍して得られる集合（つまり $n$ の倍数） $\{ nz \mid z \in \mathbb Z \}$ のこと.
$n$ の倍数どうしの和は $n$ の倍数であることや単位元 $0$ は $n$ の倍数であることから, これもやはり（加法）群である.

$a = b \in \mathbb Z / n \mathbb Z$ とは,
$a + (-b) = a - b \in n \mathbb Z$ のこと,
つまり差が $n$ の倍数ということ.
すなわち整数に $\pmod n$ を入れた数を表す.

#### 標準全射, 自然射影

$g \mapsto gH$ と写すことで, 自然に $G \to G/H$ という全射が作れる.
これを標準全射だとか自然な射影だとかそれっぽい言葉で言う.

### 群の準同型定理

群とその間の準同型 $f \colon G \to H$ について,
$$\bar{f} \colon G/\ker f \to \im f$$
$$(g \ker f) \mapsto f(g)$$
は準同型かつ同型.

ここで $\ker f$ が $G$ の部分群であることに注意（だからこそ商群が定義できる）.

また, 定義域が商群な場合にはこの写像が本当に well-defined であるか注意が必要である.
さしあたって, $G/\ker f$ がどんなものか見よう.
$$\begin{align*}
     & (g \ker f) = (g' \ker f)  ~~ \in G/\ker f \\
\iff & (gg'^{-1}) \in \ker f \\
\iff & f(gg'^{-1}) = 1 \\
\iff & f(g) f(g'^{-1}) = 1 \\
\iff & f(g) f(g'^{-1}) \times f(g') = 1 \times f(g') \\
\iff & f(g) = f(g') \\
\end{align*}$$
つまり, 商群で等しい値は同じ一つの値に $\bar{f}$ で写されていることがわかる.

準同型であることを見ていく.

- $\bar f(0) = f(0) = 0$
- $\bar f((g \ker f) + (h \ker f)) = f(g+h) = f(g) + f(h) = \bar f(g \ker f) + \bar f(h \ker f)$

自明だ.

次に同型, つまり $\bar f$ が全単射であることを見る.

- 全射
    - $h \in \im f$ を任意にとってきたとき, $f$ の像なんだから当然 $\exists g, f(g) = h$
    - その $g$ を使って, $\bar f(g \ker f) = h$
- 単射
    - $f(g) = f(g') \iff f(g g'^{-1}) = 1 \iff gg'^{-1} \in \ker f \iff (g \ker f) = (g' \ker f)$

というわけで $\bar f$ は同型射で,
$$G / \ker f \simeq \im f$$
と言える.

$G$ から商群 $G/\ker f$ への自然な射影を $\pi$ と書くと,
準同型定理とは次を言っている.

![](https://uc9f701c3635937a393fabc6f72a.previews.dropboxusercontent.com/p/thumb/ABVluSDcl0DHVA98r8stp3mqiwreDLB1cqKxM9DkSlvN0rCEDIlH9ELzUQ4Nyo1_VkQG2lMrgXx5TptSISR_pn0-C4eTEVXhFD59pIZQwsIhU1ejAZ0CrYb_crQkqbVGtOLy2lPewawEq1-UIiO0zgREvZWV5vmZmOa-0TVh4sFQaWJqOXAA1jN3Z5wK3HMX2ncqxMDXNsUzsvbj9jVKVgMYpfylZoEWKOHVlcI1lT_OwD9inmNR3_3I8J7Pw3ick0zxEGD7YpivNA_LWCU2qq0FOqD7clhRooSsigAifpAXNuD6FRsYK5QOBLJPxY_l7E-WO8WLWFJXgo4xfkBNTuumQJd2PDQvHiz5KuJct2KeN6TO3VjbQ0T84I3aOFQMKb8/p.jpeg)

### 準同型の単射性

準同型 $f \colon G \to H$ の単射性について次が成り立つ.

- $f$ が単射 $\iff \ker f = \{1\}$

というのも, 準同型定理の $\bar f$ の単射性を示す際に次が出てきた.
$$f(g) = f(g') \iff gg'^{-1} \in \ker f$$
これを使うと自然に出てくる.

- $f$ が単射と仮定する
    - $g \in \ker f \implies f(g) = f(1) \implies g = 1$
        - $g'=1$ を代入した
- $\ker f = \{1\}$ を仮定する
    - $f(g) = f(g') \implies gg'^{-1} = 1 \implies g = g'$

## 環 (Ring)

### 環の定義

加法群 $(R,+,0)$ があるとする.

- $\epsilon \colon I \to R$
    - $\epsilon(\ast) = 0 \in R$
- $\alpha \colon R \times R \to R$
    - $\alpha(x, y) = x + y$
- $\nu \colon R \to R$
    - $\nu(x) = (-x)$

ただし可換性

- $x + y = y + x$

を追加で仮定する.
可換性のある群を **可換群** とか **Abel 群** などという.

ここに演算 $\times$ とその単位元 $1$ を新たに導入する.

- $e \colon I \to R$
    - $e(\ast) = 1 \in R$
- $\mu \colon R \times R \to R$
    - $\mu(x,y) = x \times y (= xy)$

ここで $(\times, 1)$ は次を満たす.

- $xyz = (x \times y) \times z = x \times (y \times z)$
    - 結合則
- $\exists 1 \in R, x = x \times 1 = 1 \times x$

この $(R,\times,1)$ は逆元の存在だけが仮定されていない群であるが, これを **モノイド** ともいう.

というわけで, $R$ に加法群 $(R,+,0)$ という構造と, $(R,\times,1)$ というモノイドの構造を併せて入れた.

![](https://uce312d37aac3e3c2902c01625df.previews.dropboxusercontent.com/p/thumb/ABXbuSWUTTOsaJPNgNRjcs6979oHNQaAz-j98YEiqdeXWY4NhAg0oDThBcSmnBKb3pju0JQj80KYNkW7sfwMm5Ie7EFCM1EIw8Y6sf8C7fXhqIplDWjcaW4IvS5jC_RLyW9wnwf3roe9Uh6TQzzfBhLcF2hIDtNZAagQ978YRy3ICes70CkltW3zP23TwKn_gHXZPjAtMdgptyEWEfBUGrno3wkHnlAQ3R3jSCNVZQrS8PkkeihAK28phMbFK-LPCIFcv5g0DjMD2QoO8GvttCNh2T4KxTfLH1ux9Y1LNNYF8LuLl0cfQ17Eea6rE4hvLJJCt2bFvvL4BUtND_RqqmQtYUASHmG9ZUizHTr1Ff-t2J_ZWxzEO7dTW1oQSjXV5fA/p.jpeg)

ここにさらに $(+,\times)$ の分配則を要請する.

- $(x+y) \times z = xz + yz$
- $x \times (y+z) = xy + xz$

以上を満たす $(R,+,\times)$ を **環** という.

![](https://uc99d893d2cfa436766cf55be18f.previews.dropboxusercontent.com/p/thumb/ABXdZmybTUFhVZgKEcxlq9kSiOOH5Jraecdq1z_e_cvHud2LqfBXnnIz7yI63mdbOnLqbtkwFmaIu4OapOQD6LrQdlLsBFSSQp1mFgY_CtkrLXyp6rcsb8yyUmDfC565edSA1jmdp7F_CiRN0OrvJSCje0iOopUFU09yHSPPwbiSqT50_JJoqes9JUskjUngOjls6WgC4btynybDu5sMrK140lINwTBK24z3054tprvi2jJ1g8N4Q-Vik99KR9a4u_Jvvv2yQOOjF-_vWtTmkCap0iPFkLXAgfrmEagv4ysQoPMzgQFwOIMEqmiR3CBZpLxaGejhjInvXv4x7yf8mMeYockBWo4zRqt4Xmkvtobf24kkqtvxSzM72h554lBKpSI/p.jpeg)

### 0倍について

分配則より,

$$x \times 0 = 0 \times x = 0$$

が言える.
というのも

- $x \times 0 = x \times (y + (-y)) = xy - xy = 0$

であるから.

### 環の例

整数とその上の普通の足し算と掛け算がまさしく環のモデルである.
足し算は可換群であるし, 掛け算はゼロがあるために逆元が一般には存在しないモノイドになっている.

### 環の準同型

2つの環 $R,S$ の間の写像 $\varphi \colon R \to S$ が準同型であるとは,
やはりすべての構造が保たれること.

![](https://ucbf1db9752215c96683e9f7c555.previews.dropboxusercontent.com/p/thumb/ABWlG8TAfQdTBYq6myxt4beUgccPjYRKdlwAUDd0B-H_NPxyAA5Wn1XXwbNh4kZLESFk9Kf1V5KGFLSe0U9_5UYCZDNv-rH7DlyocHeivy6dGZdC2LiOreht4mH6O5VSZ6mjbtz8Hq0GoMKJN3E2__kq1liAb8I8cu-QAtvEWpXpGMi6NyM5VnGPQvtiKUg7kfW8yjszfKlS51E2Dyk7Ore5uRxeECrWGnblRLzzE7ak19TTUAKOWlddmV7cY53g62uEiTS1o-eLnTM3ZLO742AkGBX5lodMsLRNCZ_leuG7RUJ44ULpH0AFENfW_ZCyZmZ_4NJ1KKVSnC-OWNoxpGv-pM89GW4iN81GzQB7U8R0OhUWq0nKWwwFElNF4RKF6gk/p.jpeg)

目新しさはない.

### イデアル

環 $(R,+,\times)$ があるとする.
この加法群 $(R,+)$ の部分群 $(I,+)$ が

- $\forall a \in R, \forall x \in I, ax \in I$

を満たすとき, $I$ を $R$ の **左イデアル** だという.
左というのは $ax$ という掛け算の順序を言っていて, これが逆になれば右イデアルという.
特に左イデアルでかつ右イデアルであるものを **両側イデアル** という.
$\times$ が可換ならもちろんイデアルはいつでも両側イデアル.

#### イデアルの例

整数 $(\mathbb Z, +, \times)$ に対して,
$n \mathbb Z$
は（両側）イデアルになる.
これは「$n$ の倍数は自由に整数倍をいくらしても尚 $n$ の倍数である」と言っている.

### 商環

環 $R$ とその両側イデアル $I$ があるとき,
商群と同じノリで,
商環 $R/I$ を定義できる.

$$R/I := \{ a+I \mid a \in R \}$$
$$(a+I) = (b+I) \iff (a-b) \in I$$

ここで環としての構造は次の通り.

- $0 = (0+I)$
- $(a+I) + (b+I) = ((a+b) + I)$
- $1 = (1+I)$
- $(a+I) \times (b+I) = (ab + I)$

### 準同型の核と像

環の間の準同型 $f \colon R \to S$ の核とは, 加法群に関する核のことで,
$$\ker f := \{ x \in R \mid f(x) = 0 \}$$
で定められる.
$f$ の像とは,
$$\im f := \{ f(x) \mid x \in R \}$$
のこと.

$\ker f$ は $R$ の両側イデアル.
$x \in R, y \in \ker f$ を自由にとってきたとき,
$f(xy) = f(x) f(y) = f(x) \times 0 = 0$
から $xy \in \ker f$ が言える.
$0$ の掛け算は左右関係ないので両側イデアルになる.


### 環の準同型定理

式としては全く群の場合と同じことを書く.

環の間の準同型 $f \colon R \to S$ があるとき,
$$\bar f \colon R / \ker f \to \im f$$
$$(x + \ker f) \mapsto f(x)$$
は準同型でかつ同型を与える.

同型であることは群の場合の話と同じ.
準同型であることも $+$ については群の話そのままなので $\times$ だけ考える.

- $\bar f(1) = f(1) = 1$
- $\bar f( (x + \ker f) \times (y + \ker f) ) = \bar f(xy + \ker f) = f(xy) = f(x) \times f(y) = \bar f(x+\ker f) + \bar f(y+\ker f)$

自明なじゃないところがない.

## 加群 (Module)

### 加群の定義

加法群への環の作用のことを加群という.

環 $R$, 加法群 $(M,+)$ とその間の作用
$$\lambda \colon R \times M \to M$$
$$(a, x) \mapsto ax$$
が定められていて, 次を満たすとする.

- m1) $a(x+y) = ax+ay ,~ a \in R ,~ x,y \in M$
- m2) $(a+b)x = ax+bx ,~ a,b \in R ,~ x \in M$
- m3) $(ab)x = a(bx) ,~ a,b \in R ,~ x \in M$
- m4) $1x = x ,~ 1 \in R ,~ x \in M$

$M$ を **$R$-左加群** という.
この左とは作用の定義域 $R \times M$ の順序を言っていて,
同様に $M \times R \to M$ な作用を考えることで右加群を定義できる.
その場合 m1-m4 はすべて逆にすればいいだけだが,
特に $x(ab) = (xa)b$ は作用させる順番が逆になることに注意.
作用の順序が逆になっても構わない場合, 左加群であってかつ右加群になるわけだが, そのようなものは **双加群** という.

### 加群の例

加群の作用のことを特に **スカラー倍作用** などと呼ぶが, これは次を見ると納得する.

環 $R$ の上の線形空間 $V$ は $k$-加群.
ただし $V$ は加算 $+$ とゼロベクトル $0$ によって加法群としている.
特に $R$ の掛け算が可換なら双加群.

$$\lambda \colon R \times V \to V$$
$$(x,v) \mapsto xv$$

ベクトル $v \in V$ を $x$ 倍する作用.

### 加群の準同型

環 $R$ に対する2つの $R$-加群 $M$ と $N$ があって,
この間の写像 $f \colon M \to N$ を考える.
これがやはりすべての構造を保つとき, 準同型であるという.

加法群 $(M,+,0)$ の群としての準同型はそのまま同じ.
これに加えて作用も保っていないといけない.
次が可換であればよい.

![](https://uc2b1a57de40887ee1e156b25409.previews.dropboxusercontent.com/p/thumb/ABVc2Hc0qbLn6PqzNDvBszztiA7RgECAy4831XcbFLC9f8vqk3Qf_7xohPffM1ijOigsmdpcMzchV3PIQ6ix-DVj0TodUamXb2IGM6rWYpBgFGb8oh0tHkJOdfRKBTnSnK_pVBmWbmlIQAaNM5zrs4MUSfaCzX4aU7Vp7v1_ECnzZw2noEBhUIZkd0i8mEEByGoHTNcxXYAtR4XbnPHyrtMoe5Am_8OHk_KEq7-Ckob6-UaaRKWjj6OY17g_VCdezlhjSWU7r4Hsa1sHxJsLQwDOTgHPzq8ABPhUwawu6x-IXIIbgp-U6f9unYpNJRrzlyJLPEH2WQRpZXMJRiZCTBN_wzBImGWyfGGMYzAMcpoROU9wcEqSJ9R8ppfEPBXrPJU/p.jpeg)

### 部分加群

$R$-加群 $M$ があって, これを単に加法群 $(M,+)$ と見たときのその部分群 $(N,+)$ があるとする.
元の作用が $N$ の中で閉じているとき, つまり

- $\forall a \in R ,~ \forall n \in N ,~ an \in N$

とあるとき, $N$ を部分加群という.

#### 部分加群の例

環 $R$ 自体がその掛け算を作用とみなすことで $R$-加群である.
作用が対称なので, 左加群としても右加群としても定めることが出来るが仮に左加群ということにする.
$$\lambda \colon R \times R \to R$$
$$(x,y) \mapsto x \times y$$

$R$ が左イデアル $I$ を持つとき, これが加群 $R$ の部分加群になる.
作用が閉じているということがイデアルの定義そのままになっている.
$$\forall x \in R ,~ \forall y \in I ,~ xy \in I$$

### 商加群

$R$-加群 $M$ とその部分加群 $N$ があるとする.
このときに商加群 $M/N$ を定義する.

まず加法群としての商群
$$M/N := \{ (m+N) \mid m \in M \}$$
を定める.
ここにスカラー倍作用を
$$\lambda(a, (m+N)) = a(m+N) = (am)+N$$
で与える.
こうするとこれは $R$-加群.

### 加群の核と像

$R$-加群 $M, N$ の間の準同型 $f \colon M \to N$ があるときに,

- $\ker f := \{ m \in M \mid f(m)=0 \}$
- $\im f := \{ f(m) \mid m =in M \}$

これらはそれぞれ, 加法群としての $M,N$ の部分群であることはすでに見た.
ここに元のスカラー倍作用を入れれば, 部分化群でもある.

- $\ker f \subset M$
    - $\forall a \in R ,~ \forall x \in \ker f ,~ ax \in \ker f$
- $\im f \subset N$
    - $\forall a \in R ,~ \forall f(m) \in \im f ,~ af(m) = f(am) \in \im f$

### 加群の準同型定理

$R$-加群の間の準同型 $f \colon M \to N$ があるとき,
$$\bar f \colon M / \ker f \to \im f$$
$$(m + \ker f) \mapsto f(m)$$
は準同型でかつ同型を与える.

加法群としての準同型, 同型であることは今まで見てきたとおり.
作用としての準同型も見ればよいが, これは次の通り.

- $a \bar{f}(m + \ker f) = a f(m) = f(am) = \bar f (am + \ker f)$
