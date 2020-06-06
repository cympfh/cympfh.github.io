; this require ft.scm (i wrote)

; multiple of two bignumber

; receive two number from stdin

; $ gosh -l ./mult.scm -E test -E exit
; 10
; 10
; 100

(use srfi-1)
(require "./ft.scm")

; make list from read-line
(define (read-multiple-number)
    (map
        (lambda (c)
            (- (char->integer c) 48))
        (reverse (string->list (read-line)))))

; fill to length of pow of 2, with zero
(define (fill a b)
    (define len
        (let find ((len 1))
            (if (and (>= len (length a)) (>= len (length b))) (* len 2)
                (find (* len 2)))))
    (cons
        (let loop-a ((ac a))
            (if (>= (length ac) len) ac
                (loop-a (append ac '(0)))))
        (let loop-b ((ac b))
            (if (>= (length ac) len) ac
                (loop-b (append ac '(0)))))))

(define (multiple-number->string c)
    (define (erase-zero ls)
        (let loop ((i (- (length ls) 1)))
            (cond
                ((< i 0) '(0))
                ((eq? (ref ls i) 0) (loop (- i 1)))
                (else (take ls (+ i 1))))))

    ; 10以上の要素について繰り上げする
    (define (normalize ls)
        (if (eq? #f (find (cut >= <> 10) ls))
            ls
            (let loop ((ls ls) (ac '()))
                (if (null? (cdr ls))
                    (normalize (reverse (cons (modulo (car ls) 10) ac)))
                    (loop (cdr ls) (cons (+ (modulo (car ls) 10) (div (cadr ls) 10)) ac))))))

    (let ((c*
            (normalize
            (erase-zero 
            (map (lambda(c) (x->integer (real-part c))) c)))))
    (let loop ((ls c*) (ac ""))
        (if (null? ls) ac
            (loop (cdr ls) (string-append (number->string (car ls)) ac))))))

(define (test)
    (define a (read-multiple-number))
    (define b (read-multiple-number))
    (let* ((s (fill a b))
           (a (car s))
           (b (cdr s)))
        (define K (length a))
        (define omega (exp (- (* 2 pi +i (/ K)))))
        (let* ((A (fft a omega))
               (B (fft b omega))
               (C (map * A B))
               (c (ifft C omega K)))
            (display (multiple-number->string c)))))
