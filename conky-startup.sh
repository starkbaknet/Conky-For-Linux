#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="${DIR}/Titus.conkyrc"

pkill -f "conky -c.*Titus.conkyrc" 2>/dev/null || true
pkill -f "conky -c.*Titus" 2>/dev/null || true
sleep 0.5
conky -c "${CONFIG}" &
