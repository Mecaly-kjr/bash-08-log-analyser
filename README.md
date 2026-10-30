# 🏷  bash-08-log-analyser

loganalyse.sh turns a raw web server access log into a one-minute report.

----

## 📌 Problem Statements

The site was slow and some pages "disappeared", but the answer is buried in thousands of log lines. This tool summarises the log: traffic, errors, busiest pages and visitors, broken links and data sent.

----

## 🎯 Project Goals

. Turn thoushands of raw log lines into a report a manager can read in one minute
. Report total request, unique visitors and 2xx/3xx/4xx/5xx/ counts
. show the top 5 pages, top 5 IP addresses and top 5 broken links(404)
. show total data sent in MB with one decimal
. Handle errors cleary: missing or unreadable file, and an empty log

----

## 🛠 Tech Stack

• Bash, awk, sort, uniq, head
• Git & GitHub (feature branch + pull request)

----

## 🖥 Features

• Total requests and unique IP addresses
• Counts of 2xx, 3xx, 4xx and 5xx responses (exact awk field tests on the status code)
• Top 5 pages and top 5 IP addresses
• Top 5 broken links (most frequent 404 pages)
• Total data sent in MB (one decimal)
• Each report section is its own function
• Empty log: prints "No data" instead of crashing

----

## 📷 Screenshots

![alt text](<assets/images/Screenshot From 2026-10-30 12-25-49.png>)
![alt text](<assets/images/Screenshot From 2026-10-30 12-05-27.png>)
![alt text](<assets/images/Screenshot From 2026-10-30 12-24-34.png>)
![alt text](<assets/images/Screenshot From 2026-10-30 12-07-42.png>)

----

## ⚙ Installation & Setup

clone the repository;
'```bash

git clone [https://github.com/Mecaly-kjr/bash-08-log-analyser.git]

cd bash-07-backup-tool

chmod +x backup.sh

 ./loganalyse.sh access.log

----

## 🧠 Challenges Faced

• Counting a whole status class (4xx) without matching other fields by accident
• Ignoring - in the bytes field (no data sent) when adding up
• Making top-5 lists with a stable order for equal counts

----

## 📚 What I Learned

• Field-based processing with awk
• The sort | uniq -c | sort -rn | head pattern

----

## 👨🏽‍💻 Author

Mecaly Luther Bobbilla

[mecalyluther64@gmail.com](mailto:mecalyluther64@gmail.com)

Junior Developer | Software Engineering

Based in Cameroon.
