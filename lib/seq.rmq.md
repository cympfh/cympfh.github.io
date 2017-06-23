% seq.rmq

## Range Maximum (Minimum) Query (RMQ in short)

- ここでは最大値を求めるものを考える
- 最小値が欲しい場合はマイナスをぶち込めば良いと思う

1. `RMQ::new(v)`
    - 長さ $n$ の数列 $v$ を持つ
    - $O(n)$
1. `RMQ::max(l, r)`: $\max \{ v_i : l \leq i \leq r \}$
    - $O(log(n))$
1. `RMQ::update(i, x)`: $v_i \leftarrow x$
    - $O(log(n))$
        - C++ バージョンでは未実装
1. `RMQ::add(i, x)`: $v_i \leftarrow v_i + x$
    - $O(log(n))$
        - C++ バージョンでは未実装

## [seq.rmq.cc](seq.rmq.cc)

@[cpp](seq.rmq.cc)

## [seq.rmq.rs](seq.rmq.rs)

@[rust](seq.rmq.rs)
