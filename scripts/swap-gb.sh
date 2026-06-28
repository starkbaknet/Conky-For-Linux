#!/usr/bin/env bash
awk '/SwapTotal:|SwapFree:/ {
  if ($1=="SwapTotal:") total=$2
  if ($1=="SwapFree:") free=$2
}
END {
  if (total == 0) { print "0 MB / 0 MB (0%)"; exit }
  used=(total-free)/1024
  if (total >= 1048576) printf "%.1f GB / %.1f GB (%.0f%%)", used/1024, total/1024/1024, (used/(total/1024))*100
  else printf "%.0f MB / %.0f MB (%.0f%%)", used, total/1024, (used/(total/1024))*100
}' /proc/meminfo
