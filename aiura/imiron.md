% 現代意味論入門の読書メモ
% 2016-11-11 (Sun.)
% 言語 意味論
% 現代意味論入門の読書メモです

## INDEX

<div id=toc></div>

## テキスト

- 吉本啓, 中村裕昭: "現代意味論入門"
    - "現代意味論入門" では、人間がコミュニケーションの目的に用いる自然言語を、一回述語論理といった形式言語に翻訳し、意味を与える一連の手続きを解説している.
というかまあ意味ありきの形式言語だけど.
論理のための形式言語はシンタックス (統辞論) と解釈 (意味論) から成る.
翻訳とは自然言語からシンタックスへの変換であり、これは人間が手作業で行う.
シンタックスから意味への解釈は機械的にも可能なよう形式的に定義がなされる.

## 可能世界意味論

"雪が降っている" には真偽が与えられるのに対して "雪が降っているかもしれない" には普通の述語論理の枠組みでは真偽が与えにくい.
"可能世界 (possible world)" という概念によってこれが可能となる.
ここで言う世界とは変数への真偽割当のことであり、普通の述語論理では世界がただ一通りしかないのに対して、複数あり得るとする.
"かもしれない" は、真となるような世界が少なくとも一つはある、と言っていると解釈する.

### 様相論理

述語論理に **到達 (accessible)** 可能世界及び2つの演算子

1. $\Box$: 必然性, necessity
1. $\Diamond$: 可能性, possibility

を導入する.

話している今の世界 $w$ から到達可能な (唯一つとは限らない) 世界 $w_1, w_2, \ldots w_n$ を到達可能世界といい、
この関係を $R$ とし、 **フレーム** と呼ぶ.
即ち $R$ とは、
あり得る世界全体を $\mathcal{W}$ としたとき、$\mathcal{W} \times \mathcal{W}$ の部分集合である.
例えば $w$ から $w'$ に到達可能であることを $w R w'$ と書く.

そして演算子の定義は次のようである.

1. $\Box \phi$ は到達可能な全ての世界で $\phi$ が真となること
1. $\Diamond \phi$ は到達可能な少なくとも一つの世界で $\phi$ が真となること

### フレームに関する諸性質

フレームに関して次のような性質が考えられる.
これは、こういうバリエーションが考えられるというだけであって、別に制限を与えるわけではない.

1. 再帰性 (reflexivity)
    - $\forall w, wRw$ であること. この性質と $\Box p \rightarrow p$ とは同値.
2. 対称性 (symmetry)
    - $w_1 R w_2$ ならば $w_2 R w_1$ であるような性質で、$\Diamond \Box \phi \rightarrow \phi$ と同値.
3. 推移性 (transivity)
    - $w_1 R w_2 \land w_2 R w_3 \rightarrow w_1 R w_3$ であることで、$\Box \phi \rightarrow \Box \Box \phi$ と同値.
    - _N.B._ "到達可能" という言葉からついついこの性質を暗黙に仮定しがちだが、これが成り立たないフレームも考えられるということ

ところで我々が日常会話をする際に、そんな難しいことを考えることは滅多にない.
これは、任意の世界から任意の世界へ到達可能 (普遍的到達関係) なフレームを前提にしているから.

## 内包的文脈

動詞について内包的/外延的の区別がある.
「信じる」や「探す」は内包性を伴う目的語や補文をとるので内包的である.
「知る」や「見る」は外延的である.

> その肝心の「内包性」ってなんやねんという感じだが、それは下の意味論を読んで理解すればいいことである.

"神の存在を信じる" は "神の存在" を目的語にとっているが、それの真偽に関わらず "を信じる" をつければ真になり得る.
一方で、"を見る" だと、神の存在が偽のとき、"を見る" も偽に成る.

この内包を表現するのに可能世界の概念を利用する.

## 内包論理 (内包タイプ理論)

内包の概念を導入した内包論理はいくつかバリエーションがあるが、
ここではモンタギュー意味論にも使われるバージョンを説明する.
これはモンタギュー自身が "The Proper Treatment of Quantifinication in Ordinary English" (PTQ in short) [Montague, 1973] の中で提案したもので、
このテキストの中ではこの論理体系のことを PTQ と呼ぶ.


