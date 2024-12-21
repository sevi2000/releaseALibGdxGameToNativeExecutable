#!/usr/bin/bash
echo "Checking if this is a libgdx project"
[[ -d lwjgl3 ]] || [[ -d desktop ]] || {
    echo "Not a libgdx project"
    exit 1
}

# Generate JAR artifact
./gradlew assembleDist

# Get JAR artifact path
export jar_path="$(./gradlew printJarPath | grep -i 'Logged JAR name' | cut -d ':' -f 2 | tr -d ' ')"
echo "JAR artifact path: $jar_path"