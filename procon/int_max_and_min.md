% 整数の最大値、最小値

```cpp
trace(INT_MIN);
trace(INT_MAX);
trace(LONG_MIN);
trace(LONG_MAX);
trace(LLONG_MIN);
trace(LLONG_MAX);
trace(ULLONG_MAX);
```

```
>>> INT_MIN = -2147483648
>>> INT_MAX = 2147483647
>>> LONG_MIN = -9223372036854775808
>>> LONG_MAX = 9223372036854775807
>>> LLONG_MIN = -9223372036854775808
>>> LLONG_MAX = 9223372036854775807
>>> ULLONG_MAX = 18446744073709551615
```

ただし

```
   g++ -v
Using built-in specs.
COLLECT_GCC=g++
COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/4.9/lto-wrapper
Target: x86_64-linux-gnu
Configured with: (略)
Thread model: posix
gcc version 4.9.2 (Ubuntu 4.9.2-10ubuntu13)
```

