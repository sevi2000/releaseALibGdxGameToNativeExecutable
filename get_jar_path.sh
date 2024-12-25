#!/usr/bin/bash

# Function to log errors
log_error() {
    local exit_code=$?
    local line_number=${BASH_LINENO[0]}
    local script_name=${BASH_SOURCE[1]}
    echo "Error in script: $script_name at line: $line_number (exit code: $exit_code)" >> error.log
    exit $exit_code
}

# Trap errors
trap 'log_error' ERR

echo "Checking if this is a libgdx project"
[[ -d lwjgl3 ]] || [[ -d desktop ]] || {
    echo "Not a libgdx project"
    exit 1
}
./add_task.sh

# Generate JAR artifact
./gradlew assembleDist

# Get JAR artifact path
export jar_path="$(./gradlew printJarPath | grep -i 'Logged JAR name' | cut -d ':' -f 2 | tr -d ' ')"
echo "JAR artifact path: $jar_path"