この論理においてシンタックスの正しい一つの式を $\text{ME}$ (meaning expression) と呼ぶ.
これはいわゆる整式 (well-formed formulae) に相当する.
型がついている.
$\text{ME}$ 一つにはタイプ $a$ が対応づいている.
タイプ $a$ 全体を $\text{ME}_a$ と書く.
例えば $\text{ME}$ $\phi$ がタイプ $a$ を持つことを $\phi \in \text{ME}_a$ で表す.

あと$\text{ME}$ であるものとして、変数および定数がある.
変数全体を $\text{VAR}$、定数全体を $\text{CON}$ で表す.
$\text{ME}$ 同様に、型を右下に添えて $\text{VAR}_a, \text{CON}_a$ などと書く.

### シンタックス

$\text{ME}$ のシンタックスを定義する前に簡単にタイプを定義する.

1. $s, t$ はタイプである
1. $a, b$ がタイプならば $(a,b)$ もタイプである
1. この2つで定められるもののみがタイプである

では $\text{ME}$ の型付規則と共にシンタックスを定義する.

1. $\alpha \in \text{VAR}_a \cup \text{CON}_a$ ならば $\alpha \in \text{ME}_a$
1. $\alpha \in \text{ME}_a, u \in \text{VAR}_b$ ならば $\lambda u. \alpha \in \text{ME}_{(b,a)}$
1. $\alpha \in \text{ME}_{(b, a)}, \beta \in \text{VAR}_b$ ならば $\alpha(\beta) \in \text{ME}_a$
1. $\alpha, \beta \in \text{ME}_a$ なら $(\alpha = \beta) \in \text{ME}_t$ ($t$ は真偽値を表すタイプ)
1. $\phi, \psi \in \text{ME}_t, u \in \text{VAR}_b$ なら次は全て $\text{ME}_t$
    - $\lnot \phi$
    - $\phi \land \psi$
    - $\phi \lor \psi$
    - $\phi \rightarrow \psi$
    - $\phi \leftrightarrow \psi$
    - $\exists u, \phi$
    - $\forall u, \phi$
    - $\Box u, \phi$
    - $\Diamond u, \phi$
1. $\alpha \in \text{ME}_a$ なら $\uparrow \alpha \in \text{ME}_{(s, a)}$
1. $\alpha \in \text{ME}_{(s, a)}$ なら $\downarrow \alpha \in \text{ME}_a$

$\uparrow \alpha$ であるがこれはタイプを見ると分かるように $s$ を受け取る関数である.
$s$ は可能世界のタイプで、上に出てくるいずれにも付かないタイプである.

### 意味論

$\text{ME}$ $\phi$ の解釈を $[\![\phi]\!]$ と書く.  $[\![ \_ ]\!]$ は解釈関数.
特に世界 $w$ における解釈を $[\![\phi]\!]_w$ と書いたり、変数割当 $u=a$ における解釈を $[\![\phi]\!]_{u=a}$ などと書くことにします.
あとタイプ $a$ の $\text{ME}$ を解釈して得られる値全体を解釈領域 $D_a$ と書く.

1. $\alpha \in \text{CON}_a$ (定数) のとき $[\![\alpha]\!]_w$ は$w$ に基づいて解釈する (これは世界に依存)
1. $\alpha \in \text{VAR}_a$ (変数) のとき $[\![\alpha]\!]$ は適当にその文脈に基づいて解釈する (これは世界から切り離されてる)
1. $\alpha \in \text{ME}_a, u \in \text{ME}_b$ のとき $[\![\lambda u. \alpha]\!]_w$ は
    - $d \in D_b$ を $[\![\alpha]\!]_{w, u=d}$ に写す関数
    - 簡単に $\lambda d. [\![ \alpha]\!]_{w, u=d}$ と書く
1. $\alpha \in \text{ME}_{(a,b)}, \beta \in \text{ME}_a$ のとき $[\![\alpha(\beta)]\!] = [\![\alpha]\!]([\![\beta]\!])$
1. $\alpha \in \text{ME}_a$ のとき $[\![\alpha=\beta]\!]$ は
    - $[\![\alpha]\!] = [\![\beta]\!]$ のとき $1$
    - さもなくば $0$
1. $[\![\lnot \phi]\!]$
    - 同様
1. $[\![\phi \land \psi]\!]$
1. $[\![\phi \lor \psi]\!]$
1. $[\![\phi \rightarrow \psi]\!]$
1. $[\![\phi \leftrightarrow \psi]\!]$
1. $[\![\exists u, \phi]\!]$
1. $[\![\forall u, \phi]\!]$
1. $\phi \in \text{ME}_t$ のとき $[\![\Box \phi]\!]$ は
    - 全ての $w \in \mathcal{W}$ について $[\![\phi]\!]_w$ が $1$ ならば $1$
    - さもなくば $0$
