#!/usr/bin/bash

# Identify build.gradle location
if [[ -f "lwjgl3/build.gradle" ]]; then
    gradle_file="lwjgl3/build.gradle"
elif [[ -f "core/build.gradle" ]]; then
    gradle_file="core/build.gradle"
elif [[ -f "build.gradle" ]]; then
    gradle_file="build.gradle"
else
    echo "No suitable build.gradle file found!"
    exit 1
fi

echo "Using $gradle_file for task registration."

# Check if the task definition already exists
if ! grep -q 'tasks.register("printJarPath")' "$gradle_file"; then
    echo "Adding printJarPath task to $gradle_file..."
    cat << 'EOF' >> "$gradle_file"

tasks.register("printJarPath") {
    doLast {
        def jarTask = tasks.findByName("jar") ?: tasks.findByName("assemble")
        if (jarTask == null) {
            throw new GradleException("No 'jar' or 'assemble' task found in this project!")
        }
        def jarFile = jarTask.archiveFile.get().asFile
        def logFile = file("./jar-info.txt")
        
        logFile.text = jarFile.absolutePath // Overwrites existing content
        // Alternatively, to append: logFile.append("${jarFile.absolutePath}\n")
        println "Logged JAR path to: ${jarFile.absolutePath}"
    }
}
EOF
else
    echo "Task 'printJarPath' already exists in $gradle_file. Skipping addition."
fi

