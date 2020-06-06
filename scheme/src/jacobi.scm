; 連立方程式のヤコビ法．
; http://en.wikipedia.org/wiki/Jacobi_method

; サンプルの入力
; 3
; 10 1 1
; 0 10 1
; 2 1 10
; 1 2 1
; 
; 一行目は次元 n
; 続くn行に、各行nコずつ書いてn*nの行列Aを表す．
; 最後の行は n次元ベクトルbを横に寝かせたもの．

; Ax = b をxについて、解く．
; Jacobi method において、Aは対角成分がある程度大きいこと、
; という前提がある．詳しくは最初に掲げたWikipediaなど．

(define n (read))

; matrix of n*n
(define a
    (let loop ((ac '()) (acl '()) (x 0) (y 0))
        (cond ((>= x n) ac)
              ((>= y n) (loop (append ac (list acl)) '() (+ x 1) 0))
              (else (loop ac (append acl (list (read))) x (+ y 1))) )))

;inv of diagonal of a
(define d-inv
    (let loop ((ac '()) (acl '()) (x 0) (y 0))
        (cond ((>= x n) ac)
              ((>= y n) (loop (append ac (list acl)) '() (+ x 1) 0))
              (else (loop ac (append acl (list
                (if (= x y) (exact->inexact (/ 1 (ref (ref a x) y))) 0)
                )) x (+ y 1))) )))

;vector of n
(define b
    (let loop ((ac '()) (x 0))
        (if (>= x n) ac (loop (append ac (list (read))) (+ x 1))) ))

;vector zero of n
(define x
    (let loop ((ac '()) (i 0))
        (if (>= i n) ac (loop (cons 0 ac) (+ i 1))) ))

; mainly used by (next)
(define (inprod u v)
    (let loop ((u u) (v v) (ac 0))
        (if (or (null? u)(null? v)) ac
            (loop (cdr u) (cdr v) (+ ac (* (car u)(car v)))))))
(define (mat-mul a x) ; mul of mat * vec
    (let loop ((a a) (ac '()))
        (if (null? a) ac
            (loop (cdr a) (append ac (list (inprod (car a) x)))))))
(define (vec-add u v)
    (let loop ((u u) (v v) (ac '()))
        (if (or (null? u)(null? v)) ac
            (loop (cdr u)(cdr v)
                  (append ac (list (+ (car u)(car v)))) ))))
(define (vec-neg u)
    (let loop ((u u) (ac '()))
        (if (null? u) ac
            (loop (cdr u) (append ac (list (- (car u))))))))

;Jacobi method
(define (next)
    (vec-add x
        (mat-mul d-inv
            (vec-add b (vec-neg (mat-mul a x))))) )

(define (norm u)
    (let loop ((u u) (ac 0))
        (if (null? u) (sqrt ac) (loop (cdr u) (+ ac (expt (car u) 2))))))

;main
(let iter ((i 0))
    (if (> i 28) (newline)
        (begin
            (display i) (display " ")
            ;(display x) (display " -> ")
            (display (norm (vec-add b (vec-neg (mat-mul a x)))))
            (newline)
            (set! x (next))
            (iter (+ i 1)) )))
