% One pixel attack for fooling deep neural networks
% https://arxiv.org/abs/1710.08864
% 深層学習 画像認識

## 概要

DNNによる多クラス分類としての物体認識.
70.97% の画像は、入力画像の 1 pixel を変更するだけで、恣意的に選んだ別なクラスに 97.47% の確信度で以って惑わすことが可能であることを示した.

![](https://i.imgur.com/wIrXVmx.png)

1 pixel の変更で全く別物に予測させられる.

## Github

[Hyperparticle/one-pixel-attack-keras](https://github.com/Hyperparticle/one-pixel-attack-keras)

## 手法

使ってる画像は CIFAR-10.
画像サイズは 28x28 で各ピクセルは 0以上255以下の整数の三組 (RGB).
1 pixel の修正は
$X \times Y \times R \times G \times B$
で表される.
これは離散空間で、濃度は
$32\times32\times256\times256\times256 = 17,179,869,184 = 1e10$.
全通り試すのはちょっと無理で、この空間の上の最適化問題と見做して解いている.

Differential Evolution (DE) という最適化手法があって、彼らはそれを用いている
(`from scipy.optimize import differential_evolution`).

元の正しいラベルへの確信度を下げる方のアタック (Non-targeted) と、選んだ偽のラベルへの確信度を上げる方のアタック (Targeted) を試してる.

## 結果

1 pixel だけでも全体の7割程度はラベルをtargetedに変えることが出来てる.
ただし、変えることの出来るターゲットラベルには大きく偏りがある (ある一つのラベルには変えやすい).
3 pixel も変えれば、どのラベルにも変更可能である.
