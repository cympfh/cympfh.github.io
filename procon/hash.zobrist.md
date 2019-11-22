# Zobrist Hash

## 手法

状態を集合だとして説明する.

有限の母集合 $U$ があって, 状態はこれの部分集合 $X \subset U$ として与えられるとする.
このとき Zobrist Hash は $U$ の各要素にランダムな整数値を割り当てておき $X$ のハッシュを要素の値の XOR で表現する.

```python
# init
for x in U:
    h[x] = random()

def hash(X):
    return xor(h[x] for x in X)
```

## 適用

チェスのような盤面の状態のハッシュ化によく用いられる.
これを今の枠組みに当てはめるためには, $U$ として座標情報とコマの組の集合を用いれば良い.

- $U = \{ (pos, piece) \}$

局面はこの座標にこのコマがおいてあるという要素を全て集めた集合とすれば $U$ の部分集合になる.

## 参考

- [en.wikipedia.org/wiki/Zobrist_hashing](https://en.wikipedia.org/wiki/Zobrist_hashing)
