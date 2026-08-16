use("ProtoObject", "List", "Sequence", "Number", "Text", "File", "Channel", "Thread")

IoObject := Object clone
doFile("src/initialize.io")

IoObject main := method(
    // Initialize the Io scripting environment
    println("Initializing Io Tool...")
    
    // Set up concurrency and message passing
    channel := Channel clone
    thread := Thread new
    thread start
    
    // Example prototype-based object
    Car := Object clone
    Car speed := 0
    Car accelerate := method(delta,
        speed = speed + delta
        println("Accelerating to: ", speed)
    )
    
    myCar := Car clone
    myCar accelerate(10)
    
    // Send message via channel
    channel send("Task completed")
    result := channel receive
    println("Received: ", result)
    
    println("Io Tool finished execution.")
)
