% Learning Relational Patterns (ALT 2011)
% http://www2.cs.uregina.ca/~zilles/geilkeZ11.pdf
% ALT パターン 形式言語

- パターンは実際の適用のためには、表現力が十分ではない (どっちの意味だろう)
- 1つパターン中の変数同士の関係を定める
    - Relational Pattern (RP)
    - RP Languages (RPLs)
- RPLs は正提示から学習可能
- それとは別に新しい学習モデルを提案する

## Introduction

- Angluin のパターン
- 正提示からの学習
    - 正データのストリーム: 逐次的に推測
- 言語の表現力と学習可能性はトレードオフ
    - 言語が複雑になると厳密に学習するアルゴリズムが存在しない (正規言語; 文脈自由文法)
    - しばしばそれは、membership 判定の計算複雑性に起因する
        - 例えばある文字列 $s$ があるパターン言語 $L(p)$ に属するかの判定は NP-hard

## Relational Patterns

- $n$ 個の変数 $y_1..y_n$ に関する $n$項関係 $R_{y_1..y_n}$
    - 沢山予め定めておく
- 変数を $n$ 個 ($y_1..y_n$) 含むパターン $p$ について
    - $y_i \mapsto s_i$ とする代入は
    - $R_{y_1..y_n}(s_1,..,s_n)$ を満たさなければならない

### 例

- $R_{x_1} = \{ a^i : i \geq 1 \}$
- $R_{x_2} = \{ b^i : i \geq 1 \}$
- $R_{x_1, x_2} = \{ (w_1, w_2) : |w_1| = |w_2| \}$

$$L(x_1 x_2) = \{ a^i b^i : i \geq 1 \}$$
