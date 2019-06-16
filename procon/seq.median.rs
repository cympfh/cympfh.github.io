use std::cmp::Reverse;
use std::collections::BinaryHeap;

#[derive(Debug)]
struct MedianHeap<T> where T: Ord + Copy {
    head: BinaryHeap<T>,
    tail: BinaryHeap<Reverse<T>>
}
#[derive(Debug, PartialEq, Eq)]
enum Median<T> {
    None,
    Just(T),
    Between(T, T),
}
impl<T: Ord + Copy> MedianHeap<T> {
    fn new() -> MedianHeap<T> {
        MedianHeap { head: BinaryHeap::new(), tail: BinaryHeap::new() }
    }
    fn len(&self) -> usize {
        (self.head.len() + self.tail.len()) / 2
    }
    fn push(&mut self, x: T) {
        match (self.head.peek(), self.tail.peek()) {
            (None, None) => {
                self.head.push(x);
                self.tail.push(Reverse(x));
            },
            (Some(&a), Some(&Reverse(b))) => {
                if a <= x && x <= b {
                    self.head.push(x);
                    self.tail.push(Reverse(x));
                } else if x < a {
                    self.head.push(x);
                    self.head.push(x);
                    let _ = self.head.pop();
                    self.tail.push(Reverse(a));
                } else {
                    self.tail.push(Reverse(x));
                    self.tail.push(Reverse(x));
                    let _ = self.tail.pop();
                    self.head.push(b);
                }
            },
            _ => {}
        }
    }
    fn peek(&self) -> Median<T> {
        let n = self.len();
        if n == 0 {
            Median::None
        } else if n % 2 == 1 {
            Median::Just(*self.head.peek().unwrap())
        } else {
            let a = self.head.peek().unwrap();
            let b = self.tail.peek().unwrap().0;
            Median::Between(*a, b)
        }
    }
    fn pop(&mut self) -> Median<T> {
        let n = self.len();
        if n == 0 {
            Median::None
        } else if n % 2 == 1 {
            let a = self.head.pop().unwrap();
            let _ = self.tail.pop();
            Median::Just(a)
        } else {
            let a = self.head.pop().unwrap();
            let b = self.tail.pop().unwrap().0;
            Median::Between(a, b)
        }
    }
}
