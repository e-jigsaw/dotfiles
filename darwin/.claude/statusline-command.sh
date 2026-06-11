#!/bin/sh
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "Unknown"' | sed '
  s/Sonnet \([0-9]\)\.\([0-9]\)/S\1\2/
  s/Opus \([0-9]\)\.\([0-9]\)/O\1\2/
  s/Haiku \([0-9]\)\.\([0-9]\)/H\1\2/
  s/Fable \([0-9]\)\.\([0-9]\)/F\1\2/
  s/Fable \([0-9]\)/F\1/
')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_h=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
_colorize() {
  val=$(printf '%.0f' "$1")
  if [ "$val" -ge 80 ]; then c="\033[31m"; elif [ "$val" -ge 50 ]; then c="\033[33m"; else c="\033[32m"; fi
  printf "${c}%d%%\033[0m" "$val"
}
limits=""
[ -n "$five_h" ] && limits="5h: $(_colorize "$five_h")"
[ -n "$week" ] && limits="${limits:+$limits }7d: $(_colorize "$week")"

if [ -n "$used" ]; then
  used_int=$(printf '%.0f' "$used")
  filled=$(( used_int / 5 ))
  empty=$(( 20 - filled ))
  bar=""
  i=0
  while [ $i -lt $filled ]; do
    bar="${bar}█"
    i=$(( i + 1 ))
  done
  i=0
  while [ $i -lt $empty ]; do
    bar="${bar}░"
    i=$(( i + 1 ))
  done
  if [ "$used_int" -ge 80 ]; then
    color="\033[31m"
  elif [ "$used_int" -ge 50 ]; then
    color="\033[33m"
  else
    color="\033[32m"
  fi
  reset="\033[0m"
  if [ -n "$limits" ]; then
    printf "%s${color}[%s] %d%%${reset} | ⚡ %s" "$model" "$bar" "$used_int" "$limits"
  else
    printf "%s${color}[%s] %d%%${reset}" "$model" "$bar" "$used_int"
  fi
else
  if [ -n "$limits" ]; then
    printf '%s | ⚡ %s' "$model" "$limits"
  else
    printf '%s' "$model"
  fi
fi
