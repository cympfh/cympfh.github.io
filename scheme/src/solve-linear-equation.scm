(load "./LU.scm") ; LU, perm

;; 連立一次方程式 Ax = b を解きます．

(define (solve A b)
    (define (inner* x y) (apply + (map * x y)))

    (receive (L U ord) (LU A)
    (let* ((b (perm ord b))
           (Ux
          (let loop ((i 0) (Ux '()))
              (if (= i (length A)) Ux
                  (loop (+ i 1) (append Ux (list
                          (- (ref b i) (inner* (ref L i) Ux)))))))))

    (let loop ((i (- (length U) 1)) (x '()))
        (if (< i 0) x
            (loop (- i 1)
             (cons (/ (- (ref Ux i)
                         (inner* (reverse (ref U i)) (reverse x)))
                      (ref (ref U i) i)) x)))))))

; 1x + 2y + 3z = 1
; 4x + 0y + 6z = 2
; -x -  y +  z = 3
; 
; gosh> (solve '((1 2 3) (4 0 6) (-1 -1 1)) '(1 2 3))
; (-16/13 -8/13 15/13)
; 
; [x, y, z] = [-16/13, -8/13, 15/13]
