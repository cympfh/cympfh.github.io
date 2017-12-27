% libsvm
% 機械学習

## 概要

svmの実装といえば、
[libsvm](https://www.csie.ntu.edu.tw/~cjlin/libsvm/)
か
[SVMlight](http://svmlight.joachims.org/)
の2つ (だけじゃないが).

名前通り、確かに後者の方が早い気がする.
それで別に、早いほうが精度が悪いかといえば必ずしもそうではないし.
ただ、オプションの豊富さとか他ツールの豊富さは libsvm だから、
まずこちらを試すのが良いと思う.

### 参考

[http://www.okuma.nuee.nagoya-u.ac.jp/~sakaguti/wiki/index.php?LibSVM](http://www.okuma.nuee.nagoya-u.ac.jp/~sakaguti/wiki/index.php?LibSVM)

## 訓練/テストデータのフォーマット

以下の javascript コードはテストデータ形式にそったテキストを出力する。

```javascript
// test.js
for (var i=0; i<100; ++i) {
  var a = [];
  for (var j=0; j<10; ++j) {
    a[j] = Math.round(Math.random());
  }
  var t = a.reduce(function(x,y){return x+y});
  t = t > 5 ? 1 : -1;
  console.log("%d %s"
           , t
           , a.map(function(x, i){return (i+1)+':'+x}).join(' '));
}
```

## カーネル選択

```
-t <type-number>
```

例えば `-t 0` で線形カーネルを使う.
デフォルトは `-t 2` のrbfカーネル.

## 分割公差検証 (クロスバリデーション)

以下のオプションを持つ。

```
-v <int>
```

`-v 10` で、テストデータを10分割して、
クロスバリデーションをしてくれる.

## 実験

実際に先ほどの `test.js` で事例を作って訓練してみる.

```make
# Makefile
do:
    svm-train -t 0 -v 10 train.scale

train.scale: test.js
    node test.js > train
    svm-scale train > train.scale
```

出力はこうであった

```
(前略)
*.*
optimization finished, #iter = 102
nu = 0.112336
obj = -5.000000, rho = 0.999823
nSV = 38, nBSV = 1
Total nSV = 38
Cross Validation Accuracy = 100%
```

簡単すぎたようだ.

### 入力(の次元)を倍

先程は、訓練データの中の一つのデータは10次元であった.
20次元にしてみる.

```javascript
for (var i=0; i<100; ++i) {
  var a = [];
  for (var j=0; j<20; ++j) {
    a[j] = Math.round(Math.random());
  }
  var t = a.reduce(function(x,y){return x+y});
  t = t > 10 ? 1 : -1;
  console.log("%d %s"
           , t
           , a.map(function(x, i){return (i+1)+':'+x}).join(' '));
}
```

```
$ svm-train -t 0 -v 10 train.scale

(前略)
..........*......................*
optimization finished, #iter = 2885
nu = 0.094086
obj = -4.186700, rho = 0.285305
nSV = 19, nBSV = 0
Total nSV = 19
Cross Validation Accuracy = 99%
```

次元数に余裕があるのがSVMである.

### パリティ (xor)

意味のある訓練データとして、パリティを学習させてみる.
ちなみにパリティは線形分離不能なデータとして定番である.

```javascript
for (var i=0; i<100; ++i) {
  var a = [];
  for (var j=0; j<10; ++j) {
    a[j] = Math.round(Math.random());
  }
  var t = a.reduce(function(x,y){return x+y});
  t = t % 2 ? 1 : -1;
  console.log("%d %s"
           , t
           , a.map(function(x, i){return (i+1)+':'+x}).join(' '));
}
```

### カーネル選択

```
-t 0 : linear
-t 1 : poly
-t 2 : RBF
```

```bash
$ svm-train -t 0 -v 10 train.scale

(前略)
.........*
optimization finished, #iter = 860
nu = 0.669745
obj = -59.094108, rho = 0.338879
nSV = 65, nBSV = 53
Total nSV = 65
Cross Validation Accuracy = 61%
```

*多項式*

```bash
$ svm-train -t 1 -v 10 train.scale

(前略)
.*
optimization finished, #iter = 139
nu = 0.710394
obj = -43.537098, rho = 0.154695
nSV = 81, nBSV = 40
Total nSV = 81
Cross Validation Accuracy = 41%
```

*RBF*


```bash
$ svm-train -t 1 -v 10 train.scale

(前略)
*.*
optimization finished, #iter = 104
nu = 0.778061
obj = -51.085066, rho = 0.243366
nSV = 86, nBSV = 52
Total nSV = 86
Cross Validation Accuracy = 59%
```

### もっと簡単なパリティ

```javascript
for (var i=0; i<100; ++i) {
  var a = [];
  for (var j=0; j<10; ++j) {
    a[j] = Math.round(Math.random());
  }
  var t = a.slice(0,2).reduce(function(x,y){return x+y});
  t = t % 2 ? 1 : -1;
  console.log("%d %s"
           , t
           , a.map(function(x, i){return (i+1)+':'+x}).join(' '));
}
```

10次元のうち、実は2次元で答えが決まっている.

| kernel | linear | poly | RBF |
|:------:|:------:|:------:|:------:|
| Acc.   | 52 % | 62% | 82% |

パラメータをほんとは調整しないとだけど.

## 他の評価尺度を用いる

デフォルトでは Accuracy しか用いない.
[Binary-class Cross Validation with Different Criteria](http://www.csie.ntu.edu.tw/~cjlin/libsvmtools/eval/)
で紹介されてるパッチ(?)で、他の評価尺度として

- 精度
- 再現度
- Fスコア
- BAC
- AUC

が選べるようになる.
ただしコンパイル時点で選ばないといけないけど.


