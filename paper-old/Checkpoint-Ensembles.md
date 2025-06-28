% [1710.03282] Checkpoint Ensembles: Ensemble Methods from a Single Training Process
% https://arxiv.org/abs/1710.03282
% 深層学習 アンサンブル学習

## 概要

一つの学習の中での異なるチェックポイント時点でのモデルを組み合わせてアンサンブル予測する.

学習の過程で複数の極値が有ってその間を行き来することがある.
そのような場合、一方は入力空間のうちのある部分空間について特に上手く予測が出来、もう一方はまた別のある部分空間については上手く予測が出来る、ということがある.
従ってそれらを組み合わせて何方の空間でも上手く予測ができるモデルを構成しようとするのは自然である (Figure 2B).

また一つの極値に落ち込んでる場合でも、モデルの平均を取ることは過学習を防ぐ意味で有効である (Figure 2A).

## 既存手法

ここでの `train` は early stopping を行い、毎エポック後のモデルの列を返すとする.

```python
def train(early_stop: int) -> List[Model]:
    model = Model()
    models = []
    for epoch in range(Infity):
        model.train()
        if model.early_stop(early_stop):
            break
        models.append(model.copy())
    return models
```

普通NNで使われるのが Minimum validation model selection (MV).
バリデーション用のスコアをチェックポイント毎 (普通エポック毎) に測って、最良のものを一つだけ選んで使う方法.

```python
def validation(models: List[Model]) -> List[float]:
    return [validation_score(m) for m in models]

def best(models: List[Model]) -> Model:
    return min(zip(validation(models), models))[1]

def MV(early_stop: int) -> Model:
    models = train(early_stop)
    return best(models)
```

Last k smoothers (LKS).
smoothing というのは、複数モデルのその重み (パラメータ) の平均を取ることを言う.
LKS ではバリデーションスコアが良いものから固定で k 個取るとする.

Checkpoint smoothers (CS) ではこの k を固定にしないで
$k=\min (a+5,b,n)$
で決める.
ここで $a$ は early stopping round ($a$ エポック連続でバリデーションスコアが向上しなかったら学習を打ち切る).
$b$ はバリデーションスコアが最良を出したときのエポック.
$n$ はトータルのエポック.

```python
def Smoothing(method, early_stop=10) -> Model:

    models = train(early_stop)
    scores = validation(models)
    result = sorted(zip(scores, models))  # 良い順に

    n = len(models)
    b = min(zip(scores, range(1, n + 1)))[1]  # best epoch
    a = early_stop

    if method == LKS:
        k = LKS.k
    else:
        k = min(a + 5, b, n)

    models = models[:k]
    return avg(models)
```

Random initialization ensembles (RIE).
いわゆるアンサンブル学習を行う.
LKS, CS では一回の学習過程を使うけど、今度は k 回学習を回してそれぞれの最良のモデルを選ぶ.
重みの平均を取らず、全て持っておいて、予測のときに予測値の平均を取る.

```python
def RIE(early_stop=10, k=5) -> List[Model]:
    return [best(train(early_stop)) for _ in range(k)]
    return avg(models)

def RIE_predict(models: List[Model], x: Input) -> Output:
    return avg(m.predict(x) for m in models)
```

## 提案手法

Checkpoint Ensembles (CE) は大体 Checkpoint smoothers (CS) と同じだが、最後で重みの平均を取るのではなくて、
すべてのモデルは持っておいて、予測のときに予測値の平均を取る.

```python
def CE(early_stop=10) -> List[Model]:

    models = train(early_stop)
    scores = validation(models)
    result = sorted(zip(scores, models))  # 良い順に

    n = len(models)
    a = early_stop
    b = min(zip(scores, range(1, n + 1)))[1]  # best epoch

    k = min(a + 5, b, n)
    return models[:k]

def CE_predict(models: List[Model], x: Input) -> Output:
    return avg(m.predict(x) for m in models)
```

## 実験

Reuter と CIFAR-10 で実験をして `MV < CE < RIE(k=5)`.

学習時間に糸目を着けないのなら素直に `RIE` したほうが良い.
また学習率を小さくしすぎると `CE` と `MV` の区別がなくなる (悪くなることはない).