1. $\phi \in \text{ME}_t$ のとき $[\![\Diamond \phi]\!]$ は
    - ある $w$ で $[\![\phi]\!]_w = 1$ ならば $1$
    - さもなくば $0$
1. $[\![\uparrow \alpha]\!]$ は次のような関数
    - 世界 $w \in \mathcal{W}$ を $[\![\alpha]\!]_w$ に写す関数
1. $[\![\downarrow \alpha]\!]_w = ([\![\alpha]\!])(w)$

また解釈領域はある程度、具体的に書けて

1. $D_t = \{0, 1\}$
1. $D_{(a,b)} = D_b^{D_a} = \{(x,y): x \in D_a, y \in D_b\}$

注意事項としては、$s$ という型は世界 $w$ に特別に与えたものであるが、$s$ を基本型として与えたわけではない.
すなわち $s$ という型を持つ $\text{ME}$ は定められていない.

### 諸性質

$\phi$ という述語についてこれの内包 $\uparrow \phi$ を、内包論理では **属性 (property)** という.

属性のある世界への適用は $\downarrow \uparrow \phi$ であるが、一般に $[\![ \downarrow \uparrow \phi ]\!] = [\![\phi]\!]$ である.
これを down-up cancellation という.

$[\![ \uparrow \downarrow \phi ]\!] = [\![\phi]\!]$ は一般には **成り立たない**.

反例として、

- $\alpha = \lambda w. A$
- $A$ は定数
    - 世界 $u$ では $A=0$
    - 世界 $v$ では $A=1$

とする.
イコールを仮定する.

- $[\![\alpha]\!]_u = [\![\uparrow \downarrow \alpha]\!]_u$
- $= \lambda w. [\![\downarrow \alpha]\!]_w = \lambda w. [\![\alpha]\!]_w(w)$
- $\implies$ (両辺に $v$ を適用)
- $0 = [\![A]\!]_u = [\![\alpha]\!]_u(v) = (\lambda w [\![\alpha]\!]_w(w))(v) = [\![\alpha]\!]_v(v) = [\![A]\!]_v = 1$

定数関数を評価するタイミングにおける世界が異なるのが原因.
(thanks to @autotaker1984)

## two-sorted type theory

上でも注意事項として書いたように、PTQ では $s$ を基本型として与えていなかったが、それを認める論理も考えられる.
two-sorted type theory では PTQ に
$w \in \mathcal{W} = \text{ME}_s = D_s$
を加える.

この論理では内包論理に少し変更を加えることで述語論理と等しい表現力を持っていることが確認できる.
すなわち $\uparrow$ とか $\Diamond$ などという演算子は不要になる.

1. $\uparrow \phi \equiv \lambda w. \phi_w$
1. $\downarrow \phi \equiv \phi(w)$
1. $\Box \phi \equiv \forall w. \phi_w$
1. $\Diamond \phi \equiv \exists w. \phi_w$
1. $[\![\phi_w]\!]_v = [\![\phi]\!]_w$

## neo-Davidsonian approach (新 Davidson 方式)

「$b$が$c$を殺す」という述語を意味する $\text{KILL}(b,c)$ と作ったとして、
「$b$が$c$を$k$を用いて殺す」という述語を作りたくなったので $\text{KILL}(b,c,k)$ としたとする.
同じ字面を用いたとしても２つは異なる集合であり、次のような自然な推論:

$$\text{KILL}(b,c,k) \rightarrow \text{KILL}(b,c)$$

を導くような関係を二項演算$\text{KILL}$と三項演算$\text{KILL}$との間に定めたい.
或いは「何で」以外にも、「何処で」を付け足そうと思うと新しい述語を作る必要が出てくる.

[Davidson 1967] では最低限の引数として主語目的語以外のコンテキストを **イベント** と呼んで、これら3つの引数をいつも取るように $\text{KILL}(b,c,e)$ と設計する.
「何で」は $e$ の中に含まれてる情報だとして、それを取り出す述語 $\text{INSTRUCT}$ を用いる.
「$b$が$c$を$k$で殺す」を「$b$が$c$を殺す、かつ、$k$ で」と読み替えて、

$$\text{KILL}(b,c,e) \land \text{INSTRUCT}(e,k)$$

と翻訳する.
単に「殺す」は

$$\text{KILL}(b,c,e)$$

