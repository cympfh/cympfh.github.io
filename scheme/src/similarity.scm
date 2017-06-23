#!  /usr/local/bin/gosh

;; 語の重みに tf-idf を用いた用いてテキストのコサイン類似度を
;; 調べる.
;
;; 空白か改行で語を区切れる程度の簡単な文章を2つ以上用意して
;; $ gosh ./similarity.scm input1 input2 ...
;; のように実験する

; 例えば Wikipediaからいくつかの記事を wikiディレクトリに保存して
; 
; $ gosh ./similarity.scm wiki/*
; wiki/Aiura wiki/Linux 0.0054991185818617765
; wiki/Aiura wiki/Macos 0.002611462566896136
; wiki/Aiura wiki/Trisquel 0.003894850295124982
; wiki/Aiura wiki/Windows 0.0035955775448793274
; wiki/Aiura wiki/Yuyushiki 0.4289658365289811
; wiki/Linux wiki/Macos 0.135492604558405
; wiki/Linux wiki/Trisquel 0.1167040839600922
; wiki/Linux wiki/Windows 0.11053283743818382
; wiki/Linux wiki/Yuyushiki 0.005589308305096626
; wiki/Macos wiki/Trisquel 0.0170007870784677
; wiki/Macos wiki/Windows 0.10521518337390891
; wiki/Macos wiki/Yuyushiki 0.0032617734817390353
; wiki/Trisquel wiki/Windows 0.01082203311131606
; wiki/Trisquel wiki/Yuyushiki 0.00462516926987522
; wiki/Windows wiki/Yuyushiki 0.00353391844504245

;; コサイン類似度であるから2つのテキストの類似度として0以上1以下の
;; 実数が出力されて，数字が大きいほど類似度が高いことを言う


(use srfi-13)

;; filename -> hash-table(word->tf)
(define (get-tokens f)
  (define words
    (call-with-input-file f (lambda (port)
    (string-tokenize (port->string port) #[\w]))))
  (define N (length words))
  (define A (make-hash-table 'equal?))

  ;; count words and div by N
  (let1 /N (/ N)
  (for-each (cut hash-table-update! A <> (cut + /N <>) 0) words))

  A)

(define (main args)

  (let1 files (cdr args)
  (define N (length files))
  (when (< N 2) (error 'need-more-2-files))

  ;; hash-table (filename -> hash-table(word->tf))
  (let1 ht
      (apply hash-table 'equal?
        (map (lambda (f) (cons f (get-tokens f))) files))

  ;; word -> idf ; with memo
  (define idf

    (let1 memo (make-hash-table 'equal?)
    (define (get-idf w) ; without memo
      (log (/ N
              (apply +
                (hash-table-map ht (lambda (_ A)
                  (if (hash-table-exists? A w) 1 0)))))))

    (lambda (w)
      (let1 x (hash-table-get memo w #f)
      (cond (x x)
            (else
              (let1 ret (get-idf w)
              ;(format #t "idf of ~a = ~a\n" w ret)
              (hash-table-put! memo w ret)
              ret)) )))
    ))

  ;; (filename, filename) -> [0, 1]
  (define (cosine-distance f1 f2)
    (let ((A1 (hash-table-get ht f1))
          (A2 (hash-table-get ht f2)))
    (let ((abs-A1 0) (abs-A2 0) (A1*A2 0))
    (hash-table-for-each A1 (lambda (w tf)
      (let1 idf. (idf w)
      (set! A1*A2 (+ A1*A2 (* tf (hash-table-get A2 w 0) idf. idf.)))
      (set! abs-A1 (+ abs-A1 (* tf tf idf. idf.))))))
    (hash-table-for-each A2 (lambda (w tf)
      (let1 idf. (idf w)
      (set! abs-A2 (+ abs-A2 (* tf tf idf. idf.))))))
    (/ A1*A2 (sqrt abs-A1) (sqrt abs-A2)))))

  ;; for all combination, figure out cosine-distance
  (let for ((ls files))
    (cond ((< (length ls) 2) 'done)
          (else
              (let1 f1 (car ls)
              (for-each (lambda (f2)
                (let1 dis (cosine-distance f1 f2)
                  (format #t "~a ~a ~a\n" f1 f2 dis)))
                (cdr ls)))
              (for (cdr ls)))))
  ))
  0)
