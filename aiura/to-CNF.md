% CNF (連言標準形) への書き換え
% 2017-03-08 (Wed.)
% 計算機言語
% 任意の論理式はCNFに書き換えられる

## あらまし

`not`/`and`/`or` だけを演算子として持つ論理式は、必ず等価な CNF に書き換えられる.
という命題は事実だと習ったし、自然に受け入れていたが、改めて考えると、その書換規則を知らない.
Wikipedia の [連言標準形](https://ja.wikipedia.org/wiki/%E9%80%A3%E8%A8%80%E6%A8%99%E6%BA%96%E5%BD%A2) を見ても載ってない.
なので自分で考えてみた.

## notation

論理式は下の BNF で定める `LOG`.

```
LOG ::= (not LOG) | (and LOGs) | (or LOGs) | VAR
LOGs ::= LOG | LOG " " LOGs
VAR ::= (何か変数で一文字の英字で書く)
```

論理式の深さを次のように定義する (察して).

```
(depth VAR) == 0
(depth (not LOG)) == (depth LOG)
(depth (and LOGs)) == (+ 1 (max (map depth LOGs)))
(depth (or LOGs)) == (+ 1 (max (map depth LOGs)))
```

## 書換規則

まず、有り得そうな規則を列挙する.

### Rule-1. `not` について

ド・モルガンを複数回適用することで、`VAR` 以外に適用する `not` は全て潰せる.

- `(not (and A...)) => (or (not A)...)`
- `(not (or A...)) => (and (not A)...)`

以降、`not` は直接 `VAR` に適用する以外に出現しないとする.
ああ、あと二重否定除去もさっさとしておく.

### Rule-2. `(and (and A...) B...)` な部分を含むとき

CNF にこのような部分は含まれないから、取り除く必要がある.
これは簡単で、

- `=> (and A... B...)`

とすればよい.

### Rule-3. `(or (or A...) B...)` な部分を含むとき

先と同様で、

- `=> (or A... B...)`

とすればよい.

### Rule-4. `(or (and A...) B...)` な部分を含むとき

もちろん、このような部分は CNF に含まれてはならないので潰す必要がある.
分配法則を用いる.
すなわち、

- `=> (and (or A B...)...)`

### Rule-5. 最も外側が `or` のとき

CNF の外側は `and` であるから、書換が必要である.

- `(or A...)`
    - `=> (and (or A...))`

とすれば回避可能である.

## `flatten`

`Rule-2` - `Rule-5` を適用出来る限り適用する手続きを `flatten` と定める.

`flatten` は論理式の深さを 2 以下にする効果がある.
深さが 3 以上のとき、次のように変化することで浅くなるからである.

- `(and (and (op  => (and (op`
- `(and (or (or   => (and (or`
- `(and (or (and  => (and (and (or  => (and (or`
- `(or (and (and  => (or (and       => (and (or`
- `(or (and (or   => (and (or (or   => (and (or`
- `(or (or (op    => (or (op`

`Rule-2` - `Rule-4` は確かに浅くする操作だから自明なのだが、
`Rule-5` は唯一、深くする操作である.
先ほどの一番下の場合は `Rule-5` の適用がある.
しかしこの場合にも

- `(or (or (and  => (or (and  => (and (or (and  => (and (and (or => (and or`
- `(or (or (or   => (or (or   => (and (or (or => (and (or`

となって結局、元の論理式よりも浅くできる.
従って、これらを繰り返し適用することで、任意の論理式の深さを 2 以下にすることが出来る.
また書き換え後は常に、外側が `and-or` になっている.

初めから深さが 2 以下の場合は、

- `(and A...) => (and A...)` (深さ 1 のとき)
- `(or A...) => (and (or A...))` (深さ 1 のとき)
- `(and A (and B...) (or C...)) => (and A B... (or C...))`
- `(or A (and B...) (or C...)) => (or A (and B...) C...) => (and (or B A C...)...)`

外側が `and` または `and-or` な深さ 2 以下の論理式を得る.

## 後処理: 整形 (`trim`)

`flatten` を施した後の論理式を考える.
これは、深さは 2 以下であって、その外側は `and` または `and-or` である.
適当な後処理によって CNF にする.

- `(and A... (or B...)...) => (and (or A)... (or B...)...)`

要するに `or` に包まれてないものを包めばよい.

## まとめ

以上をまとめると、次の手順で CNF に変形が出来る.

1. `not` を直接変数に適用するまでド・モルガンを適用
2. 二重否定除去
    - この時点で `not` は木の葉のすぐ上にしか出現しない
3. `flatten` の適用
    - 木の深さは 2 以下
    - 深さが 2 のとき、演算は上から `and-or`
4. `trim` の適用
    - 全ての葉が深さ 2 の位置にある

## 実装

実装は Scheme (/Gauche) で行いました.
Gauche の独自ライブラリであるところの `util.match` を使っています.
コレがないと実装は絶望的でした.

```scheme
(use util.match)
; http://practical-scheme.net/gauche/man/gauche-refj/patanmatutingu.html#index-util_002ematch


;; helpers
(define (and-term? logic) (and (list? logic) (eq? (car logic) 'and)))
(define (or-term? logic) (and (list? logic) (eq? (car logic) 'or)))
(define (op-term? op logic) (and (list? logic) (eq? (car logic) op)))

; var or (not var)
(define (literal? logic)
  (or
    (symbol? logic)
    (and (list? logic)
         (eq? (car logic) 'not)
         (symbol? (cadr logic)))))

(define (CNF? logic)
  (define (or-clause? logic)
    (and (or-term? logic) (every literal? (cdr logic))))
  (and
    (and-term? logic)
    (every or-clause? (cdr logic))))

(define (depth logic)
  (match logic
         [`(and . ,body) (+ 1 (apply max (map depth body)))]
         [`(or . ,body) (+ 1 (apply max (map depth body)))]
         [else 0]))

;; Rule-1
; not を中に追いやる
(define (deMorgen logic)
  (define (negate term) (list 'not term))
  (match logic
         [`(not (and . ,body)) `(or . ,(map negate body))]
         [`(not (or . ,body)) `(and . ,(map negate body))]
         [`(,op . ,body) `(,op . ,(map deMorgen body))]
         [else logic]))

; 二重否定除去
(define (eliminate-double-negate logic)
  (match logic
         [`(not (not ,x)) (eliminate-double-negate x)]
         [`(,op . ,body) `(,op . ,(map eliminate-double-negate body))]
         [else logic]))

