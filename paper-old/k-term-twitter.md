% Twitter-scale New Event Detection via K-term Hashing
% https://aclweb.org/anthology/D/D15/D15-1310.pdf
% 自然言語処理 twitter イベント検知 ハッシュ

## FSD

First Story Detection, New Event Detection

ツイートの無限列が流れてきて:
$$d_1,d_2,..,d_{n-1},d_n,..$$
$d_n$ と同じイベント (話題) について言及してるツイートがそれ以前にあったかどうかを判定したい

そのようなツイートが無いなら、$d_n$ は新しいイベントの話をしていることになる

## Introduction

2つのツイートが同じイベントについて話してるかどうかは適当な閾値を以って $O(1)$ で出来るとする.

FSDの素朴な方法:

- ツイート $d_n$ が来る度に $d_1,..,d_{n-1}$ と比較すればよい
- $n$個までのツイートを処理するのに $O(n^2)$ 回の比較を行う

本論文で提案するのは、1つのツイートの処理が定数時間で済むもの

## 既存研究

- LSH-FSD (Petrovic+,2010)
    - Locality Sensitive Hash (LSH) を用いて探索空間を減らす
- KL-FSD (Allan+,2003)
    - 言語モデルのKLダイバージェンスで、新しく来たツイートの新規性を測る

## アプローチ

ツイートを、bag-of-words と大体同様のもので管理する.

### k-term

高々 $k$ 個の語の集合を k-term と呼ぶ.
以下 $k=3$ とする (一般に自然数).

### content

文章をbag-of-words $d$ とする.
$d$ の content とは、
$$\{ t : t \subseteq d, |t| \leq k \}.$$
$d$ の部分としての k-term 全体からなる集合のこと.

$d$ のハッシュとして content を用いる.

## 新規性

$d_1,..,d_{n-1}$ までcontent 全体を履歴 $H$ として持っておく.

ツイート $d_n$ について、
content を $c_n$ とするとき:

$$N(d_n) = \sum_{t \in c_n} \alpha_{|t|} \binom{|d_n|}{|t|}^{-1} \chi(t, H)$$
where $\chi(t,H) = 1$ if $t \not\in H$ else $0$

本質は $\chi$ の和であるところで、その前の部分は適当な重み.

$N(d_n)$ が閾値を超えたら、$d_n$ を新しいイベントについて言及したツイートとして報告する.

### 履歴の更新

新規性の計算の後、
$$H \leftarrow H \cup c_n$$

### 計算量

$|c_n|$ は $O(|d_n|^k)$.
Twitterの条件と$k$が定数であることから、これは定数.

$H$ のmembership の判定、更新はツイート数が増えるにつれて遅くなるはず.

- k-term $t$ をハッシュ関数 ([MurmurHash](https://en.wikipedia.org/wiki/MurmurHash)) で `i32` に変換
- $H$ を長さ $2^{32}$ の配列にする (500MB程度)
- 更新も定数時間

## Experiments

### 比較
1. UMass: state-of-the-art FSD system
1. LSH-FSD
1. KL-FSD

### Dataset
アノテートされた116,000のツイートを用いて実験

TDT と呼ばれる定番の指標を用いる

1. False Alarms: false positive
    - False Alarms probability: 精度の負
1. Miss: true negative
    - Miss probability: 再現度の負
1. $C_{min}$: 2つのprobability の線型結合 (和?)

[Figure 1]

- 数値は共に小さいほうが良い.
- 曲線上の $C_{min}$ の最小値を比較するのが [Table 1].

[Table 1]

- `tweets/sec` は処理速度
- UMass がそれまでは最良とされていたが、大変遅い
- k-term が最良だし、とても速い
