<cfsetting showdebugoutput="false" requesttimeout="300">
<cfscript>
    /**
     * DataProcessor Component
     * Handles ingestion, transformation, and formatting of data.
     */
    class DataProcessor {
        private array data = [];
        private struct validationRules = {};

        public function init() {
            return this;
        }

        public function ingest(array input) {
            if (isArray(input)) {
                data = input;
            } else {
                throw(type="InvalidDataException", message="Input must be an array.");
            }
            return this;
        }

        public function transform(function transformFn) {
            for (var item in data) {
                try {
                    transformFn(item);
                } catch (any e) {
                    // Log or handle transform errors
                }
            }
            return this;
        }

        public function output(string format = "json") {
            if (format == "json") {
                return serializeJSON(data);
            } else if (format == "xml") {
                return serializeXML(data);
            } else {
                throw(type="UnsupportedFormatException", message="Format not supported.");
            }
        }
    }

    // Web Application Interface
    try {
        processor = new DataProcessor();
        // Example usage: Ingest and transform data
        // processor.ingest(inputArray).transform(transformFunction);
        writeOutput(processor.output("json"));
    } catch (any e) {
        writeDump(var=e);
    }
</cfscript>