と書ける.
ただの連言だから

$$\text{KILL}(b,c,e) \land \text{INSTRUCT}(e,k) \rightarrow \text{KILL}(b,c,e)$$

は自然に導ける.

このように、あらゆる述語について引数を一つ増やしていつもイベント $e$ を受け取るようにした意味論をイベント意味論 (event semantics) と呼ぶ.
[Parsons, 1990] はこれをさらに推し進め、動詞はイベントのみを受け取る一項演算子で、他はイベントから一属性を確認するだけの二項演算子にした.
これを neo-Davidsonian approach という.

「殺した、主体が$a$で、対象が$b$で、手段が$c$」を

$$\text{KILL}(e) \land \text{AGENT}(e,a) \land \text{PATIEND}(e,c) \land \text{INSTRUCT}(e,k)$$

と翻訳する.
但しこれらは結局、述語論理と同等の表現力しかない.

## モンタギュー意味論 (Montague Semantics)

自然言語と述語論理との間には大きな隔たりがあった.
モンタギューは自然言語も形式言語の一つとして扱い、自然言語にも形式言語同様の解釈を与えることを目指した.
本章はPTQ [Montague, 1973] で採択された方法を説明する.
これでは自然言語は内包論理に翻訳され、内包論理について意味論が定義される.

> "English as a Formal Language (EFL) [Montague, 1970] では自然言語に対して直接意味論を定義することを試みられた.

### 構成性原理 (フレーゲの原理)

複雑な表現の解釈は部分の解釈の関数である.

これは即ち、
2つの語句 $\alpha, \beta$ をシンタックスの上で結合させた $F(\alpha, \beta)$ の解釈
$[\![F(\alpha, \beta)]\!]$
は適当な関数 $G$ があって
$$[\![F(\alpha, \beta)]\!] = G([\![\alpha]\!], [\![\beta]\!])$$
となることを言っている.
$[\![ \_ ]\!]$ の準同型とも言える.

モンタギュー意味論では文法 $F_i$ について($i$ は適当な添字) $G_i$ を具体的に構成していく.

### 名詞句の解釈

"John runs", "Some boys run", "Every boy runs"
を次のように解釈することにする.

- $[\![\text{run}]\!] \in [\![\text{John}]\!]$
- $[\![\text{run}]\!] \in [\![\text{some}~\text{boys}]\!]$
- $[\![\text{run}]\!] \in [\![\text{every}~\text{boy}]\!]$

これは述語論理における述語の解釈と逆である (述語論理なら $[\![\text{John}]\!] \in [\![\text{run}]\!]$).
これは量子化を上手く扱うために都合が良い.

John の解釈は、述語論理では単に個体 $a$ としていた.
モンタギュー意味論ではジョンに体操する個体 $a$ という記号を使いながらも、Johnの解釈自体は
「$a$ が成り立つ述語全体」としている.

例えば

(個人に対応する) 個体 $a, b, c$ に関する述語として $BOY, RUN, SING$ があるとする.
述語論理同様、述語は、それを満たす個体の集合である.

- $[\![\text{BOY}]\!] = \{ a,b,c \}$
- $[\![\text{RUN}]\!] = \{ a,b \}$
- $[\![\text{SING}]\!] = \{ b,c \}$

例えば $a$ が $\text{BOY}$ を満たすかに関しては $[\![\text{BOY}(a)]\!] = ([\![a]\!] \in [\![\text{BOY}]\!]) = 1$ と解釈する.
そして述語論理であれば、 $[\![\text{John}]\!] = a$ であったが、モンタギュー意味論では異なる.

