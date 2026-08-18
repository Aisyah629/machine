mod lib;

use lib::AsyncRuntime;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let mut runtime = AsyncRuntime::new();
    runtime.start().await?;
    Ok(())
}
