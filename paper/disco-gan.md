%  Learning to Discover Cross-Domain Relations with Generative Adversarial Networks
% https://arxiv.org/abs/1703.05192
% 深層学習 GAN

## 論文概要

異なるドメインの間の対応関係を教師ナシで学習する.
などと言うと大袈裟だが、ドメイン A の画像からドメイン B らしき画像に GAN を用いて学習するというだけ.

論文の初めの例 (Figure 1) では、
鞄の画像を入力すると同じような色と材質で出来た靴の画像が出力され、
靴の画像を入力するとやはり同じような色と材質で出来た鞄の画像が出力される.

## 手法

ドメインA, B の間の変換を行う
$G_{AB}$
と
$G_{BA}$
とを NNs (CNN+DCNN) で構成する.

GAN としては $G_{AB}(x_A)$ と $x_B$ の区別をするものと
$G_{BA}(x_B)$ と $x_A$ との区別をするものの２つを学習させることで、
$G_{AB}$ はドメイン A の画像をドメイン B の画像らしく変換する.

以上.
