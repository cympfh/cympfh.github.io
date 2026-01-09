# 代数 - (乗法)群と加法群

積に関する群 $(X,\times,1)$ を `Group` の名前で [Monoid](algebra.monoid) の拡張として定義する.

- 演算: `std::ops::Mul`
- 単位元: `Monoid::one()`
- 逆元: `Group::inv()`

和に関する群 $(X,+,0)$ を `AGroup` (Additive Group) の名前で定義する.

- 演算: `std::ops::Add`
- 単位元: `AGroup::zero()`
- 逆元: `std::ops::neg`

`AGroup` を加法群と呼ぶが, これは演算と単位元が和に関するものであること以外は `Group` と同じである.

## `agroup!` マクロ

マクロ `agroup!` はユーザーが定義した型を手早く加法群にする.
`agroup!` は `add_assign`, `sub`, `sub_assign`, `sum` を自動で定義する.

```rust
agroup! {
    MyStruct<X> where [X: Copy + ...] ;
    zero = MyStruct(0) ;
    add(self, other) = { ... } ;
    neg(self) = { ... } ;
}
```

## 実装
@[rust](procon-rs/src/algebra/group.rs)
@[rust](procon-rs/src/algebra/group_additive.rs)
