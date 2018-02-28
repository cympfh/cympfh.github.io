% Differential Evolution (差分進化)
% 2018-02-28 (Wed.)
% 最適化

## 参考文献

1. [Differential Evolutionで大域的最適化](http://wildpie.hatenablog.com/entry/20151003/1443863102)
    - わかりやすい
1. [http://www.sfu.ca/~ssurjano/ackley.html](http://www.sfu.ca/~ssurjano/ackley.html)
    - Ackley 関数の定義が書いてある

Wikipedia は読まなくていいです.

## scipy

scipy に実装があります.

## 実装

勉強のために実装してみた.
参考文献 [1] 先と同様に Ackley 関数を最適化してみる.
この関数は少し外だと基本 cos なので勾配法だと死ぬ.

見たとおり Ackley 関数はゼロで最小なのだが、この少し周りだと全然ただの凸関数になってるので、
初めからゼロ付近に検討を付けて最適化を始めると実際より簡単になってしまう.
(参考文献 [1] だと $[0,1)$ でしか探索してない?)


```python
import random
from typing import Tuple

import numpy


def Ackley(x: numpy.array) -> float:
    a = 20
    b = 0.2
    c = 2 * numpy.pi
    ret = a - a * numpy.exp(-b * numpy.sqrt(numpy.sum(x ** 2) / len(x))) \
        + numpy.e - numpy.exp(numpy.sum(numpy.cos(c * x)) / len(x))
    return ret


def DE(target, ranges, np=40, cr=0.5, f=0.5, loop=10, verbose=False) -> Tuple[numpy.array, float]:

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
            a = xs[(j1 + 1) % np]
            b = xs[(j2 + 1) % np]
            c = xs[(j3 + 1) % np]
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
