% [2310.11453] BitNet: Scaling 1-bit Transformers for Large Language Models
% https://arxiv.org/abs/2310.11453
% 深層学習

## 概要

計算効率化の為に精度を落とす.
この論文では BitNet というアーキテクチャを提案する.
BitNet は Transformer の中の `nn.Linear` 部分を `BitLinear` に全て置き換える.
この中では重みを全て 1bit にする.

精度と効率のトレードオフになってる.

## BitLinear

- 重み $W$ を量子化する
    - $W \in \mathbb{R}^{n \times m}$
    - $\tilde{W} = \mathrm{sign}(W - \beta)$
        - sign は正なら $+1$, 0 以下なら $-1$ に写す関数
        - $\beta$ は $W$ の成分の平均
- 入力 $x$ を absmax 量子化する
    - $b$ bit 精度に落とす
    - $Q_b = 2^b - 1$ として $x$ を区間 $[-Q_b, Q_b]$ に収める
    - $\tilde{x} = x \times Q_b / \gamma$
        - $\gamma$ は $x$ の成分の max
- ReLU 活性化するなら次の通り
    - $\tilde{x} = (x - \eta) \times Q_b / \gamma$
        - $\eta$ は $x$ の成分の min
- dequantize する
    - 元の精度で値を持ち直す
