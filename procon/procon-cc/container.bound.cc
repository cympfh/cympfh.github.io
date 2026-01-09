vi v = { 1,2,  4,5 }; // sorted

trace(*upper_bound(begin(v), end(v), 2)); // 4 // 最初の2超え
trace(*lower_bound(begin(v), end(v), 2)); // 2 // 最初の2以上

trace(*upper_bound(begin(v), end(v), 3)); // 4
trace(*lower_bound(begin(v), end(v), 3)); // 4

trace(*upper_bound(begin(v), end(v), 4)); // 5
trace(*lower_bound(begin(v), end(v), 4)); // 4
