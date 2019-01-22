% BPEmb: Tokenization-free Pre-trained Subword Embeddings in 275 Languages
% https://arxiv.org/abs/1710.02187
% 自然言語処理 文分散表現

多くの言語についてサブワードとその意味ベクトル (BPE; Byte-Pair Encoding) を学習したモデルを公開するもの.
[bheinzerling/bpemb](https://github.com/bheinzerling/bpemb)
からモデルがダウンロードできる

```bash
wget http://cosyne.h-its.org/bpemb/data/ja/ja.wiki.bpe.op200000.d300.w2v.bin.tar.gz &&
tar xf ja.wiki.bpe.op200000.d300.w2v.bin.tar.gz
wget http://cosyne.h-its.org/bpemb/data/ja/ja.wiki.bpe.op200000.model
```

```python
from gensim.models import KeyedVectors
import sentencepiece


sp = sentencepiece.SentencePieceProcessor()
sp.Load('ja.wiki.bpe.op200000.model')  # パスは適切に
wv = KeyedVectors.load_word2vec_format("ja.wiki.bpe.op200000.d300.w2v.bin", binary=True)

ps = sp.EncodeAsPieces('新田は彼女がヒナを追っていることを知り、念動力を使った「あっちむいてホイ」でヒナと対決させる。')
for p in ps:
    print(p, wv.most_similar(p)[:3])
```

## 評価

typing score なるものでサブワードの評価をしている.
これは通常の word2vec や glove だとダメになりがちな希少語にも対応できてるかを測るサブワードのための評価タスクらしい
[1610.00479](https://arxiv.org/abs/1610.00479).

fasttext+RNN や BPE+RNN などを比較している.
平均すると FastText+RNN のが安定してるが、BPEmbのが良いときもある (Figure 1).

また埋め込み次元を25から300まで用意してあるが、どれでもあんまし変わらない (Figure 2).
それよりも merge operation の回数の方が貢献するらしい (Figure 2).

