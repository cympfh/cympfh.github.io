; Karatsuba

; multiple of two bignumber
; two bignumber given by stdin

; $ gosh -l ./karatsuba.scm -E test -E exit << EOT
; > 23
; > 11
; > EOT
; 352

(use srfi-1)

; make list from read-line
(define (read-multiple-number)
    (map
        (lambda (c)
            (- (char->integer c) 48))
        (reverse (string->list (read-line)))))

; fill to length of long one, with zero
(define (fill a b)
    (define len
        (let find ((len 1))
            (if (and (>= len (length a)) (>= len (length b))) len
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
            (reverse
            (normalize
            (erase-zero 
            (map (lambda(c) (x->integer (real-part c))) c))))))
    (let loop ((ls c*) (ac ""))
        (if (null? ls) ac
            (loop (cdr ls) (string-append (number->string (car ls)) ac))))))

(define (karatsuba a b)
    (define (multiple-add a b) (map + a b))
    (define (multiple-subt a b) (map - a b))

    (define (halfen ls)
        (define len (x->integer (/ (length ls) 2)))
        (cons (take ls len) (drop ls len)))

    (define (append-base b c-top c-inn c-btm)
        (let ((buf (make-list b 0)))
        (map +
            (append c-top buf buf)
            (append buf c-inn buf)
            (append buf buf c-btm))))

    (cond ((= (length a) 0) a)
           ((= (length a) 1) (list (* (car a) (car b))))
           (else
                (let* ((as (halfen a))
                       (bs (halfen b))
                       (a-top (car as))
                       (a-btm (cdr as))
                       (b-top (car bs))
                       (b-btm (cdr bs))
                       (c-top (karatsuba a-top b-top))
                       (c-btm (karatsuba a-btm b-btm))
                       (c-inn
                            (multiple-subt
                                (multiple-add c-top c-btm)
                                (karatsuba
                                    (multiple-subt a-top a-btm)
                                    (multiple-subt b-top b-btm)))))
                (append-base (x->integer (/ (length a) 2))
                             c-top c-inn c-btm)))))


(define (test)
    (define a (read-multiple-number))
    (define b (read-multiple-number))
    (let* ((s (fill a b))
           (a (car s))
           (b (cdr s))
           (c (karatsuba a b)))
    (display (multiple-number->string c))))
