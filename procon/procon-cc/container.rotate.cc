/*
 * std::rotate
 *
 * 第二引数には、新しく作るベクタの頭を指定する (begin === end)
 */

// 左への回転
// 1,2,3,4 -> 2,3,4,1

vi xs = {1, 2, 3, 4};

rotate(begin(xs), begin(xs) + 1, end(xs));

// 右への回転
// 1,2,3,4 -> 4,1,2,3

vi ys = {1, 2, 3, 4};

rotate(begin(ys), end(ys) - 1, end(ys));

