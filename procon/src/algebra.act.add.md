# 代数 - 作用 - 加算作用

加法群 $(X, +, 0)$ に対して, 加算するというモノイド作用がある.
$$M = \{ +x \mid x \in X \}$$

- 作用
    - $(+a) \ast x = x + a$
- 単位元
    - $(+0) \ast x = x$
- 合成
    - $(+a) \times (+b) = +(a+b)$

@[rust](procon-rs/src/algebra/act_add.rs)
