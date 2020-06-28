/// Time Limited While-loop
macro_rules! loop_timeout_ms {
    ( $sec:expr; $body:expr ) => {
        let now = std::time::SystemTime::now();
        loop {
            match now.elapsed() {
                Ok(elapsed) => {
                    if elapsed.as_millis() > $sec {
                        break;
                    }
                    $body
                }
                Err(e) => {
                    eprintln!("Err, {:?}", e);
                }
            }
        }
    };
}
