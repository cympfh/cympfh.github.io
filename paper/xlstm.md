% [2405.04517] xLSTM: Extended Long Short-Term Memory
% https://arxiv.org/abs/2405.04517
% 深層学習

## 概要

Long Short-Term Memory (LSTM) の拡張版 xLSTM を提案する.
ベンチマークで Transformer に肉薄する結果を出せた.

変更は3つ

1. 指数ゲーティング (exponential gating)
2. メモリ構造の変更
    - スカラーメモリの sLSTM
    - 行列メモリの mLSTM
3. 以上を残渣ブロックに統合した
    - これを xLSTM と呼ぶ

## LSTM

### ベース

LSTM の初期バージョンは 1991 年には提案されていた.
仔細を省いて概略を描くと,
入力列 $z_t$ を受け取って隠れ状態の列 $h_t$ を次のような漸化式で求める.
$$c_t = f_t c_{t-1} + i_t z_t$$
$$h_t = o_t c_t$$
ここで $f, i, o$ がゲートと呼称されるもので,
それぞれ forget, input, output を表現している.

多くの分野でLSTMは成功したが, 新たに出現した Transformer に比べるとさすがに弱い.

### sLSTM

２つ新しいポイントがあって,

- normalizer state の導入
- input gate 及び forget gate に exp を使う

入力列 $x_t$ について

- state
    - cell state
        - $c_t = f_t c_{t-1} + i_t z_t$
    - normalizer state
        - $n_t = f_t n_{t-1} + i_t$
    - hidden state
        - $h_t = o_t( c_t / n_t )$
- cell input
    - $z_t = \phi(\tilde{z_t})$
        - $\tilde{z_t} = w_z^\top x_t + r_z h_{t-1} + b_z$
- gates
    - input gate
        - $i_t = \exp(\tilde{i_t})$
            - $\tilde{i_t} = w_i^\top x_t + r_i h_{t-1} + b_i$
    - forget gate
        - $f_t = \exp(\tilde{f_t})$ または $f_t = \sigma(\tilde{f_t})$
            - $\tilde{f_t} = w_f^\top x_t + r_f h_{t-1} + b_f$
    - output gate
        - $o_t = \sigma(\tilde{o_t})$
            - $\tilde{o_t} = w_o^\top x_t + r_o h_{t-1} + b_o$

さらに Milakov & Gimelshein, 2018 で提案された stabilizer テクニックがある.
ただし exp にしてるのは本論文の新規性.

- stabilizer state
    - $m_t = \max(\log f_t + m_{t-1}, \log i_t)$
- stabilized input gate
    - $i'_t = \exp(\tilde{i_t} - m_t)$
- stabilized forget gate
    - $f'_t = \exp( \log f_t + m_{t-1} - m_t)$

これで出来た $i', f'$ で $i,f$ を置き換えるというもの.
exp すると値が大きくなりすぎて数値計算上オーバーフローしうるのでこれを使う.

### mLSTM

$\def\R{\mathbb{R}}$
LSTM のスカラーメモリを $c \in \R$ から行列 $C \in \R^{d \times d}$ に拡張する.
Transformer でいうところの key/value を使うため.

- state
    - cell state
        - $C_t = f_t C_{t-1} + i_t (v_t k_t^\top)$
    - normalizer state
        - $n_t = f_t n_{t-1} + i_t k_t$
    - hidden state
        - $h_t = o_t \odot \tilde{h_t}$
            - $\tilde{h_t} = C_t q_t / \max(1, n_t^\top q_t)$
- input
    - query input
        - $q_t = W_q x_t + b_q$
    - key input
        - $k_t = \frac{1}{\sqrt{d}} W_k x_t + b_k$
    - value input
        - $v_t = W_v x_t + b_v$
- gate
    - input gate
        - $i_t = \exp(\tilde{i_t})$
            - $\tilde{i_t} = w_i^\top x_t + b_i$
    - forget gate
        - $f_t = \exp(\tilde{f_t})$ または $\sigma(\tilde{f_t})$
            - $\tilde{f_t} = w_f^\top x_t + b_f$
    - output gate
        - $o_t = \sigma(\tilde{o_t})$
            - $\tilde{o_t} = W_o x_t + b_o$

### xLSTM

sLSTM または mLSTM を組み込んだブロックを残渣ブロックとして使う.

#### 実験

sLSTM ブロックを a 個, mLSTM を b 個使ったものを `xLSTM[a:b]` と記述する.

## 結果

LSTM を数十億のパラメータにスケールアップした結果 「Transformers や State Space Models と同程度に良い」といえる.
スケーリング法則によれば, より大きな xLSTM モデルは現在の Transformer ベースの言語モデルの本格的な競合となる可能性がある.