$$[\![\text{John}]\!] = \{ [\![P]\!] : P(a) = 1\} = \{ [\![\text{BOY}]\!], [\![\text{RUN}]\!] \} = \{\{a,b,c\},\{a,b\}$$

量子化については次のように解釈する

$[\![\text{some}~\text{boys}]\!]$ は $a,b,c$ のいずれかを成立させる述語全体:
$$[\![\text{some}~\text{boys}]\!] = \{ [\![P]\!] : P \cap \{a,b,c\} \ne \emptyset \} = \{[\![BOY]\!],[\![RUN]\!],[\![SING]\!]\}$$

$[\![\text{every}~\text{boy}]\!]$ は $a,b,c$ の全てを成立させる述語全体:
$$[\![\text{every}~\text{boys}]\!] = \{ [\![P]\!] : \{a,b,c\} \subseteq P \ne \emptyset \} = \{[\![BOY]\!]\}$$


ここで「主語述語構造」の解釈を定める.

文 $S \rightarrow NP~VP$ について $[\![S]\!] = ([\![VP]\!] \in [\![NP]\!])$

### 内包論理の下の名詞句の翻訳

先章では John という個体を単に John と書いたが、PTQ では個体はより複雑に

$$\lambda X. \downarrow X(\text{John})$$

と記述することにする.

### 内包論理の下の主語名詞句の翻訳

「$\alpha$ が $\delta$ する」という主語名詞句の翻訳 (自然言語からPTQ) を
$\alpha(\uparrow \delta)$ (関数適用)
と定める.

集合と特性関数 (特徴関数) の区別をしなければ
($A$ という集合を $A(x) = 1 \text{ if } x \in A \text{ else } 0$ という関数と同一視する)、
"John runs" の解釈は

$$\left(\lambda X. \downarrow X(\text{John})\right)(\uparrow \text{run})
= \downarrow \uparrow \text{run}(\text{John})
= \text{run}(\text{John})$$

となる.
これはいわゆる述語論理における記述と等しい.

最後の $=$ には $\downarrow \uparrow$ 打ち消しを用いた.
名詞句でわざわざ $\downarrow$ していて、動詞の適用の際に $\uparrow$ させているのは、適切に内包的動詞を扱うための技巧である.

### 量化された名詞句

同様に "Every boy runs" といった量化された主語名詞句を持った文を内包論理の下で翻訳したい.

まず "Every boy" を翻訳するわけだが、先ほどと同様に "run" を関数適用して、最終的に

$$\forall x. \text{BOY}(x) \rightarrow \text{run}(x)$$

が得られれば良い.

というわけで次のように定める.

1. 「全ての $\zeta$」を $\lambda X. \forall x (\zeta(x) \rightarrow \downarrow X(x))$ と翻訳する
1. 「ある $\zeta$」を $\lambda X. \exists x (\zeta(x) \land \downarrow X(x))$ と翻訳する


これを用いれば "Some Boys run"

### 内包的動詞

動詞には内包/外延の区別がある.

例えばこの世界には存在しない動物としてユニコーンがあるが、
「ユニコーンを探す」と「ユニコーンを見つける」は事情が異なる.
前者はユニコーンの存在とは独立に真にもなり得る行為であるが、
後者はユニコーンが存在しない故に常に偽となるような文である.

可能世界、内包論理はこのためにある.
すなわち、ユニコーンが存在して形を持つ世界を想像できることで、常に偽となるにも関わらず、
「ユニコーン」と「ゴジラ」とを区別して使うことができる.

ただし動詞が内包的に使われるかどうかはしばしば曖昧である.

1. 彼はユニコーンを探している
1. 母親が公園で少女を探している

1つ目は存在しないものを存在をなかば信じて探す行為でこれは内包的である.
2つ目は探している少女の存在を知っていて外見もしった上で探す行為であり、これは外延的である.
これらの「探す」は英語であっても特別に区別なく $\text{FIND}$ や $\text{SEEK}$ が使われる.

> いやもしかしてら二つ目の文も内包的に使われてるようにも見えなくもない.
> 内包的に読むのはただテキスト通りに読む **事物読み (de re reading)** といい、
> テキストの奥に「主語は目的語の存在を知ってるから探してるのだ」と深読みするのを
> **言表読み (de dicto reading)** という.

### 内包論理の下の他動詞の翻訳

「$\beta$ を $\delta$ する」を $\delta(\uparrow \beta)$ と翻訳する.

例として「ジョンがあるユニコーンを探す」を「ジョンが「「あるユニコーンを」探す」」という木構造で翻訳してみる.

1. 「あるユニコーン」
    - $\lambda X. \exists x. (\text{UNICORN}(x) \land \downarrow X(x))$
1. 「あるユニコーンを探す」
    - $\text{SEEK}(\uparrow \lambda X. \exists x. (\text{UNICORN}(x) \land \downarrow X(x)))$
1. 「ジョンがあるユニコーンを探す」
    - $(\lambda X. \downarrow X(\text{John})) (\uparrow \text{SEEK}(\uparrow \lambda X. \exists x. (\text{UNICORN}(x) \land \downarrow X(x))))$
    - $= \text{SEEK}(\uparrow \lambda X. \exists x. (\text{UNICORN}(x) \land \downarrow X(x)))(\text{John})$


ここで $\text{SEEK}$ がある種のカリー化された引数を2つ受け付ける関数になっている $(A \rightarrow (B \rightarrow C))$ になってるから、
二項関数 $((B, A) \rightarrow C)$ と同一視して

$$\text{SEEK}(\text{John}, \uparrow \lambda X. \exists x. (\text{UNICORN}(x) \land \downarrow X(x)))$$

と書く.
$\text{SEEK}$ の目的語は $\uparrow$ によって内包化されているため、それ自体は、解釈する世界に **依らず** 、世界を引数とする関数であるので、
$\text{UNICORN}$ を $\text{GODZILLA}$ で置き換えたものと完全に区別ができる.

しかし、逆にこの $\text{SEEK}$ が外延的である場合は $\text{UNICORN}$ の存在が解釈に影響すべきで、
「ジョンがあるユニコーンを探す」は

$$\exists x. (\text{UNICORN}(x) \land \text{SEEK}(\text{John}, \uparrow \lambda X. \downarrow X(x))) \text{ ---------(*)}$$

と書きたい.

#### 意味公準

外延的な動詞 $\delta$ については、ある述語 $S$ が在って次が成立するとする.

$$\delta(x, X) (= \delta(X)(x)) \leftrightarrow \downarrow X(\uparrow \lambda y. \downarrow S(x, y))$$

先ほどの例を用いて、

$$\text{SEEK}(\text{John}, \uparrow \lambda X. \exists x. (\text{UNICORN}(x) \land \downarrow X(x)))$$

に $\delta = \text{SEEK}$ としてこの意味公準を適用してみる.

- $\text{SEEK}(\text{John}, \uparrow \lambda X. \exists x. (\text{UNICORN}(x) \land \downarrow X(x)))$
- $=\downarrow X(\uparrow \lambda y. \downarrow S(\text{John}, y))$
    - where $X = \uparrow \lambda X. \exists x. (\text{UNICORN}(x) \land \downarrow X(x))$
- $= \left( \lambda X. \exists x. (\text{UNICORN}(x) \land \downarrow X(x)) \right) (\uparrow \lambda y. \downarrow S(\text{John}, y))$
- $= \exists x. \left( \text{UNICORN}(x) \land \downarrow (\uparrow \lambda y. \downarrow S(\text{John}, y))(x) \right)$
- $= \exists x. \left( \text{UNICORN}(x) \land (\lambda y. \downarrow S(\text{John}, y))(x) \right)$
- $= \exists x. \left( \text{UNICORN}(x) \land (\downarrow S(\text{John}, x)) \right)$

となって、かなり $\text{(*)}$ に近いかたちが得られた.
完全に一致する形を得るために、意味公準の $X$ を $\uparrow \lambda X. \downarrow X(y))$ で置換してみると、

