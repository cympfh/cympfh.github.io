; Fast Fourie Trans (fft) and Inverse .. (ifft)

; (fft ls omega) ; ls : list?
; this translate number array as ls on omega
; (ordinary omega is (exp(-(* 2 pi +i (/ (length ls))))) )
; where (length ls) is pow of 2

; (fft-main) is receive input (length ls) and ls
; << EOT
; m a[0] a[1] .. a[K-1]
; EOT
; where K = 2^m

; (ifft) is easy. (ifft ls omega) == (fft ls (/ omega))

; $ gosh -l ./ft.scm -E fft-main -E exit <<EOT
; > 2 1 +i 0 1
; > EOT
; 
; (2.0+1.0i 2.0+1.0i 0.0-1.0i 1.1102230246251565e-16-1.0i)

; $ gosh -l ./ft.scm -E ifft-main -E exit << EOT
; > 2 2+i 2+i -i -i
; > EOT
;
; (1.0 5.551115123125783e-17+1.0i 0.0 1.0)

(define pi 3.141592653589793)

(define (horner a x)
    (let loop ((i (- (length a) 1)) (ac 0))
        (if (< i 0) ac
            (loop (- i 1) (+ (* ac x) (ref a i))))))

(define (dft a omega)
    (define len (length a))
    (let loop ((i 0) (ac '()))
        (if (>= i len) (reverse ac)
            (loop (+ i 1) (cons (horner a (expt omega i)) ac)))))

(define (halfen-list a)
    (define (sub a switch ac1 ac2)
        (cond ((null? a) (cons (reverse ac1) (reverse ac2)))
              ((= switch 0) (sub (cdr a) 1 (cons (car a) ac1) ac2))
              (else (sub (cdr a) 0 ac1 (cons (car a) ac2)))))
    (sub a 0 '() '()))

(define (merge qs ss omega)
    (let* ((K/2 (length qs))
           (K (* 2 K/2)))
    (let loop ((i 0) (ac '()))
        (cond ((< i K/2)
                  (loop (+ i 1)
                    (cons (+ (ref ss i) (* (expt omega i) (ref qs i))) ac)))
              ((< i K)
                  (let ((j (- i K/2)))
                  (loop (+ i 1)
                    (cons (- (ref ss j) (* (expt omega j) (ref qs j))) ac))))
              (else (reverse ac))))))

(define (fft a omega)
    (if (< (length a) 2)
        (dft a omega)
        (let* ((splitted-a (halfen-list a))
               (omega2 (* omega omega))
               (ss (fft (car splitted-a) omega2))
               (qs (fft (cdr splitted-a) omega2)))
            (merge qs ss omega))))

(define (ifft a omega K)
    (map (cut / <> K) (fft a (/ omega))))
    

(define (fft-main)
    (define m (read))
    (define K (expt 2 m))
    (define omega (exp (- (* 2 pi +i (/ K)))))
    (define a
        (let read-a ((ac '()) (i 0))
            (if (< i K) (read-a (cons (read) ac) (+ i 1)) (reverse ac))))
    (display
        (fft a omega)))

(define (ifft-main)
    (define m (read))
    (define K (expt 2 m))
    (define omega (exp (* 2 pi +i (/ K))))
    (define a
        (let read-a ((ac '()) (i 0))
            (if (< i K) (read-a (cons (read) ac) (+ i 1)) (reverse ac))))
    (display
        (map (cut / <> K) (fft a omega))))

