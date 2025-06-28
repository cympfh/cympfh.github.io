% [1803.05449] SentEval: An Evaluation Toolkit for Universal Sentence Representations
% https://arxiv.org/abs/1803.05449
% 自然言語処理 文分散表現

## 概要

汎用な文の分散表現 (universal sentence representation) の評価ツールキット SentEval を提供する.

## Intro

単語の分散表現については成功しつつある.
次は転移学習も容易なドメインに特化しない汎用の universal sentence representation が求められている.
それに備えて使いやすい評価ツールを整備しておく必要がある.

## Aims

SentEval は公平に評価するためのものであるので次を目指す.

1. 一つの評価セットを用いる
1. 評価の中では固定したハイパーパラメータで行い, 異なる結果が報告されることのないようにする
1. 誰でも使えること
    - Python で書かれたストレードフォワードのインターフェース
    - 必要ならばデータのダウンロードや前処理を行うスクリプト

## Evaluations

大きく5種類のタスクで転移学習して評価する.

1. Binary and multi-class classification
2. Entailment and semantic relatedness
3. Semantic Textual Similarity
4. Paraphrase detection
5. Caption-Image retrieval

### 1. Binary and multi-class classification

テキスト分類をさせる.
これには次の7種類を行う.

![](https://i.imgur.com/KTOgnso.png)

文ベクトルからロジスティック回帰か MLP で予測させる.
MR,CR,SUBJ,MPQAについては 10-fold の [nested 交差検証](https://blog.amedama.jp/entry/2018/07/23/084500) で評価する.
TREC はただの交差検証で, SST は標準の検証 (そういうのがある?).

### 2. Entailment and semantic relatedness

意味含意 (entailment) には SNLI, SICK-E データセット,
Relatedness には SICK-R データセットと STB ベンチマークを用いる.
Relatedness は二文の意味的関連を [0,5] のスコアで予測させる.

### 3. Semantic Textual Similarity

STSタスクを用いる.
英文同士に人手で関連性を [0,5] のスコアでついており,
文ベクトルどうしの cosine 類似度とそのスコアの Peason and Spearman 相関係数を SentEval は報告する.

STS は 2012 から 2016 までのバージョンがあるので, SentEval はそれらの結果の平均を取る.

### 4. Paraphrase detection

Microsoft Research Paraphrase Corpus (MRPC) を用いる.
これは web のニュース記事から人手で集めてきた, 言い換え表現の文のペアが収録されている.
SentEval はこれについて二値分類 (paraphrase/not) を予測させる.

### 5. Caption-Image retrieval

COCO を用いる.
これは 113k の画像とそれぞれに 5 つのキャプションテキストが収録されている.
行うタスクはクエリとなるキャプションから適切な画像をランク付けする Image Retrieval と,
逆に, クエリとなる画像から適切なキャプションをランク付けする Caption Retrieval.

画像からベクトルには事前学習済みの ResNet-101 を用いて 2048 次元ベクトルを用いる.
