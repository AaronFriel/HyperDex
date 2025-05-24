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

if setup_deps; then
    echo "Dependencies set up, clearing log file to avoid confusing the agent."
    > "$setup_deps_output"
fi
