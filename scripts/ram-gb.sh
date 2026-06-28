#!/usr/bin/env bash
awk '/MemTotal:|MemAvailable:/ {
  if ($1=="MemTotal:") total=$2
  if ($1=="MemAvailable:") avail=$2
}
END {
  used=(total-avail)/1024/1024
  printf "%.1f GB / %.0f GB (%.0f%%)", used, total/1024/1024, (used/(total/1024/1024))*100
}' /proc/meminfo
