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
