#!/usr/bin/env bash
printf '%s %s' "$(date +%-d)" "$(date +%b | tr '[:lower:]' '[:upper:]')"
