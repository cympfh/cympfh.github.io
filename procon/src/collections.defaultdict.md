# collections - defaultdict

参照しようとしたキーが存在しない場合に,
あらかじめ指定したデフォルト値で初期化してくれる辞書型.

## 参考

- [Python3 - collections.defaultdict](https://docs.python.org/ja/3/library/collections.html#collections.defaultdict)

## 使い方

```rust
fn main() {
    let mut m = DefaultDict::new(0);

    println!("{:?}", m[0]); // この時点でキー0が存在しないため, 0で初期化される

    m[1] += 5; // キー1が存在しないため, 0で初期化された後に5が加算される
    println!("{:?}", m[1]); // 5
}
```

## 実装

@[rust](procon-rs/src/collections/defaultdict.rs)
