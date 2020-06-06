(define (f x) (exact->inexact (/ 1 (+ 1 (expt x 2)))))
(define a -1)
(define b 1)


; int [-1, 1] 1 / (1+x**2) dx
; 
; report.scm の (solve1 N) (solve2 N) (solve3 k j) が、それぞれ、
; N点複合台数則、N点Gauss則、Romberg積分をするもの．
; 
; 例えば
; (display (solve1 40))(newline)
; (display (solve2 6))(newline)
; (display (solve3 4 3))(newline)
; とすると
; 1.5705879934770641
; 1.570731707317072
; 1.5707928918809373
; と出力された．
; 
; 真値は
; (* 2 (atan 1)))
; によって
; 1.5707963267948966
; と計算される．

; 手で計算したところ、真の値は pi/2 であった
(define truth
    (* 2 (atan 1)))

; Trapezoidal rule
(define (solve1 N) ; integral from a to b by N splits
    (let ((h (/ (- b a) N)))
        (define (solve1-sub i ac)
            (let ((x (+ a (* i h))))
                (cond ((= i 0) (solve1-sub (+ i 1) (+ ac (/ (f x) 2))))
                      ((= i N) (* h (+ ac (/ (f x) 2))))
                      (else (solve1-sub (+ i 1) (+ ac (f x)))))))
        (solve1-sub 0 0)))

; Gauss-Legendre
(define (solve2 N)
    (define pi 3.14159265358979323846264338)
    (define (P n x)
        (cond ((= n 0) 1)
              ((= n 1) x)
              (else (/ (- (* (- (* 2 n) 1) x (P (- n 1) x)) (* (- n 1) (P (- n 2) x))) n)) ))
    (define (newton x c)
        (if (<= c 0) x
            (newton
                (- x [/ (- 1 (* x x)) N (- (/ (P (- N 1) x) (P N x)) x)])
                (- c 1))))
    (define (x i)
        (newton
            (cos (* (+ i 0.75) pi (/ 1 (+ N 0.5))))
            10))
    (define (w i)
        (let ((x_i (x i)))
            (* 2 [- 1 (* x_i x_i)] [/ 1 (expt (* N (P (- N 1) x_i)) 2)])))
    (define (solve2-sub i ac)
        (if (= i N) ac
                (solve2-sub (+ i 1) (+ ac (* (f (x i)) (w i))))))
    (solve2-sub 0 0))

; Romberg
(define (solve3 k j)
    (if (= j 0) (solve1 (expt 2 k))
            (let ((r (expt 4 j)))
                (/ (- (* r (solve3 k (- j 1))) (solve3 (- k 1) (- j 1)))
                   (- r 1)) )))

(define (err x) (abs (/ (- x truth) truth )))
(define (plot n)
    (if (< n 11)
        (begin
            (display n)(display " ")
            (display (err (solve3 n 2)))(newline)
            (plot (+ n 1)))
        (newline)))
(plot 2)
