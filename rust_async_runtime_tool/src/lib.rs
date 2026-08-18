use tokio::net::{TcpListener, TcpStream};
use tokio::io::{AsyncReadExt, AsyncWriteExt};
use tracing::{info, error};

/// The main AsyncRuntime structure
pub struct AsyncRuntime {
    listener: Option<TcpListener>,
}

impl AsyncRuntime {
    /// Creates a new AsyncRuntime instance
    pub fn new() -> Self {
        AsyncRuntime {
            listener: None,
        }
    }

    /// Starts the async runtime and begins listening for connections
    pub async fn start(&mut self) -> Result<(), Box<dyn std::error::Error>> {
        let listener = TcpListener::bind("127.0.0.1:8080").await?;
        info!("Listening on 127.0.0.1:8080");
        self.listener = Some(listener);
        
        if let Some(listener) = &self.listener {
            loop {
                match listener.accept().await {
                    Ok((socket, addr)) => {
                        info!("New connection from: {}", addr);
                        tokio::spawn(async move {
                            if let Err(e) = handle_stream(socket).await {
                                error!("Error handling stream: {}", e);
                            }
                        });
                    }
                    Err(e) => {
                        error!("Failed to accept connection: {}", e);
                    }
                }
            }
        }
        Ok(())
    }

    /// Handles a single network stream
    pub async fn handle_stream(&self, _handler: impl Fn(TcpStream) -> std::pin::Pin<Box<dyn std::future::Future<Output = ()> + Send + 'static>>) -> Result<(), Box<dyn std::error::Error>> {
        // This method is a placeholder for a more complex handler registration system
        Ok(())
    }
}

/// Handles individual client connections
async fn handle_stream(mut socket: TcpStream) -> Result<(), Box<dyn std::error::Error>> {
    let mut buffer = [0; 1024];
    loop {
        match socket.read(&mut buffer).await? {
            0 => break,
            n => {
                let request = String::from_utf8_lossy(&buffer[..n]);
                info!("Received request: {}", request);
                let response = format!("HTTP/1.1 200 OK\r\nContent-Length: 12\r\n\r\nHello World!");
                socket.write_all(response.as_bytes()).await?;
            }
        }
    }
    Ok(())
}
