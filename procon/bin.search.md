# 二分探索

Yes/No を返す述語があるとする.

```cpp
bool Prop(){}
```

## 問題

整数 $n$ について, `Prop` が Yes と返す最小値を求めよ.

ただし、`Prop` には次の性質があることを仮定する.

- ある整数 $m$ があって
    - $\forall n < m, \mathrm{Prop}(n) = \mathrm{No}$
    - $\forall n \geq m, \mathrm{Prop}(n) = \mathrm{Yes}$

ただし既知の $\mathrm{sub}, \mathrm{sup}$ があって,

- $\mathrm{Prop}(\mathrm{sub}) = \mathrm{No}$
- $\mathrm{Prop}(\mathrm{sup}) = \mathrm{Yes}$

であることは分かっているとする.

## 解

```cpp
int left = sub;
int right = sup;

while (left + 2 < right) { // 2 is a magic
  assert( not Prop(left) );
  assert( Prop(right) );
  int mid = (left + right) / 2;
  if (Prop(mid)) {
    right = mid; // because of the assertion
  } else {
    left = mid;
  }
}

int ans = left;
for (; ans <= sup and ans < right + 2; ++ans) {
  if (Prop(ans)) break;
}
```


