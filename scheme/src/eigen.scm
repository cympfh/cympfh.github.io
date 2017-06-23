(load "./LU.scm")
(load "./solve-linear-equation.scm") ; solve

; 最大/最小の固有値、固有ベクトル
; および条件数

; gosh> (eigen-max '((1 1) (0 1)))
; (0.9999950243681571 0.0031545584364926077)
; 1.0031545427405713
; gosh> (eigen-min '((1 1) (0 1)))
; (1 0)
; 1
; gosh> (cond-num '((1 1) (0 1)))
; 1.0031545427405713

(define (mat*vec A x) ; [[N]] -> [N] -> [N]
    (map (lambda (ls) (apply + (map * ls x))) A))
(define (norm x) (sqrt (apply + (map (cut expt <> 2) x))))

(define (eigen A next)
    (define (near? x y) (< (norm (map - x y)) 1e-5))
    (define (inner* x y) (apply + (map * x y)))

    (define (correctly ls)
        (let1 av (/ (apply + (map car ls)) (length ls))
        (let loop ((ret (car ls))
                   (rest (cdr ls))
                   (dist (abs (- av (caar ls)))))
        (if (null? rest) ret
            (let1 dist~ (abs (- av (caar rest)))
            (if (> dist dist~)
                (loop (car rest) (cdr rest) dist~)
                (loop ret (cdr rest) dist)))))))

    (define (iter x)
        (let* ((y (next A x))
               (v (norm y))
               (z (map (cut / <> v) y)))
        (if (near? x z) z (iter z))))

    (let* ((eigen-vector
              (correctly (map iter
                (map (lambda (i)
                         (append (make-list i 0) (list 1)
                                 (make-list (- (length A) i 1) 0)))
                     (iota (length A))))))
           (eigen-value
              (/ (inner* eigen-vector (mat*vec A eigen-vector))
                 (inner* eigen-vector eigen-vector))))
    (values
        eigen-vector
        eigen-value)))

(define (eigen-max A) (eigen A mat*vec)) ; power algo is iter of mat*vec
(define (eigen-min A) (eigen A solve))   ; inverse iter is iter of solve

(define (cond-num A)
    (receive (_ l-min) (eigen-min A)
    (receive (_ l-max) (eigen-max A)
    (/ l-max l-min) )))
