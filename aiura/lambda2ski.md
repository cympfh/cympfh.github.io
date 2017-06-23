% ラムダ式からSKI式への変換
% 2017-02-15 (Wed.)
% 計算機言語
% ラムダ式からSKI式への変換の実装を示す

## 概要

ラムダ計算とSKI計算は等価であるから、任意のラムダ式と等しいSKI式を一つ示すことが出来る.
ラムダ式はここでは Scheme の文法のサブセットを取る.
サブセットと言っても body 部分に項を一つしか置けないようにするだけ.

例えば $\lambda x. \lambda y. Mxy$ は

```scheme
(lambda (x y) (M x y))
```

ラムダ式が与えられた時に、これを `S` `K` `I` という3つの関数を組み込んだラムダ式だと見直し、
そこからラムダ式な要素を再帰的に削除していく.

## 変形ルール

`S` `K` `I` からラムダ式に行くのは自明.
それらの逆を考えると

- `(lambda (x) x)`
    - $\Rightarrow$ `I`
- `(lambda (x) M)`
    - $\Rightarrow$ `(K M)`
    - ただしこれは `x` は `M` に自由変数として出現しない場合に限る
- `(lambda (x) (M N))`
    - $\Rightarrow$ `(S (lambda (x) M) (lambda (x) N))`

実はこれらのルールだけでラムダ式から `lambda` の文字は消えて、SKI式が出来上がる.
この証明は知らないけど大変そうだった.

## 実装

自由変数であるかどうかの判定が必要そう.
ラムダ式を受け取って自由変数のリストを返す手続き `FV` を与える.

あと、やっぱりなんだかんだラムダ式は 1 引数に限った形のが扱いやすいので、
その様に変形する手続き `curry` を与える.

あとは上の変形ルールを素直に実装すると出来上がり.

```scheme
(use srfi-1)
(define (FV M)
  (cond ((symbol? M) (list M))
        ((equal? (car M) 'lambda)
         (lset-difference eq? (FV (third M)) (second M)))
        (else (apply lset-union eq? (map FV M))) ))

; (print (FV '(lambda (x y z) (x z (y z))))) ; => ()
; (print (FV '(M (lambda (x y z) (x z (y z)))))) ; => (M)
; (print (FV '((lambda(x) y) (lambda (x y) (x z (y z)))))) ; => (z y)

(define (curry M)
  (cond ((symbol? M) M)
        ((eq? (car M) 'lambda)
         (let ((args (second M))
               (body (curry (third M))))
           (fold-right (lambda (arg N) `(lambda (,arg) ,N)) body args)))
        (map curry M)))

; (print (curry '(lambda (x y) (lambda (a b c) M))))
; => (lambda (x) (lambda (y) (lambda (a) (lambda (b) (lambda (c) M)))))

(define (lambda->SKI M)
    (define (lambda? M) (eq? (car M) 'lambda))
    (cond ((symbol? M) M)
          ((null? M) '())
          ((and (pair? M) (null? (cdr M))) (lambda->SKI (car M)))
          ((lambda? M)
            (let ((arg  (car (second M)))
                  (body (third M)) )
            (cond ((eq? arg body) 'I)
                  ((memv arg (FV body))
                    (if (lambda? body)
                        (lambda->SKI `(lambda (,arg) ,(lambda->SKI body)))
                        (lambda->SKI
                            `(S (lambda (,arg) ,(lambda->SKI (drop-right body 1)))
                                (lambda (,arg) ,(lambda->SKI (last body)))) )))
                  (else `(K ,(lambda->SKI body))) )))
          (else (map lambda->SKI M)) ))


(print (lambda->SKI '(lambda (x) x))) ; => I
(print (lambda->SKI '(lambda (x) M))) ; => (K M)
(print (lambda->SKI '(lambda (x) ((M x) (N x))))) ; => (S (S (K M) I) (S (K N) I))
(print (lambda->SKI '((lambda (x) (x x)) (lambda (x) (x x))))) ; => ((S I I) (S I I))
```
