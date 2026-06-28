#!/usr/bin/env bash
df -B1 / 2>/dev/null | awk 'NR==2 {
  used=$3/1024/1024/1024
  total=$2/1024/1024/1024
  pct=$5
  gsub(/%/,"",pct)
  printf "%.0f GB / %.0f GB (%s%%)", used, total, pct
}'
