% fit

fit コマンドを使うとデータ点列を説明 (近似) するような曲線を探索できる.

## SYNOPSIS

```bash
f(x) = g(x, a, b, c)
fit [:][:] f(x) 'data' via a, b, c
```

## 例

正弦曲線を描く Ruby スクリプトをデータの例に使う.

```ruby
# data.rb
def noisy_sin(x)
  return Math.sin(x) + (rand - 0.5) * 0.2
end

100.times do |i|
  x = (i - 50) / 20.0
  puts "#{x} #{noisy_sin x}"
end
```

ランダムなので実行のたびに結果が変わるけど, そこは目をつむってもらって
gnuplot からは `<ruby data.rb` を参照する.

fit コマンドを使うには, このデータを近似する関数を定義する.
ただし関数の定義には自由な変数を使って良い.
例えば下の例では
$f(x) = ax^3+bx+c$
という関数を定義し,
係数に $a,b,c$ という自由変数を含んでいる.

係数には適用な値を代入して初期化しておく.
初期化されてない場合は `1` が自動的に使われるが,
ある程度当たりをつけて良い初期値を入れることは結果の精度の為に大事になってくることがある.

```bash
f(x) = a * x * x * x + b * x + c
a = 1
b = -2
c = 0
```

この `f(x)` を使って fit コマンドを次のように叩く.
`via` キーワードの次に探索して欲しい変数を列挙する.

```bash
fit f(x) '< ruby test.rb' via a, b, c
plot '< ruby test.rb', f(x)
```

fit コマンドが終了した時点で, `a, b, c` には fitting し終えた値が代入されているので,
そのまま `plot f(x)` をすれば, 結果の曲線を描かせることができる.
今回は次のような結果が得られた.

![](https://i.imgur.com/GsL5nx8.png)

`f(x)` は多項式である必要はない.
例えばデータが正弦波っぽく見えたのなら直接正弦波に近似させればよい.

```bash
f(x) = a * sin(b * x + c)
a = 0
b = 0
c = 0
fit f(x) '< ruby test.rb' via a, b, c
plot '< ruby test.rb', f(x)
```

おそらく `a=1, b=1, c=0` に近い値がセットされるはず.
