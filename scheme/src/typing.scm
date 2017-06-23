(use srfi-1)
(load "./parser.scm")

; ./parser.scm を使って
; 一行目に型環境(signature) 二行目にラムダ項を受け取って、
; それを型推論する．

; cympfh$ gosh typing.scm << EOT
; const : a -> b -> a, take : Int -> List -> List, nat : List
; ^x -> ((((const take) x) 10) nat)
; EOT
; e     : ^x:(a.0) -> ((((const take) x) 10) nat)
; tau   : ((a.0) -> (List))
; theta : ((List List) (List a.4) (Int Int) (a.3 (List List)) (b a.0) ((Int List List) a.2) (a (Int List List)) (a.1 (b a)))

; 入力したラムダ項に型注釈 (引数に対して型を与える)を添えたものは
;    ^x:(a.0) -> ((((const take) x) 10) nat)
; 全体の型は
;    ((a.0) -> (List))
; thetaについては略．
; a.0 という型は、型変数として新たに導入したもの．Intとかa,bとかに決定されたら
; するけど、されなかったということは多相型、つまりなんでも良いということ．

; わかりやすい多相型は、例えば恒等写像
; cympfh$ gosh typing.scm << EOT
; >
; > ^x -> x
; > EOT
; e     : ^x:(a.0) -> x
; tau   : ((a.0) -> ((a.0)))
; theta : ()

; 失敗する例．
; cympfh$ gosh typing.scm << EOT
; > id : a -> a
; > ((^f -> f) id)
; > EOT
; ill-typed
; これは、MLの型推論のやり方を再現してるから．

; 型の名前は文字列で持っている
; 頭が大文字ならば、プリミティブ型である．
(define (primitive-type? ty)
    (if (list? ty) (every primitive-type? ty)
        (char-upper-case? (string-ref ty 0))))
; "a."で始まるならば、それは型変数である．型変数は優先的に、単一化されるべき
(define (type-var? ty)
    (if (list? ty) (any type-var? ty)
        (string-scan ty "a.")))

