use std::sync::{Arc, Mutex};
use tokio::task::JoinHandle;
use tokio::time::{sleep, Duration};

#[derive(Debug, Clone)]
pub struct Task {
    pub id: u64,
    pub command: String,
    pub priority: u8,
}

#[derive(Debug, Clone, PartialEq)]
pub enum TaskState {
    Pending,
    Running,
    Completed,
    Failed,
    RolledBack,
}

#[derive(Debug, Clone)]
pub struct ScheduledTask {
    pub task: Task,
    pub state: TaskState,
    pub retry_count: u8,
}

impl ScheduledTask {
    pub fn new(task: Task) -> Self {
        Self {
            task,
            state: TaskState::Pending,
            retry_count: 0,
        }
    }
}

pub struct Scheduler {
    tasks: Arc<Mutex<Vec<ScheduledTask>>>,
    max_retries: u8,
}

impl Scheduler {
    pub fn new(max_retries: u8) -> Self {
        Self {
            tasks: Arc::new(Mutex::new(Vec::new())),
            max_retries,
        }
    }

    pub fn add_task(&mut self, task: Task) {
        self.tasks.lock().unwrap().push(ScheduledTask::new(task));
    }

    pub async fn execute_all(&self) {
        let tasks = self.tasks.lock().unwrap().clone();
        let mut handles: Vec<JoinHandle<Result<Task, String>>> = Vec::new();

        for mut st in tasks {
            let max_retries = self.max_retries;
            let handle = tokio::spawn(async move {
                loop {
                    st.state = TaskState::Running;
                    // Simulate task execution
                    tokio::time::sleep(Duration::from_millis(100)).await;
                    
                    // Simulate random failure for demonstration
                    if rand::random::<u8>() > 200 {
                        st.retry_count += 1;
                        if st.retry_count >= max_retries {
                            st.state = TaskState::Failed;
                            // Automated rollback mechanism
                            println!("Rolling back task {} due to failure.", st.task.id);
                            return Err(format!("Task {} failed after {} retries", st.task.id, st.retry_count));
                        }
                        tokio::time::sleep(Duration::from_millis(50)).await;
                        continue;
                    } else {
                        st.state = TaskState::Completed;
                        println!("Task {} completed successfully.", st.task.id);
                        return Ok(st.task);
                    }
                }
            });
            handles.push(handle);
        }

        for handle in handles {
            let _ = handle.await;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use rand;

    #[tokio::test]
    async fn test_scheduler_initialization() {
        let scheduler = Scheduler::new(3);
        assert_eq!(scheduler.tasks.lock().unwrap().len(), 0);
    }

    #[tokio::test]
    async fn test_add_task() {
        let mut scheduler = Scheduler::new(3);
        scheduler.add_task(Task { id: 1, command: "echo hello".to_string(), priority: 1 });
        assert_eq!(scheduler.tasks.lock().unwrap().len(), 1);
    }
}

fn main() {
    println!("Rust Scheduler Tool Initialized.");
    let mut scheduler = Scheduler::new(3);
    scheduler.add_task(Task { id: 1, command: "init".to_string(), priority: 1 });
    // In a real scenario, we would call scheduler.execute_all().await;
}