$$\delta(x, \uparrow \lambda X. \downarrow X(y)) = \downarrow S(x,y)$$

を得る (途中略).

すなわち、
$\text{SEEK}(x, \uparrow \lambda X. \downarrow X(y)) = \downarrow S(x,y)$
を代入することで、$\text{(*)}$ を得、この意味公準の下で2つは同値であることが確認できる.


先ほどの
$$\delta(x, \uparrow \lambda X. \downarrow X(y)) = \downarrow S(x,y)$$
を書き換えると
$$\lambda y. \lambda x. \delta(x, \uparrow \lambda X. \downarrow X(y)) = \downarrow S$$

を得る (引数の順序に註意 $(S(x,y)=S(y)(x))$).
この右辺の $S$ は $\delta$ によって定まるが、左辺のことを $\delta^*$ と表記することにする.

とすると、先ほどの「ジョンがユニコーンを探す」は

$$\exists x. (\text{UNICORN}(x) \land \text{SEEK}^*(\text{John}, x))$$

と書いて馴染み深い述語論理の記述になる.

## モンタギュー意味論の問題点

として2つ挙げる.

### 文を超えた照応関係

二文目の代名詞が一文目の個体を指す場合についてモンタギュー文法は何も触れていない.

"A man walks. He whistles."

文の間を $\land$ でつなぐとしても、量化のスコープがやばい:

$$\exists x(\text{MAN}(x) \land \text{WALK}(x)) \land \text{WHISTLE}(x)$$

### ロバ文 (Donkey sentence)

- "If a farmer owns a donkey, he betas it"
- "Every farmer who owns a donkey beats it"

という2つの例文を我々は同じ意味を以って読む.
しかし、それぞれを構成的に翻訳すると、次のようになるだろう:

