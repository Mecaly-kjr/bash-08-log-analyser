#!/usr/bin/env bash

# Generate a small Apache-style access log for testing.
set -e

if [[ $# -ne 1 || ! "$1" =~ ^[0-9]+$ ]]; then
    echo "Usage: $0 NUMBER_OF_LINES" >&2
    exit 1
fi

count=$1

ips=("192.168.1.10" "192.168.1.11" "192.168.1.12"
     "192.168.1.13" "192.168.1.14")

pages=("/index.html" "/css/style.css" "/apply.html"
       "/login" "/images/logo.png" "/missing.html")

statuses=(200 200 200 301 404 500)

for ((i = 0; i < count; i++)); do
    ip=${ips[$((i % ${#ips[@]}))]}
    page=${pages[$((i % ${#pages[@]}))]}
    status=${statuses[$((i % ${#statuses[@]}))]}
    bytes=$((500 + (i % 10) * 100))

    printf '%s - - [29/Oct/2026:12:00:00 +0100] "GET %s HTTP/1.1" %s %s\n' \
        "$ip" "$page" "$status" "$bytes"
done
