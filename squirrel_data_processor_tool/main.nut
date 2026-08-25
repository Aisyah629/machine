class DataProcessor {
    constructor(config = {}) {
        this.config = ::imp.builtinconfig();
        this.log = [];
        ::print("DataProcessor initialized.");
    }

    process(data) {
        if (!data) return null;
        try {
            this.log.push("Processing data...");
            local transformed = ::json.decode(data);
            if (!transformed) throw "Invalid JSON";
            return this.transform(transformed);
        } catch (e) {
            this.log.push("Error: " + e);
            return null;
        }
    }

    transform(data) {
        this.log.push("Transforming data...");
        if (typeof data == "table") {
            local result = {};
            foreach (key, value in data) {
                result[key.tolower()] = value;
            }
            return result;
        }
        return data;
    }

    getLog() {
        return this.log;
    }
}

function main() {
    local processor = DataProcessor();
    local sampleData = "{\"Name\": \"John\", \"Age\": 30}";
    local result = processor.process(sampleData);
    ::print("Result: " + ::json.encode(result));
    foreach (logEntry in processor.getLog()) {
        ::print("Log: " + logEntry);
    }
}

main();
