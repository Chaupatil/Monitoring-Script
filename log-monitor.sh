#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 <log_file>"
    exit 1
}

# Check for the required argument
if [ $# -ne 1 ]; then
    usage
fi

# Assigning command-line argument to log file variable
log_file=$1

# Function to handle Ctrl+C
interrupt_handler() {
    echo -e "\nExiting."
    exit 0
}

# Register interrupt handler
trap interrupt_handler SIGINT

# Function to perform log analysis
analyze_logs() {
    # Count occurrences of specific keywords or patterns
    error_count=$(grep -c "ERROR" "$log_file")
   
    # Generate summary reports
    echo "===== Log Analysis====="
    echo "Total Errors: $error_count"
}

# Main function to monitor log file
monitor_logs() {
    echo "Monitoring log file: $log_file"
   
    # Start monitoring loop
    while true; do
        # Display new log entries in real-time
        tail -n 1 "$log_file"
       
        # Perform log analysis
        analyze_logs
       
        # Sleep for a short interval
        sleep 5
    done
}

# Execute main function
monitor_logs
