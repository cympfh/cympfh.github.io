% Dec a day 2012

## 日記・F# について

考えてみりゃ、関数型だなんて、しかもF#だなんて、
そんな簡単にかける言語で処理まで速いなんて夢を
見過ぎなんだ．

```fsharp
// test.fs
open System

let fib i =
    let rec fib' a b i =
        if i=0 then a else fib' b (a+b) (i-1)
    in
    fib' 0 1 i

for _ in 0 .. 99 do
    ignore <| fib 40

// F# Compiler for F# 3.0 (Open Source Edition)
// real	0m0.018s
// user	0m0.012s
// sys	0m0.004s
```

出力はしてないけどちゃんと計算してるらしい．
fsharpcには三種類ほど最適化オプションが用意
されているが、入れても入れなくてもタイムは
変わらなかったので、全く効果がないか、何も
指定しなければ自動的にオンになるかだ．

```cpp
// test.cpp
#include <cstdio>
int fibsub(int a, int b, int i) {
    if (i==0) return a;
    else return fibsub(b,a+b,i-1);
}
int fib(int i) {
    return fibsub(0,1,i);
}
main() {
    for (int i=0;i<100;++i) fib(40);
    return 0;
}
// /usr/lib/gcc/i686-linux-gnu/4.7/lto-wrapper
// real	0m0.002s
// user	0m0.000s
// sys	0m0.000s
```

素晴らしい．

```scheme
; test.scm
(define (fib i)
    (define (fib* a b i)
        (if (= i 0) a (fib* b (+ a b) (- i 1))))
    (fib* 0 1 i))

(let loop ((i 0))
    (if (< i 100) (begin (fib 40) (loop (+ i 1))) ))

; Gauche scheme shell, version 0.9.1 [utf-8,pthreads], i686-pc-linux-gnu
; real	0m0.013s
; user	0m0.008s
; sys	0m0.004s
```

F#をコンパイルしたより速い．
そういうこともあるかもしれない．

```bash
# stalin でのコンパイル
real	0m0.001s
user	0m0.000s
sys	0m0.000s
```

バカみたいに速い．本当に計算されてるのか、つまり計算結果は
捨ててるのでもしかして除去されてるのではないかと毎回display
させてみると、時間は二倍になってC++とやっと並んだ．

スクリプトとしてそのまま動かしても速いし、
Schemeで書くことにしよう．
