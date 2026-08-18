use std::fs;
use std::io::{self, BufRead, BufReader};
use std::process;

fn get_cpu_usage() -> String {
    let content = match fs::read_to_string("/proc/stat") {
        Ok(data) => data,
        Err(_) => return "N/A".to_string(),
    };
    
    let mut cpu_vals = Vec::new();
    for line in content.lines() {
        if line.starts_with("cpu ") {
            let parts: Vec<&str> = line.split_whitespace().skip(1).collect();
            cpu_vals = parts.iter().map(|&s| s.parse::<u64>().unwrap_or(0)).collect();
            break;
        }
    }
    
    if cpu_vals.len() >= 7 {
        let idle = cpu_vals[3];
        let total: u64 = cpu_vals.iter().sum();
        let usage = ((total - idle) as f64 / total as f64) * 100.0;
        format!("{:.2}%", usage)
    } else {
        "N/A".to_string()
    }
}

fn get_memory_usage() -> String {
    let content = match fs::read_to_string("/proc/meminfo") {
        Ok(data) => data,
        Err(_) => return "N/A".to_string(),
    };
    
    let mut total = 0u64;
    let mut available = 0u64;
    
    for line in content.lines() {
        if line.starts_with("MemTotal:") {
            total = line.split_whitespace().skip(1).next().and_then(|s| s.parse().ok()).unwrap_or(0);
        } else if line.starts_with("MemAvailable:") {
            available = line.split_whitespace().skip(1).next().and_then(|s| s.parse().ok()).unwrap_or(0);
        }
    }
    
    if total > 0 {
        let usage = ((total - available) as f64 / total as f64) * 100.0;
        format!("{:.2}% (Total: {} KB, Available: {} KB)", usage, total, available)
    } else {
        "N/A".to_string()
    }
}

fn get_disk_usage() -> String {
    let stdout = process::Command::new("df")
        .arg("-h")
        .arg("/")
        .output()
        .expect("Failed to execute df command");
    
    let output = String::from_utf8_lossy(&stdout.stdout);
    let mut disk_usage = String::new();
    
    for (i, line) in output.lines().enumerate() {
        if i == 1 {
            let parts: Vec<&str> = line.split_whitespace().collect();
            if parts.len() >= 6 {
                disk_usage = format!("Total: {}, Used: {}, Available: {}, Use%: {}", parts[1], parts[2], parts[3], parts[4]);
            }
        }
    }
    
    if disk_usage.is_empty() {
        "N/A".to_string()
    } else {
        disk_usage
    }
}

fn main() {
    println!("=== System Monitor Tool ===");
    println!("CPU Usage: {}", get_cpu_usage());
    println!("Memory Usage: {}", get_memory_usage());
    println!("Disk Usage (/): {}", get_disk_usage());
    println!("===========================");
}
