#!/usr/bin/env bash
nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits 2>/dev/null \
  | awk -F', ' '{
      used=$1+0; total=$2+0
      if (used >= 1024) u=sprintf("%.2f GB", used/1024); else u=sprintf("%d MB", used)
      if (total >= 1024) t=sprintf("%.1f GB", total/1024); else t=sprintf("%d MB", total)
      printf "%s / %s", u, t
    }'
