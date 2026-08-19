// Alef log analysis tool
package main

import "fmt"
import "io"
import "os"
import "os/file"
import "regexp"
import "strconv"
import "string"
import "sys"

const (
	MaxBufferSize = 8192
	TimeFormat    = "2006-01-02 15:04:05"
)

var (
	// Regex patterns for log parsing
	timePattern = regexp.compile(`^(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})`)
	levelPattern = regexp.compile(`\[(DEBUG|INFO|WARN|ERROR|FATAL)\]`)
	messagePattern = regexp.compile(`\[(DEBUG|INFO|WARN|ERROR|FATAL)\]\s+(.*)$`)
)

type LogLevel int

const (
	LevelDebug LogLevel = iota
	LevelInfo
	LevelWarn
	LevelError
	LevelFatal
)

func (l LogLevel) String() string {
	switch l {
	case LevelDebug:
		return "DEBUG"
	case LevelInfo:
		return "INFO"
	case LevelWarn:
		return "WARN"
	case LevelError:
		return "ERROR"
	case LevelFatal:
		return "FATAL"
	default:
		return "UNKNOWN"
	}
}

type LogEntry struct {
	Timestamp string
	Level     LogLevel
	Message   string
	Raw       string
}

func parseLogLine(line string) *LogEntry {
	if line == "" {
		return nil
	}

	entry := new(LogEntry)
	entry.Raw = line

	// Extract timestamp
	tsMatch := timePattern.findsubmatch(line)
	if len(tsMatch) > 1 {
		entry.Timestamp = string(tsMatch[1])
	} else {
		entry.Timestamp = "N/A"
	}

	// Extract level
	levelMatch := levelPattern.findsubmatch(line)
	if len(levelMatch) > 1 {
		levelStr := string(levelMatch[1])
		switch levelStr {
		case "DEBUG":
			entry.Level = LevelDebug
		case "INFO":
			entry.Level = LevelInfo
		case "WARN":
			entry.Level = LevelWarn
		case "ERROR":
			entry.Level = LevelError
		case "FATAL":
			entry.Level = LevelFatal
		default:
			entry.Level = LevelDebug
		}
	} else {
		entry.Level = LevelInfo // Default to INFO if no level found
	}

	// Extract message
	msgMatch := messagePattern.findsubmatch(line)
	if len(msgMatch) > 2 {
		entry.Message = string(msgMatch[2])
	} else {
		entry.Message = line
	}

	return entry
}

type LogAnalyzer struct {
	totalLines int
	levelCounts map[string]int
	errors      []LogEntry
	warnings    []LogEntry
	startTime   sys.time
	endTime     sys.time
}

func newLogAnalyzer() *LogAnalyzer {
	return &LogAnalyzer{
		levelCounts: make(map[string]int),
		startTime:   sys.now(),
	}
}

func (a *LogAnalyzer) processLog(reader io.reader) {
	buffer := make([]byte, MaxBufferSize)
	
	for {
		n, err := reader.read(buffer)
		if n > 0 {
			line := string(buffer[:n])
			// Handle partial lines if needed, but for simplicity assume full lines
			entry := parseLogLine(line)
			if entry != nil {
				a.totalLines++
				levelStr := entry.Level.String()
				a.levelCounts[levelStr]++
				
				switch entry.Level {
				case LevelError:
					a.errors = append(a.errors, *entry)
				case LevelWarn:
					a.warnings = append(a.warnings, *entry)
				}
			}
		}
		
		if err != nil {
			break
		}
	}
	
	a.endTime = sys.now()
}

func (a *LogAnalyzer) printReport() {
	fmt.println("=== Log Analysis Report ===")
	fmt.println("Total Lines Processed:", a.totalLines)
	fmt.println("\n--- Log Level Distribution ---")
	
	for level, count := range a.levelCounts {
		fmt.println(level + ": " + strconv.int(count))
	}
	
	fmt.println("\n--- Critical Issues Found ---")
	fmt.println("Errors:", len(a.errors))
	for i, err := range a.errors {
		fmt.printf("  [%d] %s: %s\n", i+1, err.Timestamp, err.Message)
	}
	
	fmt.println("Warnings:", len(a.warnings))
	for i, warn := range a.warnings {
		fmt.printf("  [%d] %s: %s\n", i+1, warn.Timestamp, warn.Message)
	}
	
	duration := a.endTime.subtract(a.startTime)
	fmt.printf("\n--- Analysis Duration ---\n")
	fmt.printf("Duration: %d seconds\n", duration.secs)
}

func main() {
	if os.argc < 2 {
		fmt.println("Usage: alef_log_analyzer_tool <log_file>")
		sys.exit(1)
	}
	
	filename := os.arg[1]
	
	file, err := os.open(filename, sys.OREAD)
	if err != nil {
		fmt.println("Error opening file:", err)
		sys.exit(1)
	}
	defer file.close()
	
	analyzer := newLogAnalyzer()
	analyzer.processLog(file)
	analyzer.printReport()
}
