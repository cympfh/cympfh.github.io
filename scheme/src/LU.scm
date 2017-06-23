#! /usr/local/bin/gosh

;; 枢軸選択(完全行交換)をするLU分解
; LU手続きは行列(list of list of number) を受け取ると、
; LとUと行についての交換を返す．

; gosh> (Hilbert 6)
; ((1 1/2 1/3 1/4 1/5 1/6) (1/2 1/3 1/4 1/5 1/6 1/7) (1/3 1/4 1/5 1/6 1/7 1/8) (1/4 1/5 1/6 1/7 1/8 1/9) (1/5 1/6 1/7 1/8 1/9 1/10) (1/6 1/7 1/8 1/9 1/10 1/11))

; gosh> (LU (Hilbert 6))
; ((1 0 0 0 0 0) (1/2 1 0 0 0 0) (1/6 5/7 1 0 0 0) (1/3 1 14/25 1 0 0) (1/4 9/10 21/25 6/7 1 0) (1/5 4/5 24/25 3/7 8/9 1))
; ((1 1/2 1/3 1/4 1/5 1/6) (0 1/12 1/12 3/40 1/15 5/84) (0 0 5/504 1/63 2/105 100/4851) (0 0 0 -1/1800 -1/875 -1/616) (0 0 0 0 -1/49000 -1/19404) (0 0 0 0 0 -1/1746360))
; (0 1 3 4 5 2)

; 連立一次方程式を解くのに使います．
; 同ディレクトリ内の solve-linear-equation.scm を参照するとよいです．

(use srfi-1)

(define (Hilbert n)
    (map (lambda (s) (map (cut / <>) (iota n s))) (iota n 1)))

(define (transpose a) ; [[N]] -> [[N]]
    (map (lambda (i) (map (cut ref <> i) a))
         (iota (length (ref a 0))) ))

(define (mat* a b) ; [[N]] -> [[N]] -> [[N]]
    (map (lambda (xs) (map (lambda (ys)
        (apply + (map * xs ys))) (transpose b))) a))

(define (perm ord ls)
    (map (lambda (i) (ref ls (list-index (pa$ = i) ord)))
         (iota (length ls))))

(define (LU a) ; LU is inductively along `decompose`
    (define (decompose a)
        (values
            (caar a)
            (cdar a)
            (cdar (transpose a))
            (map cdr (cdr a))))
    (define (compose a11 a12 a21 a22)
        (cons (cons a11 a12) (map cons a21 a22)))

    (define (swap n m a)
        (map (lambda (i) (cond
                ((= i n) (ref a m))
                ((= i m) (ref a n))
                (else (ref a i)))) (iota (length a))))
    (define (select a)
        (let* ((row (car (transpose a)))
               (idx (cdar
                (sort (map cons row (iota (length row)))
                      (lambda (a b) (> (abs (car a)) (abs (car b))))))))
        (values (swap 0 idx a) idx)))

    (define (row*col a b) ; [N] -> [N] -> [[N]]
        (map (lambda (x) (map (pa$ * x) b)) a))
    (define (mat-diff a b)
        (map (cut map - <> <>) a b))

    (if (= (length a) 1)
        (values '((1)) a '(0))
        (receive (a~ i) (select a)
            (receive (a11 a12 a21 a22) (decompose a~)
                (let ((l11 1)
                      (l12 (make-list (length a12) 0))
                      (l21 (map (cut / <> a11) a21))
                      (u11 a11)
                      (u12 a12)
                      (u21 (make-list (length a21) 0)))
                (receive (l22 u22 ord)
                         (LU (mat-diff a22 (row*col l21 u12)))
                    (values
                        (compose l11 l12 (perm ord l21) l22)
                        (compose u11 u12 u21 u22)
                        (swap 0 i (cons 0 (map (pa$ + 1) ord))))))))))
