# 最適化 - 乱択 3-SAT

## 参考文献

- [[https://www.hyuki.com/girl/random]]
- [[https://tech.preferred.jp/ja/blog/schoening-3sat/]]

## 実装

アルゴリズムは数学ガールでも紹介されている Schoening の乱択アルゴリズム.

- 以下を `max_tries` 回繰り返す
    - 変数に対してランダムに真偽値を割り当てる
    - 以下を `max_flips` 回繰り返す
        - 現在の割当で充足しているか判定する
            - 充足していれば終了
        - 充足していなければ，充足していない節をランダムに一つ選ぶ
        - その節に含まれる変数のうちランダムに一つ選び，その変数の真偽値を反転させる

`max_tries`, `max_flips` は変数の個数 $N$ に対して $3N$ としてある.

@[rust](./procon-rs/src/opt/three_sat.rs)
