% Deep Autoencoder Topic Model for Short Texts
% https://www.prhlt.upv.es/workshops/iwes15/pdf/iwes15-kumar-d'haro.pdf
% 自然言語処理 深層学習 トピックモデル

BoW からディープにトピックモデルをする話

- LDA よりも Deep な Autoencoder のが Average Topic Coherence で良かったという主張
    - 入力は BOW
        - 1文あたり20words程度
    - Deep Autoencoder
        - RBM で pretraining
        - 入力 (BOW) が疎なのでRBMにおける隠れ層は疎でなくなるようにロスを加える
              - 単に隠れでの値の和が大きくなるように調整してる

## 疑問

Deep Autoencoder と似てるものに Stacked Denoising Autoencoder (SdA) がある.
何が違うんだろう?
Deep Autoencoder は RBM っていうのであんまり逆伝播っぽくない.
とりあえず SdA は RBM ではなさそう.
SdA はノイズを想定していて、ノイズには dropout を使いそう.
