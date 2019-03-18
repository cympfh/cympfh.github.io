# 私の二分探索の書き方

Yes/No を返す述語があるとする.

```cpp
bool Prop(){}
```

## 問題

整数 $n$ (ただし $sub \leq n \leq sup$ は事前に分かっているものとする)
について、
`Prop` が Yes と返す最小値を求めよ.

ただし、`Prop` には次の性質があることを仮定する.

- ある整数 $m$ があって
    - $m$ 未満の整数 $n$ については `Prop` は No を返す
    - $m$ 以上の整数 $n$ については `Prop` は Yes を返す

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


