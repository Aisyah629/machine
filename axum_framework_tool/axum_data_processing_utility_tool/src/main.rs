use axum::{
    extract::State,
    http::StatusCode,
    response::Json,
    routing::post,
    Router,
};
use serde::{Deserialize, Serialize};
use std::sync::Arc;
use tokio::sync::Mutex;
use tracing::{info, error};

#[derive(Debug, Deserialize)]
struct DataPayload {
    records: Vec<serde_json::Value>,
}

#[derive(Debug, Serialize)]
struct ProcessingResult {
    status: String,
    processed_count: usize,
}

struct AppState {
    data_buffer: Arc<Mutex<Vec<serde_json::Value>>>,
}

impl AppState {
    fn new() -> Self {
        AppState {
            data_buffer: Arc::new(Mutex::new(Vec::new())),
        }
    }
}

async fn process_data(
    State(state): State<AppState>,
    Json(payload): Json<DataPayload>,
) -> Result<Json<ProcessingResult>, StatusCode> {
    let count = payload.records.len();
    
    {
        let mut buffer = state.data_buffer.lock().await;
        buffer.extend(payload.records);
    }

    info!("Successfully processed {} records", count);

    Ok(Json(ProcessingResult {
        status: "completed".to_string(),
        processed_count: count,
    }))
}

async fn health_check() -> &'static str {
    "OK"
}

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();

    let state = AppState::new();

    let app = Router::new()
        .route("/process", post(process_data))
        .route("/health", get(health_check))
        .with_state(state);

    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap();
    info!("Listening on 0.0.0.0:3000");
    axum::serve(listener, app).await.unwrap();
}
