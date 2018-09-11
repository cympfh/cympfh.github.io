% amb オペレータ
% 2017-02-18 (Sat.)
% 計算機言語 プログラミング
% LISP の amb オペレータの Scheme による実装

## 概要
Scheme にある現在継続 (current continuous) は、
深さ優先探索を計算グラフ上の探索と書き換えることが可能.
つまり、陽に、探索木の分岐やバックトラックを書くことをマクロで隠すことが出来る.

次に示す実装では `(fail)` という手続きをスタックとして使っている.
これを呼び出すことでスタックからポップを行うが、これが探索木のバックトラックに相当する.
分岐を行う場合は、その時点の継続 `cc` を取り出し、`(fail)` に `cc` とセットで分岐先をプッシュしていく.

## 実装

```scheme
(define (fail) 'fail)

(define-syntax amb
  (syntax-rules ()
                ((_) (fail))
                ((_ x) x)
                ((_ x y ...)
                 (let ((prev fail))
                   (let/cc cc
                           (set! fail (lambda () (set! fail prev) (cc (amb y ...))))
                           (cc x))))))
```

### 使い方

```scheme
; 補助関数
; 例えば (amb-iota 10 2) は (amb-iota 2 3 4 .. 11)
(define (amb-iota n :optional (b 0) (s 1))
  (if (zero? n) (amb)
    (amb b (amb-iota (- n 1) (+ b s) s))))

; ピタゴラス数の探索
(let ((a (amb-iota 100 100))
      (b (amb-iota 100 100))
      (c (amb-iota 100 100)))
  (if (and
        (= (+ (expt a 2) (expt b 2)) (expt c 2))
        (= 1 (gcd a b))
        (= 1 (gcd a c))
        (= 1 (gcd b c)))
    (print (list a b c))
    (fail)))
```