- $\exists x. (\text{FARMER}(x) \land \exists y. (\text{DONKEY}(y) \land \text{OWN}(x, y)) \rightarrow \text{BEAT}(x, y))$
- $\forall x. (\text{FARMER}(x) \land \exists y. (\text{DONKEY}(y) \land \text{OWN}(x, y)) \rightarrow \text{BEAT}(x, y))$

しかし本来読みたいのは次である.

- $\forall x. \forall y. (\text{FARMER}(x) \land \text{DONKEY}(y) \land \text{OWN}(x, y)) \rightarrow \text{BEAT}(x, y)$

## ダイナミック意味論

ダイナミック意味論は先のモンタギュー意味論の問題点を解決する.
そしてこれまでやってきたことは何だったのだと成る程、全く異なる.

ダイナミック意味論のための論理をダイナミック述語論理 (DPL) という.
シンタックスは察して.

### 概要

ダイナミック意味論では、読み手や聞き手の状態を考える.
ここで状態とは変数への割当関数の集合とする.

これまでは文を 0/1 (真偽) に解釈してきたが、
ダイナミック意味論では、
文の解釈という行為を、状態の遷移させるものだとする.

割当関数全体の冪集合を $G$ とする.
文の解釈は $G \times G$ の部分集合とする.

例えばある文の解釈に $\langle g, h \rangle$ が含まれる時、解釈する前に状態 $g$ を保つ場合、解釈した後に状態 $h$ を持ち得るという意味である.
わざわざ部分集合だと言っているのは関数ではない (遷移後の状態を一意に定めない) からである.
(非決定的な遷移関数といえる).

### notation

2つの割当関数 $h, g$ において、変数 $x$ 以外で等しい ($\forall y. y \ne x \rightarrow h(y) = g(h)$) ことを
$h[x]g$ と書く.

### 単純式の解釈

単純式 $R(t_1 \ldots t_n)$ の普通の解釈としては、
それが成立する引数組の集合

$$I(R) = \{ \langle t_1 \ldots t_n \rangle : R(t_1 \ldots t_n) \}$$

だけど、
ダイナミック意味論では、それが成立するような割当関数のみ通す (フィルタする) ものとする.
すなわち、

