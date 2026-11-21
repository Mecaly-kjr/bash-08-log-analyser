#!/usr/bin/env bash

# Show usage information.
usage() {
    echo "Usage: $0 LOGFILE" >&2
}

# Display an error and exit.
die() {
    echo "Error: $1" >&2
    exit 1
}

# Validate the command-line arguments.
main() {
    if [[ $# -ne 1 ]]; then
        usage
        exit 1
    fi

    LOGFILE=$1

    if [[ ! -f "$LOGFILE" || ! -r "$LOGFILE" ]]; then
        die "'$LOGFILE' is not a readable file."
    fi

    report_header

    if [[ ! -s "$LOGFILE" ]]; then
        echo "No data in log file."
        exit 0
    fi

    total_requests
    unique_visitors
    status_counts
    data_sent
    echo
    top_pages
    echo
    top_ips
    echo
    top_404_pages
}

# Print the report heading.
report_header() {
    echo "=========================================="
    echo "Log report: $LOGFILE"
    echo "=========================================="
}

# Count all log lines.
total_requests() {
    awk 'END { printf "Total requests ........ %d\n", NR }' "$LOGFILE"
}

# Count unique IP addresses.
unique_visitors() {
    local count

    count=$(awk 'NF >= 9 { print $1 }' "$LOGFILE" |
        sort -u | awk 'END { print NR }')

    printf "Unique visitors ....... %s\n" "$count"
}

# Count HTTP response status classes.
status_counts() {
    awk '
    {
        if ($9 ~ /^2[0-9][0-9]$/) c2++
        else if ($9 ~ /^3[0-9][0-9]$/) c3++
        else if ($9 ~ /^4[0-9][0-9]$/) c4++
        else if ($9 ~ /^5[0-9][0-9]$/) c5++
    }
    END {
        printf "2xx / 3xx ............. %d / %d\n", c2, c3
        printf "4xx / 5xx ............. %d / %d\n", c4, c5
    }' "$LOGFILE"
}

# Calculate the total data sent in MB.
data_sent() {
    awk '
    $10 ~ /^[0-9]+$/ { total += $10 }
    END {
        printf "Data sent ............. %.1f MB\n", total / 1048576
    }' "$LOGFILE"
}

# Show the five most requested pages.
top_pages() {
    echo "Top 5 pages"

    awk 'NF >= 9 { print $7 }' "$LOGFILE" |
        sort |
        uniq -c |
        sort -rn |
        head -5 |
        awk '{ printf "%6d  %s\n", $1, $2 }'
}

# Show the five IP addresses with the most requests.
top_ips() {
    echo "Top 5 IP addresses"

    awk 'NF >= 9 { print $1 }' "$LOGFILE" |
        sort |
        uniq -c |
        sort -rn |
        head -5 |
        awk '{ printf "%6d  %s\n", $1, $2 }'
}

# Show the five most frequent pages returning HTTP 404.
top_404_pages() {
    echo "Top 5 broken links (404)"

    awk '$9 == 404 { print $7 }' "$LOGFILE" |
        sort |
        uniq -c |
        sort -rn |
        head -5 |
        awk '{ printf "%6d  %s\n", $1, $2 }'
}

# Start the program.
main "$@"
