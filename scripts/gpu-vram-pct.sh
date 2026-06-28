#!/usr/bin/env bash
nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits 2>/dev/null \
  | awk -F', ' '{ if ($2+0 > 0) printf "%.0f", ($1/$2)*100; else print "0" }'