; プリミティブでも型変数でもない、つまり多相型がある．
; 次は、シグネチャのそれぞれの型宣言について、多相型を集めるもの．
; "a->Int" -> "forall a. a->Int"
(define (split types)
    (define (add x xs)
        (if (find (pa$ equal? x) xs) xs (cons x xs)))
    (define (flatten ls)
        (cond ((null? ls) '())
              ((pair? ls) (append (flatten (car ls)) (flatten (cdr ls))))
              (else (list ls))))
    (define (unique ls)
        (if (null? ls) '()
            (cons (car ls)
                  (remove (pa$ equal? (car ls)) (cdr ls)))))
    (values 
        ($ unique $ remove primitive-type? $ flatten types)
        types))

(define *gen* -1)
(define (new-alpha)
    ($ string-append "a." $ number->string $ inc! *gen*))

(define (Gamma G x)
    (let1 ls (assoc x G)
    (values (second ls) (third ls))))

; get type of a (a may be type-var) on theta
(define (got theta a)
    (define (find$ key duals)
        (let1 ret (assoc key duals)
        (if ret (second ret)
            (let* ((dls$ (map (^(dl) (list (second dl) (first dl))) duals))
                   (ret$ (assoc key dls$)))
            (if ret$ (second ret$) #f)))))

    (if (list? a) (map (cut got theta <>) a)
        (cond ((type-var? a)
                    (let1 ls (find$ a theta)
                    (if ls
                        (if (type-var? ls)
                            (begin (display "ill-typed\n") (exit))
                            (got theta ls))
                        a)))
              ((primitive-type? a) a)
              (else
                    (let1 ls (find$ a theta) (if ls ls a)) ))))

; get lambda with type notation on theta
(define (got-exp theta M)
    (case (car M)
        ((lambda)
            (let ((arg  (car (second M)))
                  (argt (cdr (second M)))
                  (body (third M)))
            (list 'lambda (cons arg (got theta argt))
                   (got-exp theta body))))
        (else M)))

(define (theta+G theta G)
    (if (null? G) '()
        (let* ((g    (car G))
               (name (first g))
               (alphas (second g))
               (taus (third g)))
        (let* ((dict (map (^a ($ cons a $ got theta a)) alphas))
               (taus+ (map (^t (if (assoc t dict)
                                   (cdr (assoc t dict)) t)) taus)))
        (cons (list name alphas taus+)
              (theta+G theta (cdr G))) ))))

(define theta-add append)

(define (unify t1 t2 theta) ; t1 is t2 on theta
    (define np? (compose not pair?))
    ; (format #t "unify ~a and ~a \n" t1 t2 )
    (cond
          ((and (np? t1) (np? t2)) `((,t1 ,t2)))
          ((and (np? t1) (= (length t2) 1))
                (list (list t1 (car t2))))
          ((and (np? t2) (= (length t1) 1))
                (list (list t2 (car t1))))
          ((np? t1) (list (list t1 t2)))
          ((np? t2) (list (list t2 t1)))

          ((and (= (length t1) 1) (= (length t2) 1))
                (list (list (car t1) (car t2))))
          ((= (length t2) 1) 
                (list (list (car t2) t1)))
          ((= (length t1) 1)
                (list (list (car t1) t2)))
          (else
                (append
                    (unify (car t1) (car t2) theta)
                    (unify (cdr t1) (cdr t2) theta)))))

; Inf とは、型環境Gの下で、ラムダ項Mを見て、
; (values e tau theta) を返す．
; e とは、Mに型注釈を添えたもの．型注釈とは、ラムダ注釈の引数にのみ型を添えるもの．
; tau とは、M全体の型．
; theta とは、unifyの結果．unifyは、型変数と多相型、多相型とプリミティブ型を
; 対応付けたもの．例えばbとIntが同じだと分かったら、'(("b" "Int")) みたいになってる．

(define (Inf G M)
    ; (format #t "\nInf of ~a\n ~a\n" G M)
    (case (car M)
        [(int)  (values M '("Int") '())]
        [(bool) (values M '("Boolean") '())]
        [(var)
            (receive (alphas tau) (Gamma G (cdr M))
            (values M tau '()) )]
        [(lambda)
            (let* ((arg (second M)) (body (third M))
                   (a (new-alpha))
                   (G+ (cons (list arg '() (list a)) G)))
            (receive (e tau theta) (Inf G+ body)
            (let1    t (got theta a)
            (let1    tau* (got theta tau)
            (values `(lambda (,arg . ,t) ,e)
                    `(,t ,tau*)
                     theta) ))))]
        [(apply)
            (let* ((M1 (second M)) (M2 (third M)))
            (receive (e1 tau1 theta1) (Inf G M1)
            (let1 theta1+G (theta+G theta1 G)
            (receive (e2 tau2 theta2) (Inf theta1+G M2)
            (let1 tau2* (if (= (length tau2) 1) (car tau2) tau2)
            (let* ((a (new-alpha))
                   (theta3 (unify tau1 (list tau2* a) theta1))
                   (theta3+2   (theta-add theta3 theta2))
                   (theta3+2+1 (theta-add theta3+2 theta1)))
            (values `(apply ,(got-exp theta3+2 e1) ,(got-exp theta3 e2))
                     (got theta3+2+1 a)
                     theta3+2+1) ))))))] ))

(define (show-type t)
    (string-append
        "(" (if (list? t) (string-join (map show-type t) " -> ") t) ")"))
(define (show term)
    (define (show-field ls)
        (string-append (car ls) " : " (string-join (cdr ls) " -> ")))
    (if (null? term) ""
        (case (car term)
            [(var int bool) (x->string (cdr term))]
            [(lambda)
                (let* ((arg  (second term))
                       (body (third term)))
                (string-append "^" (if (pair? arg) (string-append (car arg) ":" (show-type (cdr arg))) arg) " -> " (show body)))]
            [(apply) (string-append "(" (show (cadr term)) " "
                               (show (caddr term)) ")")]
            [else (string-join (map show-field term) ", ")] )))

;; --- 実行結果
(define env  
    (map (^f (receive (alphas taus) (split (cdr f))
             (list (car f) alphas taus))) ($ parse-env $ read-line)))
(define term ($ parse-lambda $ read-line))
; (format #t  "env : ~a\nterm : ~a\n" env term)
(receive (e tau theta) (Inf env term)
(format #t "e     : ~a\ntau   : ~a\ntheta : ~a\n"
       (show e)
       (show-type tau) theta))
