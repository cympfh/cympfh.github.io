% LIBLINEAR
% 機械学習

## 概要

libsvm の同じグループが制作した線形分類器.
SVM の線形カーネル版の他に線形回帰が含まれる.

データのフォーマットはlisvm のそれと全く同じなので、
使いまわすことができる.

libsvm を使わずにこちらを使う利点として、
線形カーネル用にチューニングが為されており、
計算空間量も時間もかなりの節約ができること.

実感として、素性が大きくなると、こちらの方が返って精度がよくなること.

詳細な原理、及びチュートリアルを含むドキュメントとして次がある.
原理を読み飛ばすにしても、細々としたテクニックが紹介されているので、
一度読んで見ることを薦める.

- [http://www.csie.ntu.edu.tw/~cjlin/papers/liblinear.pdf](http://www.csie.ntu.edu.tw/~cjlin/papers/liblinear.pdf)

## solver (`-s`)

libsvm と同様に `-s` で、どの最適化問題を解くかを (ソルバーを) 指定できる.
線形回帰を選ぶか、SVMを選ぶか、SVMにしても詳細にどのバージョンを用いるかをここで指定する.

とりあえず、SVMを用いてクラス分類するソルバーとして、次がある.

```
-s type : set type of solver (default 1) 
  1 -- L2-regularized L2-loss support vector classification (dual)
  2 -- L2-regularized L2-loss support vector classification (primal)                                         
  3 -- L2-regularized L1-loss support vector classification (dual)                                           
  4 -- support vector classification by Crammer and Singer                                                   
  5 -- L1-regularized L2-loss support vector classification  
```

線形SVMの主問題とは
$$\min \|w\| + C \cdot \sum_i \xi (w,x_i,y_i)$$
であった.
この主問題を直接解くのが (primal) で、
双対問題を直接解くのが (dual).

先ほどの [pdf](http://www.csie.ntu.edu.tw/~cjlin/papers/liblinear.pdf)
によると、

> `1. Try the default dual-based solver first.`  
> `2. If it is slow, check primal-based solvers.`

とある.

主問題第一項の $\|w\|$ が
$\sqrt{w^T w}$ なのが L1-regularized で、
$w^T w$ なのが L2-regularized.

第二項の $\xi$ は損失関数 (loss function) と呼ばれるものであるが、

L1-loss とは、
$$\xi(w, x_i, y_i) = \max(0, 1-y_i w^T x_i)$$
L2-loss とは、
$$\xi(w, x_i, y_i) = (\max(0, 1-y_i w^T x_i))^2$$
とあるものである.

以上で、
`-s 1 2 3 5` を説明したことになる.
`-s 4` の `Multi-class SVM by Crammer and Singer`
については、先pdfの
`Appendix E.`
に説明があるが、
よく読んでない.

