% FISSA: Fusing Item Similarity Models
% http://csse.szu.edu.cn/staff/panwk/publications/Conference-RecSys-20-FISSA.pdf
% 推薦システム

## タスク

系列予測としてレコメンドモデルを構築する.
すなわちユーザーの行動履歴（例えばアイテムIDの列）
$$A_1, A_2, \ldots, A_n$$
に対して $A_{n+1}$ を予測する.

## やりたいこと

- 基本的には直前の行動に影響が強く受けているはず
- とは言え系列の情報も残したい

## 手法概要

- ローカル表現
    - 各アイテム、特に系列最後 $A_n$ のベクトル表現 $x$
- グローバル表現
    - 系列全体のベクトル表現 $y$
- この二つの線形和
    - $z = x \ast g + y \ast (1-g)$ を最終的に系列のベクトル表現にする
    - ここで $g$ はゲートと呼ぶ $0 < g < 1$ なる値で, self-attention の要領で, コレ自体も予測する
        - $x, y$ 及び推薦候補の集合から予測する

各アイテム $A_i$ に対するローカル表現 $x_i$ のスコアを
$$z \ast x_i$$
で得る.

## その他

実用を考えると $g$ の計算は大変.
定数にしてしまった実験もやっていて, 性能は落ちるが悪くはない.