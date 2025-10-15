#!/bin/bash
# Logging utility for setup script
# Provides clean status output while capturing full logs

# Set up logging to file
LOGFILE="${LOGFILE:-$HOME/setup.log}"

# Initialize log file with header
if [[ ! -f "$LOGFILE" ]]; then
  echo "=== Setup Log - $(date) ===" > "$LOGFILE"
fi

# Save original stdout/stderr and redirect to logfile
if [[ -z "$LOGGING_INITIALIZED" ]]; then
  exec 3>&1 4>&2  # Save original stdout (3) and stderr (4)
  exec 1>>"$LOGFILE" 2>&1  # Redirect stdout/stderr to logfile
  export LOGGING_INITIALIZED=1
fi

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Status functions - output to original stdout (fd 3)
status_ok() {
  echo -e "${GREEN}[  OK  ]${NC} $1" >&3
  echo "[OK] $1" >> "$LOGFILE"
}

status_fail() {
  echo -e "${RED}[ FAIL ]${NC} $1" >&3
  echo "[FAIL] $1" >> "$LOGFILE"
}

status_info() {
  echo -e "${BLUE}[ .... ]${NC} $1" >&3
  echo "[INFO] $1" >> "$LOGFILE"
}

status_skip() {
  echo -e "${YELLOW}[ SKIP ]${NC} $1" >&3
  echo "[SKIP] $1" >> "$LOGFILE"
}

# Run a task with status output
# Usage: run_task "Description" command args...
run_task() {
  local description="$1"
  shift

  status_info "$description"

  if "$@"; then
    status_ok "$description"
    return 0
  else
    status_fail "$description"
    return 1
  fi
}

# Run task silently (no info message, only result)
# Usage: run_silent "Description" command args...
run_silent() {
  local description="$1"
  shift

  if "$@"; then
    status_ok "$description"
    return 0
  else
    status_fail "$description"
    return 1
  fi
}

# Print section header
section() {
  echo "" >&3
  echo -e "${BLUE}==>${NC} $1" >&3
  echo "" >> "$LOGFILE"
  echo "==> $1" >> "$LOGFILE"
}

# Post-setup message - prints a checkbox item
# Usage: post_message "Your message here"
post_message() {
  echo "  [ ] $1" >&3
  echo "  [ ] $1" >> "$LOGFILE"
}

# Export functions so they're available in subscripts
export -f status_ok
export -f status_fail
export -f status_info
export -f status_skip
export -f run_task
export -f run_silent
export -f section
export -f post_message
