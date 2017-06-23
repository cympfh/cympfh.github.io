SS<>sky(4);

sky.add(0, 4, 1); // [1, 1, 1, 1]
assert(sky.max(0, 4) == 1);
assert(sky.max(1, 4) == 1);
assert(sky.max(0, 3) == 1);

sky.add(2, 4, -1); // [1, 1, 0, 0]
assert(sky.max(0, 1) == 1); // max of [1]
assert(sky.max(0, 3) == 1); // max of [1, 1, 0]
assert(sky.max(2, 3) == 0); //        [0]
assert(sky.max(2, 4) == 0); //        [0, 0]
