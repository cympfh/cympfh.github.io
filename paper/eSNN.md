% Learning Similarity Measures from Data (extended Siamese Neural Network; eSNN)
% https://link.springer.com/content/pdf/10.1007%2Fs13748-019-00201-2.pdf
% 類似度学習

$$\def\X{\mathcal X}\def\E{\mathcal E}\def\R{\mathbb R}$$

## 概要

距離学習に分類タスクを足した

## 手法

### 枠組み

データの空間を $\X$, 埋め込み空間を $\E$, 実数全体を $\R$ とする.
ただし $\X, \E$ は暗にユークリッド空間の部分空間としている.

よくある形式は
$$S \colon \X \times \X \to \R$$
$$S(x, y) = C(G(x), G(y))$$
というように $G \colon \X \to \E$ と $C \colon \E \times \E \to \R$ に分けるもの.
そしてそれぞれを学習可能なモデルにするか, あるいは手で設計してしまうかでバリエーションがある.
特に $G(x)=I(x)=x$ としてしまうようなものもある.

### $G$: 補助タスク

$G$ 自体はそれぞれの良い特徴を得る必要がある.
データにラベルがあったとして $G(x)$ から分類できるようにする.

### $C$: 拡張

拡張なのかわからないけど
$C \colon \E \times \E \to \R$
を
$C \colon \E \to \R$
にして
$S(x, y) = C(|G(x) - G(y)|)$
とする.
ここで $| \cdot - \cdot |$ は要素ごとの差の絶対値を取る操作.
$C$ は NN なんかで設計する.

### まとめ

まとめると次の損失関数になる:

$$\mathcal L = \alpha \left( \mathcal L_c (G(x), t_x) + \mathcal L_c(G(y), t_y) \right) + \mathcal L_s(S(x, y), s)$$

$t_x, t_y$ はそれぞれのラベルで,
$\mathcal L_c$ はラベル分類としての損失関数.
$\mathcal L_s$ は類似度（実数） $s$ との回帰損失.
分類では $G$ だけを, 回帰では $G$ と $C$ とをセットで更新されることになる.

## 感想

新規性全然無い。補助タスクに分類を足すなんて１万回聞いたことがある。
けど、$C$ を $\E \times \E \to \R$ じゃなくて $\E \to \R$ にしちゃうのは初めて見た。
こっちのほうがいいのか？

