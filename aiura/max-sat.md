% MAX-SAT を近似的に解く
% 2017-02-28 (Tue.)
% アルゴリズム
% 典型的な手法を用い、近似的に MAX-SAT を解きます

## 概要

[連言標準形 (CNF)](https://ja.wikipedia.org/wiki/連言標準形) で与えられた SAT を近似的に解く.
CNF は各節が変数または変数の否定を OR で接続したもので、節を AND で接続したものでした

- $CNF = \bigwedge_{i \in I} C_i$
    - $C_i = \bigvee_{j \in J_i} v_{ij}$
        - $v_{ij} = x_k$ または $\lnot x_k$ ($1 \leq k \leq n$)

厳密に解くとは、与えられた OR 節の全てが成立する変数割当を求めることだが、
近似的に解くとは、出来るだけ多くの節の成立を目指すこと.
ここで節ごとに異なる重みを与えることを許す.
節の個数ではなく、成立する節の重みの和の最大化を目指す.
デフォルトで節の重みを 1 とし、重みを指定しなかった場合は個数の最大化と一致させる.

以下では、典型的な手法を用いて、近似的な解法を実装してみた.
実装した手法は、

1. ランダムに割り当てる
1. 山登り
1. 焼きなまし
1. 遺伝的アルゴリズム

の 4 つ.

## 実装

###  入力形式

プログラムへの入力は標準入力から与える.
初めに変数の個数を与えて、次に S 式で CNF を与える.

#### 変数の表現
変数が N 個あるとき、変数の名前を 1, 2, .., N という整数リテラルで与える.
`(not n)` を -n という負数リテラルで表現する

#### CNF の表現
`(and (or 1 2) (or -1 3 4))`
という感じの S 式で表現することにする.
各 or 節 に重みを与える場合は
`(and (or 1 2 :weight 1) (or -1 3 4 :weight 100))`
ていう感じで. 省略したら `1` とする.

#### 例

```
3
(and (or 1 2 3) (or -1 3 :weight 100))
```

#### ソースコード

```scheme
(use srfi-1)
(use srfi-13)
(use srfi-26)
(use srfi-27)

(define *N* #f) ; the number of vars
(define *weights* #f)
(define *clauses* #f)

;; read
(set! *N* (read))
(let ((body (read)))

  (define (get-clause body)
    (let loop ((skip #f) (body (cdr body)) (ret '()))
      (if (null? body) ret
        (cond
          ((eq? (car body) ':weight) (loop #t (cdr body) ret))
          (skip (loop #f (cdr body) ret))
          (else (loop #f (cdr body) (cons (car body) ret)))))))

  (define (get-weight body)
    (let loop ((body (cdr body)))
      (if (null? body) 1
        (if (eq? (car body) ':weight)
          (cadr body)
          (loop (cdr body))))))

  (set! *clauses* (map get-clause (cdr body)))
  (set! *weights* (map get-weight (cdr body))))


;; helpers
(define (random-assign)
  (list->vector (map (lambda (i) (zero? (random-integer 2))) (iota *N*))))

;; assign => total score (sum of weights)
(define (score x)
  (let loop ((cls *clauses*) (ws *weights*) (ac 0))
    (if (null? ws) ac
        (let rec ((c (car cls)))
          (if (null? c) (loop (cdr cls) (cdr ws) ac)
              (let* ((v (car c))
                     (bit (if (> v 0) (vector-ref x (- v 1))
                                      (not (vector-ref x (- -1 v))))))
              (if bit (loop (cdr cls) (cdr ws) (+ ac (car ws)))
                      (rec (cdr c)))))))))


;; 手法1. ただのランダムな割り当て．そのスコアを返す
(define (just-random) (score (random-assign)))

;; 手法2. 山登り
(define (hill-climbing)

  (define x (random-assign)) ; initial value

  (let loop ((j 0) (sc (score x)) (cx 0))
    (if (>= cx *N*) sc
        (begin
          (set! (vector-ref x j) (not (vector-ref x j))) ; swap j-th variable (true <-> false)
          (let ((sc+ (score x))
                (j+ (modulo (+ 1 j) *N*)))
          (if (> sc+ sc)
              (loop j+ sc+ 0) ; after the swap, up the score (keep the j-th)
              (begin
                (set! (vector-ref x j) (not (vector-ref x j))) ; otherwise, restore the j-th
                (loop j+ sc (+ cx 1)))))))))


;; 手法3. 焼き鈍し
(define (simulated-annealing)

  (define x (random-assign)) ; initial value
  (define max-time 2000)     ; loop times

  ;; 変数を変えてみる前後のスコア(sc), time(ループが何回目か)で、
  ;; 変数を変えるための確率
  (define (probably sc sc+ time) ; probability of transition
    (let1 d-sc (- sc+ sc)
    (if (> d-sc 0) 1 (exp (* d-sc time (/ max-time))))))
    ; スコアが上がるときは、確率 1 で動く
    ; スコアが下がるときでも、下がる量が少ない程、timeが小さい程、確率は 1 に近い数になる (0より大きいことが大切)

  (let loop ((time 1) (sc (score x)) (max-sc 0))
    (if (> time max-time) max-sc
        (let* ((j (random-integer *N*))
               (b (vector-ref x j)))
        (begin
          (set! (vector-ref x j) (not b))
          (let ((sc+ (score x))
                (time+ (+ time 1)))
          (if (< (random-real) (probably sc sc+ time))
              (begin ; keep the value of j-th after swapping
                (loop time+ sc+ (max max-sc sc+)))
              (begin
                (set! (vector-ref x j) b) ; restore the j-th
                (loop time+ sc max-sc)) )))))))

;; 手法4. 遺伝的アルゴリズム
(define (genetic-algorithm)

  ;; 変数割り当て自体を一つの遺伝子とする
  (define *L* 30) ; プールには30の遺伝子があるのを基準とする
  (define pool (map (lambda _
      (let1 x (random-assign)
      (cons x (score x))))
    (iota *L*)))

  ; プールから一様確率で選んだ2つを二点交叉して新しい遺伝子を作る
  (define (make-child)
    (let1 len (length pool)
    (let* ((i (random-integer len))
           (j (modulo (+ i (random-integer (- len 1)) 1) len))
           (m1 (car (list-ref pool i)))
           (m2 (car (list-ref pool j)))
           (i (random-integer *N*))
           (j (modulo (+ i (random-integer (- *N* 1)) 1) len)))
      (list->vector
        (map (lambda (k)
            (vector-ref (if (< (min i j) k (max i j)) m1 m2) k))
          (iota *N*))))))

  ; プールからスコアの最も低いような遺伝子を取り除いたプールを返す
  (define (delete-worst)
    (let loop ((cand (car pool)) (ac '()) (ls (cdr pool)))
      (if (null? ls) ac
          (if (< (cdr cand) (cdar ls))
              (loop cand (cons (car ls) ac) (cdr ls))
              (loop (car ls) (cons cand ac) (cdr ls)) ))))

  ; (make-child)を破壊的に追加
  (define (add-child!)
    (let1 c (make-child)
    (when (< (random-real) 0.2)
      (for-each (^i
          (let1 idx (random-integer *N*)
          (set! (vector-ref c idx) (random-integer 2))))
        (iota (random-integer 5))))
    (set! pool (cons (cons c (score c)) pool))))

  ; (delete-worst)によってプールを破壊的に上書き
  (define (elite!) (set! pool (delete-worst)))

  ; 「20回、子供作って、20回、スコアの悪いのを捨てる」を50回繰り返す
  (for-each (lambda (i)
      (for-each (lambda (j) (add-child!)) (iota 20))
      (for-each (lambda (j) (elite!)) (iota 20)) )
    (iota 50))

  ; プールから最も良いスコアを返す
  (apply max (map cdr pool)))

;;; main

(define-syntax test
  (syntax-rules ()
    ((_ algo) (begin (display (time (algo))) (newline)))))

(random-source-randomize! default-random-source)
(test just-random)
(test hill-climbing)
(test simulated-annealing)
(test genetic-algorithm)
```

## 実験

先に入力例として見せた例:

```
3
(and (or 1 2 3 :weight 1) (or -1 3 :weight 100))
```

では

```
;(time (just-random))
; real   0.000
; user   0.000
; sys    0.000
101
;(time (hill-climbing))
; real   0.000
; user   0.000
; sys    0.000
101
;(time (simulated-annealing))
; real   0.002
; user   0.010
; sys    0.000
101
;(time (genetic-algorithm))
; real   0.006
; user   0.010
; sys    0.000
101
```

3 変数への割当の内 2 通りで全ての節が成立するので
`(just-random)` では 1/4 の確率でスコア 101 を取れる.
他の手法は常に 101 を返す.

もっと大きいデータセットを探すと
[Max-SAT 2016 - Eleventh Max-SAT Evaluation](http://maxsat.ia.udl.cat/benchmarks/)
というのがあったのでこれを使います.
この Weighted Partial MaxSAT の random から
100変数 600節のを一つ使って入れてみました.

(たぶん各行の頭の数字が重みで、最後の数字が常に 0 なのが、節の終端を示す記号でいいんだよね?)
理論上の最大スコアはどこにも書いて無さそう.
random だから無いのかと思って crafted データセットも見たけど無いっぽい.

```bash
100
(and
(or :weight 3237 2 5 30)
(or :weight 3237 -68 -41 -22)
(or :weight 3237 62 -58 9)
(or :weight 3237 77 -70 42)
(or :weight 3237 -94 -17 -26)
(or :weight 3237 -72 84 2)
(or :
(or :weight 10 64 -18 97)
(or :weight 5 28 -40 53)
(or :weight 3 -60 -35 -1)
(or :weight 10 84 62 -39)
(or :weight 7 4 -66 90)
(or :weight 9 53 -48 47)
(or :weight 4 90 81 54)
(or :weight 9 -60 85 49)
(or :weight 9 -20 27 -69)
(or :weight 7 19 -38 39))
```

重みがちょうど 3237 なのが 100 節あって、残りは小さいのが 500 節ある.

```
;(time (just-random))
; real   0.000
; user   0.000
; sys    0.000
274279
;(time (hill-climbing))
; real   0.050
; user   0.040
; sys    0.000
326334
;(time (simulated-annealing))
; real   0.200
; user   0.190
; sys    0.000
326373
;(time (genetic-algorithm))
; real   0.144
; user   0.140
; sys    0.000
322979
```

大体、3237 の 100 節分くらいは拾ってる.
`genetic-algorithm` は最初に良いシードを拾えるかどうかで当たり外れがある.
`simulated-annealing` は安定してる.

