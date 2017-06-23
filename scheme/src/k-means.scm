(use srfi-1 :only (iota fold))
(use srfi-27 :only (random-integer))

;; k-means
; N points on R^s into K clasters

(define s 2)
(define N 30)
(define K 4)

; input data
(define xs
    (map (lambda (i) (map (^_ (random-integer 20)) (iota s)))
         (iota N)))

(define mus
    (map (lambda (i) (map (^_ (random-integer 20)) (iota s)))
         (iota K)))

(define rs ()); map :: N -> K

(define (update-rs)
    (define (dist a b)
        (sqrt (apply + (map (^x (* x x)) (map - a b)))))
    (set! rs
    (map
        (lambda (x)
            (cdr
              (fold
                  (lambda (di1 di2)
                    (if (< (car di1) (car di2)) di1 di2))
                 '(10000 . -1)
                  (map cons
                       (map (lambda (mu) (dist x mu)) mus)
                       (iota (length mus))))))
         xs)))

(define (update-mus)
    (let loop ((i 0))
        (when (< i K)
              (let rec ((xs xs) (rs rs) (ac (make-list s 0)) (count 0))
                   (if (null? xs)
                       (set! (ref mus i) (map (cut / <> count) ac))
                       (rec (cdr xs) (cdr rs)
                            (if (= i (car rs))
                                (map + ac (car xs)) ac)
                            (if (= i (car rs))
                                (+ count 1) count)))))))
(define (update)
    (update-rs)
    (update-mus))

(print xs)
(for-each (^_ (update)) (iota 20))
(print mus)
(print rs)
