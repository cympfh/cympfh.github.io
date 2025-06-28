% Representation Learning by Learning to Count
% http://openaccess.thecvf.com/content_ICCV_2017/papers/Noroozi_Representation_Learning_by_ICCV_2017_paper.pdf
% 画像認識 教師ナシ学習

- [YouTube](https://www.youtube.com/watch?v=ZmaXDb9akEI)
- [論文 (pdf)](http://openaccess.thecvf.com/content_ICCV_2017/papers/Noroozi_Representation_Learning_by_ICCV_2017_paper.pdf)
- [Github](https://github.com/gitlimlab/Representation-Learning-by-Learning-to-Count)

## 概要

物体認識のCNNを訓練するために、事前学習として、物の数を予測させるようなものを学習させると、転移学習させてsotaだった.
要するに feature extraction をより強固にするために、画像のある矩形部分には目がいくつあるか、耳ががいくつあるか、などが分かるべき.
彼らのやり方では、一枚の画像を 2x2 に4等分にして、それぞれに含まれる動物の目の数などを学習させた.

## 感想

このような補助タスク (Pseudo Task) として、他にも、よくデータ水増しの手法として画像を回転させていたのを、回転させた角度を予測させる、というのが最近あった. どの論文か忘れたけど.
そういう、アノテーションがずっと楽だったり、自動的に出来るような補助タスクの開発が流行りそう. あるいは流行っていそう.
