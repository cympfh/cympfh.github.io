# テスト環境

- ソースコード: `main.cc`
- コンパイラ: `g++`
- クリップボード操作: `xsel` (in Linux) : `pbpaste` (in Mac)

```bash
all: main.exe __input
	./main.exe < input | tee out
	[ ! -f ans ] || diff out ans

main.exe: main.cc
	g++ -o $@ -std=c++11 $^

__input:
	if [ "_$$TERM_PROGRAM" = "_Apple_Terminal" ] || [ "_$$TERM_PROGRAM" = "_iTerm.app" ]; then \
	pbpaste | gsed -e 's/^\s*//g' | gsed -e 's/\s*$$//g' > input; \
	else \
	xsel -bo | sed -e 's/^\s*//g' | sed -e 's/\s*$$//g' > input; \
	fi

test: main.exe
	@for i in cases/*.in; do \
		./main.exe < $$i > /tmp/out; \
		cmp -s /tmp/out $${i%in}out; \
		RETVAL=$$?; \
		if [  $$RETVAL -eq 1 ]; then \
		/bin/echo -e '\e[31m'$$i'\e[m'; \
		diff /tmp/out $${i%in}out; \
		exit 1; \
		fi; \
		done; \
		/bin/echo -e '\e[34mall passed!\e[m'

clean:
	-rm -f out *.exe cases/* /tmp/out
	mv main.cc main.cc.bk
	cp template.cc main.cc
```

## usage

### `make`

1. クリップボードの中身を `input` ファイルに書きだして
1. それを入力にして `main.exe` を実行する
1. 出力は `out` に保存されるのと同時に標準出力される
1. 目視することが前提
1. `ans` ファイルが存在する場合 `diff out ans` する

### make test

1. `cases/` 以下に複数のテストケースを用意する
1. 入力ケース `cases/X.in` に対して `cases/X.out`
1. テストが全て通ったら `all passed!` と出力

```bash
$ mkdir cases
$ echo 2 > cases/1.in
$ echo prime > cases/1.out
$ echo 3 > cases/2.in
$ echo prime > cases/2.out
$ echo 4 > cases/3.in
$ echo composed number > cases/3.out
$ make test
all passed!
```

