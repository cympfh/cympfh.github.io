% X g day 2012

## readは遅い

Haskellのreadは[Char]を任意の型の値にパースするから
普通に考えれば普通の関数ではなさそう。型クラスで
云々すればちゃんとした関数として定義できるそうだけど、
例えばIntにするとわかっていれば、自前でパースするのに
比べれば遅いだろう。しかしどうせreadする時には一緒に
型も指定するのだから、あんまり構造的でない型、Intみたいな
基本的な型についてはそれ用のreadがあってもいい。実際
あるのかな。

とりあえず、ただのreadで"123"を123に変換することを10万回
やってみる。私のPCはあんまり良いものでないので、この位の
回数で時間を測るのがちょうどよかった。

コンパイルして実行するが、最適化はわざとしてない。

```haskell
-- read_times.hs
a = "123"
n = 100000
main = print reads
  where
    reads :: [Int]
    reads = map (\x -> read a) [0 .. n] 
```

```bash
$ time ./test > /dev/null

real	0m1.121s
user	0m1.056s
sys	0m0.024s
```

これで(n+1)回、aをreadしてることになるだろう。
具体的に出力してみないと評価してくれないので、
実行の際には/dev/nullに捨ててる。出力自体の
時間なんて測りたくないので。

次は自前のパース。先頭から一文字ずつdigitToIntしてる。
これのために最初にimportがある。

```haskell
-- read_times2.hs
import Data.Char
a = "123"
n = 100000

main = print reads
  where
    reads :: [Int]
    reads = map (\x -> read_int a) [0 .. n]
    read_int str = read_int' str 0
      where
        read_int' [] ac = ac
        read_int' (s:ss) ac = read_int' ss (ac*10+digitToInt s)
```

```bash
$ time ./test > /dev/null

real	0m0.109s
user	0m0.072s
sys	0m0.004s
```

3行くらい長くなったけど、時間は1/10になった。すごい

readのtoInt専用の何かがあるかちょっと調べてみたけど
見つからなかった。あんまり探す気なかったけど。
