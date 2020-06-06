(use parser.peg)
; reference for parser.peg:  http://d.hatena.ne.jp/mjt/20110626/p2 

; parser.peg を使うテスト

; 型環境(signature) とラムダ項をパーズする．

; 型環境  ::= name : type [, 型環境]

; type ::= Typename (頭が大文字ならそれはプリミティブ型)
;        | a | b | .. (頭が小文字ならそれは多相型)
;        | type -> type
;        | (type) -> type

; ラムダ項 ::= 0 | 1 | 2 | ..
;            | #t | # f
;            | a | b | .. | y | z | aa | ab | ..
;            | (ラムダ項 ラムダ項)
;            | ^x -> ラムダ項

(define parse-lambda
    (letrec ((hat ($c #\^))
             (parel ($seq spaces ($c #\() spaces))
             (parer ($seq spaces ($c #\)) spaces))
             (shp ($c #\#))
             (arrow ($seq spaces ($string "->") spaces))

             (id  ($many1 ($one-of #[a-z\-\?])))
             (var ($do (id id) ($return `(var . ,(list->string id)) )))

             (int ($do (n ($many1 ($one-of #[0-9])))
                       ($return (cons 'int
                            (read-from-string (list->string n))))))
             (true ($do (s ($string "t")) ($return (cons 'bool #t))))
             (fals ($do (s ($string "f")) ($return (cons 'bool #f))))
             (bool ($do (shp) ($or true fals)))

             (lmbda  ($do (hat) (spaces) (arg id) (arrow) (body term)
                         ($return `(lambda . ,(list (list->string arg) body))) ))
             (abst  ($or ($do (parel) (l lmbda) (parer) ($return l))
                         lmbda))

             (appli  ($do (parel) (m1 term) (spaces) (m2 term) (parer)
                          ($return (list 'apply m1 m2))))

             (term ($or ($try abst) ($try appli) ($try var) ($try int) ($try bool))) )
    (cut peg-parse-string term <>)))

(define parse-env
    (letrec ((colon ($seq spaces ($c #\:) spaces))
             (comma ($seq spaces ($c #\,) spaces))
             (id    ($many ($one-of #[A-Za-z\?\-])))
             (arrow ($seq spaces ($string "->") spaces))
             (parel ($seq spaces ($c #\() spaces))
             (parer ($seq spaces ($c #\)) spaces))
             (to2   ($do parel (t1 type) parer arrow (t2 type)
                         ($return (cons t1 t2))))
             (to    ($do (t1 id) arrow (t2 type)
                         ($return (cons (list->string t1) t2))))
             (ti    ($do (t id)
                         ($return (list (list->string t))) ))
             (type  ($or ($try to2) ($try to) ($try ti)))
             (field ($do (x id) (_ colon) (t type)
                         ($return (cons (list->string x) t)) ))
             (env   ($sep-by field comma)))
    (cut peg-parse-string env <>)))

; 入力をS式にしてもらえば(read)で一発で読み込めちゃうんだけど、
; それじゃ芸がないからちゃんとパーズしようと思ったんだけど、
; 結果的にS式とあんまり変わらないや．
