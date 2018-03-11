% One Big Net For Everything: ONE
% https://arxiv.org/abs/1802.08864
% 深層学習 強化学習 読みかけ

## 概要

2018.02 時点のテクニカルレポート.

- "learning to think" (2015, 彼ら) に "PowerPlay" (2011) を加えることで発展させたい
- 任意のタスクを学習可能なネットワークを構築したい (ONE)
    - 現状ある中で有力なのはRNNだろう
        - 現実的には、RNNとはLSTMのことを指す
        - CNNとLSTMの組み合わせ等も含む
            - 十分大きなLSTMによって表現可能である
- タスクの形には大きく、教師あり学習と強化学習とがある
    - 前者については勾配法によって比較的易しく学習書き出る
    - 後者は比較的難しい
        - 十分小さなLSTMでないと学習してくれない
- 真のAIを目指している
    - 真のAIは絶えず学習を行うものである
    - 経験の中で学習をしてほしい
        - もちろん教師などなしに
        - 従って教師あり学習を解くことは避けられない
    - "絶えず新しいタスクを学習し、かつ、前に学習したことは忘れない"
        - ただし、自身の複製 (copy of ONE) という操作を許す?

## Basic Ideas

### 1. goal input vectors

### 2. Incremental black box optimization

既にいくつかのタスクを獲得した時点で新しいタスクを学習する時、以前の状態のONEを複製して、
そこから学習を始めることで高速にタスクの獲得が完了する.
自動的な転移学習 (algorithmic transfer learning) である.

### 3. CM system

"learning to think" を読め

読みます。

