use std::ops::Range;
use std::collections::HashMap;
struct SeqSearch<T> {
    raw: Vec<T>,
    acc: HashMap<T, Vec<usize>>,
}
impl<T> SeqSearch<T>
where T: std::hash::Hash + Eq + Copy
{
    fn new(xs: &Vec<T>) -> SeqSearch<T> {
        SeqSearch { raw: xs.to_vec(), acc: HashMap::new() }
    }
    fn len(&self) -> usize { return self.raw.len() }
    fn new_alphabet(&mut self, alphabet: T) {
        if self.acc.contains_key(&alphabet) {
            return
        }
        let n = self.raw.len();
        let mut ac = vec![0; n + 1];  // ac = count alphabet xs[0, i)
        for i in 0..n {
            ac[i + 1] = ac[i] + if self.raw[i] == alphabet { 1 } else { 0 };
        }
        self.acc.insert(alphabet, ac);
    }
    fn count(&mut self, alphabet: T, range: Range<usize>) -> usize {
        if let Some(ac) = self.acc.get(&alphabet) {
            ac[range.end] - ac[range.start]
        } else {
            self.new_alphabet(alphabet);
            self.count(alphabet, range)
        }
    }
    // most-left index in range [i, j)
    fn search(&mut self, alphabet: T, range: Range<usize>) -> Option<usize> {
        if self.count(alphabet, range.clone()) == 0 {
            return None
        }
        let mut left = range.start;
        let mut right = range.end;
        for _ in 0..100 {
            let mid = (left + right) / 2;
            if self.count(alphabet, range.start..mid) == 0 {
                left = mid;
            } else {
                right = mid;
            }
        }
        Some(left)
    }
}