;; Rule-2/Rule-3
(define (eliminate-double-op logic)
  (if (not (list? logic)) logic
    (let* ((logic (map eliminate-double-op logic)))
      (if (or (and-term? logic) (or-term? logic))
        (let1 op (car logic)
              (let loop ((body (cdr logic)) (body2 '()))
                (cond
                  [(null? body) `(,op . ,(reverse body2))]
                  [(op-term? op (car body))
                   (loop (cdr body) (append (reverse (cdar body) body2)))]
                  [else (loop (cdr body) (cons (car body) body2))])))
        logic))))

;; Rule-4
(define (or-and-distribution logic)
  (if (not (list? logic)) logic
    (let* ((logic (map or-and-distribution logic)))

      (if (and (or-term? logic)
               (any and-term? (cdr logic)))

        (let loop ((body (cdr logic)) (body2 '()))
          (if (and-term? (car body))

            (let* ((or-body-rest (append (reverse body2) (cdr body)))
                   (and-body
                     (map (lambda (a) (cons 'or (cons a or-body-rest)))
                          (cdar body))))
              `(and . ,and-body))

            (loop (cdr body) (cons (car body) body2))))

        logic))))

;; Rule-5
(define (and-closure logic)
  (if (or-term? logic)
    `(and ,logic)
    logic))

(define (flatten logic)
  (let while ((logic logic))
    (let1 logic2 (and-closure (or-and-distribution (eliminate-double-op logic)))
          ; (print `(=> ,logic ,logic2))
          (if (equal? logic logic2)
            logic
            (while logic2)))))

(define (trim logic)
  `(and . ,(map (lambda (logic)
                  (if (or-term? logic) logic `(or ,logic)))
                (cdr logic))))


(define (->CNF logic)
  (trim (flatten (eliminate-double-negate (deMorgen logic)))))

(define (test logic)
  (newline)
  (print logic)
  (print `(=> ,(deMorgen logic)))
  (print `(=> ,(eliminate-double-negate (deMorgen logic))))
  (print `(=> ,(flatten (eliminate-double-negate (deMorgen logic)))))
  (print `(=> ,(->CNF logic)))
  (print (if (CNF? (->CNF logic)) 'ok 'ng)))

(test '(and (and x y z)))
(test '(and (and a b c) (and x y z)))
(test '(and (or a b c) (and x y z)))
(test '(and (not (or a b c)) (and x y z)))
(test '(or (or a b c) (and x y z)))
(test '(or (or a b c) (or x y z)))
(test '(or (and a b c) (or x y z)))
```