$$[\![R(t_1 \ldots t_n)]\!] = \{ \langle g, g \rangle : \langle [\![ t_1 ]\!]_g \ldots [\![ t_n ]\!]_g \rangle \in I(R)$$

ここで $[\![ \_ ]\!]_g$ は割当関数 $g$ の下での解釈.

### 存在量化子の解釈

$\exists x. \phi$
の解釈を考える.

次のように状態の遷移を考える.
初め状態が $g$ だとし、
$\exists x$ の量化によって、実際に $x$ **のみ** に別な割当をした $k$ に移す.
$\phi$ の解釈によって $k \to h$ と遷移するなら、
$\exists x. \phi$ によって確かに $g \to h$ と遷移できる.
$\exists$ だから、中間の $k$ はそのようなものがただ一つでもあれば、全体として $h$ に遷移できる.

以上の考察から次のように定める.

$$[\![ \exists x. \phi ]\!] = \{
\langle g,h \rangle :
\exists k.
g[x]k \text{ and }
\langle k,h \rangle \in [\![ \phi ]\!]
\}$$

#### 単純式の量子化

一階述語 $P$ と変数 $x$ からなる単純式 $P(x)$ の量子化 $\exists x. P(x)$ の解釈は以上を組み合わせると

- $[\![ \exists x. P(x) ]\!] = \{ \langle g,h \rangle : \exists k.  g[x]k \text{ and } k = h \text{ and } h(x) \in I(P) \}$
    - $= \{ \langle g,h \rangle : g[x]h \text{ and } h(x) \in I(P) \}$

ここで $I(P)$ は $I(P) = \{ x : P(x) \}$ みたいな特徴関数.

### 連言の解釈

2つの文の解釈は連言として解釈する.
そのときに、スコープが越えていても成立するような解釈をダイナミック意味論では提供する.

$$[\![ \phi \land \psi ]\!] = \{ \langle g,h \rangle : \exists k.~
\langle g,k \rangle \in [\![\phi]\!] \text{ and }
\langle k,h \rangle \in [\![\psi]\!] \}$$

前から順に解釈するものとして、
$\phi$ を読んで $k$ に移って、その後に $\psi$ を読んで $h$ に移る.
遷移は非決定的なものなので、$k$ については $\exists k$ としてある.

#### 例

スコープを超えてる例として $(\exists x. P(x)) \land Q(x)$ を解釈してみる.

- $[\![ (\exists x. P(x)) \land Q(x) ]\!]$
    - $= \{ \langle g,h \rangle : \exists k.~ \langle g,k \rangle \in [\![\exists x. P(x)]\!] \text{ and } \langle k,h \rangle \in [\![Q(x)]\!] \}$
    - $= \{ \langle g,h \rangle : \exists k.~ (g[x]k \text{ and } k(x) \in I(P)) \text{ and } (h=k \text{ and } h(x) \in I(Q)) \}$
    - $= \{ \langle g,h \rangle : g[x]h \text{ and } h(x) \in I(P) \text{ and } h(x) \in I(Q) \}$

というわけで、モンタギュー意味論の問題点としてあげた一点目は解決された.

### 否定文の解釈

否定文は宣言であって全体としてダイナミックではない (解釈の前後で状態を変化させない).
単純式の解釈と同様にフィルタするだけである.

$$[\![\lnot \phi]\!] = \{ \langle g,g \rangle : \nexists k. \langle g, k \rangle \in [\![ \phi ]\!] \}$$

### 全称量化子の解釈

古典的に言えば
$[\![\forall x. \phi]\!] = [\![\lnot \exists x. \lnot \phi]\!]$
が成立すべきで、これを採用する.

- $[\![\forall x. \phi]\!] = [\![\lnot \exists x. \lnot \phi]\!]$
    - $= \{ \langle g,g \rangle : \nexists h. \langle g,h \rangle \in [\![ \exists x. \lnot \phi ]\!] \}$
    - $= \{ \langle g,g \rangle : \nexists h. \exists k. g[x]k \text{ and } \langle k,h \rangle \in [\![ \lnot \phi ]\!] \}$
    - $= \{ \langle g,g \rangle : \nexists h. \exists k. g[x]k \text{ and } k=h \text{ and } \nexists m. \langle k,m \rangle \in [\![\phi]\!] \}$
    - $= \{ \langle g,g \rangle : \nexists h. g[x]h \text{ and } \nexists m. \langle h,m \rangle \in [\![\phi]\!] \}$
    - $= \{ \langle g,g \rangle : \forall h. g[x]h \Rightarrow \exists m. \langle h,m \rangle \in [\![\phi]\!] \}$ (えいっ)

というわけで

$$[\![\forall x. \phi]\!] = \{ \langle g,g \rangle : \forall h. g[x]h \Rightarrow \exists m. \langle h,m \rangle \in [\![\phi]\!] \}$$

とする.

### 選言の解釈

$\phi \lor \psi$ の解釈を与える.

ド・モルガン的に
$[\![\phi \lor \psi]\!] = [\![\lnot (\lnot \phi \lor \lnot \psi)]\!]$
の成立を要請して、

$$[\![\phi \lor \psi]\!] = \{ \langle g,g \rangle : \exists k.~\left(
\langle h,k \rangle \in [\![ \phi ]\!] \text{ or }
\langle h,k \rangle \in [\![ \psi ]\!]
\right) \}$$

これは $\psi$ の解釈の中で $\phi$ を照応しないことになる.

### 含意の解釈

$\phi \rightarrow \psi$ の解釈を与える.

もう否定も選言もあるのでこれも作れて、

$$[\![\phi \rightarrow \psi]\!] =
\{
\langle g,g \rangle : \forall k.~\left(
\langle h,k \rangle \in [\![\phi]\!]
\Rightarrow
\langle k,j \rangle \in [\![\psi]\!]
\right)
\}$$


ロバ文はどのように解釈されるか.
一部省略して、「ロバを所有してる人が存在する、ならば、彼はロバを打つ」と読んで
$(\exists x. P(x)) \rightarrow Q(x)$
の解釈を考える.

- $[\![\exists x. P(x) \rightarrow Q(x)]\!]$
    - $= \{ \langle g,g \rangle : \forall k.~\left( \langle h,k \rangle \in [\![\exists x.P(x)]\!] \Rightarrow \langle k,j \rangle \in [\![Q(x)]\!] \right) \}$
    - $= \{ \langle g,g \rangle : \forall k.~\left( g[x]k \text{ and } k(x) \in I(P) \Rightarrow k(x) \in I(Q) \right) \}$

というわけで二点目の問題点も解消された.
