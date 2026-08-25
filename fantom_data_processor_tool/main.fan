// Copyright © 2023 Fantom Data Processor Tool
// License: MIT

using [core] Fantom
using [sys] Env
using [sys] Log
using [sys] ActorPool
using [sys] Job
using [sys] Thread
using [script] Script
using [doc] Doc
using [test] Test
using [xml] Xml
using [json] Json
using [sql] Sql

/**
 * Fantom Data Processor Tool
 * 
 * A high-performance data processing utility built using the Fantom programming language.
 * This tool provides efficient data ingestion, transformation, and analysis capabilities.
 */
class Main : Module
{
    static Void main()
    {
        Log log = Log("fantom_data_processor")
        
        try {
            Env env = Env.cur
            
            log.info("Starting Fantom Data Processor Tool...")
            
            // Initialize processing pipeline
            Pipeline pipeline = Pipeline(
                processor: DataProcessor(),
                buffer: DataBuffer(),
                validator: DataValidator()
            )
            
            // Configure pipeline
            pipeline.config.maxBatchSize = 1000
            pipeline.config.timeoutMs = 5000
            pipeline.config.strictMode = true
            
            log.info("Pipeline configured with batch size: %d", pipeline.config.maxBatchSize)
            
            // Process sample data
            sampleData := [
                Map(["id" -> 1, "name" -> "Alice", "score" -> 95]),
                Map(["id" -> 2, "name" -> "Bob", "score" -> 82]),
                Map(["id" -> 3, "name" -> "Charlie", "score" -> 91]),
                Map(["id" -> 4, "name" -> "Diana", "score" -> 88]),
                Map(["id" -> 5, "name" -> "Eve", "score" -> 97])
            ]
            
            log.info("Processing %d records...", sampleData.size)
            
            // Execute processing pipeline
            results := pipeline.execute(sampleData)
            
            log.info("Processing complete. Results: %d records", results.size)
            
            // Display results
            results.each |Map record, Int i| {
                log.info("Record %d: %s", i + 1, record)
            }
            
            log.info("Fantom Data Processor Tool completed successfully.")
            
        } catch (Exception e) {
            Log("fantom_data_processor").error("Fatal error: %s", e.msg)
            throw e
        }
    }
}

/**
 * Data Processing Configuration
 */
class PipelineConfig
{
    Int maxBatchSize := 1000
    Int timeoutMs := 5000
    Bool strictMode := false
    Bool debugMode := false
}

/**
 * Data Buffer for temporary storage during processing
 */
class DataBuffer
{
    private Map<Int, Map> buffer := Map<Int, Map>()
    
    Void add(Int id, Map data) {
        buffer[id] = data
    }
    
    Map? get(Int id) {
        return buffer[id]
    }
    
    Bool has(Int id) {
        return buffer.containsKey(id)
    }
    
    Void remove(Int id) {
        buffer.remove(id)
    }
    
    Int size() {
        return buffer.size
    }
    
    Void clear() {
        buffer.clear()
    }
}

/**
 * Data Validator for input validation
 */
class DataValidator
{
    Bool validate(Map data) {
        if (data == null) return false
        
        // Check for required fields
        Bool hasId := data.containsKey("id")
        Bool hasName := data.containsKey("name")
        Bool hasScore := data.containsKey("score")
        
        if (!hasId || !hasName || !hasScore) return false
        
        // Validate data types
        if (!data["id"] instanceof Int) return false
        if (!data["name"] instanceof Str) return false
        if (!data["score"] instanceof Int) return false
        
        // Validate score range
        Int score = data["score"] as Int
        if (score < 0 || score > 100) return false
        
        return true
    }
    
    Str? validateName(Str name) {
        if (name == null || name.trim.isEmpty) return "Name cannot be empty"
        if (name.length > 100) return "Name too long"
        return null
    }
    
    Str? validateScore(Int score) {
        if (score < 0 || score > 100) return "Score must be between 0 and 100"
        return null
    }
}

/**
 * Data Processor for actual data manipulation
 */
class DataProcessor
{
    private DataValidator validator := DataValidator()
    
    Map process(Map data) {
        if (!validator.validate(data))
            throw Err("Invalid data format")
        
        Map processed := Map()
        
        // Copy base fields
        processed["id"] = data["id"]
        processed["name"] = data["name"]
        processed["score"] = data["score"]
        
        // Add computed fields
        processed["grade"] = calculateGrade(data["score"] as Int)
        processed["status"] = determineStatus(data["score"] as Int)
        processed["timestamp"] = Time.now.toString("yyyy-MM-dd HH:mm:ss")
        
        return processed
    }
    
    private Str calculateGrade(Int score) {
        if (score >= 90) return "A"
        if (score >= 80) return "B"
        if (score >= 70) return "C"
        if (score >= 60) return "D"
        return "F"
    }
    
    private Str determineStatus(Int score) {
        if (score >= 80) return "Excellence"
        if (score >= 70) return "Good"
        if (score >= 60) return "Pass"
        return "Fail"
    }
    
    List<Map> processBatch(List<Map> data) {
        List<Map> results := List<Map>()
        
        data.each |Map item| {
            try {
                results.add(process(item))
            } catch (Err e) {
                Log("DataProcessor").warn("Failed to process item: %s", e.msg)
            }
        }
        
        return results
    }
}

/**
 * Processing Pipeline orchestrator
 */
class Pipeline
{
    readonly DataProcessor processor
    readonly DataBuffer buffer
    readonly DataValidator validator
    readonly PipelineConfig config
    
    construct(processor: DataProcessor, buffer: DataBuffer, validator: DataValidator) {
        this.processor = processor
        this.buffer = buffer
        this.validator = validator
        this.config = PipelineConfig()
    }
    
    List<Map> execute(List<Map> input) {
        List<Map> results := List<Map>()
        Int successCount = 0
        Int failCount = 0
        
        log.info("Starting pipeline execution with %d records...", input.size)
        
        // Validate and process in batches
        Int batchSize = config.maxBatchSize
        Int totalBatches = (input.size + batchSize - 1) / batchSize
        
        (0..totalBatches-1).each |Int batchNum| {
            Int start = batchNum * batchSize
            Int end = Min(start + batchSize, input.size)
            List<Map> batch = input[start..end-1]
            
            if (config.debugMode)
                log.info("Processing batch %d (%d-%d)", batchNum + 1, start + 1, end)
            
            // Validate batch
            List<Map> validBatch := List<Map>()
            batch.each |Map item| {
                if (validator.validate(item))
                    validBatch.add(item)
                else
                    failCount++
            }
            
            // Process valid batch
            List<Map> processedBatch = processor.processBatch(validBatch)
            
            // Add to results
            results.addAll(processedBatch)
            successCount += processedBatch.size
            
            // Store in buffer
            processedBatch.each |Map item| {
                if (item.containsKey("id"))
                    buffer.add(item["id"] as Int, item)
            }
        }
        
        log.info("Pipeline execution complete: %d succeeded, %d failed",
                successCount, failCount)
        
        return results
    }
    
    private Void log(Str msg, |Str| format := null) {
        Log("Pipeline").info(msg)
    }
}
