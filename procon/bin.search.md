# 二分探索

整数について Yes/No を返す述語 $P$ があるとする.
$$P \colon \mathbb Z \to \mathrm{Bool}$$

そして今, この $P$ はある整数 $m$ があって,

- $n < m \implies P(n) = \mathrm{No}$
- $n \geq m \implies P(n) = \mathrm{Yes}$

を満たすことが分かっているとする.
このとき, この整数 $m$ を求めたい.

ただし, 次のような2つの値 $l, r$ も予め分かっているとする.
すなわち $l$ は十分小さく $P(l) = \mathrm{No}$ を満たし,
$r$ は十分大きく $P(r) = \mathrm{Yes}$ を満たす.

## 解

```rust
// sample P
fn P(n: i64) -> bool {
    n * n * n > 100
}

fn main() {

    let mut left = -10000;  // small enough
    let mut right = 100000;  // large enough

    while left + 2 <= right {
        let mid = (left + right) / 2;
        println!("{:?} {} => {} {}", left, right, mid, P(mid));
        if P(mid) {
            right = mid;
        } else {
            left = mid;
        }
        // condition:
        //   P(left) == false
        //   P(right) == true
    }
    // right is the answer
    println!("The smallest number that satisfies P is {}", right);
}
```


