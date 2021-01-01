# int.mod.inv

整数 $a$ と $m$ について
$$a^{-1} \bmod m$$
の存在のための必要十分条件は $a,m$ が互いに素であること.
存在する時, これは拡張ユークリッドの互除法で次のように解ける.

## [int.mod.inv.rs](int.mod.inv.rs)

逆数が存在しない場合は `None` を返す.

@[rust](int.mod.inv.rs)

## [int.mod.inv.cc](int.mod.inv.cc)

@[cpp](int.mod.inv.cc)
