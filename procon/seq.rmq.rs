use std::i32;
use std::ops::{Range, Index};
use std::cmp::{ min, max };

struct RMQ {
    size: usize, len: usize,
    heap_max: Vec<i32>,
    heap_min: Vec<i32>,
    lefts: Vec<usize>, rights: Vec<usize>
}

impl RMQ {

    const INF: i32 = 1000000;

    fn new(v: &Vec<i32>) -> RMQ {
        let n = v.len();
        let size = RMQ::alignment(n);
        let lefts = (0..size).map(|i| RMQ::of_left(i, size/2)).collect();
        let rights = (0..size).map(|i| RMQ::of_right(i, size/2)).collect();
        let mut heap_max = vec![0; size];
        for i in 0..n { heap_max[i + size/2] = v[i]; }
        for i in (0..size/2).rev() { heap_max[i] = max(heap_max[i*2+1], heap_max[i*2+2]); }
        let mut heap_min = vec![0; size];
        for i in 0..n { heap_min[i + size/2] = v[i]; }
        for i in (0..size/2).rev() { heap_min[i] = min(heap_min[i*2+1], heap_min[i*2+2]); }
        RMQ {size: size, len: n, heap_max: heap_max, heap_min: heap_min, lefts: lefts, rights: rights}
    }

    fn len(&self) -> usize {
        self.len
    }

    fn alignment(n: usize) -> usize {
        let mut m = 1;
        while n > m { m <<= 1; }
        m * 2 - 1
    }

    fn of_left(idx: usize, base: usize) -> usize {
        let mut i = idx; while i < base { i = i * 2 + 1; }
        i - base
    }

    fn of_right(idx: usize, base: usize) -> usize {
        let mut i = idx; while i < base { i = i * 2 + 2; }
        i - base + 1
    }

    fn max(&self, range: Range<usize>) -> i32 {
        if range.end == 0 || range.start + 1 > range.end {
            return -RMQ::INF;
        }
        if range.start + 1 == range.end {
            return self.heap_max[self.size / 2 + range.start]
        }
        let left = range.start;
        let right = range.end;
        let mut i = self.size / 2 + left;
        while i > 0 {
            let p = (i - 1) / 2;
            if self.lefts[p] == range.start && self.rights[p] <= range.end {
                i = p;
            } else {
                break
            }
        }
        max(self.heap_max[i], self.max(self.rights[i]..right))
    }

    fn min(&self, range: Range<usize>) -> i32 {
        if range.end == 0 || range.start + 1 > range.end {
            return RMQ::INF;
        }
        if range.start + 1 == range.end {
            return self.heap_min[self.size / 2 + range.start]
        }
        let left = range.start;
        let right = range.end;
        let mut i = self.size / 2 + left;
        while i > 0 {
            let p = (i - 1) / 2;
            if self.lefts[p] == range.start && self.rights[p] <= range.end {
                i = p;
            } else {
                break
            }
        }
        min(self.heap_min[i], self.min(self.rights[i]..right))
    }

    // [idx] <- x
    fn update(&mut self, idx: usize, x: i32) {
        let mut i = idx + self.size/2;
        self.heap_max[i] = x;
        self.heap_min[i] = x;
        loop {
            i = (i - 1) / 2;
            if i == 0 { break }
            self.heap_max[i] = max(self.heap_max[i*2+1], self.heap_max[i*2+2]);
            self.heap_min[i] = min(self.heap_max[i*2+1], self.heap_max[i*2+2]);
        }
    }

    // [idx] <- [idx] + x
    fn add(&mut self, idx: usize, x: i32) {
        self.update(idx, self[idx] + x);
    }

    fn to_vec(&self) -> Vec<i32> {
        (0..self.len()).map(|i| self[i]).collect()
    }
}

impl Index<usize> for RMQ {
    type Output = i32;
    fn index(&self, i: usize) -> &i32 {
        &self.heap_max[i + self.size / 2]
    }
}

fn main() {

    let a = vec![1,2,3,4];
    let mut rmq = RMQ::new(&a);

    for i in 0..rmq.len() {
        println!("rmq[{}] = {}", i, rmq[i]);
    }

    trace!(rmq.to_vec());
    for i in 0..rmq.len() {
        for j in i..rmq.len() {
            println!("max{:?} = {}, min(..) = {}", (i, j), rmq.max(i..j), rmq.min(i..j));
        }
    }

    rmq.update(1, 4);

    trace!(rmq.to_vec());
    for i in 0..rmq.len() {
        for j in i..rmq.len() {
            println!("max{:?} = {}, min(..) = {}", (i, j), rmq.max(i..j), rmq.min(i..j));
        }
    }
}
