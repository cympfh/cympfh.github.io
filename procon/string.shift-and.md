% Shift-And アルゴリズム

- 文字列 `text`, `pattern` について、`text` 中に `pattern` が部分文字列として初めて出現する位置を返す
    - 大体 $O(n)$
    - Rust では位置を `Option<usize>` とし、出現しない場合を `None` で表現する
    - C++ では `int` で返し、出現しない場合を `-1` で表現する

## [string.shift-and.rs](string.shift-and.rs)

- `pattern` 長がusizeの大きさ (32bit or 64bit) 以下であることを仮定
    - マシン依存

@[rust](string.shift-and.rs)

## Example

```rust
fn test(s: &str, t: &str) {
    let a = String::from(s);
    let b = String::from(t);
    println!("{:?} {:?} {:?}", s, t, shift_and(&a, &b));
}

fn main() {
    test("ABC", "BCX");    // "ABC" "BCX" None
    test("ABC", "BX");     // "ABC" "BX" None
    test("ABC", "X");      // "ABC" "X" None
    test("ABC", "BC");     // "ABC" "BC" Some(1)
    test("ABC", "B");      // "ABC" "B" Some(1)
    test("ABC", "C");      // "ABC" "C" Some(2)
    test("ABC", "AC");     // "ABC" "AC" None
    test("ABC", "AB");     // "ABC" "AB" Some(0)
    test("ABC", "A");      // "ABC" "A" Some(0)
    test("BACABAB", "AB"); // "BACABAB" "AB" Some(3)
}
```

## [string.shift-and.cc](string.shift-and.cc)

- `pattern` 長が32以下であることを仮定
- 64以下なら unsigned long に切り替えればまだ使える

@[cpp](string.shift-and.cc)

## Example

```cpp
void test(string s, string t) {
  auto r = shift_and(s, t);
  cout << s << ' ' << t << ' ' << r << endl;
}

int main()
{
  test("ABC", "BCX");    // ABC BCX -1
  test("ABC", "BX");     // ABC BX -1
  test("ABC", "X");      // ABC X -1
  test("ABC", "BC");     // ABC BC 1
  test("ABC", "B");      // ABC B 1
  test("ABC", "C");      // ABC C 2
  test("ABC", "AC");     // ABC AC -1
  test("ABC", "AB");     // ABC AB 0
  test("ABC", "A");      // ABC A 0
  test("BACABAB", "AB"); // BACABAB AB 3
}
```
