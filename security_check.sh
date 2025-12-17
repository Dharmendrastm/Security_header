#!/bin/bash

URL=$1

if [ -z "$URL" ]; then
  echo "Usage: ./security_check.sh https://example.com"
  exit 1
fi

echo "Checking security headers for $URL"
echo "Header,Status" > report.csv

check_header () {
  HEADER=$1
  if curl -I -s "$URL" | grep -iq "$HEADER"; then
    echo "$HEADER,Present" >> report.csv
    echo "[✔] $HEADER"
  else
    echo "$HEADER,Missing" >> report.csv
    echo "[✘] $HEADER"
  fi
}

# Security Headers
check_header "Strict-Transport-Security"
check_header "Content-Security-Policy"
check_header "X-Frame-Options"
check_header "X-Content-Type-Options"
check_header "Referrer-Policy"
check_header "Permissions-Policy"
check_header "Set-Cookie"

# HTTP Methods
echo "" >> report.csv
echo "HTTP Method,Status" >> report.csv

for METHOD in GET POST PUT DELETE TRACE OPTIONS CONNECT; do
  STATUS=$(curl -X $METHOD -o /dev/null -s -w "%{http_code}" "$URL")
  echo "$METHOD,$STATUS" >> report.csv
  echo "[METHOD] $METHOD → HTTP $STATUS"
done

echo ""
echo "✔ Scan completed. Report saved as report.csv"
