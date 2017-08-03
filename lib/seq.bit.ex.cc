int main() {

    auto bit = BIT(5);

    bit.add(0, 1);
    bit.add(4, 1);  // [1, 0, 0, 0, 1]
    trace(bit.sum(0, 0));  // 0
    trace(bit.sum(0, 1));  // 1
    trace(bit.sum(0, 2));  // 1
    trace(bit.sum(0, 3));  // 1
    trace(bit.sum(0, 4));  // 1
    trace(bit.sum(0, 5));  // 2
    trace(bit.sum(1, 4));  // 0
    trace(bit.sum(1, 5));  // 1
    trace(bit.sum(2, 5));  // 1

    bit.add(4, -1);
    bit.add(3, 1);
    bit.add(2, 2);  // [1, 0, 2, 1, 0]
    trace(bit.sum(0, 1));  // 1
    trace(bit.sum(0, 2));  // 1
    trace(bit.sum(0, 3));  // 3
    trace(bit.sum(0, 4));  // 4
    trace(bit.sum(2, 5));  // 3

    return 0;
}
