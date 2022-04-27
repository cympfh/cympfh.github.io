% [2111.01007] Projected GANs Converge Faster
% https://arxiv.org/abs/2111.01007
% GAN

## 概要

GAN を上手く訓練するテクニック.
みんな Discriminator さえうまく訓練できれば Generator は勝手に強くなってくれると言ってる.

## 参考

https://qiita.com/T-STAR/items/faefb9a25e9bcec99176

## Multi-Scale Disciminators + Random Projections

生成した画像を次のような機構で射影して,
これに関する判別器を育てる.

- 生成/真の画像 $x$
    - Pretrained Features
        - $z_1 = L_1(x)$
        - $z_2 = L_2(z_1)$
        - $z_3 = L_3(z_2)$
        - $z_4 = L_4(z_3)$
    - Projection
        - $d_1 = \pi_1(z_1)$
        - $d_2 = \pi_2(z_2)$
        - $d_3 = \pi_3(z_3)$
        - $d_4 = \pi_4(z_4)$
    - Disciminators
        - $D_1(d_1) \in [0,1]$
        - $D_2(d_2) \in [0,1]$
        - $D_3(d_3) \in [0,1]$
        - $D_4(d_4) \in [0,1]$

$L_i$ はすべて CNN 層.
したがって, $x$ から $z_4$ を作る操作は普通の四層の CNN.
そしてこれにはすでに分類タスクなどで学習済みの CNN を固定して使う.

$\pi_i$ はランダムに射影する操作を表すが実装上は重みをランダムに初期化した 1x1 の CNN でこれもやはり固定して使う.

$D_i$ は独立の判別器で自由に作る.
上記では4つの入力に対して4つの判別器が独立にある.
ロスはいつものやつを4つに関して合計して使う.

## "Floating Heads"

Feature を取り出す層として, 分類器として訓練したものを使うと,
"確かに正しく猫として分類される"
ような画像が生成されるようになる.
その結果として, 猫の生首だけが宙に浮いた画像なんかが生成される.
これを Floating Heads という問題点として挙げている.
