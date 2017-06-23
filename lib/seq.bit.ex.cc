auto bit = BIT(10);
// 0 0 0 0

bit.add(0, 1);
// 1 0 0 0
cout << bit.sum(0) << endl; // 1
cout << bit.sum(1) << endl; // 1

bit.add(1, 1);
// 1 1 0 0
bit.add(3, 1);
// 1 1 0 1
cout << bit.sum(0) << endl; // 1
cout << bit.sum(1) << endl; // 2
cout << bit.sum(2) << endl; // 2
cout << bit.sum(3) << endl; // 3

bit.add(1, 1);
// 1 2 0 1
bit.add(2, -1);
// 1 2 -1 1
cout << bit.sum(0) << endl; // 1
cout << bit.sum(1) << endl; // 3
cout << bit.sum(2) << endl; // 2
cout << bit.sum(3) << endl; // 3
