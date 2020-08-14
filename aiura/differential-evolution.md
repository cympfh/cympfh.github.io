% Differential Evolution (差分進化)
% 2018-02-28 (Wed.)
% 最適化

## 参考文献

1. [Differential Evolutionで大域的最適化](http://wildpie.hatenablog.com/entry/20151003/1443863102)
    - わかりやすい
1. [www.sfu.ca/~ssurjano/ackley.html](http://www.sfu.ca/~ssurjano/ackley.html)
    - Ackley 関数の定義が書いてある

Wikipedia は読まなくていいです.

## scipy

scipy に実装があります.

## 実装

勉強のために実装してみた.
参考文献 [1] 先と同様に Ackley 関数上での最適化を試してみる.
下図に示すようにこの関数は $0$ で最小値 $0$ を取るが $\cos$ を重ねているのでいろんなところで極小値を取り,
単純な勾配法だと簡単に局所解に落ち着いてしまう.

![](https://i.imgur.com/7ZqrQmU.png)

注意点として, $0$ のすぐ付近だけだと単純な凸関数で, 実際より簡単な最適化問題になってしまうので, 広い範囲で実験しないと意味がない.
(参考文献 [1] だと $[0,1)$ でしか探索してない?)


```python
import random
from typing import Tuple

import numpy


def Ackley(x: numpy.array) -> float:
    """目的関数"""
    a = 20
    b = 0.2
    c = 2 * numpy.pi
    ret = a - a * numpy.exp(-b * numpy.sqrt(numpy.sum(x ** 2) / len(x))) \
        + numpy.e - numpy.exp(numpy.sum(numpy.cos(c * x)) / len(x))
    return ret


def DE(target, ranges, np=40, cr=0.5, f=0.5, loop=10, verbose=False) -> Tuple[numpy.array, float]:
    """最適化の実行

    Parameters
    ----------
    target: numpy.array -> float
        最小化する目的関数
    ranges: List[Tuple(float, float)]
        パラメータ空間（超区間とする）
    np: int
        num of population
        シードを保存するプールのサイズ
    cr: float
        交叉確率
        assert 0 < cr < 1
    f: float
        交叉のさせ方（混ぜ方）
        assert 0 < f < 1
    loop: int
        ステップ実行回数
    """

    def make_random():
        x = numpy.array([numpy.random.uniform(left, right) for left, right in ranges])
        return x

    xs = [make_random() for _ in range(np)]
    ys = [target(x) for x in xs]
    mini = ys[0]
    min_index = 0

    for _ in range(loop):
        for i in range(np):
            j1, j2, j3 = random.sample(range(np - 1), 3)
            a = xs[(i + j1 + 1) % np]
            b = xs[(i + j2 + 1) % np]
            c = xs[(i + j3 + 1) % np]
            x_new = xs[i] + 0.0
            # cross
            k = random.choice(range(len(ranges)))
            for j in range(len(ranges)):
                if j == k or random.random() < cr:
                    x_new[j] = a[j] + f * (b[j] - c[j])
            x_new = numpy.array(x_new)

            y_new = target(x_new)
            if y_new < ys[i]:
                xs[i] = x_new
                ys[i] = y_new
                if y_new < mini:
                    mini = y_new
                    min_index = i
                    if verbose:
                        print(mini)

    return xs[min_index], ys[min_index]


result = DE(Ackley, [[0, 20], [-100, 100]], loop=100, verbose=True)
print(result)
```

例えば探索範囲を 100 くらいにまで広げると、ループ回数が 10 とかだと全然到達できないが、100 までにしとけば大体安定する.
