// Main entry point for the ColdC Framework Engine Tool
// Language: ColdC

import std.io;
import std.arg;
import std.fs;
import std.path;

import scaffold;
import analyzer;
import resolver;

struct ToolConfig {
    string project_name;
    string target_dir;
    bool verbose;
    bool generate_docs;
    list<string> modules;
}

void main() {
    var config = parse_arguments();
    
    if (config.project_name == "init") {
        scaffold.create_project(config.target_dir, config.modules);
        log("Project scaffolded successfully at: " + config.target_dir, config.verbose);
    } else if (config.project_name == "analyze") {
        analyzer.scan_directory(config.target_dir, config.verbose);
        log("Analysis complete.", config.verbose);
    } else if (config.project_name == "resolve") {
        resolver.build_dependency_graph(config.target_dir);
        log("Dependency graph built.", config.verbose);
    } else {
        print_usage();
        exit(1);
    }
}

ToolConfig parse_arguments() {
    var args = get_arguments();
    var config = ToolConfig();
    
    if (args.length < 2) {
        print_usage();
        exit(1);
    }
    
    config.project_name = args[1];
    config.target_dir = args.length > 2 ? args[2] : ".";
    config.verbose = args.contains("--verbose");
    config.modules = parse_module_flags(args);
    
    return config;
}

list<string> parse_module_flags(list<string> args) {
    var modules = list<string>();
    for (var i = 0; i < args.length; i++) {
        if (args[i] == "--module" && i + 1 < args.length) {
            modules.add(args[i+1]);
        }
    }
    return modules;
}

void print_usage() {
    print("Usage: coldc_framework_engine_tool <command> [target_dir] [--verbose] [--module <name>]");
    print("Commands: init, analyze, resolve");
    print("Example: coldc_framework_engine_tool init ./my_coldc_proj --module net --module io");
}
