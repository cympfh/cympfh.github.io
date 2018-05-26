fn main() {
    {
        let xs = vec![1, 1, 2, 3];
        let cumsum = Cumsum::new(&xs);
        trace!(cumsum.array);
        assert!(cumsum.sum(0..1) == 1);
        assert!(cumsum.sum(0..2) == 2);
        assert!(cumsum.sum(0..3) == 4);
        assert!(cumsum.sum(0..4) == 7);
        assert!(cumsum.sum(2..4) == 5);
        assert!(cumsum.sum(1..1) == 0);
        assert!(cumsum.sum(2..2) == 0);
    }
}
