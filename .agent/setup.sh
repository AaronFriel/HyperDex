#!/usr/bin/env bash

CURRENT_DIR=$(cd $(dirname $0); pwd)

setup_deps_output="$CURRENT_DIR/setup.log"
function setup_deps {
    "$CURRENT_DIR/deps.sh" 2>&1 | tee -a "$setup_deps_output"
    local pipe_status=("${PIPESTATUS[@]}")
    local exit_code="${pipe_status[0]}"

    if [ $exit_code -ne 0 ]; then
        echo "setup_deps failed.  Output was written to $setup_deps_output"
    fi
    return $exit_code
}

setup_deps
status=$?

if [ $status -eq 0 ]; then
    echo "Dependencies set up, clearing log file to avoid confusing the agent."
    > "$setup_deps_output"
fi

if [ "${CODEX_AGENT:-0}" = "1" ]; then
    exit $status
else
    exit 0
fi
