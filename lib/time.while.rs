use std::time::SystemTime;

macro_rules! loop_timeout {
    ( $sec:expr; $body:expr ) => {
        let now = SystemTime::now();
        loop {
            match now.elapsed() {
                Ok(elapsed) => {
                    if elapsed.as_secs() > $sec {
                        break
                    }
                    $body
                },
                Err(e) => {
                    eprintln!("Err, {:?}", e);
                }
            }
        }
    };
}

fn main() {
    // yes while 3sec
    use std::time::Duration;
    use std::thread::sleep;
    loop_timeout!(3; {
        println!("yes");
        sleep(Duration::new(0, 100000000));
    });
}
