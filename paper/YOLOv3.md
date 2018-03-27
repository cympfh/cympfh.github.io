% YOLOv3
% https://pjreddie.com/media/files/papers/YOLOv3.pdf
% 物体検出 読みかけ

# links

- [paper](https://pjreddie.com/media/files/papers/YOLOv3.pdf)
- [project page](https://pjreddie.com/darknet/yolo/)

# 概要

YOLO のアップデートに関するテクニカルレポート.
以前のものよりも遅くはなったが、より正確になった.
他の手法と比較すると以前として高速で精度も同等以上に良い.

# 方法

## Bounding Box Prediction

YOLO9000と同様.
画像をセルに分割し、各セルを入力として
ネットワークは4パラメータ
$(t_x, t_y, t_w, t_h)$
を予測する.
これを次のようにして、bounding box に変換する.
意味としては、そのセルに含まれる物体の、その領域の予測.

セルの左上の座標 が $(c_x, c_y)$ であるとする.
また、事前知識として bounding box の幅と高さの目安 $(p_w, p_h)$ を持っておいて、

- $b_x = \sigma(t_x) + c_x$
- $b_y = \sigma(t_y) + c_y$
- $b_w = p_w e^{t_w}$
- $b_h = p_h e^{t_h}$

とする.
bounding box の **中心* を座標 $(b_x, b_y)$ とし、幅高さが $(b_w, b_h)$ な領域を bounding box として解釈する.
教師データはこれを逆算して $t$ を計算する.

> v2 の論文読めばどっかに書いてるのかもだけど、全体の画像サイズを $1.0 \times 1.0$ にリサイズしてから計算してると思う.
> なので, $0 \leq b_x,b_y, b_w,b_h \leq 1$.

- 相対座標であること、中心 (そこに物体がある) を予測すること
    - セル (例えば7x7) は領域より小さいサイズを想定していて (?) その領域の中の相対的な場所を学習すること

v3 では、目的関数に logistic 回帰を使う.
セルが正しい領域に重なっていない場合は

つかれた
