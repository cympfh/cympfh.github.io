;;; 竹内関数
; 何かの思い違いかと思ったけど，node.jsに比べて６倍も遅かった

;;; 動機

;(define (tak x y z)
;  (if (<= x y) y
;      (tak (tak (- x 1) y z)  (tak (- y 1) z x) (tak (- z 1) x y))))
;
;(print (tak 13 6 0))
; real    0m6.851s
; user    0m6.824s
; sys     0m0.008s

; 竹内関数は遅延評価にすれば大幅に計算を削れることで有名である
; 次のように

;(define (ltak x y z)
;  (let ((x (force x))
;        (y (force y)))
;  (if (<= x y) y
;      (let1 z (force z)
;        (ltak (delay (ltak (- x 1) y z))
;              (delay (ltak (- y 1) z x))
;              (delay (ltak (- z 1) x y)))))))
;
;(print (ltak 13 6 0))
; real    0m0.043s
; user    0m0.012s
; sys     0m0.016s

; delayの使い方に注意
; delayはltakがとる引数全てにそれぞれdelayをかませるのである
; 形式的には
;   (ltake (- x 1) y z)
; っていうのも
;   (ltake (delay (- x 1)) (delay y) (delay z))
; ってするべきなんだけど，この (- x 1) , y , z はすでに評価済みだし
; 手でいちいち書くのが大変だったし，
; forceにpromiseでない，例えば3を渡してみると
; > (force 3)
; 3
; として，恒等関数のように働く
; ので実際，動作に問題ないので

; forceの使い方に注意
; forceは基本的にはひとつのpromiseを受け取って評価する
; 一度評価したらその値は内部に保存して二度評価することはないので
; 上のようにletで保存する必要はないのであって，
;   (let ...
;   (if (<= x y) y
; というのは
;   (if (<= (force x) (force y)) (force y)
; と書いても実は問題ないのだ

;;; 結論

; というわけで，
; 初めに書いた tak 手続きは次のように，形式的に書き換えれば遅延評価になる


; (define (tak x y z)
;   (if (<= (force x) (force y)) (force y)
;       (tak (delay (tak (delay (- (force x) 1))
;                        (delay (force y))
;                        (delay (force z))))
;            (delay (tak (delay (- (force y) 1))
;                        (delay (force z))
;                        (delay (force x))))
;            (delay (tak (delay (- (force z) 1))
;                        (delay (force x))
;                        (delay (force y)))))))

; 「形式的に書き換える」，のココロはマクロ
; 次のようなものを書いた

(define-macro (define-lazy ls . body)

  (define funname (car ls))
  (define args (cdr ls))

  (define (insert-delay expr)
    (cond [(not (pair? expr))
            (if (find (pa$ equal? expr) args) `(force ,expr) expr)]
          [(equal? (car expr) funname)
            (let1 args (insert-delay (cdr expr))
            `(,funname ,@(map (^x (list 'delay x)) args)))]
          [else (map insert-delay expr)] ))

  `(define ,ls ,@(insert-delay body)))

; このように使う

(define-lazy (tak x y z)
  (if (<= x y) y
      (tak (tak (- x 1) y z) (tak (- y 1) z x) (tak (- z 1) x y))))

(print (tak 13 6 0))


;;; ダメなところ．

; 関数名をfunnameとして，関数本体に (funname x ...) を見つけ次第
; (funname (delay x) ... ) に置き換えるのだが，
; じゃあ (apply funname ls) は置き換えられていない
; ほかにもdelayしたいような関数手続きの書き方はいくらでもあるので
; いちいち対応できない気がした

; 実際的には自分で delay するんだけど，delayとforceくらいリーダマクロ
; あって欲しいなあ

; vim: set ft=scheme:
