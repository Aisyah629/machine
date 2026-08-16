#include <iostream>
#include <mutex>
#include <thread>
#include <memory>
#include <functional>
#include <atomic>

// Thread-safe Singleton with Lazy Initialization
class Singleton {
private:
    static std::unique_ptr<Singleton> instance;
    static std::once_flag initFlag;
    
    Singleton() {
        std::cout << "Singleton initialized\n";
    }

public:
    Singleton(const Singleton&) = delete;
    Singleton& operator=(const Singleton&) = delete;

    static Singleton& getInstance() {
        std::call_once(initFlag, []() {
            instance.reset(new Singleton());
        });
        return *instance;
    }

    void doWork(int id) {
        std::cout << "Thread " << id << " working on Singleton\n";
    }
};

std::unique_ptr<Singleton> Singleton::instance = nullptr;
std::once_flag Singleton::initFlag;

// Thread-local storage example
thread_local std::string threadId = "unknown";

void worker(int id) {
    threadId = "Thread-" + std::to_string(id);
    Singleton::getInstance().doWork(id);
    std::cout << "Thread " << id << " TLS: " << threadId << "\n";
}

int main() {
    std::vector<std::thread> threads;
    for (int i = 0; i < 5; ++i) {
        threads.emplace_back(worker, i);
    }
    for (auto& t : threads) {
        t.join();
    }
    return 0;
}
