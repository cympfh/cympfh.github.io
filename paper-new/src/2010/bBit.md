% b-Bit minwise hashing
% http://dl.acm.org/citation.cfm?id=1772759
% Jaccard 係数を bit 演算で確率近似する
% ハッシュ

$$resemble(s, t) = \frac{\#(s \cap t)}{\#(s \cup t)}$$

これの利用例として、重複した web page の発見とか．

しかしながら、intersectionなんかに時間がかかりすぎる．

そのためのよくある手法が、Minwise hashing

- $D = \{1 \ldots m\}$
- $S \subseteq D$
- $T \subseteq D$
- $\pi : D \rightarrow D$ -- 置換, bijection

$$Pr ( \min \pi(S) = \min \pi(T) ) = resemble(S, T)$$

その時に、イコールを見るのに、下bビットだけしかcheckしない．

$b = 1$ で十分いい．

$b < 1$ の場合も考えられる．
例えば、2bitをxorなどで1bitに圧縮して、その1bitを見る？？？？？
いみふ
