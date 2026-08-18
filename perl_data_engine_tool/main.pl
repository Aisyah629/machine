#!/usr/bin/env perl

use strict;
use warnings;
use Getopt::Long;
use File::Basename;
use POSIX qw(strftime);

# Configuration
my $config_file = 'perl_data_engine_tool.conf';
my $input_file;
my $output_file;
my $verbose = 0;

GetOptions(
    'config=s' => \$config_file,
    'input=s'  => \$input_file,
    'output=s' => \$output_file,
    'verbose'  => \$verbose
) or die "Error in command line arguments\n";

# Logging function
sub log_message {
    my ($level, $msg) = @_;
    my $timestamp = strftime("%Y-%m-%d %H:%M:%S", localtime);
    my $log_level = "[$level]";
    my $log_msg = "$timestamp $log_level $msg";
    
    print STDERR "$log_msg\n" if $verbose;
    open(my $fh, '>>', 'engine.log') or warn "Could not open log file: $!";
    print $fh "$log_msg\n";
    close($fh);
}

# Data extraction function
sub extract_data {
    my ($content) = @_;
    my @extracted_data;
    
    # Example: Extract email addresses
    while ($content =~ /([\w.-]+@[\w.-]+\.[a-z]{2,})/g) {
        push @extracted_data, $1;
    }
    
    # Example: Extract IP addresses
    while ($content =~ /(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/g) {
        push @extracted_data, "IP: $1";
    }
    
    return @extracted_data;
}

# Main processing logic
sub process_pipeline {
    my ($input, $output) = @_;
    
    log_message('INFO', 'Starting data processing pipeline...');
    
    unless (-e $input) {
        log_message('ERROR', "Input file not found: $input");
        return;
    }
    
    open(my $in_fh, '<', $input) or die "Cannot open input file: $!";
    my $content = do { local $/; <$in_fh> };
    close($in_fh);
    
    log_message('INFO', 'Data extracted successfully.');
    
    my @data = extract_data($content);
    
    open(my $out_fh, '>', $output) or die "Cannot open output file: $!";
    print $out_fh join("\n", @data);
    close($out_fh);
    
    log_message('INFO', "Processing complete. Output written to $output");
}

# Execution
if ($input_file && $output_file) {
    process_pipeline($input_file, $output_file);
} else {
    print STDERR "Usage: $0 --config <config_file> --input <input_file> --output <output_file> [--verbose]\n";
    exit 1;
}
