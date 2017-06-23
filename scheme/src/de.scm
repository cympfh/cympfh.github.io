(define pi 3.141592653589793238462643)

; DE変換

; (define (f x) (/ 1 (expt (+ x 1) 2)))
; こんな関数を、xについて0からinfinityまで積分すると、
; 解析的に 1 に値を定めることがわかる．

; 複数台形則によって数値計算するのが(J_x h) でhはその
; 幅．(幅じゃなくて分割数を引数にするべきだった)
; 普通にやると収束が遅い．

; DE変換とは、数式の上では単なる変数変換であり、
; xを(phi t)に置き換える．そうすると積分範囲と、後ろに
; dt/dxみたいなのがくっつく．それをやって台数則するのが
; (J h)であり、収束があっというまだ．

(define (phi t)
    (exp (* pi 0.5 (sinh t))))

(define (dtdx t)
    (* pi 0.5 (exp (* pi 0.5 (sinh t))) (cosh t)))


(define (f t)
    (/ 1 (expt (+ (phi t) 1) 2)))

(define (J h)
    (let ((N 6))
    (let loop ((t (- N)) (sum 0.0))
        (if (>= t N) (* sum h)
            (loop (+ t h) (+ sum (* (f t) (dtdx t) )))))))

(define (main*)
    (let loop ((h 0.0001))
        (if (> h 1) (newline)
            (begin
            (display h)(display " ")
            (display (abs (- (J h) (J (/ h 2)) )))(newline)
            (loop (* h 2))))))
(main*)

;  (J h)のxで積分するバージョン
  (define (J_x h)
      (define (f_x x)
          (let ((ret (/ 1 (expt (+ x 1) 2))))
                (if (= x 0.0) (/ ret 2) ret)))
      (let ((N 60))
      (let loop ((x 0) (sum 0.0))
          (if (>= x N) (* sum h)
              (loop (+ x h) (+ sum (f_x x)))))))

(define (main_x)
    (let loop ((h 0.0001))
        (if (> h 1) (newline)
            (begin
            (display h)(display " ")
            (display (abs (- (J_x h) (J_x (/ h 2)) )))(newline)
            (loop (* h 2))))))
;(main_x)
