% [1906.00446] Generating Diverse High-Fidelity Images with VQ-VAE-2
% https://arxiv.org/abs/1906.00446
% 深層学習 オートエンコーダ 生成モデル VAE

## 概要

[VQ-VAE](VQ-VAE.html) の version 2.

VQ-VAE を大きなサイズの画像にも適用できるようになった.

## 方法

まず VQ-VAE の学習は 2 stages に分けられる.
オートエンコーダーの学習と, 潜在空間の事前分布の学習.

### stage-1: VQ-VAE training

エンコーダをさらに2つに分けて, 階層的エンコードを行う.
ここでは $E_1, E_2$ とする.

- $e_1 = Q(E_1(x))$
- $e_2 = Q(E_2(x, e_1))$
- $\tilde{x} = D(e_1, e_2)$

これで VQ-VAE と同じように $L(x, \tilde{x})$ を考えて学習する.

### stage-2: Piror training

潜在空間に関する事前分布を学習する.

- 訓練セット
    - $T_1 = \{ Q(E_1(x)) \mid x \in X \}$ ($X$ は元の学習セット)
    - $T_2 = \{ Q(E_2(x, Q(E_1(x)))) \mid x \in X \}$
- 分布
    - $p_1 = \mathrm{TrainPixelCNN}(T_1)$
    - $p_2 = \mathrm{TrainConditionalPixelCNN}(T_2, T_1)$
- サンプリング
    - $e_1 \sim p_1$
    - $e_2 \sim p_2(e_1)$
    - $x = D(e_1, e_2)$

よくわからん
