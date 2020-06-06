;; Brainfuck interpreter 

; read code by (read-line)

(define (char->sym c)
  (cond ((char=? c #\+) 'plus)
        ((char=? c #\-) 'minus)
        ((char=? c #\>) 'right)
        ((char=? c #\<) 'left)
        ((char=? c #\.) 'output)
        ((char=? c #\,) 'input)
        ((char=? c #\[) 'begin)
        ((char=? c #\]) 'close)
        (else #f)))

(define (comp program)
  (define prg (list->vector program))
  (define mem (make-vector 120 0))
  
  ; (~ prg pc) is #\[ => find the position of #\] for it
  (define (next pc)
    (let rec ((d 0) (i (+ pc 1)))
      (let1 c (vector-ref prg i)
      (case c
        ((begin) (rec (+ d 1) (+ i 1)))
        ((close) (if (zero? d) i (rec (- d 1) (+ i 1))))
        (else    (rec d (+ i 1)))))))
  
  ; find the position of #\[ for #\] at pc
  (define (prev pc)
    (let rec ((d 0) (i (- pc 1)))
      (let1 c (vector-ref prg i)
      (case c
        ((close) (rec (+ d 1) (- i 1)))
        ((begin) (if (zero? d) i (rec (- d 1) (- i 1))))
        (else    (rec d (- i 1)))))))

  (let while ((ptr 20) (pc 0))
    (if (>= pc (vector-length prg)) 'done
      (let1 c (vector-ref prg pc)
      (case c
        ((plus)  (vector-set! mem ptr (+ (vector-ref mem ptr) 1)) (while ptr (+ pc 1)))
        ((minus) (vector-set! mem ptr (- (vector-ref mem ptr) 1)) (while ptr (+ pc 1)))
        ((right) (while (+ ptr 1) (+ pc 1)))
        ((left)  (while (- ptr 1) (+ pc 1)))
        ;((input) (vector-set! mem ptr (read-char)) (while ptr (+ pc 1)))
        ((output)(write-char (ucs->char (vector-ref mem ptr))) (while ptr (+ pc 1)))
        ((begin) (while ptr (if (zero? (vector-ref mem ptr)) (next pc) (+ pc 1))))
        ((close) (while ptr (if (zero? (vector-ref mem ptr)) (+ pc 1) (prev pc))))
        (else (while ptr (+ pc 1))))))))

(let* ((line (read-line))
       (sls  (map char->sym (string->list line)))
       (sls  (filter (lambda (x) (not (equal? x #f))) sls)) )
  (comp sls))

; vim: set ft=scheme:
