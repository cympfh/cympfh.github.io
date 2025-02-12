% Aitken 加速
% 2017-02-14 (Tue.)
% 数値計算

## 概要・加速法とは何か

収束する数列
$$a_1, a_2, \ldots, a_N, \ldots$$

があるときに、その収束値 $\alpha = a_\infty$ を知りたい.
**加速法** は、元の数列よりもその収束が速い数列
$$a_1', a_2', \ldots, a_N', \ldots$$

を作る手法を言う.

$a_n$ の値の計算が定数時間でしかないのなら、
$a_1, a_2, a_3, \ldots$ と計算する代わりに
(例えば)
$a_1, a_4, a_9, \ldots$ と計算すれば、加速するじゃんってことなのだけど、
例えば、 $a_n$ は漸化式で計算できない等の理由によって、$a_n$ の値の計算に $O(n)$ の時間が掛かる等、
何かそういう理由で、無限列の中の有限の断片
$$a_1, a_2, \ldots, a_N$$
しか手に入らないと仮定してるのだと思う.
たぶん.

## Richardson 加速

収束していく様子を凡そ次で近似する:

$$a_n \sim \alpha + \beta \gamma^n$$

ここで $\alpha$ が実際の収束値で、$\gamma$ は大きさが $1$ 未満の値であって、
$n \to \infty$ に対してこれが $0$ に収束する.

今、都合よく右辺の $\gamma$ だけが既知だとすると (これは結構強い仮定だが)、

- $a_n \sim \alpha + \beta \gamma^n$
    - $\gamma a_n \sim \gamma \alpha + \beta \gamma^{n+1}$
- $a_{n+1} \sim \alpha + \beta \gamma^{n+1}$

から

$$\alpha \sim \frac{a_{n+1} - \gamma a_n}{1 - \gamma}$$

を得る.
この右辺は $a_n$ よりもずっと $\alpha$ そのものに近い.
というわけで

$$a_n' = \frac{a_{n+1} - \gamma a_n}{1 - \gamma}$$

と定めた時に

$$a_1', a_2', \ldots, a_N', \ldots$$

は元の数列よりも収束に近づいていそう (常にではないが).

また、$a_n'$ の計算コストは $a_n$ を計算する時間の二倍でしかないし、
というか $a_1, \ldots, a_N$ を初めに全て計算してメモしておけば、計算時間は、差を取って割り算する分しか増えない.

## Aitken 加速

Aitken 加速は、Richardson 加速で既知だと仮定していた $\gamma$ も推定する.
2つの未知変数 ($\alpha, \beta$) を消すために3つ用意して弄る.
すなわち、

- $a_n \sim \alpha + \beta \gamma^n$
- $a_{n+1} \sim \alpha + \beta \gamma^{n+1}$
- $a_{n+2} \sim \alpha + \beta \gamma^{n+2}$

から、

$$\frac{a_{n+2} - a_{n+1}}{a_{n+1} - a_n} \sim \gamma$$

を得る.

これを、Richardson 加速の結果に代入すると、

$$\begin{align}
a_n' & = \frac{a_{n+1} - \gamma a_n}{1 - \gamma} \\
& = a_n - \frac{(a_{n+1} - a_n)^2}{a_{n+2} - 2a_{n+1} + a_n}
\end{align}$$

を得る.
この方法によって、数列 $\{a_n\}$ から $\{a_n'\}$ を得る方法を **Aitken 加速** という.
特にこの方法は繰り返し適用できる.
すなわち、$\{a_n'\}$ から $\{a_n''\}$ を構成し、更なる加速が期待できる.
$k$ 回 Aitken 加速を繰り返し適用したものを、$k$ 段のAitken加速列 $\{a_n^k\}$ という.
特に $\{a_n\} = \{a_n^0\}$ である.

## Aitken 加速の実装

初めに述べたように、
有限の断片
$a_1, a_2, \ldots, a_N$
しか手に入らない場合を考える.

また、一回の Aitken 加速は、元の数列の連続した3つの成分から一つの成分を作るので、
数列の長さは 2 ずつ減る.
従って、$N/2$ 段階程度しか繰り返しの加速は適用できない.

$k$ 段階 加速列の第 $n$ 成分をメモして利用していく.

実装は Scheme (R5RS) で行い、処理系は Gauche を用いた.

```scheme
; リストとして与えた有限長の数列を Aitken 加速する
(define (accell ls)

  (define return (list ls))
  (define n (length ls))

  ; k 段の第 n 成分 を (memo-get (cons k n)) に置くメモ
  ; k = 0 には元の数列の値を入れて初期化する
  (define memo (make-hash-table 'equal?))
  (define (memo-get key) (hash-table-get memo key #f))
  (define (memo-put! key val) (hash-table-put! memo key val))

  ; 数列 a の k 段 第 n 成分 の計算
  (define (accell-get k n)

    (let ((i   (memo-get (cons (- k 1) n)))
          (i+1 (memo-get (cons (- k 1) (+ n 1))))
          (i+2 (memo-get (cons (- k 1) (+ n 2)))))

      (- i
         (/
           (expt (- i+1 i) 2)
           (+ i+2 (- (* 2 i+1)) i)))))

  ; 初期化
  (for-each (lambda (i val) (memo-put! (cons 0 i) val))
            (iota n) ls)

  ; k 段加速列を求める
  ; len は k-1 段加速列の長さ (3以上必要)
  (let loop-k ((k 1) (len n))
    (if (>= len 3)
      (begin
        (let ((k-list (map (lambda (i) (accell-get k i)) (iota (- len 2)))))
            ; memo
            (for-each (lambda (i val) (memo-put! (cons k i) val))
                      (iota (- len 2)) k-list)
            ; append to return
            (set! return (cons k-list return))
            (loop-k (+ k 1) (- len 2))))
      (reverse return))))
```

## Aitken 加速のテスト

これを実際に使ってみる.

$$a_i = \sum_{i=1}^n \frac{1}{i^2}$$

という数列の初めの 20 個だけがある時にこの数列の収束を加速する.

```scheme
; 元の数列 a_n
(define (a n) (exact->inexact (apply + (map (lambda (i) (/ 1 i i)) (iota n 1)))))

(define (main)
  (let* ((ls (map a (iota 20)))
         (accelled (accell ls)))

    (for-each print accelled)))

(main)
```

出力は次のようになった.
第 $k$ 行の $i$ 個目が $k$ 段階の $i$ 成分の値である ($i=0,1,\ldots$)

```
(0.0 1.0 1.25 1.3611111111111112 1.4236111111111112 1.4636111111111112 1.4913888888888889 1.511797052154195 1.527422052154195 1.5397677311665408 1.5497677311665408 1.558032193976458 1.5649766384209025 1.5708937981842162 1.5759958390005426 1.580440283444987 1.584346533444987 1.587806741057444 1.5908931608105303 1.5936632439130232)
(1.3333333333333333 1.4500000000000002 1.503968253968254 1.5347222222222225 1.554520202020201 1.5683119658119669 1.5784637188208614 1.586245581565961 1.5923993101139085 1.5973867787855873 1.601510454846023 1.6049766384209048 1.6079308352212494 1.6104785976212364 1.6126983479611146 1.6146495637480214 1.61637816962887 1.6179201878375327)
(1.5504219409282693 1.5754646587979944 1.5902960706837768 1.5999812811164984 1.6067762968051236 1.6117984051328198 1.615658065508923 1.6187155102777195 1.6211965508256334 1.6232497424316008 1.6249767418133803 1.6264494240106278 1.6277200260352533 1.628827415368778 1.629801104592609 1.6306639030465382)
(1.6118379556171667 1.618208958750515 1.622751773303022 1.6260245133948446 1.628473244200103 1.6303681986935261 1.6318757963574695 1.6331027427724136 1.6341202058309288 1.634977329264381 1.6357090804983214 1.6363409924548054 1.6368921287269687 1.6373770061547686)
(1.6340400858298227 1.6344577415560138 1.63575020412567 1.6368525001260705 1.6377433854726031 1.6384666864944257 1.6390620355451848 1.6395592320840038 1.6399800422462878 1.6403405478494382 1.6406525572897073 1.6409253040801053)
(1.6338406860344015 1.6432419327022334 1.641497579909569 1.6415884842465425 1.6418321413066959 1.6420778064263943 1.6422982722856518 1.6424956799285038 1.6426599303483833 1.6428200007426248)
(1.6417705815256831 1.6415839815540603 1.6414434820296193 1.6120232439588271 1.6442271064755278 1.6441857402857707 1.6434735750994256 1.648949755277927)
(1.6410152840928347 1.6415846557443825 1.6273978343059143 1.644185793352898 1.6442296574060804 1.6441037831190743)
(1.6410372534500808 1.6350869211560288 1.6442297723155552 1.644197128771634)
(1.6386913961616871 1.644197244907166)
```

0 行目が元の数列であるが、これを見ただけではまさか収束値が 1.6 を超えるようには見えない.
最後の行を見ると、1.64 くらいを定めそうである.

ちなみに正しい収束値は

$$\frac{\pi^2}{6} = 1.644934066848226\ldots$$

である.

