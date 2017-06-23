% Co-training for Semi-supervised Sentiment Classification Based on Dual-view Bags-of-words Representation
% http://www.aclweb.org/anthology/P15-1102
% 自然言語処理 極性分析 半教師アリ学習 共訓練

- レビューテキストの極性判定. BOW. 線形回帰 (liblinear L2)
- 半教師アリにしたい
- <i>"we propose a dual-view co-training approach based on dual-view BOW representation for semi-supervised sentiment classification."</i>
    - 単にオリジナルのテキストの pos/neg を学習するのではなくて、そのちょうど反対 (neg/pos) がどんなであるかも学習する
        - posな文を学習するときに、一緒にnegも必ず学習する
    - 自動で対なる2レビューを人工的に生成する
        - negator (not) を取り除く
        - sentiment word は全部対義語で置き換える
            - あらかじめそのような辞書を持っておく
    - dual-view co-training
        - ラベル付き学習データ $L_o$ (original)
            - 2値分類器 $h_o (x \mapsto y \in \{0,1\})$
        - 対になるように作ったデータ $L_a$ (antonymous)
            - 2値分類器 $h_a (x \mapsto y \in \{0,1\})$ を作成
        - これらを合わせたような $h_d$ というものを作ることを考える
        - ラベルなし $x_o$ について対 $x_a$ を作成する
            - `assert` $h_o(x_o) \ne h_a(x_a)$ 一方が pos のとき neg であるべきである
            - それが満たされた場合だけ、それぞれを $L_o$, $L_a$ に追加
                - ある程度たまったら $h_o$, $h_a$ を更新する
        - 最終的な予測としては $h_o$ $h_a$ の両方を使いたい
            - 各分類器で確率を計算して足して2で割る
