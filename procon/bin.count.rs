/// Binary Search - Counting Elements in a Sorted Array
// @bin.search.rs
// the number of elements == x
fn binsearch_count<T: Ord>(x: T, xs: &Vec<T>) -> usize {
    let n = xs.len();
    let i = binsearch(0, n, &|i| xs[i] >= x);
    let j = binsearch(0, n, &|i| xs[i] > x);
    j - i
}

// the number of elements >= x
fn binsearch_count_geq<T: Ord>(x: T, xs: &Vec<T>) -> usize {
    let n = xs.len();
    if xs[0] >= x { return n }
    n - binsearch(0, n, &|i| xs[i] >= x)
}

// the number of elements > x
fn binsearch_count_gt<T: Ord>(x: T, xs: &Vec<T>) -> usize {
    let n = xs.len();
    if xs[0] > x { return n }
    n - binsearch(0, n, &|i| xs[i] > x)
}

// the number of elements <= x
fn binsearch_count_leq<T: Ord>(x: T, xs: &Vec<T>) -> usize {
    xs.len() - binsearch_count_gt(x, &xs)
}

// the number of elements < x
fn binsearch_count_lt<T: Ord>(x: T, xs: &Vec<T>) -> usize {
    xs.len() - binsearch_count_geq(x, &xs)
}
